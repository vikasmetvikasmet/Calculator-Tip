//
//  ContentView.swift
//  calculatorTip
//
//  Created by Vika on 13.01.2024.
//

import SwiftUI


struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 0
    let tipPercentages = [0, 5, 10, 15, 20]
    
    var totalPerPerson: Double{
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentages [tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    @State private var sharingToggle = false
    @State private var addressee = ""
    let choiceOfLocation = ["Restaurant", "Bar", "Cafe", "Coffee shop", "Taxi", "Shop" ]
    @State private var numberOfLocation = 0
    @State private var visitingTime = Date()
    @State private var dateFormatter = DateFormatter()
    
    
    
    var finalAccount: String{
        dateFormatter.dateFormat = "dd.MM.yyyy"
       
        let accountFinal = "\(choiceOfLocation[numberOfLocation]) bill (from: \(dateFormatter.string(from: visitingTime))) with \(tipPercentages [tipPercentage])% tip.\n\nFinal: \(totalPerPerson) "
        return accountFinal
    }
    

   
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section{
                        TextField("Amount", text: $checkAmount)
                        Picker("Number of people", selection: $numberOfPeople){
                            ForEach(1..<101){
                                Text("\($0) people")
                            }
                        }
                    }
                    Section(header: Text("How much tip do you want to leave?")){
                        Picker("Tip percentage", selection: $tipPercentage){
                            ForEach(0..<tipPercentages.count, id: \.self){
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                    Section{
                        Text("\(totalPerPerson, specifier: "%.2f")")
                        
                    }
                    Section(header: Text("Do you want to share account with tip?")){
                    Toggle("Sharing Tips", isOn: $sharingToggle)
                        if sharingToggle == true{
//                            TextField("Whom", text: $addressee)
                            Picker("Place:", selection: $numberOfLocation){
                                ForEach(0..<choiceOfLocation.count, id: \.self){
                                    Text("\(self.choiceOfLocation[$0])")}}
                            DatePicker("Day Visit", selection: $visitingTime, displayedComponents: .date)
                            //Text(finalAccount)
                           
                            
                            ShareLink(item: finalAccount)
                                .padding()
                                .bold()
                                .imageScale(.large)
                            
                                
                        }
                       
                    }
                    }.navigationBarTitle("Calculator Tip ", displayMode: .inline)
            }
        }
    }
    
}


#Preview {
    ContentView()
}

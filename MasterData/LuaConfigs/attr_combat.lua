local attr_combat = {
  [101] = {
    formula = "(tab[2]*1+tab[3]*25+tab[4]*11+tab[5]*33+tab[6]*0+tab[7]*35+tab[9]*17+tab[10]*8+tab[11]*0+tab[12]*11+tab[13]*0+tab[14]*27+tab[15]*1+tab[16]*0+tab[26]*25+tab[17]*11+tab[18]*11+tab[19]*40+tab[20]*40+tab[21]*27+tab[22]*27+tab[23]*22+tab[24]*27+tab[25]*49+tab[27]*11+tab[28]*11-3000)*5//100*(95+tab[16]*5)//100-430",
    id = 101
  },
  [102] = {
    formula = "(tab[2]*1+tab[3]*24+tab[4]*43+tab[5]*38+tab[6]*0+tab[7]*34+tab[9]*31+tab[10]*25+tab[11]*0+tab[12]*43+tab[13]*0+tab[14]*43+tab[15]*1+tab[16]*0+tab[26]*24+tab[17]*17+tab[18]*17+tab[19]*64+tab[20]*64+tab[21]*43+tab[22]*43+tab[23]*34+tab[24]*43+tab[25]*77+tab[27]*43+tab[28]*43+tab[202]*15+tab[203]*15+tab[204]*15+tab[212]*15+tab[226]*15+tab[227]*15+tab[228]*15)*2//40",
    id = 102
  },
  [103] = {
    formula = "((tab[2]*1+tab[3]*25+tab[4]*11+tab[5]*33+tab[6]*0+tab[7]*35+tab[9]*17+tab[10]*8+tab[11]*0+tab[12]*11+tab[13]*0+tab[14]*27+tab[15]*1+tab[16]*0+tab[26]*25+tab[17]*11+tab[18]*11+tab[19]*40+tab[20]*40+tab[21]*27+tab[22]*27+tab[23]*22+tab[24]*27+tab[25]*49+tab[27]*11+tab[28]*11-3000)*5//100*(95+tab[16]*5)//100-430)*math.min(1,2*tab[1]/tab[2])",
    id = 103
  },
  [104] = {
    formula = "tab.power//10",
    id = 104
  },
  [105] = {
    formula = "tab.lv>10 and (1+((tab.lv-10)/10+4.5)*0.8) or (tab.lv>1 and ( 1+((tab.lv-1)*1-((tab.lv-0)*(tab.lv-1)*0.05))*0.8) or ( 1+(tab.lv-1)*0.9 ) )",
    id = 105
  },
  [106] = {id = 106},
  [107] = {id = 107},
  [108] = {
    formula = "math.max(50,((tab[2]*1+tab[3]*25+tab[4]*11+tab[5]*33+tab[6]*0+tab[7]*35+tab[9]*17+tab[10]*8+tab[11]*0+tab[12]*11+tab[13]*0+tab[14]*0+tab[15]*1+tab[16]*0+tab[26]*25+tab[17]*11+tab[18]*11+tab[19]*40+tab[20]*40+tab[21]*27+tab[22]*27+tab[23]*22+tab[24]*27+tab[25]*49+tab[27]*11+tab[28]*11-3000)*5//100*(95+tab[16]*5)//100-430))*math.min(1,2*tab[1]/tab[2])",
    id = 108
  },
  [1000] = {}
}
local __default_values = {formula = "", id = 1000}
local base = {__index = __default_values}
for k, v in pairs(attr_combat) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(attr_combat, {__index = __rawdata})
return attr_combat

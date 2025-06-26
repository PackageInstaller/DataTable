module("cycle.CycleComboVo", Class.impl())

function parseCombo(self,id,data)
    self.id = id
    
    self.type = data.type
    self.args = data.args 
    self.name = data.name 
    self.des = data.des
    self.icon = data.icon
end



return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

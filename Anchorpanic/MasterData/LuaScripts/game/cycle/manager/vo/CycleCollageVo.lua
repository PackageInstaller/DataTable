module("cycle.CycleCollageVo", Class.impl())

function parseCollageCombo(self, id, data)
    self.id = id

    self.skillId = data.skill_id
    self.gainType = data.gain_type
    self.attrType = data.attr_type
    self.icon = data.icon

    self.name = data.name 
    self.des = data.des
    self.des2 = data.des2
    self.effParam = data.effect_param
    self.eleType = data.ele_type
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]

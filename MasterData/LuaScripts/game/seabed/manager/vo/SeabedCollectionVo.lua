

module("seabed.SeabedCollectionVo", Class.impl())

function parseData(self,id,data)
    self.id = id    
    self.skillId = data.skill_id
    self.gainType = data.gain_type 
    self.attrType = data.attr_type
    self.icon = data.icon
    self.effectParam = data.effect_param
    self.name = data.name 
    self.des = data.des
    self.des2 = data.des2
    self.color = data.color
end

return _M
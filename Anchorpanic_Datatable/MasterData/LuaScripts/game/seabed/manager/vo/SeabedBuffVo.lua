module("seabed.SeabedBuffVo", Class.impl())

function parseData(self,id,data)
    self.id = id    
    self.skillId = data.skill_id
    self.buffType = data.buff_type 
    self.attrType = data.attr_type
    self.icon = data.icon
    self.name = data.name 
    self.des = data.des
    self.color = data.color
end

return _M
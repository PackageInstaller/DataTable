module("seabed.SeabedSkillVo", Class.impl())

function parseData(self,id,data)
    self.id = id    
    self.skillId = data.skill_id
    self.tag = data.tag
    self.color = data.color
end

return _M
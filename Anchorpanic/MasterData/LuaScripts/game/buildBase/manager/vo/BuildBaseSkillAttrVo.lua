module("buildBase.BuildBaseSkillAttrVo", Class.impl())

function parseConfigData(self, id, data)
    
    self.skillId = id
    -- 技能等级
    self.skillLv = data.skill_lv
    -- 效果值替换
    self.value = data.value
    -- 描述
    self.des = data.des
end
return _M
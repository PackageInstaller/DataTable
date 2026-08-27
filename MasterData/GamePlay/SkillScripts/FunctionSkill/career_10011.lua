local career_10011 = class("career_10011", LuaSkillBase)
local base = LuaSkillBase
career_10011.config = {effectId1 = 10993}

function career_10011:ctor()
end

function career_10011:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "career_10011_3", 2, self.OnAfterPlaySkill)
end

function career_10011:OnAfterPlaySkill(skill, role)
  if skill.maker == self.caster and skill.isNormalSkill and LuaSkillCtrl:CallRange(1, 1000) <= self.arglist[1] then
    local targetlist = LuaSkillCtrl:CallTargetSelect(self, 96, 10)
    if targetlist.Count > 0 then
      local target = targetlist[0].targetRole
      LuaSkillCtrl:CallEffect(target, self.config.effectId1, self)
      LuaSkillCtrl:RemoveLife(1, self, target, true, nil, true, true, eHurtType.RealDmg)
    end
  end
end

function career_10011:OnCasterDie()
  base.OnCasterDie(self)
end

return career_10011

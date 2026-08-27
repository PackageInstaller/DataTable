local bs_81027 = class("bs_81027", LuaSkillBase)
local base = LuaSkillBase
bs_81027.config = {hurtConfig = 3}

function bs_81027:ctor()
end

function bs_81027:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_81027_1", 1, self.OnAfterHurt, self.caster, nil, nil, nil, nil, nil, nil, eSkillTag.normalSkill)
end

function bs_81027:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender ~= self.caster or isMiss then
    return
  end
  if skill.skillTag ~= eSkillTag.normalSkill then
    return
  end
  local role = target
  local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, role)
  LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.hurtConfig, {
    self.arglist[1]
  }, true, true)
  skillResult:EndResult()
end

function bs_81027:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_81027

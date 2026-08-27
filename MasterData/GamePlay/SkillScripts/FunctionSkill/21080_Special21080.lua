local bs_21080 = class("bs_21080", LuaSkillBase)
local base = LuaSkillBase
bs_21080.config = {
  heal_config = {baseheal_formula = 501}
}

function bs_21080:ctor()
end

function bs_21080:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_21080_5", 1, self.OnAfterPlaySkill)
  self.targetRole1 = nil
end

function bs_21080:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack and skill.moveSelectTarget ~= nil and skill.moveSelectTarget.targetRole ~= self.targetRole1 then
    if self.targetRole1 == nil then
      self.targetRole1 = skill.moveSelectTarget.targetRole
    else
      self.targetRole1 = skill.moveSelectTarget.targetRole
      local value = self.caster.maxHp * self.arglist[1] // 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
      LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {value}, true)
      skillResult:EndResult()
    end
  end
end

function bs_21080:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if skill.isCommonAttack and self.target ~= nil and LuaSkillCtrl:GetRoleComAtkSkillMoveSelectTarget(self.caster) ~= self.target then
    self.target = LuaSkillCtrl:GetRoleComAtkSkillMoveSelectTarget(self.caster)
    local value = self.caster.maxHp * self.arglist[1] // 1000
    local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, self.caster)
    LuaSkillCtrl:HealResult(skillResult, self.config.heal_config, {value})
    skillResult:EndResult()
  end
end

function bs_21080:OnCasterDie()
  base.OnCasterDie(self)
  self.targetRole1 = nil
  self.target = nil
end

function bs_21080:LuaDispose()
  base.LuaDispose(self)
  self.targetRole1 = nil
  self.target = nil
end

return bs_21080

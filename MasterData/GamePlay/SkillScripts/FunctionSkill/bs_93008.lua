local bs_93008 = class("bs_93008", LuaSkillBase)
local base = LuaSkillBase
bs_93008.config = {
  effectId1 = 10970,
  effectId2 = 10971,
  effectId3 = 10972,
  hurt_config = {
    hit_formula = 0,
    basehurt_formula = 502,
    crit_formula = 0
  }
}

function bs_93008:ctor()
end

function bs_93008:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_93008", 90, self.OnSetHurt, self.caster)
  self.layer = 0
end

function bs_93008:OnSetHurt(context)
  if context.skill.isCommonAttack and context.sender == self.caster and context.isTriggerSet ~= true and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    local targetRole = self.caster.recordTable.lastAttackRole
    if targetRole ~= nil then
      local damage = self.caster.pow * (self.arglist[1] + self.arglist[2] * self.layer) // 1000
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {damage}, true)
      if self.layer < self.arglist[3] // 5 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId1, self)
      elseif self.layer < self.arglist[3] // 2 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self)
      else
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId3, self)
      end
      if self.layer < self.arglist[3] then
        self.layer = self.layer + 1
      end
      skillResult:EndResult()
    end
  end
end

function bs_93008:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    local targetRole = self.caster.recordTable.lastAttackRole
    if targetRole ~= nil then
      local damage = self.caster.pow * (self.arglist[1] + self.arglist[2] * self.layer)
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, targetRole)
      LuaSkillCtrl:HurtResult(self, skillResult, self.config.hurt_config, {damage}, true)
      if self.layer < self.arglist[3] // 5 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId1, self)
      elseif self.layer < self.arglist[3] // 2 then
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId2, self)
      else
        LuaSkillCtrl:CallEffect(targetRole, self.config.effectId3, self)
      end
      if self.layer < self.arglist[3] then
        self.layer = self.layer + 1
      end
      skillResult:EndResult()
    end
  end
end

function bs_93008:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_93008

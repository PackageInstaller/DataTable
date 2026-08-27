local bs_15070 = class("bs_15070", LuaSkillBase)
local base = LuaSkillBase
bs_15070.config = {configId1 = 28}

function bs_15070:ctor()
end

function bs_15070:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_15070_1", 1, self.OnSetHurt, nil, self.caster)
  self.damageValue = 0
end

function bs_15070:OnSetHurt(context)
  if context.hurt > 0 and not context.isTriggerSet then
    if self.caster.def >= self.caster.magic_pen then
      self.damageValue = self.caster.def
    else
      self.damageValue = self.caster.magic_pen
    end
    if 0 < self.damageValue then
      local skillResult = LuaSkillCtrl:CallSkillResultNoEffect(self, context.sender)
      LuaSkillCtrl:HurtResultWithConfig(self, skillResult, self.config.configId1, {
        self.damageValue
      }, true)
      skillResult:EndResult()
    end
  end
end

function bs_15070:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15070

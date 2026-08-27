local bs_30074 = class("bs_30074", LuaSkillBase)
local base = LuaSkillBase
bs_30074.config = {configId1 = 28}

function bs_30074:ctor()
end

function bs_30074:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_30074_1", 1, self.OnSetHurt, nil, self.caster)
  self.damageValue = 0
end

function bs_30074:OnSetHurt(context)
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

function bs_30074:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30074

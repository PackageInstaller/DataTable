local bs_10129 = class("bs_10129", LuaSkillBase)
local base = LuaSkillBase
bs_10129.config = {effectId = 10172}

function bs_10129:ctor()
end

function bs_10129:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10129_2", 1, self.OnSetHurt, self.caster)
  self.caster.recordTable["10129_lastRole"] = nil
end

function bs_10129:OnSetHurt(context)
  if context.sender == self.caster and not context.isMiss and self:IsReadyToTake() then
    if self.caster.recordTable["10129_lastRole"] == nil then
      self.caster.recordTable["10129_lastRole"] = context.target
    end
    if self.caster.recordTable["10129_lastRole"] ~= nil and self.caster.recordTable["10129_lastRole"] ~= context.target then
      self:PlayChipEffect()
      if context.isCrit then
        context.hurt = (1000 + self.caster.critDamage - self.arglist[1]) * context.hurt // (1000 + self.caster.critDamage)
      else
        context.isCrit = true
        context.hurt = (1000 + self.caster.critDamage - self.arglist[1]) * context.hurt // 1000
      end
      self.caster.recordTable["10129_lastRole"] = context.target
      self:OnSkillTake()
    end
  end
end

function bs_10129:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10129

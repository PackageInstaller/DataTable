local bs_10082 = class("bs_10082", LuaSkillBase)
local base = LuaSkillBase
bs_10082.config = {}

function bs_10082:ctor()
end

function bs_10082:InitSkill(isMidwaySkill)
  self.caster.recordTable.SkillTime = self.arglist[1]
  self:AddSetHurtTrigger("bs_10082_1", 1, self.OnSetHurt, nil, self.caster)
end

function bs_10082:OnSetHurt(context)
  if self:IsReadyToTake() and context.target == self.caster and self.caster.recordTable.SkillTime > 0 and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    local damage = math.max(context.hurt * self.arglist[2] // 1000)
    LuaSkillCtrl:RemoveLife(damage, self, context.sender, true)
    context.hurtAbs = 0
    LuaSkillCtrl:CallFloatText(self.caster, 8)
    self:PlayChipEffect()
    self.caster.recordTable.SkillTime = self.caster.recordTable.SkillTime - 1
    self:OnSkillTake()
  end
end

function bs_10082:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10082

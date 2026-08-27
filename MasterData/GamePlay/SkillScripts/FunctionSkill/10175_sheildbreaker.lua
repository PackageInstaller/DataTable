local bs_10175 = class("bs_10175", LuaSkillBase)
local base = LuaSkillBase
bs_10175.config = {
  sheildBuffId = 174,
  shieldKeyYuan = "50002_HuDun",
  shieldKeyJin = "50003_HuDun"
}

function bs_10175:ctor()
end

function bs_10175:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10175_3", 1000, self.OnSetHurt, self.caster)
end

function bs_10175:OnSetHurt(context)
  if context.sender == self.caster and self.caster.attackRange > 1 and context.target:GetShield(eShieldType.LongRange) > 0 then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
  if context.sender == self.caster and self.caster.attackRange == 1 and 0 < context.target:GetShield(eShieldType.NoRange) then
    context.hurt = context.hurt * (1000 + self.arglist[1]) // 1000
  end
end

function bs_10175:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10175

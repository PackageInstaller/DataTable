local bs_10178 = class("bs_10178", LuaSkillBase)
local base = LuaSkillBase
bs_10178.config = {
  sheildBuffId = 174,
  buffIdJin = 1048,
  shieldKey = "50003_HuDun",
  effectIdJin = 10373
}

function bs_10178:ctor()
end

function bs_10178:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10178_1", 100, self.OnSetHurt, self.caster)
end

function bs_10178:OnSetHurt(context)
  if context.sender == self.caster and self.caster.attackRange > 1 and LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange) > 0 then
    context.hurtMagnify:Add(self.arglist[1])
  end
end

function bs_10178:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10178

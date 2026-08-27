local bs_10177 = class("bs_10177", LuaSkillBase)
local base = LuaSkillBase
bs_10177.config = {
  sheildBuffId = 174,
  buffIdYuan = 1047,
  shieldKey = "50002_HuDun",
  effectIdYuan = 10371
}

function bs_10177:ctor()
end

function bs_10177:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10177_1", 100, self.OnSetHurt, self.caster)
end

function bs_10177:OnSetHurt(context)
  if context.sender == self.caster and self.caster.attackRange == 1 and LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange) > 0 then
    context.hurtMagnify:Add(self.arglist[1])
  end
end

function bs_10177:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10177

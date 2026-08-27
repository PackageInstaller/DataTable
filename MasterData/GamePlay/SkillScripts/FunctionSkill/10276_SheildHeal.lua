local bs_10276 = class("bs_10276", LuaSkillBase)
local base = LuaSkillBase
bs_10276.config = {buffId = 1189, buffTier = 1}

function bs_10276:ctor()
end

function bs_10276:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHealTrigger("bs_10276_4", 1, self.OnSetHeal, self.caster)
end

function bs_10276:OnSetHeal(context)
  if context.sender == self.caster and (LuaSkillCtrl:GetShield(context.target, eShieldType.Normal) > 0 or 0 < LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange) or 0 < LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)) then
    context.heal = context.heal + context.heal * self.arglist[1] // 1000
  end
end

function bs_10276:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10276

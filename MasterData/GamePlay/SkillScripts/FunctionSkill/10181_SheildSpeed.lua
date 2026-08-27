local bs_10181 = class("bs_10181", LuaSkillBase)
local base = LuaSkillBase
bs_10181.config = {sheildBuffId = 174, buffId = 1068}

function bs_10181:ctor()
end

function bs_10181:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10181_3", 1, self.OnSetHurt, self.caster)
end

function bs_10181:OnSetHurt(context)
  if context.sender == self.caster and not context.isTriggerSet and context.extraArg ~= ConfigData.buildinConfig.HurtIgnoreKey then
    if LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange) > 0 or 0 < LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange) then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
    else
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
    end
  end
end

function bs_10181:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10181

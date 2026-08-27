local bs_10184 = class("bs_10184", LuaSkillBase)
local base = LuaSkillBase
bs_10184.config = {sheildBuffId = 174, buffId = 1066}

function bs_10184:ctor()
end

function bs_10184:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetHurtTrigger("bs_10184_3", 1, self.OnSetHurt, self.caster)
end

function bs_10184:OnSetHurt(context)
  if context.sender == self.caster and not context.skill.isPassive then
    local value = LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)
    local value2 = LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange)
    if 0 < value or 0 < value2 then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, self.arglist[2])
    else
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
      return
    end
  end
end

function bs_10184:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10184

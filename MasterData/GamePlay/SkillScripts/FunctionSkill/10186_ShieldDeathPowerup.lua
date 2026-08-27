local bs_10186 = class("bs_10186", LuaSkillBase)
local base = LuaSkillBase
bs_10186.config = {sheildBuffId = 174, buffId = 1019}

function bs_10186:ctor()
end

function bs_10186:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSetDeadHurtTrigger("bs_10186_1", 99, self.OnSetDeadHurt, self.caster)
end

function bs_10186:OnSetDeadHurt(context)
  if context.sender == self.caster and context.target.belongNum ~= self.caster.belongNum then
    local value = LuaSkillCtrl:GetShield(context.target, eShieldType.NoRange)
    local value2 = LuaSkillCtrl:GetShield(context.target, eShieldType.LongRange)
    if 0 < value or 0 < value2 then
      local buffTier = context.target.pow * self.arglist[1] // 1000
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buffTier, nil, true)
    end
  end
end

function bs_10186:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10186

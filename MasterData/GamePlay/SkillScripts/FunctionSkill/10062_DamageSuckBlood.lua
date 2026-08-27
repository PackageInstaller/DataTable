local bs_10062 = class("bs_10062", LuaSkillBase)
local base = LuaSkillBase
bs_10062.config = {buffId = 105, buffTier = 1}

function bs_10062:ctor()
end

function bs_10062:InitSkill(isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10062_1", 1, self.OnHurtResultStart)
end

function bs_10062:OnHurtResultStart(skill, context)
  if context.sender == self.caster and context.sender.maxHp > context.target.maxHp then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  elseif context.sender == self.caster and context.sender.maxHp <= context.target.maxHp then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
  end
end

function bs_10062:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10062

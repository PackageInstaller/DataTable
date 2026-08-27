local bs_20006 = class("bs_20006", LuaSkillBase)
local base = LuaSkillBase
bs_20006.config = {buffId = 1097}

function bs_20006:ctor()
end

function bs_20006:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_20006_14", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_20006_15", 1, self.OnHurtResultEnd)
end

function bs_20006:OnHurtResultStart(skill, context)
  if context.sender == self.caster and context.target.intensity >= 2 then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, 1, nil, true)
  end
end

function bs_20006:OnHurtResultEnd(skill, targetRole, hurtValue)
  if targetRole == self.caster then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
  end
end

function bs_20006:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_20006

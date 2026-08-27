local bs_10221 = class("bs_10221", LuaSkillBase)
local base = LuaSkillBase
bs_10221.config = {
  buffId1 = 1078,
  buffId2 = 1079,
  buffTier = 1,
  buffId = 195
}

function bs_10221:ctor()
end

function bs_10221:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10221_1", 1, self.OnAfterBattleStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultStart, "bs_10221_2", 1, self.OnHurtResultStart)
  self:AddSelfTrigger(eSkillTriggerType.HurtResultEnd, "bs_10221_15", 1, self.OnHurtResultEnd)
end

function bs_10221:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, self.config.buffTier, nil, true)
end

function bs_10221:OnHurtResultStart(skill, context)
  if skill.maker == self.caster and not skill.isCommonAttack then
    local restTier = context.target:GetBuffTier(self.config.buffId)
    if 0 < restTier then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, restTier, nil, true)
    end
  end
end

function bs_10221:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and not skill.isCommonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
  end
end

function bs_10221:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10221

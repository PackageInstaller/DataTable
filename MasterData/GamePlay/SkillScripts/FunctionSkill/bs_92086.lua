local bs_92086 = class("bs_92086", LuaSkillBase)
local base = LuaSkillBase
bs_92086.config = {
  buffId1 = 1078,
  buffId2 = 2096,
  buffTier = 1,
  buffId_blood = 195,
  buffId_fire = 1227
}

function bs_92086:ctor()
end

function bs_92086:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_92086_1", 1, self.OnAfterBattleStart)
  self:AddHurtResultStartTrigger("bs_92086_2", 1, self.OnHurtResultStart, self.caster)
  self:AddHurtResultEndTrigger("bs_92086_15", 1, self.OnHurtResultEnd, self.caster)
end

function bs_92086:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, self.config.buffTier, nil, true)
end

function bs_92086:OnHurtResultStart(skill, context)
  if skill.maker == self.caster and skill.skillTag ~= eSkillTag.commonAttack then
    local restTier1 = context.target:GetBuffTier(self.config.buffId_blood)
    local restTier2 = context.target:GetBuffTier(self.config.buffId_fire)
    if 0 < restTier1 or 0 < restTier2 then
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, restTier1 + restTier2, nil, true)
    end
  end
end

function bs_92086:OnHurtResultEnd(skill, targetRole, hurtValue)
  if skill.maker == self.caster and skill.skillTag ~= eSkillTag.commonAttack then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
  end
end

function bs_92086:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_92086

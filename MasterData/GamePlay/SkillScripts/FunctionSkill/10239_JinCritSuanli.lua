local bs_10239 = class("bs_10239", LuaSkillBase)
local base = LuaSkillBase
bs_10239.config = {
  buffId = 1092,
  buffTier = 1,
  buffId2 = 1125
}

function bs_10239:ctor()
end

function bs_10239:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10239_3", 1, self.OnAfterHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10239_1", 2, self.OnAfterBattleStart)
end

function bs_10239:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_10239:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and self:IsReadyToTake() and not isTriggerSet then
    self:OnSkillTake()
    local buffTier = target:GetBuffTier(self.config.buffId)
    if buffTier < self.arglist[2] then
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.config.buffTier, nil, true)
    elseif buffTier > self.arglist[2] then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0, true)
      LuaSkillCtrl:CallBuff(self, target, self.config.buffId, self.arglist[2], nil, true)
    end
  end
end

function bs_10239:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10239

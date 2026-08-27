local bs_10279 = class("bs_10279", LuaSkillBase)
local base = LuaSkillBase
bs_10279.config = {
  buffId = 1190,
  buffTier = 1,
  buffId2 = 1125
}

function bs_10279:ctor()
end

function bs_10279:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterHurtTrigger("bs_10279_3", 1, self.OnAfterHurt, self.caster)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10279_1", 2, self.OnAfterBattleStart)
end

function bs_10279:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_10279:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if sender == self.caster and isCrit and self:IsReadyToTake() then
    local buffTier = sender:GetBuffTier(self.config.buffId)
    if buffTier >= self.arglist[2] then
      return
    end
    self:OnSkillTake()
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  end
end

function bs_10279:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10279

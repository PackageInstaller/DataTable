local bs_30001 = class("bs_30001", LuaSkillBase)
local base = LuaSkillBase
bs_30001.config = {buffId = 1074, buffTier = 1}

function bs_30001:ctor()
end

function bs_30001:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_30001_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_30001_2", 2, self.OnCasterAttributeChange)
end

function bs_30001:OnAfterBattleStart()
  self:OnSkillTake()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_30001:OnCasterAttributeChange()
  if self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    self:PlayChipEffect()
  end
end

function bs_30001:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_30001

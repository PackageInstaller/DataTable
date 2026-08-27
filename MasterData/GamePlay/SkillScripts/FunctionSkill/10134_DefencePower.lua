local bs_10134 = class("bs_10134", LuaSkillBase)
local base = LuaSkillBase
bs_10134.config = {buffId = 1074, buffTier = 1}

function bs_10134:ctor()
end

function bs_10134:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10134_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnSelfAttrChanged, "bs_10134_2", 2, self.OnCasterAttributeChange)
end

function bs_10134:OnAfterBattleStart()
  self:OnSkillTake()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
end

function bs_10134:OnCasterAttributeChange()
  if self:IsReadyToTake() then
    self:OnSkillTake()
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
    self:PlayChipEffect()
  end
end

function bs_10134:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10134

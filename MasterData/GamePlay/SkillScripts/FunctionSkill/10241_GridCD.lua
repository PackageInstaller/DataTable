local bs_10241 = class("bs_10241", LuaSkillBase)
local base = LuaSkillBase
bs_10241.config = {buffId = 1116}

function bs_10241:ctor()
end

function bs_10241:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10241_1", 1, self.OnAfterBattleStart)
  self:AddTrigger(eSkillTriggerType.OnGridCreatedInBattle, "bs_10241_2", 2, self.OnGridCreatedInBattle)
end

function bs_10241:OnGridCreatedInBattle(gridId, totalGridCount)
  local tier = math.min(15, totalGridCount)
  local buffTier = self.caster:GetBuffTier(self.config.buffId)
  if 0 < buffTier then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, 0)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, tier, nil, true)
  end
end

function bs_10241:OnAfterBattleStart()
  local tier = LuaSkillCtrl:CallGetTotalEfcGridCount()
  tier = math.min(15, tier)
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, tier, nil, true)
end

function bs_10241:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10241

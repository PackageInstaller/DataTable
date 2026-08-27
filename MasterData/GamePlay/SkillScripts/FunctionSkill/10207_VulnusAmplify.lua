local bs_10207 = class("bs_10207", LuaSkillBase)
local base = LuaSkillBase
bs_10207.config = {
  damageConfig1 = {basehurt_formula = 10034},
  damageConfig2 = {basehurt_formula = 10073},
  buffId = 195,
  effectId = 1049,
  effectId1 = 10753,
  buffId2 = 1124,
  buffId3 = 1183,
  buffTier = 1
}

function bs_10207:ctor()
end

function bs_10207:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10207_1", 2, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_10207_2", 1, self.OnAfterAddBuff, self.caster, nil, nil, nil, self.config.buffId)
end

function bs_10207:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, 1, nil, true)
end

function bs_10207:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.buffId and self.caster:GetBuffTier(self.config.buffId3) < self.arglist[3] then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId3, self.config.buffTier, nil, true)
  end
end

function bs_10207:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10207

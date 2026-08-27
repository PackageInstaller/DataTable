local bs_15219 = class("bs_15219", LuaSkillBase)
local base = LuaSkillBase
bs_15219.config = {
  buffId1 = 110116,
  buffId2 = 110117,
  freezeBuff = 1178
}

function bs_15219:ctor()
end

function bs_15219:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_15219_1", 1, self.OnAfterBattleStart)
  self:AddAfterBuffRemoveTrigger("bs_15217_2", 4, self.AfterBuffRemove, self.caster, nil, self.config.freezeBuff)
  self:AddAfterAddBuffTrigger("bs_15217_3", 1, self.OnAfterAddBuff, nil, self.caster, nil, nil, self.config.freezeBuff)
end

function bs_15219:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, 1, nil, true)
end

function bs_15219:AfterBuffRemove(buffId, target, removeType)
  if target == self.caster and buffId == self.config.freezeBuff then
    local buffTier = self.caster:GetBuffTier(self.config.freezeBuff)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
  end
end

function bs_15219:OnAfterAddBuff(buff, target)
  if target == self.caster then
    local buffTier = self.caster:GetBuffTier(self.config.freezeBuff)
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0, true)
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buffTier, nil, true)
  end
end

function bs_15219:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_15219

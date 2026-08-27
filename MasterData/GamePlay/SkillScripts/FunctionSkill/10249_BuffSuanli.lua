local bs_10249 = class("bs_10249", LuaSkillBase)
local base = LuaSkillBase
bs_10249.config = {
  buffId1 = 1135,
  buffId2 = 1136,
  buffTier = 1,
  checkBuffId = 1088
}

function bs_10249:ctor()
end

function bs_10249:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterBattleStart, "bs_10249_1", 1, self.OnAfterBattleStart)
  self:AddAfterAddBuffTrigger("bs_10249_7", 2, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.checkBuffId)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10249_11", 3, self.OnBuffDie)
  self.buffNum = 0
end

function bs_10249:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.checkBuffId then
    self.buffNum = self.buffNum + buff.tier
    local buff_limit = self.arglist[3]
    if buff_limit >= self.buffNum then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, self.buffNum, nil, true)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buff_limit, nil, true)
    end
  end
end

function bs_10249:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.checkBuffId then
    self.buffNum = math.max(0, self.buffNum - buff.tier)
    local buff_limit = self.arglist[3]
    if buff_limit >= self.buffNum then
      LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId2, 0)
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, self.buffNum, nil, true)
    else
      LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId2, buff_limit, nil, true)
    end
  end
end

function bs_10249:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId1, self.config.buffTier, nil, true)
  self:PlayChipEffect()
end

function bs_10249:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10249

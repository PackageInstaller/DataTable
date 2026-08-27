local bs_10210 = class("bs_10210", LuaSkillBase)
local base = LuaSkillBase
bs_10210.config = {
  checkBuffId = 1059,
  buffId = 1060,
  buffStartId = 1173
}

function bs_10210:ctor()
end

function bs_10210:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddAfterAddBuffTrigger("bs_10210_7", 1, self.OnAfterAddBuff, nil, nil, nil, nil, self.config.checkBuffId)
  self:AddTrigger(eSkillTriggerType.BuffDie, "bs_10210_9", 1, self.OnBuffDie)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_10210_1", 1, self.OnAfterBattleStart)
end

function bs_10210:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffStartId, 1, nil, true)
end

function bs_10210:OnAfterAddBuff(buff, target)
  if buff.dataId == self.config.checkBuffId then
    LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, buff.tier, nil, true)
    self:PlayChipEffect()
  end
end

function bs_10210:OnBuffDie(buff, target, removeType)
  if buff.dataId == self.config.checkBuffId then
    LuaSkillCtrl:DispelBuff(self.caster, self.config.buffId, buff.tier, true)
  end
end

function bs_10210:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_10210

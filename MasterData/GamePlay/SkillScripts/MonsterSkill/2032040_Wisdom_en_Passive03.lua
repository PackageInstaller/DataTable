local bs_2032040 = class("bs_2032040", LuaSkillBase)
local base = LuaSkillBase
bs_2032040.config = {
  skill_time = 31,
  start_time = 17,
  actionId = 1002,
  action_speed = 1,
  audioId1 = 251,
  buffId_Hua = 102502,
  buffId_CH = 102501,
  buffId_170 = 170,
  effectId_trail = 102503,
  effectId_P = 105791,
  effectId_hit2 = 102505,
  HurtConfig = {
    hit_formula = 0,
    basehurt_formula = 3000,
    crit_formula = 0,
    crithur_ratio = 0
  },
  ex_hurttime = 3,
  buffId_tip = 102503,
  commonAttackId = 532,
  timeDuration = 15
}

function bs_2032040:ctor()
end

function bs_2032040:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self:AddSelfTrigger(eSkillTriggerType.AfterPlaySkill, "bs_2032040_2", 1, self.OnAfterPlaySkill)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_2032040_1", 1, self.OnAfterBattleStart)
  self.caster.recordTable["203204_attakflag"] = false
  self.caster.recordTable["203204_arg"] = self.arglist[1]
  self.attackNum = 0
  self.totalTime = 1800
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_2032040:OnAfterPlaySkill(skill, role)
  if role == self.caster and skill.isCommonAttack then
    self.attackNum = self.attackNum + 1
    if self.attackNum >= 2 then
      self.attackNum = 0
      self.caster.recordTable["203204_attakflag"] = true
    end
  end
end

function bs_2032040:OnAfterBattleStart()
  LuaSkillCtrl:StartTimer(nil, 15, BindCallback(self, self.CountDown), nil, 119, 15)
end

function bs_2032040:CountDown()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  if self.timeValue <= 0 then
    LuaSkillCtrl:ForceEndBattle(false)
  end
end

function bs_2032040:OnCasterDie()
  base.OnCasterDie(self)
end

return bs_2032040

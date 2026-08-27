local bs_70002 = class("bs_70002", LuaSkillBase)
local base = LuaSkillBase
bs_70002.config = {
  buffId = 66,
  buffTier = 1,
  timeDuration = 15,
  formula1 = 10153,
  formula2 = 10154,
  formula3 = 10155,
  actionId = 1103,
  audioId1 = 391
}

function bs_70002:ctor()
end

function bs_70002:InitSkill(isMidwaySkill)
  base.InitSkill(self, isMidwaySkill)
  self.totalTime = self.arglist[2]
  self.timeValue = self.totalTime
  LuaSkillCtrl:SetGameScoreAcitve(2, true)
  LuaSkillCtrl:SetGameScoreValue(2, self.timeValue // 15)
  LuaSkillCtrl:SetGameScoreAcitve(3, true)
  LuaSkillCtrl:SetGameScoreValue(3, 0)
  local arriveCallBack = BindCallback(self, self.OnArriveAction)
  LuaSkillCtrl:StartTimer(nil, self.config.timeDuration, arriveCallBack, self, -1)
  local timeCallBack = BindCallback(self, self.TimeUp)
  LuaSkillCtrl:StartTimer(nil, self.totalTime, timeCallBack)
  self:AddTrigger(eSkillTriggerType.AfterBattleStart, "bs_70002_1", 1, self.OnAfterBattleStart)
  self:AddAfterHurtTrigger("bs_70002_3", 2, self.OnAfterHurt, nil, self.caster)
  self.isAction = false
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
end

function bs_70002:OnAfterHurt(sender, target, skill, hurt, isMiss, isCrit, hurtType, isTriggerSet)
  if target == self.caster and not isMiss and not self.isAction then
    LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
    if self.caster.hp * 2 < self.caster.maxHp then
      LuaSkillCtrl:CallRoleAction(self.caster, self.config.actionId)
      self.isAction = true
    end
  end
end

function bs_70002:OnAfterBattleStart()
  LuaSkillCtrl:CallBuff(self, self.caster, self.config.buffId, self.config.buffTier, nil, true)
  LuaSkillCtrl:CallBuff(self, self.caster, 198, 1, nil, true)
end

function bs_70002:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  local score = (self.caster.maxHp - self.caster.hp) * 1000 // self.caster.maxHp
  local showScore = score
  if 600 < score then
    showScore = LuaSkillCtrl:CallFormulaNumber(self.config.formula1, self.caster, self.caster, score)
  elseif 200 < score then
    showScore = LuaSkillCtrl:CallFormulaNumber(self.config.formula2, self.caster, self.caster, score)
  else
    showScore = LuaSkillCtrl:CallFormulaNumber(self.config.formula3, self.caster, self.caster, score)
  end
  LuaSkillCtrl:SetGameScoreValue(3, showScore)
  LuaSkillCtrl:BattlegroundDrop(self.caster.curCoord, 3, "FXP_Common_diaoluo_DGB")
end

function bs_70002:TimeUp()
  local score = (self.caster.maxHp - self.caster.hp) * 1000 // self.caster.maxHp
  LuaSkillCtrl:SetFinalScoreValue(2, score)
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_70002:PlaySkill(data)
end

function bs_70002:OnCasterDie()
  base.OnCasterDie(self)
  LuaSkillCtrl:SetFinalScoreValue(2, 1000)
  LuaSkillCtrl:ForceEndBattle(true)
end

return bs_70002

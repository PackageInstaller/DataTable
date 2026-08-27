local bs_70000 = class("bs_70000", LuaSkillBase)
local base = LuaSkillBase
bs_70000.config = {
  timeDuration = 15,
  animID = 1002,
  animLoopTime = 30,
  formula1 = 10153,
  formula2 = 10154,
  formula3 = 10155,
  audioId1 = 389,
  audioId2 = 390
}

function bs_70000:ctor()
end

function bs_70000:InitSkill(isMidwaySkill)
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
  local arriveCallBack2 = BindCallback(self, self.OnProAction)
  LuaSkillCtrl:StartTimer(nil, self.config.animLoopTime, arriveCallBack2, self, -1)
  self:AddSetHealTrigger("bs_70000_5", 1, self.OnSetHeal, nil, self.caster)
  self:AddSetHurtTrigger("bs_70000_2", 30, self.OnSetHurt, nil, self.caster)
  LuaSkillCtrl:RecordLimitTime(self.totalTime)
  self.caster.recordTable.IsGuardPro = true
end

function bs_70000:OnSetHeal(context)
  if context.target == self.caster then
    context.heal = 0
  end
end

function bs_70000:OnSetHurt(context)
  if context.target == self.caster then
    local hurt = self.caster.maxHp // self.arglist[1] + 1
    context.hurt = hurt
  end
end

function bs_70000:OnProAction()
  LuaSkillCtrl:CallRoleAction(self.caster, self.config.animID)
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId1)
  local playVFX = BindCallback(self, self.OnPlayVFX)
  LuaSkillCtrl:StartTimer(nil, 12, playVFX, self)
end

function bs_70000:OnPlayVFX()
  LuaSkillCtrl:PlayAuSource(self.caster, self.config.audioId2)
  LuaSkillCtrl:BattlegroundDrop(self.caster.curCoord, 3, "FXP_Common_diaoluo_JNS")
end

function bs_70000:OnArriveAction()
  self.timeValue = self.timeValue - self.config.timeDuration
  local showTime = self.timeValue // 15
  local score = (self.totalTime - self.timeValue) * 1000 // self.totalTime
  local showScore = score
  if 600 < score then
    showScore = LuaSkillCtrl:CallFormulaNumber(self.config.formula1, self.caster, self.caster, score)
  elseif 200 < score then
    showScore = LuaSkillCtrl:CallFormulaNumber(self.config.formula2, self.caster, self.caster, score)
  else
    showScore = LuaSkillCtrl:CallFormulaNumber(self.config.formula3, self.caster, self.caster, score)
  end
  LuaSkillCtrl:SetGameScoreValue(2, showTime)
  LuaSkillCtrl:SetGameScoreValue(3, showScore)
end

function bs_70000:TimeUp()
  LuaSkillCtrl:SetFinalScoreValue(2, 1000)
  LuaSkillCtrl:ForceEndBattle(true)
end

function bs_70000:OnCasterDie()
  base.OnCasterDie(self)
  local score = (self.totalTime - self.timeValue) * 1000 // self.totalTime
  LuaSkillCtrl:SetFinalScoreValue(2, score)
  LuaSkillCtrl:ForceEndBattle(true)
end

return bs_70000

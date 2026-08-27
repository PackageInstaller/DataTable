local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightRuleCtrl = class("DormFightRuleCtrl", DormFightCtrlBase)

function DormFightRuleCtrl:ctor()
  self._isDoing = false
  self.isPause = false
  self._scoreInfo = {}
  self._countdown = 0
  self._fightResultDelegate = nil
  self._countdownChangedDelegate = nil
  self._scoreChangedDelegate = nil
end

function DormFightRuleCtrl:OnInit()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local characterCtrl = dormCtrl:GetCharacterCtrl()
  if characterCtrl ~= nil then
    characterCtrl:SetSomeoneKnockOutDelegate(BindCallback(self, self.OnSomeoneLossHp))
  end
  self:RecoveryCountdown()
end

function DormFightRuleCtrl:OnUpdate(deltaTime)
  if not self._isDoing then
    return
  end
  if self.isPause then
    return
  end
  self._countdown = self._countdown - deltaTime
  if self._countdownChangedDelegate ~= nil then
    self._countdownChangedDelegate(self._countdown)
  end
  if self._countdown <= 0 then
    self:PostResult(DormFightConst.DormFightResult.Tie)
  end
end

function DormFightRuleCtrl:StopCountdown()
  self.isPause = true
end

function DormFightRuleCtrl:RecoveryCountdown()
  self.isPause = false
end

function DormFightRuleCtrl:AddComp(comp)
  self._scoreInfo[comp] = DormFightConst.MaxScore
end

function DormFightRuleCtrl:GetScore(comp)
  return comp and self._scoreInfo[comp] or 0
end

function DormFightRuleCtrl:GetScoreMax(comp)
  return DormFightConst.MaxScore
end

function DormFightRuleCtrl:GetCountdown()
  return self._countdown
end

function DormFightRuleCtrl:OnFightTrueStart()
  self._isDoing = true
  self._countdown = DormFightConst.FightDuration
end

function DormFightRuleCtrl:OnFightEnd()
  self._isDoing = false
  self._fightResultDelegate = nil
  self._scoreInfo = {}
end

function DormFightRuleCtrl:OnSomeoneLossHp(comp)
  if comp == nil or self._scoreInfo == nil or self._scoreInfo[comp] == nil then
    return
  end
  local current = self._scoreInfo[comp]
  self._scoreInfo[comp] = current - 1
  if self._scoreChangedDelegate ~= nil then
    self._scoreChangedDelegate(comp, self._scoreInfo[comp], self:GetScoreMax(comp))
  end
  if self._scoreInfo[comp] <= 0 then
    local result = comp == DormFightConst.DormFightComp.Myself and DormFightConst.DormFightResult.Loss or DormFightConst.DormFightResult.Win
    self:PostResult(result)
  end
end

function DormFightRuleCtrl:PostResult(result)
  if self._fightResultDelegate ~= nil then
    self._fightResultDelegate(result)
  end
  self._fightResultDelegate = nil
end

function DormFightRuleCtrl:SetFightResultDelegate(listener)
  self._fightResultDelegate = listener
end

function DormFightRuleCtrl:SetCountDownChangedDelegate(listener)
  self._countdownChangedDelegate = listener
end

function DormFightRuleCtrl:SetScoreChangedDelegate(listener)
  self._scoreChangedDelegate = listener
end

return DormFightRuleCtrl

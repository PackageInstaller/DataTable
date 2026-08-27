local DormFightConst = require("Game.Fight.DormFightConst")
local CS_UnityEngine_Camera = CS.UnityEngine.Camera
local DormFightCtrlBase = require("Game.Fight.Ctrl.DormFightCtrlBase")
local DormFightSceneUiCtrl = class("DormFightSceneUiCtrl", DormFightCtrlBase)

function DormFightSceneUiCtrl:ctor()
  self._sceneUiRoot = nil
  self._sceneCamera = nil
end

function DormFightSceneUiCtrl:OnInit()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local ruleCtrl = dormCtrl:GetRuleCtrl()
  if ruleCtrl ~= nil then
    ruleCtrl:SetCountDownChangedDelegate(BindCallback(self, self.OnCountDownChanged))
    ruleCtrl:SetScoreChangedDelegate(BindCallback(self, self.OnScoreChanged))
  end
end

function DormFightSceneUiCtrl:OnEnterFightScene()
  self._sceneCamera = CS_UnityEngine_Camera.main
end

function DormFightSceneUiCtrl:OnFightStart()
  self._sceneUiRoot = UIManager:ShowWindow(UIWindowTypeID.FightScene)
  if isGameDev then
    UIManager:ShowWindow(UIWindowTypeID.FightDebug)
  end
end

function DormFightSceneUiCtrl:OnFightEnd()
  UIManager:HideWindow(UIWindowTypeID.FightScene)
end

function DormFightSceneUiCtrl:OnExitFightScene()
  self._sceneUiRoot = nil
end

function DormFightSceneUiCtrl:OnCountDownChanged(countdown)
  self:SetCountdown(countdown)
end

function DormFightSceneUiCtrl:OnScoreChanged(comp, score, scoreMax)
  self:SetScore(comp, score, scoreMax)
end

function DormFightSceneUiCtrl:CreateSceneUi(sceneUiType)
  return self._sceneUiRoot ~= nil and self._sceneUiRoot:CreateSceneUi(sceneUiType) or -1
end

function DormFightSceneUiCtrl:ClearAllSceneUi()
  if self._sceneUiRoot ~= nil then
    self._sceneUiRoot:ClearAllSceneUi()
  end
end

function DormFightSceneUiCtrl:UpdatePosition(index, position)
  if self._sceneUiRoot == nil then
    return
  end
  local screenPos = self._sceneCamera:WorldToScreenPoint(position)
  self._sceneUiRoot:UpdatePosition(index, screenPos)
end

function DormFightSceneUiCtrl:SetName(index, name)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetName(index, name)
end

function DormFightSceneUiCtrl:SetNamePlateStyle(index, isSelf)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetNamePlateStyle(index, isSelf)
end

function DormFightSceneUiCtrl:SetVitalityRatio(index, ratio)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetVitalityRatio(index, ratio)
end

function DormFightSceneUiCtrl:ShowVitalityNode(index)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:ShowVitalityNode(index)
end

function DormFightSceneUiCtrl:ShowStartCountDown(countdown)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:ShowStartCountDown(countdown)
end

function DormFightSceneUiCtrl:SetUserInfo(comp, userInfo)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetUserInfo(comp, userInfo)
end

function DormFightSceneUiCtrl:SetScore(comp, score, scoreMax)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetScore(comp, score, scoreMax)
end

function DormFightSceneUiCtrl:SetCountdown(countdown)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetCountdown(countdown)
end

function DormFightSceneUiCtrl:SetCountdownVisible(visible)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetCountdownVisible(visible)
end

function DormFightSceneUiCtrl:SetDragListener(listener)
  if self._sceneUiRoot == nil then
    return
  end
  self._sceneUiRoot:SetDragListener(listener)
end

function DormFightSceneUiCtrl:UpdateDisplay()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.DormFight)
  local ruleCtrl = dormCtrl:GetRuleCtrl()
  if ruleCtrl == nil then
    return
  end
  self:SetCountdown(ruleCtrl:GetCountdown())
  self:SetScore(DormFightConst.DormFightComp.Myself, ruleCtrl:GetScore(DormFightConst.DormFightComp.Myself), ruleCtrl:GetScoreMax(DormFightConst.DormFightComp.Myself))
  self:SetScore(DormFightConst.DormFightComp.Enemy, ruleCtrl:GetScore(DormFightConst.DormFightComp.Enemy), ruleCtrl:GetScoreMax(DormFightConst.DormFightComp.Enemy))
end

function DormFightSceneUiCtrl:ShowResultView(userInfo, resultType)
  local resultView = UIManager:ShowWindow(UIWindowTypeID.FightResult)
  if resultView ~= nil then
    resultView:SetResult(userInfo, resultType)
  end
end

return DormFightSceneUiCtrl

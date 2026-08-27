local util = require("XLua.Common.xlua_util")
local DormFightConst = require("Game.Fight.DormFightConst")
local DormFightController = class("DormFightController", ControllerBase)
local DormFightSceneCtrl = require("Game.Fight.Ctrl.DormFightSceneCtrl")
local DormFightCharacterCtrl = require("Game.Fight.Ctrl.DormFightCharacterCtrl")
local DormFightSceneUiCtrl = require("Game.Fight.Ctrl.DormFightSceneUiCtrl")
local DormFightRuleCtrl = require("Game.Fight.Ctrl.DormFightRuleCtrl")
local DormFightCameraCtrl = require("Game.Fight.Ctrl.DormFightCameraCtrl")

function DormFightController:OnInit()
  self.ctrls = {}
  self._myUserInfo = nil
  self._opUserInfo = nil
  self._countdownTimer = nil
  self._dormStartWindow = nil
  self._updateHandler = nil
  self._sceneCtrl = DormFightSceneCtrl.New(self)
  self._characterCtrl = DormFightCharacterCtrl.New(self)
  self._sceneUiCtrl = DormFightSceneUiCtrl.New(self)
  self._ruleCtrl = DormFightRuleCtrl.New(self)
  self._cameraCtrl = DormFightCameraCtrl.New(self)
  self:OnChildCtrlInit()
end

function DormFightController:EnterScene(myUserInfo, opUserInfo)
  self._myUserInfo = myUserInfo
  self._opUserInfo = opUserInfo
  UIManager:DeleteAllWindow()
  
  local function preLoadFunc()
    UIManager:ShowWindowAsync(UIWindowTypeID.FightStart)
    repeat
      coroutine.yield(nil)
      self._dormStartWindow = UIManager:GetWindow(UIWindowTypeID.FightStart)
    until self._dormStartWindow
  end
  
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Fight, function()
    if self._dormStartWindow ~= nil then
      self._dormStartWindow:Refresh(self._myUserInfo, self._opUserInfo)
    end
    self:OnChildCtrlEnterScene()
    self:StartUpdate()
  end, util.cs_generator(preLoadFunc))
end

function DormFightController:InitComp()
  if self._myUserInfo ~= nil then
    self._ruleCtrl:AddComp(DormFightConst.DormFightComp.Myself)
    local myName = self._myUserInfo:GetUserName()
    local characterId = self._myUserInfo:GetSex() and DormFightConst.FemaleProfessorIdDefine or DormFightConst.MaleProfessorIdDefine
    self._characterCtrl:AddCharacter(characterId, DormFightConst.CharacterType.Player, true, myName, DormFightConst.DormFightComp.Myself, DormFightConst.BornPositions[1], Quaternion.LookRotation(DormFightConst.BornPositions[3] - DormFightConst.BornPositions[1], Vector3.up))
    self._characterCtrl:AddCharacter(self._myUserInfo:GetShowGirlId(), DormFightConst.CharacterType.Npc, false, myName, DormFightConst.DormFightComp.Myself, DormFightConst.BornPositions[2], Quaternion.LookRotation(DormFightConst.BornPositions[4] - DormFightConst.BornPositions[2], Vector3.up))
  end
  if self._opUserInfo ~= nil then
    self._ruleCtrl:AddComp(DormFightConst.DormFightComp.Enemy)
    local opName = self._opUserInfo:GetUserName()
    local characterId = self._opUserInfo:GetSex() and DormFightConst.FemaleProfessorIdDefine or DormFightConst.MaleProfessorIdDefine
    self._characterCtrl:AddCharacter(characterId, DormFightConst.CharacterType.Npc, true, opName, DormFightConst.DormFightComp.Enemy, DormFightConst.BornPositions[3], Quaternion.LookRotation(DormFightConst.BornPositions[1] - DormFightConst.BornPositions[3], Vector3.up))
    self._characterCtrl:AddCharacter(self._opUserInfo:GetShowGirlId(), DormFightConst.CharacterType.Npc, false, opName, DormFightConst.DormFightComp.Enemy, DormFightConst.BornPositions[4], Quaternion.LookRotation(DormFightConst.BornPositions[2] - DormFightConst.BornPositions[4], Vector3.up))
  end
end

function DormFightController:GetCharacterCtrl()
  return self._characterCtrl
end

function DormFightController:GetSceneCtrl()
  return self._sceneCtrl
end

function DormFightController:GetSceneUiCtrl()
  return self._sceneUiCtrl
end

function DormFightController:GetRuleCtrl()
  return self._ruleCtrl
end

function DormFightController:GetCameraCtrl()
  return self._cameraCtrl
end

function DormFightController:StartFight()
  self:OnChildCtrlStartFight()
  self:InitComp()
  self._sceneUiCtrl:UpdateDisplay()
  self._sceneUiCtrl:SetUserInfo(DormFightConst.DormFightComp.Myself, self._myUserInfo)
  self._sceneUiCtrl:SetUserInfo(DormFightConst.DormFightComp.Enemy, self._opUserInfo)
  self:StopStartCountDown()
  self._sceneUiCtrl:ShowStartCountDown(DormFightConst.StartCountdown)
  self._sceneUiCtrl:SetCountdownVisible(false)
  self._countdownTimer = TimerManager:StartTimer(DormFightConst.StartCountdown, self.TrueStartFight, self, true, false, false)
end

function DormFightController:TrueStartFight()
  self:OnChildCtrlTrueStartFight()
  self._sceneUiCtrl:SetCountdownVisible(true)
  self._ruleCtrl:SetFightResultDelegate(BindCallback(self, self.OnFightResult))
end

function DormFightController:DebugRestartDoubleMode()
  self:StopUpdate()
  self:OnChildCtrlEndFight()
  self._characterCtrl:DestroyAllCharacter()
  self._sceneUiCtrl:ClearAllSceneUi()
  self:OnChildCtrlStartFight()
  self:InitComp()
  self:TrueStartFight()
  self:DeBugRule()
  self:StartUpdate()
end

function DormFightController:DebugRestartSingleMode()
  self:StopUpdate()
  self:OnChildCtrlEndFight()
  self._characterCtrl:DestroyAllCharacter()
  self._sceneUiCtrl:ClearAllSceneUi()
  self:OnChildCtrlStartFight()
  if self._myUserInfo ~= nil then
    self._ruleCtrl:AddComp(DormFightConst.DormFightComp.Myself)
    local myName = self._myUserInfo:GetUserName()
    local characterId = self._myUserInfo:GetSex() and DormFightConst.FemaleProfessorIdDefine or DormFightConst.MaleProfessorIdDefine
    self._characterCtrl:AddCharacter(characterId, DormFightConst.CharacterType.Player, true, myName, DormFightConst.DormFightComp.Myself, DormFightConst.BornPositions[1], Quaternion.identity)
    self:TrueStartFight()
  end
  self:DeBugRule()
  self:StartUpdate()
end

function DormFightController:StopStartCountDown()
  if self._countdownTimer ~= nil then
    TimerManager:StopTimer(self._countdownTimer)
    self._countdownTimer = nil
  end
end

function DormFightController:OnFightResult(resultType)
  self:StopUpdate()
  self:OnChildCtrlEndFight()
  self._sceneUiCtrl:ShowResultView(self._myUserInfo, resultType)
end

function DormFightController:ExitScene()
  self:StopUpdate()
  self:StopStartCountDown()
  UIManager:DeleteAllWindow()
  self:OnChildCtrlExitScene()
  CS.GSceneManager.Instance:LoadSceneAsyncByAB(Consts.SceneName.Main, function(ok)
    ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
    UIManager:ShowWindowAsync(UIWindowTypeID.Home, function(window)
      if window == nil then
        return
      end
      window:SetFrom2Home(AreaConst.FactoryDorm, true)
    end)
  end)
end

function DormFightController:StartUpdate()
  self:StopUpdate()
  self._updateHandler = TimerManager:StartTimer(1, self.Update, self, false, true, false)
end

function DormFightController:StopUpdate()
  if self._updateHandler ~= nil then
    TimerManager:StopTimer(self._updateHandler)
    self._updateHandler = nil
  end
end

function DormFightController:DeBugRule()
  local ruleCtrl = self:GetRuleCtrl()
  ruleCtrl:StopCountdown()
end

function DormFightController:Update()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnUpdate(Time.deltaTime)
  end
end

function DormFightController:OnChildCtrlInit()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnInit()
  end
end

function DormFightController:OnChildCtrlStartFight()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnFightStart()
  end
end

function DormFightController:OnChildCtrlTrueStartFight()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnFightTrueStart()
  end
end

function DormFightController:OnChildCtrlEndFight()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnFightEnd()
  end
end

function DormFightController:OnChildCtrlEnterScene()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnEnterFightScene()
  end
end

function DormFightController:OnChildCtrlExitScene()
  for _, ctrl in ipairs(self.ctrls) do
    ctrl:OnExitFightScene()
  end
end

function DormFightController:OnDelete()
  self:StopUpdate()
  self:StopStartCountDown()
end

return DormFightController

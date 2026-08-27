local base = require("Game.Exploration.MainCtrl.EpMainCtrlBase")
local EpLightMainCtrl = class("EpLightMainCtrl", base)
local EpLightBattleCtrl = require("Game.Exploration.Light.Ctrl.EpLightBattleCtrl")
local ExplorationTDPlayerCtrl = require("Game.BattleTowerDefence.Ctrl.ExplorationTDPlayerCtrl")
local EpLightSceneCtrl = require("Game.Exploration.Light.Ctrl.EpLightSceneCtrl")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local util = require("XLua.Common.xlua_util")

function EpLightMainCtrl:ctor(mapData, dynPlayer)
  print("todo是轻量级无地图显示探索")
  self.__enterBattleCount = 0
  self.__showLightProcessAndNext = BindCallback(self, self.ShowLightProcessAndNext)
  self._outsideTheRoomFunc = BindCallback(self, self.__OutsideTheRoom)
  self._afterOutSideNextFunc = BindCallback(self, self.__AfterOutSideNext)
  local unlockProcessView = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_SerialBattleUI)
  self.__unlockProcessView = unlockProcessView
end

function EpLightMainCtrl:InitEpMainSubCtrls()
  base.InitEpMainSubCtrls(self)
  self.battleCtrl = EpLightBattleCtrl.New(self)
  self.playerCtrl = ExplorationTDPlayerCtrl.New(self)
  self.sceneCtrl = EpLightSceneCtrl.New(self)
end

function EpLightMainCtrl:__EnterExplorationScene(state)
  self.sceneCtrl:SetLightInBattleScene(false)
  self.__playerState = state
  self:__OnEnterEpSceneComplete()
end

function EpLightMainCtrl:__OnEnterEpSceneComplete()
  base.__OnEnterEpScene(self)
end

function EpLightMainCtrl:__EnterBattleScene(roomData, isReconnect)
  self.sceneCtrl:SetLightInBattleScene(true)
  if self.sceneCtrl:IsRoleChangingState() then
    self.__waitEnterBattleCo = GR.StartCoroutine(util.cs_generator(function()
      while self.sceneCtrl:IsRoleChangingState() do
        coroutine.yield()
      end
      self.__waitEnterBattleCo = nil
      self:__EnterBattleSceneLogic(roomData, isReconnect)
    end))
  else
    self:__EnterBattleSceneLogic(roomData, isReconnect)
  end
end

function EpLightMainCtrl:__EnterBattleSceneLogic(roomData, isReconnect)
  base.__EnterBattleScene(self, roomData, isReconnect)
  CS.CameraController.Instance:OnBattleExit()
  local csbattleCtrl = self.battleCtrl:StartNewEpBattle(roomData, self.dynPlayer)
  csbattleCtrl:PlayRecycleRoleEffect()
  if self.__enterBattleCount > 0 then
    self.sceneCtrl:BattleToBattleSceneNormal(function()
      csbattleCtrl:StartEnterDeployState()
    end)
  else
    csbattleCtrl:StartEnterDeployState()
  end
  self.__enterBattleCount = self.__enterBattleCount + 1
end

function EpLightMainCtrl:OnStartTimelineComplete()
  base.OnStartTimelineComplete(self)
  local dungeonWindow = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if dungeonWindow ~= nil then
    dungeonWindow:Show()
  end
end

function EpLightMainCtrl:TryEnterNextLightRoom()
  local curRoomData = self:GetCurrentRoomData()
  local nextRoomList = curRoomData:GetNextRoom()
  local nextRoomData = nextRoomList[1]
  if self.sceneCtrl:IsRoleChangingState() then
    self.__waitEnterNextRoomCo = GR.StartCoroutine(util.cs_generator(function()
      while self.sceneCtrl:IsRoleChangingState() do
        coroutine.yield()
      end
      self.__waitEnterNextRoomCo = nil
      self.playerCtrl:Move(nextRoomData)
    end))
  else
    self.playerCtrl:Move(nextRoomData)
  end
end

function EpLightMainCtrl:__OutsideTheRoom()
  self:TryEnterNextLightRoom()
end

function EpLightMainCtrl:__AfterOutSideNext()
  if not self.residentStoreCtrl:CheckEpResidentStore(self._outsideTheRoomFunc) then
    self._outsideTheRoomFunc()
  end
end

function EpLightMainCtrl:CheckAfterOutSide()
  base.CheckAfterOutSide(self)
  local opDetail = self.dynPlayer:GetOperatorDetail()
  local opState = opDetail.state
  if opState ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Over then
    return
  end
  self:CheckBossRoom(self.__showLightProcessAndNext)
end

function EpLightMainCtrl:ShowLightProcessAndNext()
  if not self.__unlockProcessView or self.autoCtrl:IsAutoModeRunning() then
    self._afterOutSideNextFunc()
    return
  end
  self:__ShowLightProcessView(self._afterOutSideNextFunc)
end

function EpLightMainCtrl:__ShowLightProcessView(continueFunc)
  UIManager:ShowWindowAsync(UIWindowTypeID.TDProcessView, function(window)
    if window == nil then
      if continueFunc ~= nil then
        continueFunc()
      end
      return
    end
    local opDetail = self.dynPlayer:GetOperatorDetail()
    local x, y = ExplorationManager.Coordination2Pos(opDetail.curPostion)
    window:RefreshLightProcessView(self.mapData, x + 1, x, function()
      if continueFunc ~= nil then
        continueFunc()
      end
    end)
    local isReinforceCardEp = ExplorationManager:IsReinforceCardEp()
    if isReinforceCardEp then
      local mapData = ExplorationManager.epCtrl.mapData
      local gradeUp = mapData:GetReCardGradeUp()
      local gradeDown = mapData:GetReCardGradeDown()
      window:RefreshFactorTip(gradeUp, gradeDown)
    end
  end)
end

function EpLightMainCtrl:GetSupportAutoEpType()
  return ExplorationEnum.eAutoEpSwitchType.Battle
end

function EpLightMainCtrl:IsEpAutoSelectRoom()
  return true
end

function EpLightMainCtrl:OnDelete()
  if self.__waitEnterBattleCo ~= nil then
    GR.StopCoroutine(self.__waitEnterBattleCo)
    self.__waitEnterBattleCo = nil
  end
  if self.__waitEnterNextRoomCo ~= nil then
    GR.StopCoroutine(self.__waitEnterNextRoomCo)
    self.__waitEnterNextRoomCo = nil
  end
  base.OnDelete(self)
end

return EpLightMainCtrl

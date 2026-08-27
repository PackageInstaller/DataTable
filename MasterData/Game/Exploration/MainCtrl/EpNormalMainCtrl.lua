local base = require("Game.Exploration.MainCtrl.EpMainCtrlBase")
local EpNormalMainCtrl = class("EpNormalMainCtrl", base)
local ExplorationPlayerCtrl = require("Game.Exploration.Ctrl.ExplorationPlayerCtrl")
local ExplorationMapCtrl = require("Game.Exploration.Ctrl.ExplorationMapCtrl")
local ExplorationBattleCtrl = require("Game.Exploration.Ctrl.ExplorationBattleCtrl")
local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local ePlayerState = base.ePlayerState
local cs_MessageCommon = CS.MessageCommon
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function EpNormalMainCtrl:ctor(mapData, dynPlayer)
end

function EpNormalMainCtrl:InitEpMainSubCtrls()
  base.InitEpMainSubCtrls(self)
  self.playerCtrl = ExplorationPlayerCtrl.New(self)
  self.mapCtrl = ExplorationMapCtrl.New(self)
  self.battleCtrl = ExplorationBattleCtrl.New(self)
  self.sceneCtrl = ExplorationSceneCtrl.New(self)
end

function EpNormalMainCtrl:Start(isReconnect, isFirstEnter)
  base.Start(self, isReconnect, isFirstEnter)
end

function EpNormalMainCtrl:__EnterExplorationScene(state)
  ExplorationManager:PlayEpAuSelctRoomSelect()
  base.__EnterExplorationScene(self, state)
end

function EpNormalMainCtrl:__OnEnterEpSceneComplete()
  base.__TryShowOperationBeforeEpSceneComplete(self)
end

function EpNormalMainCtrl:__EnterBattleScene(roomData, isReconnect)
  if self.dynPlayer:IsEpQuickBattleRoomType(roomData:GetRoomType()) then
    if self.dynPlayer:GetOperatorDetailState() ~= proto_object_ExplorationCurGridState.ExplorationCurGridStateBattleALGWaiting then
      error("opStageError:" .. tostring(self.dynPlayer:GetOperatorDetailState()))
      return
    end
    ExplorationManager.epCtrl:ContinueExploration()
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.BattleToEp)
    return
  end
  base.__EnterBattleScene(self, roomData, isReconnect)
  if (roomData:IsBossRoom() or roomData:GetRoomType() == ExplorationEnum.eRoomType.challenge) and not ExplorationManager:IsSectorNewbee() then
    ExplorationManager:PlayEpAuSelctBossCombat()
  else
    ExplorationManager:PlayEpAuSelctNormalCombat()
  end
  local window = UIManager:GetWindow(UIWindowTypeID.DungeonStateInfo)
  if window ~= nil then
    window:Hide(true)
  end
  window = UIManager:GetWindow(UIWindowTypeID.Exploration)
  if window ~= nil then
    window:Hide(true)
  end
  local csbattleCtrl = self.battleCtrl:StartNewEpBattle(roomData, self.dynPlayer)
  
  local function epToBattleAction()
    csbattleCtrl:StartEnterDeployState()
  end
  
  if roomData:IsDeployRoom() or isReconnect then
    self.sceneCtrl:ExplorationToBattleSceneInReconnected(epToBattleAction)
  else
    local epDetail = self.dynPlayer:GetOperatorDetail()
    local index = epDetail.state == proto_object_ExplorationCurGridState.ExplorationCurGridState_Over and #epDetail.path - 1 or #epDetail.path
    local lastRoomCoord = epDetail.path[index]
    local lastRoomPos = self.mapCtrl:GetRoomEntity(lastRoomCoord):GetRoomEntityLocalPos(0)
    local curRoomPos = self.mapCtrl:GetRoomEntity(roomData.position):GetRoomEntityLocalPos(0)
    local isUp = curRoomPos.y > lastRoomPos.y
    local dir = -1
    if isUp then
      dir = 1
    end
    if roomData:IsBossRoom() then
      dir = 0
    end
    local roomPos = self.mapCtrl:GetRoomEntityPos(roomData)
    local mapRoot = self:GetRoomRoot()
    self.sceneCtrl:ExplorationToBattleSceneNormal(dir, mapRoot, roomPos, epToBattleAction)
  end
end

function EpNormalMainCtrl:UpdateNextRoomInfo(epGrid, epOp)
  base.UpdateNextRoomInfo(self, epGrid, epOp)
end

function EpNormalMainCtrl:CheckAfterOutSide()
  base.CheckAfterOutSide(self)
  self._outsideTheRoomFunc = self._outsideTheRoomFunc or function()
    self:CheckBossRoom()
    GuideManager:TryTriggerGuide(eGuideCondition.InEpRoomOutside)
  end
  if not self.residentStoreCtrl:CheckEpResidentStore(self._outsideTheRoomFunc) then
    self._outsideTheRoomFunc()
  end
end

function EpNormalMainCtrl:OnPlayerMoveStart(roomData)
  AudioManager:PlayAudioById(1002)
  if roomData:IsBattleRoom() then
    self.mapCtrl:PlayerPosItemMove2NextPos()
    self:OnPlayerMoveComplete(roomData)
  else
    UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
    local roomUI = self:GetRoomUI(roomData.position)
    self.mapCtrl:PlayerPosItemMove2NextPos()
    self.sceneCtrl.epSceneEntity:EpRoomCoverBattleMap(true, function()
      self:OnPlayerMoveComplete(roomData)
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
    end, roomUI.transform.position)
  end
end

function EpNormalMainCtrl:OnExitEpRoomBegin()
  local curRoomData = self:GetCurrentRoomData(true)
  if curRoomData:IsEndColRoom() then
    return
  end
  UIManager:ShowWindow(UIWindowTypeID.ClickContinue):InitContinue(nil, nil, nil, Color.clear, false)
  self.mapCtrl:PlayerPosItemMove2NextPos(function()
    self.sceneCtrl.epSceneEntity:EpRoomCoverBattleMap(true, function()
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      self:OnExitEpRoomEnd(curRoomData)
    end)
  end)
end

function EpNormalMainCtrl:GenExplorationMap()
  self.mapCtrl:GenMap(self.mapData, self:GetCurrentRoomData(true))
end

function EpNormalMainCtrl:SetViewPositionOffset(offsetPosition)
  local position = self.mapCtrl:GetViewPosition() + offsetPosition
  return self.mapCtrl:SetViewPosition(position)
end

function EpNormalMainCtrl:GetRoomRoot()
  return self.mapCtrl:GetRoomRoot()
end

function EpNormalMainCtrl:GetRoomUI(position, index)
  return self.mapCtrl:GetRoomUI(position, index)
end

function EpNormalMainCtrl:GetSupportAutoEpType()
  return ExplorationEnum.eAutoEpSwitchType.EpWindow
end

function EpNormalMainCtrl:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.Exploration)
  UIManager:DeleteWindow(UIWindowTypeID.EpChipSuit)
  base.OnDelete(self)
end

return EpNormalMainCtrl

local EpSceneA = class("EpSceneA", EpSceneBase)
local base = EpSceneBase
local CS_CameraController = CS.CameraController
local CS_Ease = CS.DG.Tweening.Ease
local tl_Start

function EpSceneA:OnSceneLoadCompleted(onSceneLoadCompletedGeneral)
  base.OnSceneLoadCompleted(self, onSceneLoadCompletedGeneral)
end

function EpSceneA:InitTimeLineCtr()
  base.InitTimeLineCtr(self)
  if self.bind.tl_Start_array ~= nil then
    for i = 1, #self.bind.tl_Start_array do
      self.bind.tl_Start_array[i].gameObject:SetActive(false)
    end
    math.randomseed(os.time())
    local randomRes = math.random(1, #self.bind.tl_Start_array)
    self.tl_Start = self.bind.tl_Start_array[randomRes]
    self.tl_Start.gameObject:SetActive(true)
  else
    self.tl_Start = self.bind.tl_Start
  end
  if self.tl_Start ~= nil then
    self._onSceneLoadedComplete = BindCallback(self, self.OnSceneLoadedComplete)
    self.timeLineCtr:RegistTLEvent(TimeLineType.TLEventType.OnSceneLoadedTL, self.tl_Start, self._onSceneLoadedComplete)
  end
  if self.bind.tl_EpToBattleLeft ~= nil then
    self._onReconnectToBattleComplete = BindCallback(self, self.OnReconnectToBattleComplete)
    self.timeLineCtr:RegistTLEvent(TimeLineType.TLEventType.OnReconnectToBattleTL, self.bind.tl_EpToBattleLeft, self._onReconnectToBattleComplete)
  end
  if self.bind.tl_BattleToEp ~= nil then
    self._onExitBattleComplete = BindCallback(self, self.OnExitBattleComplete)
    self.timeLineCtr:RegistTLEvent(TimeLineType.TLEventType.OnExitBattleTL, self.bind.tl_BattleToEp, self._onExitBattleComplete)
  end
  if self.bind.tl_BattleEndToBattle ~= nil then
    self._OnBattleEndToBattleComplete = BindCallback(self, self.OnBattleEndToBattleComplete)
    self.timeLineCtr:RegistTLEvent(TimeLineType.TLEventType.OnBattleEndToBattle, self.bind.tl_BattleEndToBattle, self._OnBattleEndToBattleComplete)
  end
  base.RegistExpVcam(self, self.bind.vcam_Exploration)
  base.RegistBattleVcam(self, self.bind.vcam_Battle)
  base.RegistEpCamFollowTarget(self, self.bind.epCamFollowTarget)
end

function EpSceneA:OnSceneLoadedPlay(onCompleteEvent)
  self:InitEpCamNormal()
  self._onStartTimeLineCompleteEvent = onCompleteEvent
  base.OnSceneLoadedPlay(self)
end

function EpSceneA:OnSceneLoadedComplete(playableDirector)
  if playableDirector ~= self.tl_Start then
    return
  end
  if self._onStartTimeLineCompleteEvent ~= nil then
    self._onStartTimeLineCompleteEvent()
  end
end

function EpSceneA:OnStartBattlePlay(onCompleteEvent)
  self._onStartBattleTimeLineCompleteEvent = onCompleteEvent
  self.bind.vcam_Battle.gameObject:SetActive(true)
  self.bind.battleCanvasGroup.alpha = 0
  base.OnStartBattlePlay(self)
end

function EpSceneA:OnReconnectToBattlePlay(onCompleteEvent)
  self._onReconnectToBattleCompleteEvent = onCompleteEvent
  self.bind.vcam_Battle.gameObject:SetActive(true)
  self.bind.battleCanvasGroup.alpha = 0
  base.OnReconnectToBattlePlay(self)
end

function EpSceneA:OnReconnectToBattleComplete(playableDirector)
  if playableDirector ~= self.bind.tl_EpToBattleLeft then
    return
  end
  self.bind.battleCanvasGroup.alpha = 1
  self.bind.vcam_Exploration.gameObject:SetActive(false)
  if self._onReconnectToBattleCompleteEvent ~= nil then
    self._onReconnectToBattleCompleteEvent()
  end
end

function EpSceneA:OnExitBattlePlay(onCompleteEvent)
  self._onExitBattleCompleteEvent = onCompleteEvent
  self.bind.vcam_Exploration.gameObject:SetActive(true)
  self.bind.vcam_Battle.gameObject:SetActive(false)
  base.OnExitBattlePlay(self)
end

function EpSceneA:OnExitBattleComplete(playableDirector)
  if playableDirector ~= self.bind.tl_BattleToEp then
    return
  end
  if self._onExitBattleCompleteEvent ~= nil then
    self._onExitBattleCompleteEvent()
  end
end

function EpSceneA:PlayBattleEndToBattle(onCompleteEvent)
  self.__OnBattleEndToBattleEvent = onCompleteEvent
  self.bind.vcam_Exploration.gameObject:SetActive(false)
  self.bind.vcam_Battle.gameObject:SetActive(true)
  base.OnBattleEndToBattlePlay(self)
end

function EpSceneA:OnBattleEndToBattleComplete(playableDirector)
  if playableDirector ~= self.bind.tl_BattleEndToBattle then
    return
  end
  if self.__OnBattleEndToBattleEvent ~= nil then
    self.__OnBattleEndToBattleEvent()
  end
end

function EpSceneA:CalculateExpToBattleNormalTL(dir)
  local tlIndex = 1
  if dir == 1 then
    tlIndex = math.random(1, #self.bind.tl_EpToBattleRightUp)
    self._onStartBattleTL = self.bind.tl_EpToBattleRightUp[tlIndex]
  elseif dir == -1 then
    tlIndex = math.random(1, #self.bind.tl_EpToBattleRightDown)
    self._onStartBattleTL = self.bind.tl_EpToBattleRightDown[tlIndex]
  else
    self._onStartBattleTL = self.bind.tl_EpToBattleBoss
  end
  if self._onStartBattleComplete == nil then
    self._onStartBattleComplete = BindCallback(self, self.OnStartBattleComplete)
  end
  self.timeLineCtr:RegistTLEvent(TimeLineType.TLEventType.OnStartBattleTL, self._onStartBattleTL, self._onStartBattleComplete)
  return tlIndex
end

function EpSceneA:OnStartBattleComplete(playableDirector)
  if playableDirector ~= self._onStartBattleTL then
    return
  end
  self.bind.battleCanvasGroup.alpha = 1
  self.bind.vcam_Exploration.gameObject:SetActive(false)
  if self._onStartBattleTimeLineCompleteEvent ~= nil then
    self._onStartBattleTimeLineCompleteEvent()
  end
end

function EpSceneA:GetBattleCanvasGroup()
  return self.bind.battleCanvasGroup
end

function EpSceneA:GetMainCam()
  return self.bind.mainCamera
end

function EpSceneA:GetBattleToMapLine()
  return self.bind.battleToMapLine
end

function EpSceneA:InitEpCamNormal()
  if ExplorationManager.epCtrl.mapCtrl == nil then
    return
  end
  local vcam_Exploration = self:GetExpVcam()
  local vcam_Battle = self:GetBattleVcam()
  self.__epCamOriginalPos = vcam_Exploration.transform.position
  local roomRoot = ExplorationManager.epCtrl:GetRoomRoot()
  local crossPos = MathUtil:GetIntersectWithLineAndPlane(self.__epCamOriginalPos, vcam_Exploration.transform.forward, Vector3.New(0, 1, 0), roomRoot.position)
  local followOffset = self.__epCamOriginalPos - crossPos
  self.__epCamFollowOriginalPos = crossPos
  CS_CameraController.Instance:InitEpCam(self.__epCamFollowOriginalPos, followOffset)
  self:EpRoomCoverBattleMap()
  vcam_Exploration.gameObject:SetActive(true)
  vcam_Battle.gameObject:SetActive(false)
end

function EpSceneA:EpRoomCoverBattleMap(withTween, tweenCompleteFunc, playerPos)
  local roomRoot = self.sceneCtr.epCtrl:GetRoomRoot()
  if playerPos == nil then
    local playerPosItem = self.sceneCtr.epCtrl.mapCtrl:GetPlayerPosItem()
    playerPos = playerPosItem.transform.position
  end
  local opDetail = self.sceneCtr.epCtrl.dynPlayer:GetOperatorDetail()
  local mapPosOffset = Vector3.zero
  local curRoomData = self.sceneCtr.epCtrl:GetCurrentRoomData(true)
  if not curRoomData:IsCrossRoom() then
    mapPosOffset = ConfigData.buildinConfig.EpMapPosOffset
  end
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted and not curRoomData:IsBossRoom() then
    playerPos = playerPos + mapPosOffset
  end
  local battleMapPos = Vector3.zero
  local direct = self.__epCamOriginalPos - battleMapPos
  local crossPos = MathUtil:GetIntersectWithLineAndPlane(battleMapPos, direct, Vector3.New(0, 1, 0), roomRoot.position)
  local offset = crossPos - playerPos
  if withTween then
    roomRoot:DOMove(roomRoot.position + offset, ConfigData.buildinConfig.EpMapMoveTweenDuration):OnComplete(tweenCompleteFunc):SetEase(CS_Ease.InOutQuad)
  else
    roomRoot.position = roomRoot.position + offset
  end
  if withTween then
    self:GetEpCamFollowTarget():DOMove(self.__epCamFollowOriginalPos, ConfigData.buildinConfig.EpMapMoveTweenDuration):SetEase(CS_Ease.InOutQuad)
  else
    self:GetEpCamFollowTarget().position = self.__epCamFollowOriginalPos
  end
  self.sceneCtr.epCtrl.mapCtrl:OffsetMapRect(offset, self.__epCamFollowOriginalPos)
end

function EpSceneA:OnDelete()
  base.OnDelete(self)
  self._onStartTimeLineCompleteEvent = nil
  self._onStartBattleTimeLineCompleteEvent = nil
  self._onReconnectToBattleCompleteEvent = nil
  self._onExitBattleCompleteEvent = nil
  self._onStartTimelineComplete = nil
  self._onSceneLoadedComplete = nil
  self._onReconnectToBattleComplete = nil
  self._onExitBattleComplete = nil
  self._onStartBattleComplete = nil
end

return EpSceneA

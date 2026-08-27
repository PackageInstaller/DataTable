local ExplorationSceneCtrl = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local EpLightSceneCtrl = class("EpLightSceneCtrl", ExplorationSceneCtrl)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function EpLightSceneCtrl:ctor(epCtrl)
  self.__onBattleToBattlComplete = BindCallback(self, self.OnBattleToBattleComplete)
end

function EpLightSceneCtrl:SwithCameraCtrlState(cameraState)
end

function EpLightSceneCtrl:SetLightInBattleScene(flag)
  self.inBattleScene = flag
end

function EpLightSceneCtrl:InBattleScene()
  return self.inBattleScene
end

function EpLightSceneCtrl:__PlaySceneStartTimeline()
  self.loadRoleComplete = true
  self:SceneResetBattleCamera()
  self.__onStartTimelineCompleteGeneral()
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InBattleScene)
  for k, heroGo in pairs(self.heroObjectDic) do
    heroGo:SetActive(true)
  end
  self:TryPlayFairyEnterAni(false)
end

function EpLightSceneCtrl:BattleToBattleSceneNormal(epToBattleAction)
  self:SceneResetBattleCamera()
  self.__epToBattleAction = epToBattleAction
  self:SwithCameraCtrlState(ExplorationEnum.eEpCamControlState.None)
  self.epSceneEntity:PlayBattleEndToBattle(self.__onBattleToBattlComplete)
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InTimeline)
  if self.skipEpTimeline then
    self.epSceneEntity:EndOnStartBattleTimeLine()
  else
    self:ShowSkipWindow()
  end
end

function EpLightSceneCtrl:OnBattleToBattleComplete()
  self:DeleteSkipWindow()
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InBattleScene)
  if self.__epToBattleAction ~= nil then
    self.__epToBattleAction()
    self.__epToBattleAction = nil
  end
end

function EpLightSceneCtrl:OnPlayerMoveComplete(roomData)
end

return EpLightSceneCtrl

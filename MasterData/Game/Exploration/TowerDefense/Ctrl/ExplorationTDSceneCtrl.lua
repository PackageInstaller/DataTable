local Base = require("Game.Exploration.Ctrl.ExplorationSceneCtrl")
local ExplorationTDSceneCtrl = class("ExplorationTDSceneCtrl", Base)
local CS_RenderMgr = CS.RenderManager.Instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationTDSceneCtrl:ctor()
  self.__onStartTimelineCompleteGeneral = BindCallback(self, self.OnStartTimelineCompleteGeneral, true)
end

function ExplorationTDSceneCtrl:__PlaySceneStartTimeline()
  self.loadRoleComplete = true
  self.showEpUIComplete = true
  self.epSceneEntity:OnSceneLoadedPlay(self.__onStartTimelineCompleteGeneral)
  self:ChangeEpSceneState(ExplorationEnum.eEpSceneState.InTimeline)
  self:ShowSkipWindow(false)
  self:SetEpMapCameraCullMask(LayerMask.UI3D)
end

function ExplorationTDSceneCtrl:OnStartTimelineCompleteGeneral(isAbandonExpCamCtrl)
  Base.OnStartTimelineCompleteGeneral(self, isAbandonExpCamCtrl)
  self:TryPlayFairyEnterAni(false)
end

function ExplorationTDSceneCtrl:OnPlayerMoveComplete(roomData)
end

function ExplorationTDSceneCtrl:SetTDInBattleScene(flag)
  self.inBattleScene = flag
end

function ExplorationTDSceneCtrl:InBattleScene()
  return self.inBattleScene
end

return ExplorationTDSceneCtrl

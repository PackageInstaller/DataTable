local EpSceneBase = class("EpSceneBase")
local CS_GSceneManager_Ins = CS.GSceneManager.Instance
local CS_CameraController = CS.CameraController
local epSceneTimeLineCtr = require("Game.Exploration.Scene.EpSceneTimeLineCtr")

function EpSceneBase:ctor(sceneName, sceneCtr)
  self.sceneName = sceneName
  self.sceneCtr = sceneCtr
end

function EpSceneBase:OnSceneLoadCompleted(onCompletedGeneral)
  self.bind = {}
  UIUtil.LuaUIBindingTable(CS_CameraController.Instance.transform.parent, self.bind)
  self:InitTimeLineCtr()
  if onCompletedGeneral ~= nil then
    onCompletedGeneral()
  end
end

function EpSceneBase:LoadArenaSceneForce(onCompletedGeneral, ...)
  local _onSceneLoadCompleted = BindCallback(self, self.OnSceneLoadCompleted, onCompletedGeneral)
  UIManager:GetWindow(UIWindowTypeID.Loading):SetLoadingTipsSystemId(1)
  CS_GSceneManager_Ins:LoadSceneAsyncByABEx(self.sceneName, true, false, _onSceneLoadCompleted, ...)
end

function EpSceneBase:OnSceneLoadedPlay(onCompleteEvent)
  self.timeLineCtr:OnSceneLoaded()
end

function EpSceneBase:EndOnSceneLoadedTimeLine()
  self.timeLineCtr:SkipTL(TimeLineType.TLEventType.OnSceneLoadedTL)
end

function EpSceneBase:OnStartBattlePlay()
  self.timeLineCtr:OnStartBattle()
end

function EpSceneBase:EndOnStartBattleTimeLine()
  self.timeLineCtr:SkipTL(TimeLineType.TLEventType.OnStartBattleTL)
end

function EpSceneBase:OnReconnectToBattlePlay()
  self.timeLineCtr:OnReconnectToBattle()
end

function EpSceneBase:EndOnReconnectToBattleTimeLine()
  self.timeLineCtr:SkipTL(TimeLineType.TLEventType.OnReconnectToBattleTL)
end

function EpSceneBase:OnExitBattlePlay()
  self.timeLineCtr:OnExitBattle()
end

function EpSceneBase:OnBattleEndToBattlePlay()
  self.timeLineCtr:OnBattleEndToBattle()
end

function EpSceneBase:EndOnExitBattleTimeLine()
  self.timeLineCtr:SkipTL(TimeLineType.TLEventType.OnExitBattleTL)
end

function EpSceneBase:RegistExpVcam(expVcamm)
  self.timeLineCtr:RegistVCam(VcamType.ExpVcam, expVcamm)
end

function EpSceneBase:GetExpVcam()
  return self.timeLineCtr.VCamDic[VcamType.ExpVcam]
end

function EpSceneBase:RegistBattleVcam(btlVcam)
  self.timeLineCtr:RegistVCam(VcamType.BtlVcam, btlVcam)
end

function EpSceneBase:GetBattleVcam()
  return self.timeLineCtr.VCamDic[VcamType.BtlVcam]
end

function EpSceneBase:RegistEpCamFollowTarget(target)
  self.timeLineCtr:RegistVCam(VcamType.MainCamFollow, target)
end

function EpSceneBase:GetEpCamFollowTarget()
  return self.timeLineCtr.VCamDic[VcamType.MainCamFollow]
end

function EpSceneBase:GetBattleCanvasGroup()
end

function EpSceneBase:GetMainCam()
end

function EpSceneBase:GetEpMapCamera()
  return self.bind.epMapCamera
end

function EpSceneBase:GetBattleToMapLine()
end

function EpSceneBase:CalculateExpToBattleNormalTL()
end

function EpSceneBase:GetOnSceneLoadedTL()
  return self.timeLineCtr.TLEventDic[TimeLineType.TLEventType.OnSceneLoadedTL].playableDirector
end

function EpSceneBase:GetOnExitBattleTL()
  return self.timeLineCtr.TLEventDic[TimeLineType.TLEventType.OnExitBattleTL].playableDirector
end

function EpSceneBase:GetOnStartBattleTL()
  if self.timeLineCtr.TLEventDic[TimeLineType.TLEventType.OnStartBattleTL] == nil then
    return nil
  end
  return self.timeLineCtr.TLEventDic[TimeLineType.TLEventType.OnStartBattleTL].playableDirector
end

function EpSceneBase:GetOnReconnectToBattleTL()
  return self.timeLineCtr.TLEventDic[TimeLineType.TLEventType.OnReconnectToBattleTL].playableDirector
end

function EpSceneBase:InitTimeLineCtr()
  self.timeLineCtr = self:GetTimeLineCtr()
end

function EpSceneBase:GetTimeLineCtr()
  return epSceneTimeLineCtr.New(self)
end

function EpSceneBase:IsExitBattleTLPlaying()
  return self.timeLineCtr:IsTLPlaying(TimeLineType.TLEventType.OnExitBattleTL)
end

function EpSceneBase:OnDelete()
  self.sceneName = nil
  self.sceneCtr = nil
  self.timeLineCtr:OnDelete()
end

return EpSceneBase

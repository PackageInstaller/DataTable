local EpSceneTimeLineCtr = class("EpSceneTimeLineCtr")
local cs_PlayState_Playing = CS.UnityEngine.Playables.PlayState.Playing
local cs_MonoDriver_Instance = CS.MonoDriver.Instance
require("Common.TableUtil")

function EpSceneTimeLineCtr:ctor(sceneEntity)
  self.sceneEntity = sceneEntity
  self.TLEventDic = {}
  self.VCamDic = {}
  self._onDeleteFunc = BindCallback(self, self.OnDelete)
  cs_MonoDriver_Instance:onApplicationQuit("+", self._onDeleteFunc)
end

function EpSceneTimeLineCtr:OnCustomEvent(tlEventType)
  self:TLExecute(tlEventType, TimeLineType.TLAction.Play)
end

function EpSceneTimeLineCtr:OnSceneLoaded()
  self:TLExecute(TimeLineType.TLEventType.OnSceneLoadedTL, TimeLineType.TLAction.Stop)
  self:TLExecute(TimeLineType.TLEventType.OnSceneLoadedTL, TimeLineType.TLAction.Play)
end

function EpSceneTimeLineCtr:OnStartBattle()
  self:TLExecute(TimeLineType.TLEventType.OnStartBattleTL, TimeLineType.TLAction.Stop)
  self:TLExecute(TimeLineType.TLEventType.OnStartBattleTL, TimeLineType.TLAction.Play)
end

function EpSceneTimeLineCtr:OnExitBattle()
  self:TLExecute(TimeLineType.TLEventType.OnExitBattleTL, TimeLineType.TLAction.Stop)
  self:TLExecute(TimeLineType.TLEventType.OnExitBattleTL, TimeLineType.TLAction.Play)
end

function EpSceneTimeLineCtr:OnReconnectToBattle()
  self:TLExecute(TimeLineType.TLEventType.OnReconnectToBattleTL, TimeLineType.TLAction.Stop)
  self:TLExecute(TimeLineType.TLEventType.OnReconnectToBattleTL, TimeLineType.TLAction.Play)
end

function EpSceneTimeLineCtr:OnBattleEndToBattle()
  self:TLExecute(TimeLineType.TLEventType.OnBattleEndToBattle, TimeLineType.TLAction.Stop)
  self:TLExecute(TimeLineType.TLEventType.OnBattleEndToBattle, TimeLineType.TLAction.Play)
end

function EpSceneTimeLineCtr:SkipTL(tlEventType)
  local pbDirector = self.TLEventDic[tlEventType].playableDirector
  if pbDirector ~= nil then
    pbDirector.time = pbDirector.duration
  end
end

function EpSceneTimeLineCtr:IsTLPlaying(tlEventType)
  local pbDirector = self.TLEventDic[tlEventType].playableDirector
  if pbDirector ~= nil then
    return pbDirector.state == cs_PlayState_Playing
  end
  return false
end

function EpSceneTimeLineCtr:RegistVCam(vcamType, vcam)
  self.VCamDic[vcamType] = vcam
end

function EpSceneTimeLineCtr:RegistTLEvent(tlEventType, plyDire, onComplete, onStart)
  self.TLEventDic[tlEventType] = {}
  self.TLEventDic[tlEventType].playableDirector = plyDire
  self.TLEventDic[tlEventType].event = {}
  local TLEventTB = self.TLEventDic[tlEventType].event
  if onStart ~= nil then
    TLEventTB[TimeLineType.EventTick.OnStarted] = onStart
    plyDire:played("-", TLEventTB[TimeLineType.EventTick.OnStarted])
    plyDire:played("+", TLEventTB[TimeLineType.EventTick.OnStarted])
  end
  if onComplete ~= nil then
    TLEventTB[TimeLineType.EventTick.OnStopped] = onComplete
    plyDire:stopped("-", TLEventTB[TimeLineType.EventTick.OnStopped])
    plyDire:stopped("+", TLEventTB[TimeLineType.EventTick.OnStopped])
  end
end

function EpSceneTimeLineCtr:RemoveTLEvent(tlEventType, eventTick)
  if self.TLEventDic[tlEventType] ~= nil then
    local tl = self.TLEventDic[tlEventType].playableDirector
    if self.TLEventDic[tlEventType].event ~= nil then
      local tlEvntTB = self.TLEventDic[tlEventType].event
      if tlEvntTB[eventTick] ~= nil then
        if eventTick == TimeLineType.EventTick.OnStarted then
          tl:played("-", tlEvntTB[eventTick])
        elseif eventTick == TimeLineType.EventTick.OnStopped then
          tl:stopped("-", tlEvntTB[eventTick])
        end
        self.TLEventDic[tlEventType].event[eventTick] = nil
      end
    end
  end
end

function EpSceneTimeLineCtr:RemoveAllTLEvent(tlEventType)
  if self.TLEventDic[tlEventType] ~= nil then
    local tl = self.TLEventDic[tlEventType].playableDirector
    if self.TLEventDic[tlEventType].event ~= nil then
      local tlEvntTB = self.TLEventDic[tlEventType].event
      if tlEvntTB[TimeLineType.EventTick.OnStarted] ~= nil then
        tl:played("-", tlEvntTB[TimeLineType.EventTick.OnStarted])
      end
      if tlEvntTB[TimeLineType.EventTick.OnStopped] ~= nil then
        tl:stopped("-", tlEvntTB[TimeLineType.EventTick.OnStopped])
      end
      self.TLEventDic[tlEventType].event[tlEventType] = nil
    end
  end
end

function EpSceneTimeLineCtr:TLExecute(tlEventType, TLActionType)
  if self.TLEventDic[tlEventType] ~= nil and self.TLEventDic[tlEventType].playableDirector ~= nil then
    if TLActionType == TimeLineType.TLAction.Play then
      self.TLEventDic[tlEventType].playableDirector:Play()
    elseif TLActionType == TimeLineType.TLAction.Stop then
      self.TLEventDic[tlEventType].playableDirector:Stop()
    elseif TLActionType == TimeLineType.TLAction.Pause then
      self.TLEventDic[tlEventType].playableDirector:Pause()
    end
  end
end

function EpSceneTimeLineCtr:TLSetTime(tlEventType, tarTime)
  if self.TLEventDic[tlEventType] ~= nil and self.TLEventDic[tlEventType].playableDirector ~= nil then
    self.TLEventDic[tlEventType].playableDirector.time = tarTime
  end
end

function EpSceneTimeLineCtr:OnDelete()
  cs_MonoDriver_Instance:onApplicationQuit("-", self._onDeleteFunc)
  for k, v in pairs(self.TLEventDic) do
    self:RemoveAllTLEvent(k)
  end
  self.TLEventDic = table.emptytable
  self.VCamDic = table.emptytable
end

return EpSceneTimeLineCtr

_class("SeasonManager", Object)
SeasonManager = SeasonManager

function SeasonManager:Constructor()
  self._seasonNavManager = SeasonNavManager:New()
  self._seasonCoverManager = SeasonCoverManager:New()
  self._seasonCoverByNavManager = SeasonCoverByNavManager:New()
  self._seasonShowByNavManager = SeasonShowByNavManager:New()
  self._seasonSceneManager = SeasonSceneManager:New()
  self._seasonPlayerManager = SeasonPlayerManager:New()
  self._seasonTriggerManager = SeasonTriggerManager:New()
  self._seasonCameraManager = SeasonCameraManager:New()
  self._seasonInputManager = SeasonInputManager:New()
  self._seasonMapManager = SeasonMapManager:New()
  self._seasonAudioManager = SeasonAudioManager:New()
  self._seasonUIManager = SeasonUIManager:New()
end

function SeasonManager:Init(seasonID, params)
  self._locks = {}
  self._inputMode = SeasonInputMode.Input
  self._seasonCoverManager:OnInit(seasonID)
  self._seasonCoverByNavManager:OnInit(seasonID)
  self._seasonShowByNavManager:OnInit(seasonID)
  self._seasonSceneManager:OnInit(seasonID, params)
  self._seasonPlayerManager:OnInit(seasonID, params)
  self._seasonTriggerManager:OnInit(seasonID, params)
  self._seasonCameraManager:OnInit(seasonID, params)
  self._seasonInputManager:OnInit(seasonID, params)
  self._seasonMapManager:OnInit(seasonID, params)
  self._seasonAudioManager:OnInit(seasonID, params)
  self._seasonUIManager:OnInit(seasonID)
end

function SeasonManager:AfterInit()
  self._seasonPlayerManager:OnAfterInit()
  self._seasonMapManager:OnAfterInit()
  self._seasonSceneManager:OnAfterInit()
  self._seasonAudioManager:OnAfterInit()
end

function SeasonManager:Update(deltaTime)
  self._inputMode = self:GetInputMode()
  self._seasonSceneManager:Update(deltaTime)
  self._seasonPlayerManager:Update(deltaTime)
  self._seasonTriggerManager:Update(deltaTime)
  self._seasonCameraManager:Update(deltaTime, self._inputMode)
  if self._inputMode == SeasonInputMode.Input then
    self._seasonInputManager:Update(deltaTime)
  end
  self._seasonMapManager:Update(deltaTime)
  self._seasonAudioManager:Update(deltaTime)
  self._seasonUIManager:Update(deltaTime)
  self._seasonCoverManager:Update(deltaTime)
end

function SeasonManager:Dispose(isExit)
  self._seasonSceneManager:Dispose()
  self._seasonPlayerManager:Dispose(isExit)
  self._seasonTriggerManager:Dispose()
  self._seasonCameraManager:Dispose()
  self._seasonInputManager:Dispose()
  self._seasonMapManager:Dispose()
  self._seasonAudioManager:Dispose()
  self._seasonUIManager:Dispose()
  self._seasonCoverManager:Dispose()
  self._seasonCoverByNavManager:Dispose()
  self._seasonShowByNavManager:Dispose()
  table.clear(self._locks)
end

function SeasonManager:SeasonSceneManager()
  return self._seasonSceneManager
end

function SeasonManager:SeasonPlayerManager()
  return self._seasonPlayerManager
end

function SeasonManager:SeasonCameraManager()
  return self._seasonCameraManager
end

function SeasonManager:SeasonInputManager()
  return self._seasonInputManager
end

function SeasonManager:SeasonMapManager()
  return self._seasonMapManager
end

function SeasonManager:SeasonAudioManager()
  return self._seasonAudioManager
end

function SeasonManager:SeasonUIManager()
  return self._seasonUIManager
end

function SeasonManager:SeasonTriggerManager()
  return self._seasonTriggerManager
end

function SeasonManager:SeasonCoverManager()
  return self._seasonCoverManager
end

function SeasonManager:SeasonCoverByNavManager()
  return self._seasonCoverByNavManager
end

function SeasonManager:SeasonShowByNavManager()
  return self._seasonShowByNavManager
end

function SeasonManager:NavManager()
  return self._seasonNavManager
end

function SeasonManager:GetInputMode()
  if table.count(self._locks) > 0 then
    return SeasonInputMode.LockInput
  else
    return SeasonInputMode.Input
  end
end

function SeasonManager:Lock(name)
  if self._locks[name] then
    Log.error("SeasonManager lock exist.", name)
  end
  self._locks[name] = true
  Log.debug("SeasonManager add lock", name)
end

function SeasonManager:UnLock(name)
  if self._locks[name] then
    self._locks[name] = nil
    Log.debug("SeasonManager remove lock", name)
  else
    Log.error("SeasonManager UnLock not exist.", name)
  end
end

function SeasonManager:ClearLocks()
  self._locks = {}
end

function SeasonManager:SwitchDiff(diff)
  self._seasonMapManager:SwitchDiff(diff)
  self._seasonUIManager:SwitchDiff(diff)
end

function SeasonManager:AutoMoveToEventPoint(id)
  local eventPoint = self._seasonMapManager:GetEventPoint(id)
  if eventPoint then
    self._seasonCameraManager:SeasonCamera():Focus(eventPoint:Position())
    self._seasonInputManager:GetInput():SetClickUnLockZone(eventPoint:IsUnlock())
    self._seasonInputManager:GetInput():GetClickEffect():Click()
    self._seasonInputManager:GetInput():SetCurClickEventPoint(eventPoint)
    eventPoint:AutoMoveToMe()
  end
end

function SeasonManager:LockUI()
  return self._seasonMapManager:EventPointPlaying() and self:GetInputMode() == SeasonInputMode.LockInput
end

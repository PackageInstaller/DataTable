_class("SeasonMapExpressUnlockZone", SeasonMapExpressBase)
SeasonMapExpressUnlockZone = SeasonMapExpressUnlockZone

function SeasonMapExpressUnlockZone:Constructor(cfg, eventPoint)
  self._content = self._cfg.UnlockZone
  self._seasonManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._seasonMapManger = self._seasonManager:SeasonMapManager()
  self._sceneManager = self._seasonManager:SeasonSceneManager()
  self._cameraManager = self._seasonManager:SeasonCameraManager()
  self._time = 0
  self._executing = false
end

function SeasonMapExpressUnlockZone:Update(deltaTime)
  if self._state == SeasonExpressState.Playing and not self._executing then
    self._time = self._time - deltaTime
    if self._time <= 0 then
      self._executing = true
      self:Next()
    end
  end
end

function SeasonMapExpressUnlockZone:OnPlay()
  if self._content then
    self._executing = false
    local zoneID = self._content.zoneID
    self._time = (self._content.time or 0) * 1000
    local unlockZoneIDs = self._seasonMapManger:UnlockZoneIDs()
    if table.icontains(unlockZoneIDs, zoneID) then
      Log.error("SeasonMapExpressUnlockZone Play this zone is unlocked.", zoneID)
      self:Next()
    else
      local tempUnlockZoneIDs = {zoneID}
      for _, zoneID in pairs(unlockZoneIDs) do
        table.insert(tempUnlockZoneIDs, zoneID)
      end
      local zoneMask = 0
      for _, zoneID in pairs(tempUnlockZoneIDs) do
        zoneMask = zoneMask | 1 << zoneID - 1
      end
      self._sceneManager:UnLockZone(zoneMask, zoneID)
      self._cameraManager:UnLock(zoneMask, zoneID)
      self._state = SeasonExpressState.Playing
    end
  end
end

require("season_config")
_class("SeasonSceneEnvironment", Object)
SeasonSceneEnvironment = SeasonSceneEnvironment

function SeasonSceneEnvironment:Constructor(sceenRoot, seasonID)
  self._sceenRoot = sceenRoot
  self._seasonID = seasonID
  self._entities = {}
  local config = SeasonEnvironmentConfig[seasonID]
  if config then
    for key, cfg in pairs(config) do
      self._entities[key] = _createInstance(cfg.value, self._sceenRoot, cfg.param)
    end
  end
end

function SeasonSceneEnvironment:Update(deltaTime)
  for _, entity in pairs(self._entities) do
    entity:Update(deltaTime)
  end
end

function SeasonSceneEnvironment:Dispose()
  for _, entity in pairs(self._entities) do
    entity:Dispose()
  end
end

function SeasonSceneEnvironment:UnLockZone(zoneMask, zoneID2Animation)
  local unlockZoneIDs = SeasonTool:GetInstance():GetZonesByZoneMask(zoneMask)
  if self._seasonID == UISeasonID.S1 and table.icontains(unlockZoneIDs, SeasonZone.Two) then
    self._entities[1]:UnLock(true)
  end
end

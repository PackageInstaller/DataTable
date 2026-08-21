require("season_maze_environment_config")
_class("SeasonMazeSceneEnvironment", Object)
SeasonMazeSceneEnvironment = SeasonMazeSceneEnvironment

function SeasonMazeSceneEnvironment:Constructor(sceenRoot)
  self._sceenRoot = sceenRoot
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
  self._seasonID = self._uiSeasonMazeModule:GetSeasonID()
  self._entities = {}
  local config = SeasonMazeEnvironmentConfig[self._seasonID]
  if config then
    for key, cfg in pairs(config) do
      self._entities[key] = _createInstance(cfg.value, self._sceenRoot, cfg.param)
    end
  end
end

function SeasonMazeSceneEnvironment:Update(deltaTime)
  for _, entity in pairs(self._entities) do
    entity:Update(deltaTime)
  end
end

function SeasonMazeSceneEnvironment:Dispose()
  for _, entity in pairs(self._entities) do
    entity:Dispose()
  end
end

function SeasonMazeSceneEnvironment:UnLockZone(zoneMask, zoneID2Animation)
  local unlockZoneIDs = SeasonMazeTool:GetInstance():GetZonesByZoneMask(zoneMask)
  if self._seasonID == UISeasonID.S1 and table.icontains(unlockZoneIDs, SeasonZone.Two) then
    self._entities[1]:UnLock(true)
  end
end

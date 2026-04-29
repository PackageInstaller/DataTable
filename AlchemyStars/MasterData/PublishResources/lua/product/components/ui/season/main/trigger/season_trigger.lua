_class("SeasonTrigger", Object)
SeasonTrigger = SeasonTrigger

function SeasonTrigger:Constructor(seasonID, root)
  self._root = root
  self._triggers = {}
  self._seasonModule = GameGlobal.GetModule(SeasonModule)
  self:_CreateAllTrigger()
end

function SeasonTrigger:FindTrigger(triggerId)
  return self._triggers[triggerId]
end

function SeasonTrigger:Update(deltaTime)
  for _, trigger in pairs(self._triggers) do
    trigger:Update(deltaTime)
  end
end

function SeasonTrigger:Dispose()
  for _, trigger in pairs(self._triggers) do
    trigger:Dispose()
  end
  table.clear(self._triggers)
end

function SeasonTrigger:_CreateAllTrigger()
  local cfgs
  local seasonID = self._seasonModule.uiModule:GetSeasonID()
  if self._seasonModule.uiModule:IsBackTrack() then
    cfgs = Cfg.cfg_season_map_trigger({BacktrackID = seasonID})
  else
    cfgs = Cfg.cfg_season_map_trigger({SeasonID = seasonID})
  end
  if cfgs then
    for id, cfg in pairs(cfgs) do
      self._triggers[cfg.ID] = SeasonTriggerBase:New(self._root, cfg)
    end
  end
end

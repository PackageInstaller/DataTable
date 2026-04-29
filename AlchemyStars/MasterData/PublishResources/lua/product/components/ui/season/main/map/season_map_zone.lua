_class("SeasonMapZone", Object)
SeasonMapZone = SeasonMapZone

function SeasonMapZone:Constructor(id, unlock, loader)
  self._zoneID = id
  self._isUnlock = unlock
  self._loader = loader
  self._eventPoints = {}
  self._seasonManger = GameGlobal.GetUIModule(SeasonModule):SeasonManager()
  self._navManager = self._seasonManger:NavManager()
end

function SeasonMapZone:ZoneID()
  return self._zoneID
end

function SeasonMapZone:OnAfterInit()
  for id, eventPoint in pairs(self._eventPoints) do
    eventPoint:OnAfterInit()
  end
end

function SeasonMapZone:Update(deltaTime)
  for id, eventPoint in pairs(self._eventPoints) do
    eventPoint:Update(deltaTime)
  end
end

function SeasonMapZone:Dispose()
  for _, eventPoint in pairs(self._eventPoints) do
    eventPoint:Dispose()
  end
  table.clear(self._eventPoints)
end

function SeasonMapZone:AddEventPoint(cfgMission)
  if not cfgMission then
    return
  end
  local missionID = cfgMission.ID
  if self._eventPoints[missionID] then
    return
  end
  local cfgEventPoint = Cfg.cfg_season_map_eventpoint[missionID]
  if cfgEventPoint then
    local eventPoint = SeasonMapEventPoint:New(self, cfgMission, cfgEventPoint)
    if eventPoint:GetResName() then
      self._loader:LoadResource(eventPoint)
    else
      eventPoint:CreateVirtualPoint()
    end
    self._eventPoints[missionID] = eventPoint
    if cfgEventPoint.EventPointType == SeasonEventPointType.NavPoint then
      self._navManager:AddTransPoint(self._zoneID, eventPoint)
    end
  end
end

function SeasonMapZone:GetEventPoint(id)
  return self._eventPoints[id]
end

function SeasonMapZone:GetEventPoints()
  return self._eventPoints
end

function SeasonMapZone:IsUnlock()
  return self._isUnlock
end

function SeasonMapZone:SetUnlock(unlock)
  self._isUnlock = unlock
end

function SeasonMapZone:CheckEventPointCondition(map)
  if self._isUnlock then
    for id, eventPoint in pairs(self._eventPoints) do
      local result, progress = eventPoint:CheckCondition(map)
      if result then
        eventPoint:PlayExpress(progress, SeasonExpressTriggerType.Passive)
      end
    end
  end
end

function SeasonMapZone:GetEventPointsByType(eventPointType, force)
  local result
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:EventPointType() == eventPointType and (eventPoint:DiffAble() and eventPoint:ModeAble() or force) then
      result = result or {}
      table.insert(result, eventPoint)
    end
  end
  return result
end

function SeasonMapZone:SwitchDiff(diff)
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:SwitchDiff(diff)
    end
  end
end

function SeasonMapZone:EventPointPlaying()
  for _, eventPoint in pairs(self._eventPoints) do
    local isPlaying, id = eventPoint:IsPlaying()
    if isPlaying then
      return isPlaying, id
    end
  end
  return false, nil
end

function SeasonMapZone:SwitchMapMode(mapMode)
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:SwitchMapMode(mapMode)
    end
  end
end

function SeasonMapZone:TryResumeExpress()
  for _, eventPoint in pairs(self._eventPoints) do
    if eventPoint:IsUnlock() then
      eventPoint:TryResumeExpress()
    end
  end
end

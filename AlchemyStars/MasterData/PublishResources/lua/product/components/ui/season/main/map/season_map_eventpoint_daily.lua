_class("SeasonMapEventPointDaily", SeasonMapEventPointBase)
SeasonMapEventPointDaily = SeasonMapEventPointDaily

function SeasonMapEventPointDaily:Constructor(owner, cfgMission, cfgEventPoint)
  self:_InitDailyPR()
end

function SeasonMapEventPointDaily:PRID()
  return self._dailyPRID
end

function SeasonMapEventPointDaily:_OnPlayEnd()
  self:_RandomNextPR()
end

function SeasonMapEventPointDaily:_InitDailyPR()
  if self._componentInfo.m_daily_info and self._componentInfo.m_daily_info.m_save_info then
    local serverPR = self._componentInfo.m_daily_info.m_save_info[self._id]
    if serverPR then
      self._dailyPRID = serverPR
    elseif self._cfgEventPoint.PRP then
      self:RandomPR(self._cfgEventPoint.PRP)
    end
    local cfg = Cfg.cfg_season_map_eventpoint_pr[self._dailyPRID]
    if cfg then
      self._position = Vector3(cfg.Position[1], cfg.Position[2], cfg.Position[3])
      self._rotation = Quaternion.Euler(cfg.Rotation[1], cfg.Rotation[2], cfg.Rotation[3])
    else
      Log.error("SeasonMapEventPointDaily:_GetInitPR error.", self._dailyPRID)
    end
  end
end

function SeasonMapEventPointDaily:_RandomNextPR()
  local seasonMapDaily = self._owner
  local cfg = Cfg.cfg_season_map_eventpoint_pr[self._dailyPRID]
  if cfg and cfg.Next then
    self:RandomPR(cfg.Next)
    seasonMapDaily:TrySyncPRIDs(function()
      self:ResetPR()
      Log.debug("SeasonMapEventPointDaily RandomNextPR Success.")
    end)
  end
end

function SeasonMapEventPointDaily:RandomPR(pool)
  if pool and 0 < #pool then
    local mapDaily = self._owner
    local ids = mapDaily:GetAllPRIDs()
    local randomPRIDs = {}
    for _, id in pairs(pool) do
      if not table.icontains(ids, id) then
        table.insert(randomPRIDs, id)
      end
    end
    local count = #randomPRIDs
    if 0 < count then
      self._dailyPRID = randomPRIDs[math.random(1, count)]
    else
      Log.error("SeasonMapEventPointDaily:_RandomPR error.", self._dailyPRID)
    end
  end
end

function SeasonMapEventPointDaily:ResetPR()
  local cfg = Cfg.cfg_season_map_eventpoint_pr[self._dailyPRID]
  if cfg then
    self._position = Vector3(cfg.Position[1], cfg.Position[2], cfg.Position[3])
    self._rotation = Quaternion.Euler(cfg.Rotation[1], cfg.Rotation[2], cfg.Rotation[3])
    self._transform.position = self._position
    self._transform.rotation = self._rotation
    self._seasonManger:SeasonUIManager():Refresh()
    self:ReCreatCover()
    Log.debug("SeasonMapEventPointDaily ResetPR.")
  end
end

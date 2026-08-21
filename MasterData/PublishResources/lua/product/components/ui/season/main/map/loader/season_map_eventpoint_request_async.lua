_class("SeasonMapEventPointRequestAsync", Object)
SeasonMapEventPointRequestAsync = SeasonMapEventPointRequestAsync

function SeasonMapEventPointRequestAsync:Constructor(id, resName)
  self._id = id
  self._resName = resName
  self._gameObject = nil
  self._request = {}
  self._state = SeasonEventPointLoadState.Wait
end

function SeasonMapEventPointRequestAsync:ID()
  return self._id
end

function SeasonMapEventPointRequestAsync:ResName()
  return self._resName
end

function SeasonMapEventPointRequestAsync:GameObject()
  return self._gameObject
end

function SeasonMapEventPointRequestAsync:State()
  return self._state
end

function SeasonMapEventPointRequestAsync:Dispose()
  if self._request then
    self._request:Dispose()
    self._request = nil
  end
  if self._asyncLoadTask then
    GameGlobal.TaskManager():KillTask(self._asyncLoadTask)
    self._asyncLoadTask = nil
  end
  self._state = SeasonEventPointLoadState.Closed
end

function SeasonMapEventPointRequestAsync:Load()
  self._state = SeasonEventPointLoadState.Loading
  self._asyncLoadTask = GameGlobal.TaskManager():StartTask(function(TT)
    Log.info("Start async loading season eventpoint", self._id)
    local req = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._resName, LoadType.GameObject)
    if not req then
      Log.error("Failed to load the season eventpoint asset.", self._resName)
    end
    self._request = req
    if self._state == SeasonEventPointLoadState.Invalid then
      self:Dispose()
      return
    end
    self._gameObject = req.Obj
    self._state = SeasonEventPointLoadState.Finish
  end)
end

function SeasonMapEventPointRequestAsync:Close()
  if self._state == SeasonEventPointLoadState.Loading then
    self._state = SeasonEventPointLoadState.Invalid
  else
    self._state = SeasonEventPointLoadState.Closed
  end
end

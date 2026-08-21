_class("SeasonMapEventPointRequestSync", Object)
SeasonMapEventPointRequestSync = SeasonMapEventPointRequestSync

function SeasonMapEventPointRequestSync:Constructor(id, resName)
  self._id = id
  self._resName = resName
  self._gameObject = nil
  self._request = nil
end

function SeasonMapEventPointRequestSync:ID()
  return self._id
end

function SeasonMapEventPointRequestSync:ResName()
  return self._resName
end

function SeasonMapEventPointRequestSync:GameObject()
  return self._gameObject
end

function SeasonMapEventPointRequestSync:Dispose()
  if self._request then
    self._request:Dispose()
    self._request = nil
  end
end

function SeasonMapEventPointRequestSync:Load()
  Log.info("Start sync loading season eventpoint", self._id)
  local req = ResourceManager:GetInstance():SyncLoadAsset(self._resName, LoadType.GameObject)
  if not req then
    Log.error("Failed to load the season eventpoint asset.", self._resName)
  end
  self._request = req
  self._gameObject = req.Obj
end

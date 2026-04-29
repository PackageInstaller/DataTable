_class("AircraftPetLoader", Object)
AircraftPetLoader = AircraftPetLoader

function AircraftPetLoader:Init(onLoadingCountChanged)
  self._queue = AircraftQueue:New()
  self._pets = {}
  local req = ResourceManager:GetInstance():SyncLoadAsset("AircraftPetSelectAnimRef.prefab", LoadType.GameObject)
  self._clickAnimClip = req.Obj:GetComponent(typeof(UnityEngine.Animation)).clip
  self._clickReq = req
  self._onLoadingCountChanged = onLoadingCountChanged
end

function AircraftPetLoader:SyncLoadePet(pet)
  local req = AircraftPetRequestSync:New(pet:TemplateID(), pet:PstID(), pet:PrefabName(), self._clickAnimClip)
  pet:Show(req)
end

function AircraftPetLoader:AsyncLoadPet(pet)
  local pstID = pet:PstID()
  if self._pets[pstID] then
    return false
  end
  self._queue:Enqueue(AircraftPetRequestAsync:New(pet:TemplateID(), pstID, pet:PrefabName(), self._clickAnimClip))
  self._pets[pstID] = pet
  self:onLoadingChanged()
  return true
end

function AircraftPetLoader:TryDelPet(pet)
  local id = pet:PstID()
  if self._pets[id] then
    local req = self._queue:PopFirst(function(r)
      local req = r
      return req:ID() == id
    end)
    req:Close()
    self._pets[id] = nil
    self:onLoadingChanged()
    return true
  end
  return false
end

function AircraftPetLoader:Dispose()
  self._queue:ForEach(function(r)
    local req = r
    req:Close()
  end)
  self._queue:Clear()
  self._pets = {}
  self._clickReq:Dispose()
  self._clickReq = nil
  self:onLoadingChanged()
end

function AircraftPetLoader:Update()
  if self._queue:Count() <= 0 then
    return
  end
  local req = self._queue:Peek()
  if req:State() == AircraftPetLoadState.Wait then
    req:Load()
    return
  end
  if req:State() == AircraftPetLoadState.Loading then
    return
  end
  if req:State() == AircraftPetLoadState.Finish then
    local id = req:ID()
    local pet = self._pets[id]
    pet:Show(req, self._clickAnimClip)
    self._queue:Dequeue()
    self._pets[id] = nil
    self:onLoadingChanged()
    return
  end
  if req:State() == AircraftPetLoadState.Closed then
    self._queue:Dequeue()
    self._pets[req:ID()] = nil
    self:onLoadingChanged()
    return
  end
end

function AircraftPetLoader:onLoadingChanged()
  if self._onLoadingCountChanged then
    self._onLoadingCountChanged(self._queue:Count())
  end
end

function AircraftPetLoader:LoadingCount()
  return self._queue:Count()
end

_class("HomelandPetLoader", Object)
HomelandPetLoader = HomelandPetLoader

function HomelandPetLoader:Init()
  self._queue = HomelandQueue:New()
  self._pets = {}
  self._clickReq = ResourceManager:GetInstance():SyncLoadAsset("AircraftPetSelectAnimRef.prefab", LoadType.GameObject)
  self._clickAnimClip = self._clickReq.Obj:GetComponent(typeof(UnityEngine.Animation)).clip
end

function HomelandPetLoader:SyncLoadePet(pet)
  local req = HomelandPetRequestSync:New(pet:TemplateID(), pet:PstID(), pet:PrefabName(), self._clickAnimClip)
  pet:Show(req, self._clickAnimClip)
end

function HomelandPetLoader:AsyncLoadPet(pet)
  local pstID = pet:PstID()
  if self._pets[pstID] then
    return
  end
  self._queue:Enqueue(HomelandPetRequestAsync:New(pet:TemplateID(), pstID, pet:PrefabName(), self._clickAnimClip))
  self._pets[pstID] = pet
end

function HomelandPetLoader:SyncLoadePetSkinModle(pet)
  local req = HomelandPetRequestSync:New(pet:TemplateID(), pet:PstID(), pet:PrefabName(), self._clickAnimClip)
  pet:ShowSkinModle(req, self._clickAnimClip)
end

function HomelandPetLoader:InterruptAsyncLoad(pet)
  self._queue:ForEach(function(r)
    local req = r
    if req:PstID() == pet:PstID() then
      if req:State() == HomelandPetLoadState.Wait then
        req:Close()
      elseif req:State() == HomelandPetLoadState.Loading then
        req:Dispose()
      end
    end
  end)
end

function HomelandPetLoader:Dispose()
  self._queue:ForEach(function(r)
    local req = r
    req:Close()
  end)
  self._queue:Clear()
  self._pets = nil
  self._clickReq:Dispose()
  self._clickReq = nil
end

function HomelandPetLoader:Update()
  if self._queue:Count() <= 0 then
    return
  end
  local req = self._queue:Peek()
  if req:State() == HomelandPetLoadState.Wait then
    req:Load()
    return
  end
  if req:State() == HomelandPetLoadState.Loading then
    return
  end
  if req:State() == HomelandPetLoadState.Finish then
    local pstid = req:PstID()
    local pet = self._pets[pstid]
    pet:Show(req, self._clickAnimClip)
    self._queue:Dequeue()
    self._pets[pstid] = nil
    return
  end
  if req:State() == HomelandPetLoadState.Closed then
    self._queue:Dequeue()
    self._pets[req:PstID()] = nil
    return
  end
end

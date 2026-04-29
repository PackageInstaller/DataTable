require("aircraft_pet_request_base")
_class("AircraftPetRequestAsync", AircraftPetRequestBase)
AircraftPetRequestAsync = AircraftPetRequestAsync

function AircraftPetRequestAsync:Constructor(petID, pstID, assetName, clickAnimClip)
  self._animName = HelperProxy:GetInstance():GetPetAnimatorControllerName(assetName, PetAnimatorControllerType.Aircraft)
  self._reqs = {}
  self._state = AircraftPetLoadState.Wait
end

function AircraftPetRequestAsync:ID()
  return self._pstID
end

function AircraftPetRequestAsync:State()
  return self._state
end

function AircraftPetRequestAsync:PetGameObject()
  return self._petGameObject
end

function AircraftPetRequestAsync:Dispose()
  for _, req in pairs(self._reqs) do
    req:Dispose()
  end
  self._reqs = {}
  self._state = AircraftPetLoadState.Closed
end

function AircraftPetRequestAsync:Load()
  self._state = AircraftPetLoadState.Loading
  GameGlobal.TaskManager():StartTask(function(TT)
    AirLog("开始异步加载星灵:", self._petID)
    local req1 = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._assetName, LoadType.GameObject)
    if not req1 then
      Log.exception("加载星灵模型失败,可能是账号中包含没有资源的星灵:", self._assetName)
    end
    table.insert(self._reqs, req1)
    if self._state == AircraftPetLoadState.Invalid then
      self:Dispose()
      return
    end
    local req2 = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._animName, LoadType.GameObject)
    if not req2 then
      Log.exception("加载星灵的风船动作失败,可能是策划漏提了资源:", self._animName)
    end
    table.insert(self._reqs, req2)
    if self._state == AircraftPetLoadState.Invalid then
      self:Dispose()
      return
    end
    self._petGameObject = req1.Obj
    self._petAnimation = req2.Obj:GetComponent("Animation")
    self:makePet()
    self._state = AircraftPetLoadState.Finish
  end)
end

function AircraftPetRequestAsync:Close()
  if self._state == AircraftPetLoadState.Loading then
    self._state = AircraftPetLoadState.Invalid
  else
    self._state = AircraftPetLoadState.Closed
  end
end

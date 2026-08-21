require("homeland_pet_request_base")
_class("HomelandPetRequestAsync", HomelandPetRequestBase)
HomelandPetRequestAsync = HomelandPetRequestAsync

function HomelandPetRequestAsync:Constructor(petID, pstID, assetName, clickAnimClip)
  self._aircraftAnimName = HelperProxy:GetInstance():GetPetAnimatorControllerName(assetName, PetAnimatorControllerType.Aircraft)
  self._homelandAnimName = HelperProxy:GetInstance():GetPetAnimatorControllerName(assetName, PetAnimatorControllerType.Homeland)
  self._reqs = {}
  self._state = HomelandPetLoadState.Wait
end

function HomelandPetRequestAsync:PstID()
  return self._pstID
end

function HomelandPetRequestAsync:State()
  return self._state
end

function HomelandPetRequestAsync:PetGameObject()
  return self._petGameObject
end

function HomelandPetRequestAsync:Dispose()
  for _, req in pairs(self._reqs) do
    req:Dispose()
  end
  self._reqs = {}
  if self._asyncLoadTask then
    GameGlobal.TaskManager():KillTask(self._asyncLoadTask)
    self._asyncLoadTask = nil
  end
  self._state = HomelandPetLoadState.Closed
end

function HomelandPetRequestAsync:Load()
  self._state = HomelandPetLoadState.Loading
  self._asyncLoadTask = GameGlobal.TaskManager():StartTask(function(TT)
    Log.info("Start async loading pet", self._petID)
    local req1 = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._assetName, LoadType.GameObject)
    if not req1 then
      Log.error("Failed to load the pet asset. The account may contain a pet with no asset", self._assetName)
    end
    table.insert(self._reqs, req1)
    if self._state == HomelandPetLoadState.Invalid then
      self:Dispose()
      return
    end
    local req2 = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._aircraftAnimName, LoadType.GameObject)
    if not req2 then
      Log.error("Failed to load pet's homeland animation, probably because missed resources.", self._aircraftAnimName)
    end
    table.insert(self._reqs, req2)
    if self._state == HomelandPetLoadState.Invalid then
      self:Dispose()
      return
    end
    local req3 = ResourceManager:GetInstance():AsyncLoadAsset(TT, self._homelandAnimName, LoadType.GameObject)
    if not req3 then
      Log.error("Failed to load pet's homeland exclusive animation, probably because missed resources.", self._homelandAnimName)
    end
    table.insert(self._reqs, req3)
    if self._state == HomelandPetLoadState.Invalid then
      self:Dispose()
      return
    end
    self._petGameObject = req1.Obj
    self._aircraftAnimation = req2.Obj:GetComponent("Animation")
    if req3 then
      self._homelandAnimation = req3.Obj:GetComponent("Animation")
    end
    self:MakePet()
    self._state = HomelandPetLoadState.Finish
  end)
end

function HomelandPetRequestAsync:Close()
  if self._state == HomelandPetLoadState.Loading then
    self._state = HomelandPetLoadState.Invalid
  else
    self._state = HomelandPetLoadState.Closed
  end
end

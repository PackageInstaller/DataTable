_class("AircraftPetRequestSync", AircraftPetRequestBase)
AircraftPetRequestSync = AircraftPetRequestSync

function AircraftPetRequestSync:Constructor(petID, pstID, assetName, clickAnimClip)
  local req1 = ResourceManager:GetInstance():SyncLoadAsset(assetName, LoadType.GameObject)
  if req1 == nil then
    AirError("找不到星灵模型:", petID)
  end
  local animName = HelperProxy:GetInstance():GetPetAnimatorControllerName(assetName, PetAnimatorControllerType.Aircraft)
  local req2 = ResourceManager:GetInstance():SyncLoadAsset(animName, LoadType.GameObject)
  self._req1 = req1
  self._req2 = req2
  self._petGameObject = req1.Obj
  self._petAnimation = req2.Obj:GetComponent("Animation")
  self:makePet()
end

function AircraftPetRequestSync:Dispose()
  self._req1:Dispose()
  self._req2:Dispose()
end

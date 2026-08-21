require("homeland_pet_request_base")
_class("HomelandPetRequestSync", HomelandPetRequestBase)
HomelandPetRequestSync = HomelandPetRequestSync

function HomelandPetRequestSync:Constructor(petID, pstID, assetName, clickAnimClip)
  local req1 = ResourceManager:GetInstance():SyncLoadAsset(assetName, LoadType.GameObject)
  if not req1 then
    Log.error("Failed to load the pet asset. The account may contain a pet with no asset", assetName)
  end
  local aircraftAnimationName = HelperProxy:GetInstance():GetPetAnimatorControllerName(assetName, PetAnimatorControllerType.Aircraft)
  local req2 = ResourceManager:GetInstance():SyncLoadAsset(aircraftAnimationName, LoadType.GameObject)
  if not req2 then
    Log.error("Failed to load pet's homeland animation, probably because missed resources.", aircraftAnimationName)
  end
  local homelandAnimationName = HelperProxy:GetInstance():GetPetAnimatorControllerName(assetName, PetAnimatorControllerType.Homeland)
  local req3 = ResourceManager:GetInstance():SyncLoadAsset(homelandAnimationName, LoadType.GameObject)
  if not req3 then
    Log.error("Failed to load pet's homeland exclusive animation, probably because missed resources.", homelandAnimationName)
  end
  self._req1 = req1
  self._req2 = req2
  self._req3 = req3
  self._petGameObject = req1.Obj
  self._aircraftAnimation = req2.Obj:GetComponent("Animation")
  self._homelandAnimation = req3.Obj:GetComponent("Animation")
  self:MakePet()
end

function HomelandPetRequestSync:Dispose()
  self._req1:Dispose()
  self._req2:Dispose()
  self._req3:Dispose()
end

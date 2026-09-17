local this = {}

function this:refreshMountData()
  local mountPetGuid = L_PlayerStore:getPlayerMount()
  if not mountPetGuid or mountPetGuid <= 0 then
    return
  end
  local mountEntityId = AzurWorld.playerMgr.myPlayerData.mountData.mountEntityId
  if mountEntityId == 0 then
    return
  end
end

function this:refreshPetEntityLevel(petGuid)
  local entityId = L_PetStore:getPetEntityId(petGuid)
  if not entityId then
    return
  end
  local petItem = L_PetStore:getPetItem(petGuid)
  C_EntityManager.RefreshPetEntity(entityId, petItem:petLv())
end

function this:refreshPetEntityFlashParam(petGuid)
  local entityId = L_PetStore:getPetEntityId(petGuid)
  if not entityId then
    return
  end
  local petItem = L_PetStore:getPetItem(petGuid)
  C_EntityManager.RefreshPetEntity(entityId, petItem:hasFlashGene())
end

return this

local this = {}

function this:generatePhotoPetEntity(petItem, callback, isSituation, entranceType)
  local createPhotoEntityData = C_EntityManager.CreatePhotoEntityData()
  local petTpl = L_GameTpl:getPetTpl()
  local tpl = petTpl:getTplById(petItem.id)
  createPhotoEntityData.unitId = petTpl:getUnitID(tpl)
  createPhotoEntityData.specialParam = petItem:isSpecialPet()
  createPhotoEntityData.flashParam = petItem:hasFlashGene()
  createPhotoEntityData.name = petItem.pet_name
  createPhotoEntityData.isSituation = isSituation
  createPhotoEntityData.petConfigId = petItem.petId
  createPhotoEntityData.skinId = petItem.wear_skin_id
  createPhotoEntityData.starColorId = petItem.colorMatId
  createPhotoEntityData.entityEntranceType = entranceType or C_EEntityEntranceType.None
  local entityId = C_EntityManager.CreatePhotoEntity(createPhotoEntityData, function(cEntity)
    if not isSituation then
      AzurWorldInstance:SetEntityAttachToNode(cEntity, L_Const.WorldNode.PHOTO)
    end
    local entity = require(L_EcsConst.aliveType.photoPet).new()
    entity:bindCsEntity(cEntity)
    entity:initialize()
    entity.petName = petItem.pet_name
    if callback then
      callback(entity)
    end
  end)
  return entityId
end

function this:generateUIHeroEntity(heroConfigId, callback, playerId, animatorType, entranceType, clothingId)
  local heroConfigId = heroConfigId
  local isPlayerHero = heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) or heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female)
  playerId = playerId or L_PlayerStore:getPlayerId()
  if isPlayerHero then
    local sex = L_FriendStore:getPlayerBaseInfo(playerId).wardrobe.sex
    heroConfigId = L_GameUtil.getDefaultHeroId(sex)
  end
  local skinId = clothingId or heroConfigId
  local unitId = L_GameUtil.getUnitIdByRole(skinId, L_Const.roleType.hero)
  local createPhotoEntityData = C_EntityManager.CreateUIHeroEntityData()
  createPhotoEntityData.unitId = unitId
  createPhotoEntityData.heroConfigId = heroConfigId
  createPhotoEntityData.name = tostring(heroConfigId)
  createPhotoEntityData.playerId = isPlayerHero and playerId or 0
  createPhotoEntityData.entityEntranceType = entranceType or C_EEntityEntranceType.None
  animatorType = animatorType or C_AnimatorControllerType.World
  createPhotoEntityData.animatorType = animatorType
  if heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.female) then
    createPhotoEntityData.modelPath = L_GameUtil.getMainHeroPath(L_Const.sexType.female)
  elseif heroConfigId == L_GameUtil.getDefaultHeroId(L_Const.sexType.male) then
    createPhotoEntityData.modelPath = L_GameUtil.getMainHeroPath(L_Const.sexType.male)
  else
    local unitTpl = L_GameTpl:getUnitTpl()
    local tpl = unitTpl:getTplById(unitId)
    local modelPath = unitTpl:getModel(tpl, 1)
    createPhotoEntityData.modelPath = modelPath
  end
  local entityId = C_EntityManager.CreateUIHeroEntity(createPhotoEntityData, function(cEntity)
    local entity = require(L_EcsConst.aliveType.uiHero).new()
    entity:bindCsEntity(cEntity)
    entity:initialize()
    if callback then
      callback(entity)
    end
  end)
  return entityId
end

return this

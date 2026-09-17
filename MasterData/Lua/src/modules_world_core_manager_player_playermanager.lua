local this = class("playerManager", G_EventManagerBase)
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_debug"))
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_hero"))
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_mainControl"))
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_mount"))
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_operator"))
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_voice"))
table.merge(this, require(L_R.world.coreMgr .. "player.playerManager_baseInfo"))
this.event = {
  setMainControl = "setMainControl",
  playMount = "playMount",
  outMount = "outMount",
  outMountEnd = "outMountEnd",
  playerUnitInit = "playerUnitInit",
  playerUnitRemove = "playerUnitRemove",
  petEntityLoadFinish = "petEntityLoadFinish"
}

function this:ctor()
  this.super.ctor(self)
end

function this:createPlayerUnitLua()
  self:sendEvent(self.event.playerUnitInit)
end

function this:removePlayerUnitLua()
  self:sendEvent(self.event.playerUnitRemove)
end

function this:getMainControlEntityPos()
  return L_Vector3.UnityV3ToLua(AzurWorld.playerMgr.myPlayerData.mainControlPosition)
end

function this:getMainControlEntityRot()
  return L_Vector3.UnityV3ToLua(AzurWorld.playerMgr.myPlayerData.mainControlRotation.eulerAngles)
end

function this:inMountFly()
  return AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() and AzurWorld.playerMgr.myPlayerData.mountData.mountStatus == C_WorldMapPlayerMountStatusType.WmpmstFly
end

function this:inMountGlide()
  return AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() and AzurWorld.playerMgr.myPlayerData.mountData.mountStatus == C_WorldMapPlayerMountStatusType.WmpmstGlide
end

function this:inHookFly()
  return AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount() and AzurWorld.playerMgr.myPlayerData.mountData.mountStatus == C_WorldMapPlayerMountStatusType.WmpmstHookfly
end

function this:inKiBoTransformMainControl()
  return AzurWorld.playerMgr.myPlayerData.mainControlType == C_EPlayerMainControlType.KiBoTransform
end

function this:getAllHeroCsEntity()
  local result = {}
  local formationHeroList = AzurWorld.playerMgr.myPlayerData.formationHeroes
  if formationHeroList then
    for i, v in pairs(formationHeroList) do
      local csEntityId = v.heroEntityId
      local csEntity = C_EntityManager.GetAliveEntity(csEntityId)
      if csEntity then
        local curModule = L_WorldManager:getCurModule()
        if curModule == L_Const.worldModule.bigBattleWorld or curModule == L_Const.worldModule.levelSimulator or curModule == L_Const.worldModule.purifySimulator then
          table.insert(result, csEntity)
        else
          result[csEntity.data.UUID] = csEntity
        end
      end
    end
  end
  return result
end

function this:getCanChangeHero(heroId)
  local mainHero = AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(true)
  if not mainHero then
    return false
  end
  if mainHero.data.UUID == heroId then
    return false
  end
  return C_EntityManager.MainPlayer.entity:CanSwitchHero(mainHero.data.UUID, heroId)
end

function this:createCsEntityEnd(csEntityId, type)
  if type == 1 then
    local csEntity = C_EntityManager.GetEntity(csEntityId)
    L_EntityManager:registerEntityTriggerStack(csEntity)
  elseif type == 2 then
    local csEntity = C_EntityManager.GetEntity(csEntityId)
    L_PetStore:refreshPetEntityGuidToEntityId(true, csEntity.data.UUID, csEntity.data.entityId)
  end
end

function this:disposeCsEntityEnd(csEntityId)
  local csEntity = C_EntityManager.GetEntity(csEntityId)
  if csEntity then
    L_PetStore:refreshPetEntityGuidToEntityId(false, csEntity.data.UUID)
    L_EntityManager:unRegisterEntityTriggerStack(csEntity)
  end
  L_PhotoManager:onCsEntityDestroy(csEntityId)
end

function this:setMainControlEntityId(csEntityId)
  self:sendEvent(self.event.setMainControl, AzurWorld.playerMgr.myPlayerData:GetPlayerMainControl(false).data.UUID)
end

function this:startRideMountVoice(petGuid)
  local petItem = L_PetStore:getPetItem(petGuid)
  if petItem then
    L_AudioUtil.stopSound(self.petIntoRideVoiceWrap)
    self.petIntoRideVoiceWrap = L_PetStore:playPetVoiceSound(petItem.id, L_PetConst.PetSystemVoiceType.IntoRide)
  end
end

function this:stopRideMountVoice()
  L_AudioUtil.stopSound(self.petIntoRideVoiceWrap)
end

function this:isInMounting()
  return AzurWorld.playerMgr.myPlayerData:GetPlayerIsRidingMount()
end

return this

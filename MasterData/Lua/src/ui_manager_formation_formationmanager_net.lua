local this = {}

function this:req_changeFormationData(type, index, posData, callback)
  if not self:checkCanChangeFormation() then
    return
  end
  if type == self:getCurFormationType() and index == L_FormationStore:getUsingTeamIndex(type) and not self:checkCanChangeFormationHero(posData) then
    return
  end
  AzurWorld.formationMgr:ReqChangeFormationPosData(type, index, posData, function(errCode, rspData)
    if errCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:switchGroup(teamType, teamIndex, callback)
  if not self:checkCanChangeFormation() then
    return
  end
  if not self:checkCanChangeFormationHero(L_FormationStore:getFormationPosData(teamType, teamIndex)) then
    return
  end
  AzurWorld.formationMgr:ReqChangeCurFormation(teamType, teamIndex, function(errCode, data)
    if errCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_quickChangeGroup(formationType, formationIndex, wearPets, callback)
  if not self:checkCanChangeFormation() then
    return
  end
  local heroList = {}
  for i, wear in ipairs(wearPets) do
    table.insert(heroList, wear.hero_guid)
  end
  local using = L_FormationStore:getUsingTeamIndex(formationType) == formationIndex
  if using and not self:checkCanChangeFormationHero(heroList) then
    return
  end
  AzurWorld.formationMgr:ReqQuickFormation(formationType, formationIndex, wearPets, function(errCode, data)
    if errCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_removeHero(formationType, formationIndex, posIndex, callback)
  local curPosData = L_FormationStore:getAllPosData(formationType, formationIndex)
  curPosData[posIndex].hero_guid = 0
  curPosData[posIndex].pet_guid = 0
  L_FormationManager:req_quickChangeGroup(formationType, formationIndex, curPosData, callback)
end

function this:req_addHero(formationType, formationIndex, posIndex, heroGuid, callback)
  local curPosData = L_FormationStore:getAllPosData(formationType, formationIndex)
  local oriPlace = L_FormationStore:getHeroPlaceInTeam(formationType, formationIndex, heroGuid)
  local posData = L_FormationStore:getFormationPosData(formationType, formationIndex)
  if 0 < oriPlace then
    local oriHeroGuid = posData[posIndex]
    curPosData[oriPlace] = {
      hero_guid = oriHeroGuid,
      pet_guid = L_HeroStore:getHeroPetGuidByHeroGuid(oriHeroGuid)
    }
  end
  curPosData[posIndex] = {
    hero_guid = heroGuid,
    pet_guid = L_HeroStore:getHeroPetGuidByHeroGuid(heroGuid)
  }
  L_FormationManager:req_quickChangeGroup(formationType, formationIndex, curPosData, callback)
end

function this:req_addPet(formationType, formationIndex, posIndex, petGuid, callback)
  local posData = L_FormationStore:getFormationPosData(formationType, formationIndex)
  local curPosData = {}
  for i, guid in ipairs(posData) do
    curPosData[i] = {
      hero_guid = guid,
      pet_guid = L_FormationStore:getFormationPosPetGuid(formationType, formationIndex, i)
    }
  end
  for i, data in ipairs(curPosData) do
    if data.pet_guid == petGuid then
      curPosData[i].pet_guid = 0
    end
    if i == posIndex then
      curPosData[i].pet_guid = petGuid
    end
  end
  L_FormationManager:req_quickChangeGroup(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), curPosData, function()
    if callback then
      callback()
    end
  end)
end

function this:req_removePet(formationType, formationIndex, posIndex, callback)
  local posData = L_FormationStore:getFormationPosData(formationType, formationIndex)
  local curPosData = {}
  for i, guid in ipairs(posData) do
    curPosData[i] = {
      hero_guid = guid,
      pet_guid = L_FormationStore:getFormationPosPetGuid(formationType, formationIndex, i)
    }
  end
  for i, data in ipairs(curPosData) do
    if i == posIndex then
      curPosData[i].pet_guid = 0
    end
  end
  L_FormationManager:req_quickChangeGroup(L_FormationManager:getRuntimeFormationType(), L_FormationManager:getRuntimeFormationIndex(), curPosData, function()
    callback()
  end)
end

function this:checkCanChangeFormation()
  if L_PlayerManager:inMountFly() or L_PlayerManager:inMountGlide() or L_PlayerManager:inHookFly() then
    L_FlyMsgManager:showNormalMsg(L_Lang:get(L_WordsTpl:getValue("notice_dungeon_team_fly")))
    return false
  end
  return true
end

function this:checkPetRuleEnableFormation(curPosData, callback)
  for i, v in pairs(curPosData) do
    local petGuid = v.pet_guid
    local petItem = L_PetStore:getPetItem(petGuid)
    if petItem ~= nil then
      local petGameplayStatus = petItem:getGameplayStatus()
      if petGameplayStatus == L_Const.PetState.PET_WORKING or petGameplayStatus == L_Const.PetState.PET_RESTING or petGameplayStatus == L_Const.PetState.PET_HUB then
        L_GameUtil.showCommonTip({
          txtContent = L_WordsTpl:getValue("notice_qibo_confirm_farm_team"),
          confirmCallback = callback
        })
        return
      end
    end
  end
  callback()
end

function this:checkCanChangeFormationHero(heroGuids)
  local allDie = true
  for i, guid in pairs(heroGuids) do
    if not math.isEmpty(guid) then
      local remainHp = L_FormationStore:getFormationHeroHp(guid)
      if 0 < remainHp then
        allDie = false
      end
    end
  end
  if allDie then
    self:showFormationTip(L_FormationConst.FormationTipType.NoAliveExist)
    return false
  end
  return true
end

function this:checkCanChangeFormationPet(petGuid, callback)
  if type(petGuid) == "number" then
    local petItem = L_PetStore:getPetItem(petGuid)
    local petGameplayStatus = petItem:getGameplayStatus()
    if petGameplayStatus == L_Const.PetState.PET_WORKING or petGameplayStatus == L_Const.PetState.PET_RESTING or petGameplayStatus == L_Const.PetState.PET_HUB then
      L_GameUtil.showCommonTip({
        txtContent = L_WordsTpl:getValue("notice_qibo_confirm_farm_team"),
        confirmCallback = callback
      })
      return false
    end
  end
  return true
end

function this:checkCanReviveHeros()
  if AzurWorld.DungeonMgr.GetIsReqExitDungeon then
    print("checkCanReviveHeros", "正在退出副本，不能复活")
    return false
  end
  return true
end

return this

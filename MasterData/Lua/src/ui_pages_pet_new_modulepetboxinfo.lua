local this = class("modulePetBoxInfo", G_UIModuleBase)
local petLearningAblityTpl = L_GameTpl:getPetLearningAblityTpl()
local petLearningEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()

function this.bind()
  return {
    modulePetBoxRating = {
      moduleName = "pages/pet/new/modulePetBoxRating"
    },
    modulePetBoxName = {
      moduleName = "pages/pet/new/modulePetBoxName"
    },
    modulePetNewSimpleTags = {
      moduleName = "pages/pet/new/modulePetNewSimpleTags"
    },
    modulePetFavorability = {
      moduleName = "pages/pet/new/modulePetFavorability"
    },
    modulePetBoxAttrInfo = {
      moduleName = "pages/pet/new/modulePetBoxAttrInfo"
    },
    modulePetNewSkills = {
      moduleName = "pages/pet/new/modulePetNewSkills"
    },
    modulePetGeneSkills = {
      moduleName = "pages/pet/new/modulePetNewGeneInfo"
    },
    modulePetNewHomeTag = {
      moduleName = "pages/pet/new/modulePetNewHomeTags"
    },
    modulePetMountInfo = {
      moduleName = "pages/pet/new/modulePetMountInfo"
    },
    modulePetRaceInfo = {
      moduleName = "pages/pet/new/modulePetRaceInfo"
    },
    modulePetCard = {
      moduleName = "pages/pet/new/modulePetCard"
    },
    moduleTabInfo = {
      moduleName = "pages/pet/new/modulePetBoxTabtwo"
    },
    panel_skill = false,
    panel_info = false,
    showInfoRoot = false,
    showEmpty = false,
    detailBtnActive = false,
    commonDetailBtnActive = true,
    mutationBtnActive = false,
    active_btnRoot = true,
    active_skinBtn = false,
    go_evoBtn = true,
    go_canEvo = false,
    go_cantEvo = true,
    go_useMutationBtn = false,
    txt_mutationNum = "",
    go_modulePetCard = false
  }
end

function this:resetBoxInfo()
  self.isPetOpen = false
end

function this.methods()
  return {
    onClick_commonDetail = function(self)
      self:onClickDetail()
    end,
    onClick_detail = function(self)
      self:onClickDetail()
    end,
    onClick_useMutationNum = function(self)
      local petItem = L_PetStore:getPetItem(self.petGuid)
      if petItem and petItem:hasMutationGene() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_dna_mutation_next_limit"))
        return
      end
      L_PetStore:req_CSProtoUseMutationTimes(self.petGuid, function()
        self:refreshPetProperty(self.petGuid)
      end)
    end,
    onClick_mutation = function(self)
      L_UI:open("pagePetGeneMutation", {
        petId = self.petGuid,
        playExchangeSaveIn = true
      })
    end,
    onClick_detail2 = function(self)
      self.isPetOpen = true
      L_UI:open("pagePet", {
        petId = self.petGuid,
        failure_jump = self:GetSourceLuaPageOptions("failure_jump")
      })
    end,
    onClick_skin = function(self)
      if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.petDecoration) then
        return
      end
      if self:GetSourceLuaPageOptions("failure_jump") then
        L_FlyMsgManager:showNormalMsgByKey("common_jump_ban_tips")
        return
      end
      if L_PetReleaseManager:getIsReleaseMode() then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_release_skin_tips"))
        return
      end
      if not self:checkPetCanChangeSkin() then
        return
      end
      L_UI:open("pagePetSkin", {
        petGuid = self.petGuid
      })
    end,
    onClick_evo = function(self)
      self:onClickEvo()
    end,
    onClick_evo2 = function(self)
      self:onClickEvo()
    end
  }
end

function this:open()
  self.isPetBoxOpening = true
  self.recoverLimit = tonumber(L_GameTpl:getGameConstTpl():getData("PET_MAXENERGY", L_Const.GameTplType.int))
  self.recoverPoint = tonumber(L_GameTpl:getGameConstTpl():getData("PET_ENERGYRECOVER", L_Const.GameTplType.int))
  self.scale = tonumber(L_GameTpl:getGameConstTpl():getData("PET_ENERGYPERSEC", L_Const.GameTplType.int))
  self.modules.moduleTabInfo:setData(1, function(bLeft)
    self:showInfo(bLeft)
  end)
  self:showInfo(true)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutation, self)
  self._ESyncMountRouletteServerDataHandler = handler(self, self.onEvent_mountSync)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:close()
  L_TimerManager:clearTimer(self)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.setCurPetId, self.onEvent_setCurPetId)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutation, self)
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self._ESyncMountRouletteServerDataHandler)
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.petGuid then
    return
  end
  self:refreshPetProperty(self.petGuid)
end

function this:onEvent_setCurPetId(petGuid)
  if petGuid == self.petGuid then
    return
  end
  self:refreshPetProperty(petGuid, true)
end

function this:onEvent_refreshPetGeneMutation(petGuid)
  if petGuid ~= self.petGuid then
    return
  end
  self:refreshPetProperty(self.petGuid)
end

function this:onEvent_mountSync()
  if math.isEmpty(self.petGuid) then
    return
  end
  self:refreshPetProperty(self.petGuid)
end

function this:showInfo(bool)
  self.bind.panel_info = not bool
  self.bind.panel_skill = bool
end

function this:playPetCardShowAnim()
  local modulePetCard = self.modules.modulePetCard
  if modulePetCard then
    self.bind.go_modulePetCard = true
    modulePetCard:playShowAnim()
  end
  self.isPetBoxOpening = false
end

function this:refreshPetProperty(petGuid, doAnim)
  local isOpen = not self.isPetOpen
  if self.isPetOpen then
    doAnim = false
  end
  if math.isEmpty(petGuid) then
    self.petGuid = nil
    self.modules.modulePetCard:enableCard(false)
    self.bind.go_evoBtn = false
    self.bind.go_canEvo = false
    self.bind.go_cantEvo = true
    self.bind.showInfoRoot = false
    self.bind.showEmpty = true
    self:setDetailBtnActive(false)
    return
  end
  self.petGuid = petGuid
  self.bind.showInfoRoot = true
  self.bind.showEmpty = false
  if not self.isPetBoxOpening then
    self.modules.modulePetCard:enableCard(true)
  end
  self:setDetailBtnActive(true)
  if not doAnim then
    self.modules.modulePetCard:setGuid(petGuid)
    self:initNoAnimModule(petGuid)
  else
    self.modules.modulePetCard:setGuidWithAnim(petGuid)
    if self.parent and self.parent.bindComponents and self.parent.bindComponents.anim then
      self.parent.bindComponents.anim:Stop()
      self.parent.bindComponents.anim:Play("anim_petbox_switch")
    end
    self.modules.modulePetNewHomeTag:setGuid(petGuid)
    L_TimerManager:newOrResetTimer(self, "setPetInfo", function()
      self:initNoAnimModule(petGuid)
    end, 0.2)
  end
  local petItem = L_PetStore:getPetItem(petGuid)
  if petItem:hasMutationGene() then
    self.bind.mutationBtnActive = true
  else
    self.bind.mutationBtnActive = false
  end
  self.bind.active_skinBtn = petItem:haveSkinConfig()
  self.bind.go_evoBtn = true
  local canStartEvo = self:checkPetCanStartEvolution(petItem, petRankTpl:getchildren(petItem.id))
  self.bind.go_canEvo = canStartEvo
  self.bind.go_cantEvo = not canStartEvo
  if petItem:haveMutationNum() then
    self.bind.go_useMutationBtn = true
    self.bind.detailBtnActive = true
    self.bind.commonDetailBtnActive = false
    self.bind.txt_mutationNum = "x" .. petItem.mutation_times
  else
    self.bind.go_useMutationBtn = false
    self.bind.detailBtnActive = false
    self.bind.commonDetailBtnActive = true
    self.bind.txt_mutationNum = ""
  end
end

function this:initNoAnimModule(petGuid)
  self.modules.modulePetBoxRating:setGuid(petGuid)
  self.modules.modulePetBoxName:setGuid(petGuid)
  self.modules.modulePetNewSimpleTags:setGuid(petGuid, true)
  self.modules.modulePetFavorability:setGuid(petGuid)
  self.modules.modulePetBoxAttrInfo:setGuid(petGuid)
  self.modules.modulePetNewSkills:setGuid(petGuid)
  self.modules.modulePetGeneSkills:setGuid(petGuid)
  self.modules.modulePetGeneSkills:setUseTipBubble(true)
  self.modules.modulePetMountInfo:setGuid(petGuid)
  self.modules.modulePetRaceInfo:setGuid(petGuid)
end

function this:setDetailBtnActive(isShow)
  local resActive = isShow and not L_PetReleaseManager:getIsReleaseMode() and not self.bind.showEmpty
  self.bind.active_btnRoot = resActive
end

function this:checkPetCanFeed()
  local serverData = L_PetStore:getPetItem(self.petGuid)
  return not serverData:getPetAbilityLimited()
end

function this:checkPetCanChangeSkin()
  if self:checkPetInBattle(self.petGuid) then
    L_FlyMsgManager:showNormalMsgByKey("notice_kibo_change_skin_fight_limit")
    return false
  end
  if self:checkPetRiding(self.petGuid) then
    L_FlyMsgManager:showNormalMsgByKey("notice_kibo_change_skin_ride_limit")
    return false
  end
  return true
end

function this:checkPetInBattle(petGuid)
  if math.isEmpty(petGuid) or not L_BattleDataManager:checkPlayerBattle() then
    return false
  end
  for posIndex = 0, 3 do
    local petCsEntity = AzurWorld.playerMgr.myPlayerData:GetPetEntity(posIndex)
    if petCsEntity and petCsEntity.data and petCsEntity.data.UUID == petGuid then
      return true
    end
  end
  return false
end

function this:checkPetRiding(petGuid)
  if math.isEmpty(petGuid) then
    return false
  end
  local playerData = AzurWorld.playerMgr.myPlayerData
  local mountData = playerData.mountData
  return (playerData:GetPlayerIsRidingMount() or mountData.isLeaveAniPlaying or mountData.isRideAniPlaying) and mountData and mountData.mountGuid == petGuid
end

function this:getPetEvoData()
  if math.isEmpty(self.petGuid) then
    return nil, nil
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem == nil then
    return nil, nil
  end
  return petItem, petRankTpl:getchildren(petItem.id)
end

function this:checkPetCanShowEvo(petItem)
  if petItem == nil then
    return false
  end
  local rankData = petRankTpl:getchildren(petItem.id)
  if table.isEmpty(rankData) then
    return false
  end
  local nextPetId = rankData.nextPetId
  local levelNeed = rankData.levelNeed
  if math.isEmpty(nextPetId) or levelNeed == nil then
    return false
  end
  return levelNeed <= petItem.lv
end

function this:checkPetCanStartEvolution(petItem, rankData)
  if petItem == nil or table.isEmpty(rankData) then
    return false
  end
  if L_PetReleaseManager:getIsReleaseMode() then
    return false
  end
  if math.isEmpty(rankData.nextPetId) then
    return false
  end
  if petItem:getPetAbilityLimited() then
    return false
  end
  local levelNeed = rankData.levelNeed
  if levelNeed == nil or levelNeed > petItem.lv then
    return false
  end
  if self:checkPetHasEvoItemConfig(rankData) then
    return petItem:checkCanEvo()
  end
  return true
end

function this:checkPetHasEvoItemConfig(rankData)
  local costItems = rankData.rankBreakthroughItem or {}
  for i = 1, #costItems do
    local itemInfo = costItems[i]
    local itemId
    if #itemInfo == 2 then
      itemId = itemInfo[1]
    elseif #itemInfo == 3 then
      itemId = itemInfo[2]
    end
    if not math.isEmpty(itemId) then
      return true
    end
  end
  return false
end

function this:getPetEvolutionReqData()
  return {
    u64 = self.petGuid
  }
end

function this:getPetEvoUpgradePreviewData(petItem, rankData, levelNotMatch, hasEvoItemConfig)
  return {
    reqData = self:getPetEvolutionReqData(),
    petGuid = self.petGuid,
    petItem = petItem,
    rankData = rankData,
    nextPetId = rankData.nextPetId,
    levelNeed = rankData.levelNeed,
    levelNotMatch = levelNotMatch,
    hasEvoItemConfig = hasEvoItemConfig,
    evoItemList = rankData.rankBreakthroughItem or {}
  }
end

function this:showPetEvoUpgradePreview(previewData)
  if previewData == nil then
    return
  end
  self.evoUpgradePreviewData = previewData
  L_UI:open("pagePetEvoTip", previewData)
end

function this:startPetEvolution(petItem)
  if self.isRankUpRequesting then
    return
  end
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PetEvolutionEntrance), 0)
    return
  end
  local oldSkillInfo = L_PetStore:getPetSkills(petItem, false, false, true)
  local oldPetData = table.clone(petItem)
  local data = self:getPetEvolutionReqData()
  self.isRankUpRequesting = true
  L_PetStore:setIsPlayingTimeLine(true)
  L_PetStore:req_changeRankUpPet(data, function(rspData, errorCode)
    self.isRankUpRequesting = false
    if errorCode ~= L_Const.errorCode.ErrCodeSucc or not self.isBind then
      L_PetStore:setIsPlayingTimeLine(false)
      return
    end
    local pet = L_PetStore:getPetItem(self.petGuid)
    local triggerCommonGetPet = L_CatalogStore and L_CatalogStore._triggerCommonGetPet
    if pet ~= nil and triggerCommonGetPet ~= nil then
      triggerCommonGetPet(L_CatalogStore, pet)
    end
    self.isPetOpen = true
    L_UI:open("pagePetEvo", {
      guid = self.petGuid,
      prePetData = oldPetData,
      oldSkillInfo = oldSkillInfo
    })
  end)
end

function this:onClickDetail()
  self.isPetOpen = true
  L_UI:open("pagePet", {
    petId = self.petGuid,
    failure_jump = self:GetSourceLuaPageOptions("failure_jump")
  })
end

function this:onClickEvo()
  local petItem, rankData = self:getPetEvoData()
  if petItem == nil or table.isEmpty(rankData) then
    return
  end
  if L_PetReleaseManager:getIsReleaseMode() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_release_evolution_tips"))
    return
  end
  if math.isEmpty(rankData.nextPetId) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_evolution_no_next"))
    return
  end
  if not self:checkPetCanFeed() then
    L_FlyMsgManager:showNormalMsgByKey("notice_kibo_suppression_can_not_upgrade")
    return
  end
  local levelNeed = rankData.levelNeed
  local levelNotMatch = levelNeed == nil or levelNeed > petItem.lv
  local hasEvoItemConfig = self:checkPetHasEvoItemConfig(rankData)
  if levelNotMatch or hasEvoItemConfig then
    self:showPetEvoUpgradePreview(self:getPetEvoUpgradePreviewData(petItem, rankData, levelNotMatch, hasEvoItemConfig))
    return
  end
  self:startPetEvolution(petItem)
end

return this

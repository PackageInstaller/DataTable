local this = class("modulePetFeed", G_UIModuleBase)
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local _petFavorabilityTpl = L_GameTpl:getPetFavorabilityTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()

function this.bind()
  return {
    txt_materialToggleName = "",
    materialToggle = {
      type = "toggleModule",
      moduleMaterial = {
        assetName = "UI/Pages/Pet/modulePetAttributeFruit",
        moduleName = "pages/pet/modulePetAttributeFruit"
      }
    },
    modulePetFeedInfoBox = {
      moduleName = "pages/pet/new/modulePetFeedInfoBox"
    },
    modulePetBoxAttrInfo = {
      moduleName = "pages/pet/new/modulePetBoxAttrInfo"
    },
    modulePetGeneSkills = {
      moduleName = "pages/pet/new/modulePetNewGeneInfo"
    },
    active_btnCultivate = true,
    active_rootFavor = false,
    txt_favor = "",
    active_unLockDes = false,
    txt_unLockDes = "",
    go_emptyNode = false,
    go_canEvo = false,
    go_notEvo = false,
    go_fullTips = false
  }
end

function this.methods()
  return {
    onClick_btnCultivate = function(self)
      if not self:checkPetCanFeed() then
        L_FlyMsgManager:showNormalMsgByKey("notice_kibo_suppression_can_not_upgrade")
        return
      end
      C_AudioManager.Play("Play_SFX_System_UI_General_Halfscreen_Open")
      self.bind.active_btnCultivate = false
      self.bind.active_rootFavor = false
      self.bind.active_favorUpItem = false
      self.bind.txt_materialToggleName = "moduleMaterial"
      self.modules.materialToggle[self.bind.txt_materialToggleName]:setInfos({
        petGuid = self.petGuid,
        parent = self
      })
      self.modules.materialToggle[self.bind.txt_materialToggleName]:refreshUI()
      self.fruitShow = true
      self.bind.go_emptyNode = true
      self:setNodesVisibleWhenOpenMaterial(false)
    end,
    onClick_empty = function(self)
      local modulePetAttributeFruit = self.modules.materialToggle[self.bind.txt_materialToggleName]
      if modulePetAttributeFruit then
        if modulePetAttributeFruit:closeRecommendList() then
          return
        end
        modulePetAttributeFruit:resetFilterState()
        modulePetAttributeFruit:resetSelectNum()
      end
      self:closeMaterialModule()
    end,
    onClick_canEvo = function(self)
      self:onClick_evo()
    end,
    onClick_notEvo = function(self)
      self:onClick_evo()
    end
  }
end

function this:open()
  this.super.open(self)
  self.dailyFavorateMax = L_GameTpl:getGameConstTpl():getData("PET_FAVORABILITY_MAX", L_Const.GameTplType.int)
  L_PetStore:listenCallFunc(L_PetStore.event.petComprehensionLvUp, self.onPetComprehensionLvUp, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetFruitFavorLvUp, self.onEventMessageRefreshPetFruitFavorLvUp, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet, self)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutation, self)
end

function this:show()
  local tpl_uiTopBar = uiTopBarTpl:getTplByPageName("pagePet")
  local resource = uiTopBarTpl:getResourceBar(tpl_uiTopBar, 1)
  local tb = L_LuaToCSharpUtil.parseLuaCfgList(resource)
  C_IntegrateMgr.TopBarModule:Lua_SetResourcesByResList(tb)
  self.bind.active_btnCultivate = true
  self:closeMaterialModule()
  if self.petGuid then
    self:refreshEvoBtnState(L_PetStore:getPetItem(self.petGuid))
    self:refreshCurPetGeneFullTips()
  end
end

function this:setShowPetGuid(petGuid)
  self.petGuid = petGuid
  local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
  modulePetFeedInfoBox:setShowPetGuid(petGuid)
  local modulePetBoxAttrInfo = self.modules.modulePetBoxAttrInfo
  if modulePetBoxAttrInfo then
    modulePetBoxAttrInfo:setGuid(petGuid)
  end
  self:refreshPetGeneSkills()
  self:refreshEvoBtnState(L_PetStore:getPetItem(petGuid))
end

function this:refreshUI()
  self.bind.active_btnCultivate = true
  self:closeMaterialModule()
  self:refreshEvoBtnState(L_PetStore:getPetItem(self.petGuid))
  self:RefreshPetLevelLimit()
  self:refreshPetGeneSkills()
  if not self.lockRefresh then
    if self.bind.txt_materialToggleName ~= "" then
      local modulePetAttributeFruit = self.modules.materialToggle[self.bind.txt_materialToggleName]
      modulePetAttributeFruit:setInfos({
        petGuid = self.petGuid,
        parent = self
      })
      modulePetAttributeFruit:refreshUI()
    end
    local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
    modulePetFeedInfoBox:refreshUI()
  end
end

function this:RefreshPetLevelLimit()
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem.lv >= L_PetStore:getPetMaxLevel() then
    return
  end
  if petItem.lv >= L_PetStore:getPetMaxLevel(true) then
    local tpl = _petLevelTpl:getTplById(petItem.lv + 1)
    local condition = _petLevelTpl:getCondition(tpl)
    local bCompelte = true
    if not table.isEmpty(condition) then
      bCompelte = L_ConditionManager:singleIsComplete(condition)
    end
    if not bCompelte then
      local limitLevel = condition[2]
      self.bind.txt_unLockDes = L_WordsTpl:getValue("ui_pet_maxlevellimittips", {
        [0] = L_GameUtil.fillColor(tostring(limitLevel), "#ffa200")
      })
    end
    self.bind.active_unLockDes = not bCompelte
  else
    self.bind.active_unLockDes = false
  end
end

function this:onPetExpItemSelectNumChange(selectInfo, preUseFruitInfoList)
  local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
  modulePetFeedInfoBox:onPetExpItemSelectNumChange(selectInfo, preUseFruitInfoList)
  self:refreshAttrFruitPreview(preUseFruitInfoList)
end

function this:onPetAttrFruitSelectNumChange(preUseFruitInfoList)
  self:refreshAttrFruitPreview(preUseFruitInfoList)
end

function this:refreshAttrFruitPreview(preUseFruitInfoList)
  local modulePetBoxAttrInfo = self.modules.modulePetBoxAttrInfo
  if not modulePetBoxAttrInfo then
    return
  end
  local previewLv
  local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
  local modulePetLevelInfo = modulePetFeedInfoBox and modulePetFeedInfoBox.modules.modulePetLevelInfo
  if modulePetLevelInfo then
    previewLv = modulePetLevelInfo:getCurrentLv()
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  local previewMap = L_PetStore:getPetAttrFruitPreviewPropertyDeltaMap(pet, preUseFruitInfoList, previewLv)
  modulePetBoxAttrInfo:setPreviewPropertyDeltaMap(previewMap)
end

function this:getPetGuid()
  return self.petGuid
end

function this:checkPetCanFeed()
  local serverData = L_PetStore:getPetItem(self.petGuid)
  return serverData ~= nil and not serverData:getPetAbilityLimited()
end

function this:close()
  L_PetStore:unListenCallFunc(L_PetStore.event.petComprehensionLvUp, self.onPetComprehensionLvUp)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetFruitFavorLvUp, self.onEventMessageRefreshPetFruitFavorLvUp)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self.onEvent_refreshPet)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPetGeneMutation, self.onEvent_refreshPetGeneMutation)
  L_TimerManager:clearTimer(self)
  self:setNodesVisibleWhenOpenMaterial(true)
end

function this:setLockGeneSkillsRefresh(lock)
  self.lockGeneSkillsRefresh = lock == true
  if not self.lockGeneSkillsRefresh then
    self:refreshPetGeneSkills()
  end
end

function this:refreshPetGeneSkills()
  if math.isEmpty(self.petGuid) then
    return
  end
  if self.lockGeneSkillsRefresh then
    return
  end
  local modulePetGeneSkills = self.modules.modulePetGeneSkills
  if modulePetGeneSkills then
    modulePetGeneSkills:setPreviewNewTagOnly(true)
    modulePetGeneSkills:setGuid(self.petGuid)
    modulePetGeneSkills:setUseTipBubble(true)
  end
  self:refreshCurPetGeneFullTips()
end

local _petDnaMaxNum = tonumber(L_GameTpl:getGameConstTpl():getData("PET_DNA_MAX_NUM", L_Const.GameTplType.int)) or 0

function this:isGeneFruitPreviewActive()
  local modulePetGeneSkills = self.modules.modulePetGeneSkills
  if not modulePetGeneSkills or not modulePetGeneSkills.preUseGeneFruitInfoList then
    return false
  end
  return #modulePetGeneSkills.preUseGeneFruitInfoList > 0
end

function this:refreshCurPetGeneFullTips()
  if self:isGeneFruitPreviewActive() then
    self:refreshGeneFullTips(false)
    return
  end
  if math.isEmpty(self.petGuid) or _petDnaMaxNum <= 0 then
    self:refreshGeneFullTips(false)
    return
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local geneInfos = petItem and petItem.gene_infos or {}
  local geneNum = 0
  for _, _ in pairs(geneInfos) do
    geneNum = geneNum + 1
  end
  self:refreshGeneFullTips(geneNum >= _petDnaMaxNum)
end

function this:onPetGeneFruitSelectNumChange(preUseGeneFruitInfoList)
  local modulePetGeneSkills = self.modules.modulePetGeneSkills
  if modulePetGeneSkills then
    modulePetGeneSkills:setPreUseGeneFruitInfoList(preUseGeneFruitInfoList)
  end
  self:refreshCurPetGeneFullTips()
end

function this:clearPetGeneFruitPreview()
  local modulePetGeneSkills = self.modules.modulePetGeneSkills
  if modulePetGeneSkills then
    modulePetGeneSkills:setPreUseGeneFruitInfoList({})
  end
  self:refreshCurPetGeneFullTips()
end

function this:onEvent_refreshPet(pet)
  if pet.guid ~= self.petGuid then
    return
  end
  self:refreshPetGeneSkills()
end

function this:onEvent_refreshPetGeneMutation(petGuid)
  if petGuid ~= self.petGuid then
    return
  end
  self:refreshPetGeneSkills()
end

function this:onEventMessageRefreshPetFruitFavorLvUp(msg)
  if string.isEmpty(msg) or self.petGuid ~= msg.petGuid then
    return
  end
  local fruitFavor = msg.newFavorVal - msg.oldFavorVal
  if msg.isFavorLvUp then
    local upFavorExp = 0
    if msg.newFavorLv > 1 then
      for i = msg.oldFavorLv, msg.newFavorLv do
        if i ~= msg.newFavorLv then
          upFavorExp = upFavorExp + _petFavorabilityTpl:getUpgradeExp(i)
        end
      end
      upFavorExp = upFavorExp - msg.oldFavorVal
    end
    fruitFavor = msg.newFavorVal + upFavorExp
  end
  if fruitFavor ~= 0 then
    self:showFruitFavor(msg.isFavorLvUp, fruitFavor)
  else
    if not self.isSelectAttribute then
      return
    end
    if _petFavorabilityTpl:getIsMaxLv(msg.newFavorLv) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_favorability_level_max"))
    elseif msg.dailyFavorCount >= self.dailyFavorateMax then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_fruit_favorability_max"))
    end
  end
end

function this:showFruitFavor(isFavorLvUp, fruitFavor)
  if isFavorLvUp then
    local msg = CS.Lens.Gameplay.UI.FlymsgPetFavorLevelUp.PetFavorLevelUpMsg()
    msg.petGuid = self.petGuid
    msg.isLeft = true
    AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petFavorLevelUpMsg, msg)
  end
  C_AudioManager.Play("Play_SFX_System_UI_Qibo_Like_LikeUp")
  self.bind.txt_favor = tostring(fruitFavor)
  L_TimerManager:newOrResetTimer(self, "showFruit", function()
    self.bind.active_rootFavor = true
  end, 0.22)
  L_TimerManager:newOrResetTimer(self, "hideFruit", function()
    self.bind.active_rootFavor = false
  end, 2)
end

function this:onPetComprehensionLvUp()
  self:refreshUI()
  local modulePetBoxAttrInfo = self.modules.modulePetBoxAttrInfo
  if modulePetBoxAttrInfo and self.petGuid then
    modulePetBoxAttrInfo:setGuid(self.petGuid)
  end
  if not self.lockRefresh then
    local modulePetAttributeFruit = self.modules.materialToggle[self.bind.txt_materialToggleName]
    if modulePetAttributeFruit then
      modulePetAttributeFruit:resetSelectNum()
    end
  end
end

function this:playPetFeedItemEffect(params)
  if not self.isBind then
    return
  end
end

function this:onFeedPet(params)
  if params.isPetLevelUp and params.isPetAttrUp then
    self:playPetBoxLevelUpFx(params)
    self:playPetLevelUpAnim(params, nil, function()
      L_TimerManager:newOrResetTimer(self, "attrLevelUp", function()
        self:playPetFeedItemEffect(params)
        self:feedPetSuccess(params)
      end, 0)
    end)
  elseif params.addExp > 0 then
    if params.isPetLevelUp or params.isPetAttrUp then
      self:playPetBoxLevelUpFx(params)
    end
    self:playPetLevelUpAnim(params, function()
      self:feedPetSuccess(params)
    end)
  elseif params.isPetAttrUp then
    self:playPetBoxLevelUpFx(params)
    L_TimerManager:newOrResetTimer(self, "attrLevelUp", function()
      self:playPetFeedItemEffect(params)
      self:feedPetSuccess(params)
    end, 0.5)
  else
    self:feedPetSuccess(params)
  end
end

function this:playPetLevelUpAnim(params, callback, upCallback)
  local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
  modulePetFeedInfoBox:playPetLevelUpAnim(params, callback, upCallback)
end

function this:playPetBoxLevelUpFx(params)
  if not params then
    return
  end
  if params.isRatingUp then
    local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
    if modulePetFeedInfoBox and modulePetFeedInfoBox.playRatingFx then
      modulePetFeedInfoBox:playRatingFx()
    end
  end
  if not params.isPetLevelUp then
    return
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local isMaxLv = petItem and petItem.lv >= L_PetStore:getPetMaxLevel()
  local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
  local modulePetLevelInfo = modulePetFeedInfoBox and modulePetFeedInfoBox.modules.modulePetLevelInfo
  if modulePetLevelInfo and modulePetLevelInfo.playLevelUpFx then
    modulePetLevelInfo:playLevelUpFx(isMaxLv)
  end
end

function this:feedPetSuccess(params)
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem then
    L_PetStore:playPetVoiceSound(petItem.id, L_PetConst.PetSystemVoiceType.Upgrade)
  end
  self:setIsLvUpgrading(false)
  self:setIsAttrUpgrading(false)
  self:onPetComprehensionLvUp()
end

function this:setIsLvUpgrading(isLvUpgrading)
  self.isLvUpgrading = isLvUpgrading
  if self.isLvUpgrading or self.isAttrUpgrading then
    self.lockRefresh = true
  else
    self.lockRefresh = false
  end
end

function this:setIsAttrUpgrading(isAttrUpgrading)
  self.isAttrUpgrading = isAttrUpgrading
  if self.isLvUpgrading or self.isAttrUpgrading then
    self.lockRefresh = true
  else
    self.lockRefresh = false
  end
end

function this:hide()
  if self.isLvUpgrading or self.isAttrUpgrading then
    L_TimerManager:stopTimer(self, "attrLevelUp")
    local modulePetFeedInfoBox = self.modules.modulePetFeedInfoBox
    local anim = modulePetFeedInfoBox and modulePetFeedInfoBox.bindComponents and modulePetFeedInfoBox.bindComponents.anim
    if anim then
      local clipName = "anim_petfeed_feed_show"
      anim:Play(clipName)
      local animState = anim.get_Item and anim:get_Item(clipName)
      if animState then
        animState.normalizedTime = 1
        anim:Sample()
      end
      anim:Stop()
    end
    self:feedPetSuccess()
  end
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

function this:refreshEvoBtnState(petItem)
  local canStartEvo = false
  if petItem ~= nil then
    canStartEvo = self:checkPetCanStartEvolution(petItem, petRankTpl:getchildren(petItem.id))
  end
  self.bind.go_canEvo = canStartEvo
  self.bind.go_notEvo = not canStartEvo
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

function this:onClick_evo()
  local petItem, rankData = self:getPetEvoData()
  if petItem == nil or table.isEmpty(rankData) then
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
    L_UI:open("pagePetEvo", {
      guid = self.petGuid,
      prePetData = oldPetData,
      oldSkillInfo = oldSkillInfo
    })
  end)
end

function this:refreshGeneFullTips(isFull)
  self.bind.go_fullTips = isFull
end

function this:closeMaterialModule()
  local wasOpen = self.fruitShow
  self.bind.txt_materialToggleName = ""
  self.fruitShow = false
  self.bind.go_emptyNode = false
  if wasOpen then
    self:setNodesVisibleWhenOpenMaterial(true)
  end
end

function this:setNodesVisibleWhenOpenMaterial(visible)
  AzurWorld.IntegrateMgr.TopBarModule:SetTopBarReturnBtnVisible(visible)
  AzurWorld.IntegrateMgr.TopBarModule:SetTopBarMainBtnVisible(visible)
  self.parent:setTabListShow(visible)
  self.parent.bind.active_topBar = visible
end

return this

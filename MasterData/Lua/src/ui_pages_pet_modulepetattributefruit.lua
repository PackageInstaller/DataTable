local this = class("modulePetAttributeFruit", G_UIModuleBase)
local _petLearingEnumTpl = L_GameTpl:getPetLearingEnumTpl()
local _petFeedItemTpl = L_GameTpl:getPetFeedItemTpl()
local _petTalentUpgradeTpl = L_GameTpl:getPetTalentUpgradeTpl()
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _petDnaTpl = L_GameTpl:getDnaTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _wordsTpl = L_GameTpl:getWordsTpl()
local _petExpItemIdList = L_GameTpl:getGameConstTpl():getData("PET_EXPITEMID", L_Const.GameTplType.list_int) or {}
local _petPotentialItemIds = L_GameTpl:getGameConstTpl():getData("PET_POTENTIAL_ITEM_ID", L_Const.GameTplType.list_int) or {}
local _potentialFruitIntroGroupId = tonumber(L_GameTpl:getGameConstTpl():getData("KIBO_POTENTIAL_FRUIT_INTRO_ID", L_Const.GameTplType.int))
local _geneFruitIntroGroupId = tonumber(L_GameTpl:getGameConstTpl():getData("KIBO_DNA_FRUIT_INTRO_ID", L_Const.GameTplType.int))
local _petSameDnaNum = tonumber(L_GameTpl:getGameConstTpl():getData("PET_SAME_DNA_NUM", L_Const.GameTplType.int)) or 0
local _petDnaMaxNum = tonumber(L_GameTpl:getGameConstTpl():getData("PET_DNA_MAX_NUM", L_Const.GameTplType.int)) or 0
local colNum = 2
local geneFruitEffectType = 3
local geneFruitDnaTypeFilterType = 19
local geneFruitRarityFilterType = 35
local _randomKiboExpression = {
  5,
  8,
  9
}
local _petGeneFruitItemIds, _petGeneFruitItemIdMap

local function containsValue(list, value)
  for _, v in ipairs(list or {}) do
    if v == value then
      return true
    end
  end
  return false
end

local function getPetGeneFruitItemIds()
  if _petGeneFruitItemIds then
    return _petGeneFruitItemIds
  end
  _petGeneFruitItemIds = {}
  for itemId, tpl in pairs(_petFeedItemTpl:getAllTpl()) do
    if _petFeedItemTpl:getEffectType(tpl) == geneFruitEffectType then
      table.insert(_petGeneFruitItemIds, itemId)
    end
  end
  table.sort(_petGeneFruitItemIds)
  return _petGeneFruitItemIds
end

local function getPetGeneFruitItemIdByGeneId(geneId)
  if not _petGeneFruitItemIdMap then
    _petGeneFruitItemIdMap = {}
    for _, itemId in ipairs(getPetGeneFruitItemIds()) do
      local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
      local dnaParam = petFeedItemTpl and _petFeedItemTpl:getDnaParam(petFeedItemTpl)
      if not math.isEmpty(dnaParam) and not _petGeneFruitItemIdMap[dnaParam] then
        _petGeneFruitItemIdMap[dnaParam] = itemId
      end
    end
  end
  return _petGeneFruitItemIdMap[geneId]
end

function this.bind()
  return {
    txt_expTitle = "",
    list_cellPetExpFruitItem = {
      moduleName = "pages/pet/cellPetExpFruitItem"
    },
    go_attrFruit = true,
    txt_attributeTitle = "",
    list_cellPetAttributeFruitItem = {
      moduleName = "pages/pet/cellPetAttributeFruitItem"
    },
    go_geneFruit = true,
    txt_geneTitle = "",
    list_cellPetGeneFruitItem = {
      moduleName = "pages/pet/cellPetGeneFruitItem"
    },
    module_sortFilter = L_Const.ModuleInfo.SortFilterModule,
    txt_autoBtn = "",
    go_recommendList = false,
    list_recommendGeneFruitItem = {
      moduleName = "pages/pet/cellRecommendPetGeneFruitItem"
    }
  }
end

function this.methods()
  return {
    onClick_confirmUseFruit = function(self)
      self:onBtnTrain()
      C_AudioManager.Play("Play_SFX_System_UI_General_Halfscreen_Close")
    end,
    onClick_maxLevel = function(self)
      if self.isAutoBtnClearMode then
        self:setAutoBtnClearMode(false)
        self:clearSelectNum()
        return
      end
      if self:onBtnAutoSetUpLv() then
        self:setAutoBtnClearMode(self:shouldShowAutoBtnClearMode())
      end
    end,
    onClick_geneHelp = function(self)
      if math.isEmpty(_geneFruitIntroGroupId) then
        return
      end
      L_UI:open("pageCommonIntroduction", {groupId = _geneFruitIntroGroupId})
    end,
    onClick_geneRecommend = function(self)
      if self:hasNormalFilter() then
        self:clearSortFilterState()
        self:refreshPetGeneList()
        self:onPetGeneFruitSelectNumChange()
      end
      self.bind.go_recommendList = true
      self:refreshRecommendGeneFruitList()
      self:refreshRecommendListResourceVisible()
    end,
    onClick_clearRecommend = function(self)
      if not self:hasRecommendGeneFruitFilter() then
        return
      end
      self.selectedRecommendGeneFruitMap = {}
      self:refreshRecommendGeneFruitList()
      self:refreshPetGeneList()
    end,
    onClick_closeRecommend = function(self)
      if not self.bind.go_recommendList then
        return
      end
      self:closeRecommendList()
      self:refreshPetGeneList()
    end
  }
end

function this:open()
  self.bind.txt_expTitle = L_Lang:get(L_WordsTpl:getValue("ui_pet_exp_fruit_list_title"))
  self.bind.txt_attributeTitle = L_Lang:get(L_WordsTpl:getValue("ui_pet_potential_fruit_list_title"))
  self.bind.txt_geneTitle = L_Lang:get(L_WordsTpl:getValue("ui_pet_dna_fruit_list_title"))
  L_PetStore:listenCallFunc(L_PetStore.event.getNewPetSkill, self.onEvent_showPetSkillInfo, self)
  L_PetStore:listenCallFunc(L_PetStore.event.updatePetSkill, self.onEvent_showPetSkillInfo, self)
  L_PetStore:listenCallFunc(L_PetStore.event.convertPetSkill, self.onEvent_showPetSkillInfo, self)
  self:initSortFilterModule()
end

function this:onEvent_showPetSkillInfo(skillInfo, type)
end

function this:setInfos(params)
  self.parent = params.parent
  if self.petGuid ~= params.petGuid then
    self.selectedRecommendGeneFruitMap = {}
    self.bind.go_recommendList = false
    self.bind.list_recommendGeneFruitItem:clear()
    self:refreshRecommendListResourceVisible()
  end
  self.petGuid = params.petGuid
end

function this:refreshUI()
  self:setAutoBtnClearMode(false)
  self:refreshPetGeneFullTip()
  self:refreshPetExpList()
  self:refreshPetAttributeList()
  self:refreshPetGeneList()
  if self.bind.go_recommendList then
    self:refreshRecommendGeneFruitList()
  end
  self:refreshFilterActiveState()
end

function this:resetAttrFruitScrollPosition()
  local scroll = self.bindComponents.scrollView_attrFruit_scrollView
  if scroll then
    scroll.verticalNormalizedPosition = 1
  end
end

function this:setAutoBtnClearMode(isClearMode)
  self.isAutoBtnClearMode = isClearMode
  self.bind.txt_autoBtn = isClearMode and L_WordsTpl:getValue("ui_kibo_fruit_auto_clear") or L_WordsTpl:getValue("ui_kibo_fruit_auto_put")
end

function this:isAllExpItemSelected()
  local hasExpItem = false
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    local itemNum = C_BagMgr:getItemNumByItemId(module:getItemId())
    if 0 < itemNum then
      hasExpItem = true
    end
    if itemNum > module:getSelectNum() then
      return false
    end
  end
  return hasExpItem
end

function this:shouldShowAutoBtnClearMode()
  if self.lv >= self.maxLv then
    return true
  end
  return self:isAllExpItemSelected()
end

function this:isPetFruitLevelUnlocked()
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petFruitLevel)
end

function this:isPetFeedUnlocked()
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petFruitPotential)
end

function this:isPetGeneFruitUnlocked()
  return C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.petFruitGene)
end

function this:refreshPetExpList()
  if not self:isPetFruitLevelUnlocked() then
    self.bind.list_cellPetExpFruitItem:clear()
    return
  end
  local petExpFruitItemList = {}
  for _, id in ipairs(_petExpItemIdList) do
    local itemId = id
    local itemType = L_Const.CommonItemSubType.kPetExpBook
    local itemNum = C_BagMgr:getItemNumByItemId(itemId)
    local itemConfig = {
      itemId = itemId,
      itemType = itemType,
      itemNum = itemNum,
      onSelectChangeNumChangeCbk = function()
        self:onPetExpFruitSelectChange()
      end
    }
    table.insert(petExpFruitItemList, itemConfig)
  end
  self.maxLv = L_PetStore:getPetMaxLevel(true)
  local pet = L_PetStore:getPetItem(self.petGuid)
  self.lv = pet.lv
  self.configId = pet:petCfgId()
  self.bind.list_cellPetExpFruitItem:clear()
  self.bind.list_cellPetExpFruitItem:insert_array(petExpFruitItemList)
end

function this:onPetExpFruitSelectChange()
  local selectInfo = self:getSelectedExpInfo()
  local preUseFruitInfoList = self:getPreUseFruitInfoList()
  self.parent:onPetExpItemSelectNumChange(selectInfo, preUseFruitInfoList)
  self:onEvent_petExpChange()
  self:refreshExpFruitMaskState()
end

function this:hasAnyExpFruitSelected()
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    if module:getSelectNum() > 0 then
      return true
    end
  end
  return false
end

function this:refreshExpFruitMaskState()
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    module:refreshMaskState()
  end
end

function this:getSelectedExpInfo()
  local tempExp = {}
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    if module:getSelectNum() > 0 then
      local data = {}
      data = {
        item_id = module:getItemId(),
        item_num = module:getSelectNum()
      }
      table.insert(tempExp, data)
    end
  end
  return tempExp
end

function this:getSelectAddExp()
  local tempExpAll = 0
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    local exp = _commonItemTpl:getUseFunction(_commonItemTpl:getTplById(module:getItemId()))[1]
    tempExpAll = tempExpAll + module:getSelectNum() * exp
  end
  return tempExpAll
end

function this:onEvent_petExpChange()
  local pet = L_PetStore:getPetItem(self.petGuid)
  local tempExpAll = self:getSelectAddExp()
  local tempExp = tempExpAll + pet.exp
  local tempLv = pet.lv
  for i = tempLv, self.maxLv - 1 do
    if tempExp - _petLevelTpl:getExp(_petLevelTpl:getTplById(i)) < 0 then
      break
    end
    tempLv = i + 1
    tempExp = tempExp - _petLevelTpl:getExp(_petLevelTpl:getTplById(i))
  end
  self.lv = tempLv
end

function this:checkCanAddExpItem(isShowInfo)
  if not self.petGuid then
    return false
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem.lv >= L_PetStore:getPetMaxLevel() then
    if isShowInfo then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_pet_maxleveltips"))
    end
    return false
  end
  if petItem.lv >= L_PetStore:getPetMaxLevel(true) then
    if isShowInfo then
      local tpl = _petLevelTpl:getTplById(petItem.lv + 1)
      local condition = _petLevelTpl:getCondition(tpl)
      local bCompelte = true
      if not table.isEmpty(condition) then
        bCompelte = L_ConditionManager:singleIsComplete(condition)
      end
      if not bCompelte then
        L_FlyMsgManager:showNormalMsg(L_ConditionManager:getSingleDesc(condition))
      end
    end
    return false
  end
  if self.lv >= L_PetStore:getPetMaxLevel(true) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_exp_fruit_limit"))
    return false
  end
  return self.lv < self.maxLv
end

function this:getPetExpAll(targetLv)
  local maxLv = self.maxLv
  if not math.isEmpty(targetLv) then
    maxLv = targetLv
  end
  local pet = L_PetStore:getPetItem(self.petGuid)
  local petExpAll = 0 - pet.exp
  for i = pet.lv, maxLv - 1 do
    petExpAll = petExpAll + _petLevelTpl:getExp(_petLevelTpl:getTplById(i))
  end
  return petExpAll
end

function this:onBtnAutoSetUpLv()
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem.lv >= L_PetStore:getPetMaxLevel() then
    L_PetManager:petHintInfo(5)
    return false
  end
  if petItem.lv >= L_PetStore:getPetMaxLevel(true) then
    local tpl = _petLevelTpl:getTplById(petItem.lv + 1)
    local condition = _petLevelTpl:getCondition(tpl)
    local bCompelte = true
    if not table.isEmpty(condition) then
      bCompelte = L_ConditionManager:singleIsComplete(condition)
    end
    if not bCompelte then
      L_FlyMsgManager:showNormalMsg(L_ConditionManager:getSingleDesc(condition))
    end
    return false
  end
  if self.lv >= L_PetStore:getPetMaxLevel(true) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_exp_fruit_limit"))
    return false
  end
  local tempExpAll = 0
  local data = {}
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    local itemId = module:getItemId()
    local exp = _commonItemTpl:getUseFunction(_commonItemTpl:getTplById(itemId))[1]
    tempExpAll = tempExpAll + C_BagMgr:getItemNumByItemId(itemId) * exp
    data[exp] = C_BagMgr:getItemNumByItemId(itemId)
  end
  if tempExpAll == 0 then
    L_PetManager:petHintInfo(3)
    return false
  end
  local petExpAll = self:getPetExpAll()
  local exp = 0
  if tempExpAll >= petExpAll then
    exp = petExpAll
  else
    exp = tempExpAll
  end
  for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
    module:setSelectNum(0)
    module:setSelectState(false)
  end
  for k, v in pairs(L_PetManager:autoLvUp(data, exp)) do
    for _, module in ipairs(self.modules.list_cellPetExpFruitItem) do
      local itemId = module:getItemId()
      local exp = _commonItemTpl:getUseFunction(_commonItemTpl:getTplById(itemId))[1]
      if exp == k and v ~= 0 then
        module:setSelectNum(v)
        module:setSelectState(true)
      end
    end
  end
  self:onPetExpFruitSelectChange()
  return true
end

function this:hasPetAttributeFruitInBag()
  for _, itemId in ipairs(_petPotentialItemIds) do
    if C_BagMgr:getItemNumByItemId(itemId) > 0 then
      return true
    end
  end
  return false
end

function this:hasPetGeneFruitInBag()
  for _, itemId in ipairs(getPetGeneFruitItemIds()) do
    if C_BagMgr:getItemNumByItemId(itemId) > 0 then
      return true
    end
  end
  return false
end

function this:refreshPetAttributeList()
  if not self:isPetFeedUnlocked() then
    self.bind.list_cellPetAttributeFruitItem:clear()
    self.bind.go_attrFruit = false
    return
  end
  self.bind.go_attrFruit = self:hasPetAttributeFruitInBag()
  local petAttributeFruitItemList = {}
  for _, itemId in ipairs(_petPotentialItemIds) do
    local itemType = L_Const.CommonItemSubType.kPetTalentFeed
    local itemNum = C_BagMgr:getItemNumByItemId(itemId)
    if 0 < itemNum then
      local itemConfig = {
        itemId = itemId,
        itemType = itemType,
        itemNum = itemNum,
        onSelectChangeNumChangeCbk = function()
          self:onPetAttrFruitSelectNumChange()
        end
      }
      table.insert(petAttributeFruitItemList, itemConfig)
    end
  end
  if #petAttributeFruitItemList == 0 then
    self.bind.list_cellPetAttributeFruitItem:clear()
    return
  end
  if #petAttributeFruitItemList % colNum ~= 0 then
    local num = colNum - #petAttributeFruitItemList % colNum
    for i = 1, num do
      table.insert(petAttributeFruitItemList, {})
    end
  end
  self.bind.list_cellPetAttributeFruitItem:clear()
  self.bind.list_cellPetAttributeFruitItem:insert_array(petAttributeFruitItemList)
end

function this:getPetGeneCountMap()
  local geneCountMap = {}
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local geneInfos = petItem and petItem.gene_infos or {}
  for _, geneInfo in pairs(geneInfos) do
    local geneId = geneInfo.gene_id or geneInfo.geneId
    if not math.isEmpty(geneId) then
      geneCountMap[geneId] = (geneCountMap[geneId] or 0) + 1
    end
  end
  return geneCountMap
end

function this:getRecommendGeneMap()
  local recommendGeneMap = {}
  for _, geneId in ipairs(self:getRecommendGeneList()) do
    recommendGeneMap[geneId] = true
  end
  return recommendGeneMap
end

function this:getRecommendGeneList()
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local petConfigId = petItem and petItem:petCfgId()
  local petTpl = petConfigId and _petTpl:getTplById(petConfigId)
  return petTpl and _petTpl:getDnaRecommend(petTpl) or {}
end

function this:hasRecommendGeneFruitFilter()
  return self.selectedRecommendGeneFruitMap and not table.isEmpty(self.selectedRecommendGeneFruitMap)
end

function this:onRecommendGeneFruitSelectChange(selectCell)
  if not selectCell or not selectCell:getItemId() then
    return
  end
  self.selectedRecommendGeneFruitMap = self.selectedRecommendGeneFruitMap or {}
  local itemId = selectCell:getItemId()
  if selectCell:getSelectNum() > 0 then
    self.selectedRecommendGeneFruitMap[itemId] = true
  else
    self.selectedRecommendGeneFruitMap[itemId] = nil
  end
  self:refreshFilterActiveState()
  self:refreshPetGeneList()
  self:onPetGeneFruitSelectNumChange()
end

function this:refreshRecommendGeneFruitList()
  local recommendGeneFruitItemList = {}
  local geneCountMap = self:getPetGeneCountMap()
  self.selectedRecommendGeneFruitMap = self.selectedRecommendGeneFruitMap or {}
  for _, geneId in ipairs(self:getRecommendGeneList()) do
    local itemId = getPetGeneFruitItemIdByGeneId(geneId)
    if itemId then
      table.insert(recommendGeneFruitItemList, {
        itemId = itemId,
        itemType = L_Const.CommonItemSubType.kPetTalentFeed,
        itemNum = C_BagMgr:getItemNumByItemId(itemId),
        geneId = geneId,
        alreadyHave = 0 < (geneCountMap[geneId] or 0),
        isSelected = self.selectedRecommendGeneFruitMap[itemId] == true,
        onSelectChangeNumChangeCbk = function(cell)
          self:onRecommendGeneFruitSelectChange(cell)
        end
      })
    end
  end
  self.bind.list_recommendGeneFruitItem:clear()
  self.bind.list_recommendGeneFruitItem:insert_array(recommendGeneFruitItemList)
end

function this:refreshRecommendListResourceVisible()
  C_IntegrateMgr.TopBarModule:SetResourceVisible(not self.bind.go_recommendList)
end

function this:closeRecommendList()
  local isRecommendListOpen = self.bind.go_recommendList == true
  self.bind.go_recommendList = false
  self.bind.list_recommendGeneFruitItem:clear()
  self:refreshRecommendListResourceVisible()
  return isRecommendListOpen
end

function this:clearRecommendState()
  local hadRecommendState = self.bind.go_recommendList or self:hasRecommendGeneFruitFilter()
  if not hadRecommendState then
    return false
  end
  self.selectedRecommendGeneFruitMap = {}
  self:closeRecommendList()
  return true
end

function this:hasNormalFilter()
  local filterKeyDic = self._sortFilter and self._sortFilter.filterKeyDic or {}
  if table.isEmpty(filterKeyDic) or filterKeyDic[L_SortFilterConst.FilterType.All] then
    return false
  end
  for typeId, idList in pairs(filterKeyDic) do
    if typeId ~= L_SortFilterConst.FilterType.All and not table.isEmpty(idList) then
      return true
    end
  end
  return false
end

function this:refreshFilterActiveState()
  local moduleSortFilter = self.modules and self.modules.module_sortFilter
  if not moduleSortFilter then
    return
  end
  local isActive = self:hasNormalFilter()
  if moduleSortFilter.bindComponents and moduleSortFilter.bindComponents.ani_btn_filter then
    moduleSortFilter.bindComponents.ani_btn_filter:SetBool("On", isActive)
  end
  moduleSortFilter.bind.go_icon_on = isActive
end

function this:getGeneFruitSortInfo(itemId, itemNum, geneCountMap, recommendGeneMap)
  local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
  local geneId = _petFeedItemTpl:getDnaParam(petFeedItemTpl)
  local geneTpl = _petDnaTpl:getTplById(geneId)
  local rarity = geneTpl and _petDnaTpl:getRarity(geneTpl) or 0
  local isRecommend = recommendGeneMap[geneId] == true
  local cannotFeed = 0 < _petSameDnaNum and (geneCountMap[geneId] or 0) >= _petSameDnaNum
  return {
    geneId = geneId,
    rarity = rarity,
    isRecommend = isRecommend,
    cannotFeed = cannotFeed,
    itemNum = itemNum
  }
end

function this:isGeneFruitFilterMatched(itemId)
  if self:hasRecommendGeneFruitFilter() and not self.selectedRecommendGeneFruitMap[itemId] then
    return false
  end
  local filterKeyDic = self._sortFilter and self._sortFilter.filterKeyDic or {}
  if table.isEmpty(filterKeyDic) or filterKeyDic[L_SortFilterConst.FilterType.All] then
    return true
  end
  local geneTypeFilter = filterKeyDic[geneFruitDnaTypeFilterType]
  if not table.isEmpty(geneTypeFilter) then
    local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
    local geneId = petFeedItemTpl and _petFeedItemTpl:getDnaParam(petFeedItemTpl)
    local geneTpl = geneId and _petDnaTpl:getTplById(geneId)
    local geneType = geneTpl and _petDnaTpl:getType(geneTpl)
    if not containsValue(geneTypeFilter, geneType) then
      return false
    end
  end
  local rarityFilter = filterKeyDic[geneFruitRarityFilterType]
  if not table.isEmpty(rarityFilter) then
    local commonItemTpl = _commonItemTpl:getTplById(itemId)
    local rarity = commonItemTpl and _commonItemTpl:getRarity(commonItemTpl)
    if not containsValue(rarityFilter, rarity) then
      return false
    end
  end
  return true
end

function this:sortGeneFruitItemList(itemList)
  table.sort(itemList, function(a, b)
    if a.cannotFeed ~= b.cannotFeed then
      return not a.cannotFeed
    end
    if a.rarity ~= b.rarity then
      return a.rarity > b.rarity
    end
    if a.isRecommend ~= b.isRecommend then
      return a.isRecommend
    end
    if a.itemNum ~= b.itemNum then
      return a.itemNum > b.itemNum
    end
    return a.itemId < b.itemId
  end)
end

function this:refreshPetGeneList()
  self:refreshPetGeneFullTip()
  if not self:isPetGeneFruitUnlocked() then
    self.bind.list_cellPetGeneFruitItem:clear()
    self.bind.go_geneFruit = false
    return
  end
  self.bind.go_geneFruit = self:hasPetGeneFruitInBag()
  local petGeneFruitItemList = {}
  local geneCountMap = self:getPetGeneCountMap()
  local recommendGeneMap = self:getRecommendGeneMap()
  for _, itemId in ipairs(getPetGeneFruitItemIds()) do
    local itemType = L_Const.CommonItemSubType.kPetTalentFeed
    local itemNum = C_BagMgr:getItemNumByItemId(itemId)
    if 0 < itemNum and self:isGeneFruitFilterMatched(itemId) then
      local sortInfo = self:getGeneFruitSortInfo(itemId, itemNum, geneCountMap, recommendGeneMap)
      local itemConfig = {
        itemId = itemId,
        itemType = itemType,
        itemNum = itemNum,
        cannotFeed = sortInfo.cannotFeed,
        rarity = sortInfo.rarity,
        isRecommend = sortInfo.isRecommend,
        onSelectChangeNumChangeCbk = function(cell)
          self:onPetGeneFruitSelectNumChange(cell)
        end
      }
      table.insert(petGeneFruitItemList, itemConfig)
    end
  end
  if #petGeneFruitItemList == 0 then
    if not self.bind.go_geneFruit then
      self.bind.list_cellPetGeneFruitItem:clear()
      return
    end
    for i = 1, colNum do
      table.insert(petGeneFruitItemList, {})
    end
  else
    self:sortGeneFruitItemList(petGeneFruitItemList)
    if #petGeneFruitItemList % colNum ~= 0 then
      local num = colNum - #petGeneFruitItemList % colNum
      for i = 1, num do
        table.insert(petGeneFruitItemList, {})
      end
    end
  end
  self.bind.list_cellPetGeneFruitItem:clear()
  self.bind.list_cellPetGeneFruitItem:insert_array(petGeneFruitItemList)
end

function this:onPetAttrFruitSelectNumChange()
  local preUseFruitInfoList = self:getPreUseFruitInfoList()
  self.parent:onPetAttrFruitSelectNumChange(preUseFruitInfoList)
  self:refreshAttrFruitMaskState()
end

function this:refreshAttrFruitMaskState()
  for i = 1, #self.bind.list_cellPetAttributeFruitItem do
    local cellPetAttributeFruitItem = self.bind.list_cellPetAttributeFruitItem:getItemCls(i)
    if cellPetAttributeFruitItem:getItemId() then
      cellPetAttributeFruitItem:refreshMaskState()
    end
  end
end

function this:onPetGeneFruitSelectNumChange(selectCell)
  if self:isPetGeneFull() then
    if selectCell and selectCell:getSelectNum() > 0 then
      local hasChangedSelect = self:resetOtherGeneFruitSelect(selectCell)
      if hasChangedSelect then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_dna_fruit_change"))
      end
    end
    self:clearPetGeneFruitPreview()
    return
  end
  local selectedGeneFruitInfoList = self:getSelectedGeneFruitInfoList()
  if self.parent and self.parent.onPetGeneFruitSelectNumChange then
    self.parent:onPetGeneFruitSelectNumChange(selectedGeneFruitInfoList)
  end
end

function this:clearPetGeneFruitPreview()
  if self.parent and self.parent.clearPetGeneFruitPreview then
    self.parent:clearPetGeneFruitPreview()
  end
end

function this:resetOtherGeneFruitSelect(selectCell)
  local hasChangedSelect = false
  for i = 1, #self.bind.list_cellPetGeneFruitItem do
    local cellPetGeneFruitItem = self.bind.list_cellPetGeneFruitItem:getItemCls(i)
    if cellPetGeneFruitItem ~= selectCell and cellPetGeneFruitItem:getSelectNum() > 0 then
      cellPetGeneFruitItem:resetSelectNum()
      hasChangedSelect = true
    end
  end
  return hasChangedSelect
end

function this:getPetGeneNum()
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local geneInfos = petItem and petItem.gene_infos or {}
  local count = 0
  for _, _ in pairs(geneInfos) do
    count = count + 1
  end
  return count
end

function this:isPetGeneFull()
  if _petDnaMaxNum <= 0 then
    return false
  end
  return self:getPetGeneNum() >= _petDnaMaxNum
end

function this:refreshPetGeneFullTip()
  if self.parent and self.parent.refreshGeneFullTips then
    self.parent:refreshGeneFullTips(self:isPetGeneFull())
  end
end

function this:checkIfCanSelectGeneFruitItem()
  if _petDnaMaxNum <= 0 then
    return true
  end
  if self:isPetGeneFull() then
    return true
  end
  local selectedNum = #self:getSelectedGeneFruitInfoList()
  if self:getPetGeneNum() + selectedNum >= _petDnaMaxNum then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_dna_fruit_add_max"))
    return false
  end
  return true
end

function this:autoSelectGeneFruit()
  for i = 1, #self.bind.list_cellPetGeneFruitItem do
    local cellPetGeneFruitItem = self.bind.list_cellPetGeneFruitItem:getItemCls(i)
    if cellPetGeneFruitItem:getItemId() and cellPetGeneFruitItem:getItemNum() > 0 and not cellPetGeneFruitItem:getCannotFeed() then
      cellPetGeneFruitItem:setSelectNum(1)
      cellPetGeneFruitItem:setSelectState(true)
      self:onPetGeneFruitSelectNumChange(cellPetGeneFruitItem)
      return true
    end
  end
  return false
end

function this:clearSelectNum()
  self:setAutoBtnClearMode(false)
  for i = 1, #self.bind.list_cellPetExpFruitItem do
    local cellPetExpFruitItem = self.bind.list_cellPetExpFruitItem:getItemCls(i)
    cellPetExpFruitItem:resetSelectNum()
    cellPetExpFruitItem:setSelectState(false)
  end
  self:onPetExpFruitSelectChange()
end

function this:clearSortFilterState()
  if self._sortFilter and self.modules.module_sortFilter then
    self._sortFilter:resetSortFiter(self.modules.module_sortFilter)
  end
  self:refreshFilterActiveState()
end

function this:resetFilterState()
  self:clearRecommendState()
  self:clearSortFilterState()
end

function this:resetSelectNum()
  for i = 1, #self.bind.list_cellPetAttributeFruitItem do
    local cellPetAttributeFruitItem = self.bind.list_cellPetAttributeFruitItem:getItemCls(i)
    cellPetAttributeFruitItem:resetSelectNum()
    cellPetAttributeFruitItem:setSelectState(false)
  end
  self:onPetAttrFruitSelectNumChange()
  for i = 1, #self.bind.list_cellPetGeneFruitItem do
    local cellPetGeneFruitItem = self.bind.list_cellPetGeneFruitItem:getItemCls(i)
    cellPetGeneFruitItem:resetSelectNum()
  end
  self:onPetGeneFruitSelectNumChange()
  self:clearSelectNum()
  self.parent:refreshUI()
end

function this:checkIfCanAddSelectNumOfTargetFruitItem(itemId)
  local ifCanAdd = false
  local addResultComprehensionExpList = self:getAddResultComprehensionExpList()
  local allComprehensionMaxNeedExpList = _petTalentUpgradeTpl:getAllComprehensionMaxNeedExpList()
  local targetFruitItemAddComprehensionAttrEnumNumList = self:getTargetFruitItemAddComprehensionAttrEnumNumList(itemId)
  if 0 < #addResultComprehensionExpList then
    for _, attrEnumNum in pairs(targetFruitItemAddComprehensionAttrEnumNumList) do
      local addResultComprehensionExp = addResultComprehensionExpList[attrEnumNum]
      local oneComprehensionMaxNeedExp = allComprehensionMaxNeedExpList[attrEnumNum]
      if addResultComprehensionExp < oneComprehensionMaxNeedExp then
        ifCanAdd = true
      end
    end
  end
  return ifCanAdd
end

function this:getAddResultComprehensionExpList()
  local preUseFruitInfoList = self:getPreUseFruitInfoList()
  local addComprehensionExpList = self:getAddComprehensionExpListByPreUseFruitInfoList(preUseFruitInfoList)
  local petCurComprehensionExpList = self:getPetCurComprehensionExpList()
  local addResultComprehensionExpList = {}
  if 0 < #petCurComprehensionExpList then
    for attrEnumNum, _ in pairs(addComprehensionExpList) do
      local curComprehensionExp = petCurComprehensionExpList[attrEnumNum]
      local addComprehensionExp = addComprehensionExpList[attrEnumNum]
      local resultComprehensionExp = curComprehensionExp + addComprehensionExp
      addResultComprehensionExpList[attrEnumNum] = resultComprehensionExp
    end
  end
  return addResultComprehensionExpList
end

function this:getPreUseFruitInfoList()
  local preUseFruitInfoList = {}
  for i = 1, #self.bind.list_cellPetAttributeFruitItem do
    local cellPetAttributeFruitItem = self.bind.list_cellPetAttributeFruitItem:getItemCls(i)
    if cellPetAttributeFruitItem:getItemId() then
      local itemNum = cellPetAttributeFruitItem:getSelectNum()
      if 0 < itemNum then
        local itemId = cellPetAttributeFruitItem:getItemId()
        table.insert(preUseFruitInfoList, {itemId = itemId, itemNum = itemNum})
      end
    end
  end
  return preUseFruitInfoList
end

function this:getSelectedGeneFruitInfoList()
  local selectedGeneFruitInfoList = {}
  for i = 1, #self.bind.list_cellPetGeneFruitItem do
    local cellPetGeneFruitItem = self.bind.list_cellPetGeneFruitItem:getItemCls(i)
    if cellPetGeneFruitItem:getSelectNum() > 0 then
      table.insert(selectedGeneFruitInfoList, {
        itemId = cellPetGeneFruitItem:getItemId()
      })
    end
  end
  return selectedGeneFruitInfoList
end

function this:getAddComprehensionExpListByPreUseFruitInfoList(preUseFruitInfoList)
  local addComprehensionExpList = {}
  local petLearingEnumTplData = _petLearingEnumTpl:getAllEnum(true)
  for _, petLearingEnumTpl in pairs(petLearingEnumTplData) do
    local attrEnumNum = _petLearingEnumTpl:getEnumNum(petLearingEnumTpl)
    addComprehensionExpList[attrEnumNum] = 0
  end
  for _, preUseFruitInfo in pairs(preUseFruitInfoList) do
    local itemId = preUseFruitInfo.itemId
    local itemNum = preUseFruitInfo.itemNum
    local petFeedItemTpl = _petFeedItemTpl:getTplById(itemId)
    local effectParamList = _petFeedItemTpl:getEffectParamList(petFeedItemTpl)
    for _, effectParam in pairs(effectParamList) do
      local attrEnumNum = effectParam[1]
      local expAddNum = effectParam[2] * itemNum
      addComprehensionExpList[attrEnumNum] = addComprehensionExpList[attrEnumNum] + expAddNum
    end
  end
  return addComprehensionExpList
end

function this:getPetCurComprehensionExpList()
  local petCurComprehensionExpList = {}
  local petItem = L_PetStore:getPetItem(self.petGuid)
  if petItem then
    local petLearingEnumTplData = _petLearingEnumTpl:getAllEnum(true)
    for _, petLearingEnumTpl in pairs(petLearingEnumTplData) do
      local attrEnumNum = _petLearingEnumTpl:getEnumNum(petLearingEnumTpl)
      local attrComprehension = petItem:getTargetAttributeComprehension(attrEnumNum)
      local attrComprehensionCurExp = attrComprehension.cur_exp + _petTalentUpgradeTpl:getNeedExpOfTargetComprehensionTargetLevel(attrEnumNum, attrComprehension.level)
      petCurComprehensionExpList[attrEnumNum] = attrComprehensionCurExp
    end
  end
  return petCurComprehensionExpList
end

function this:getTargetFruitItemAddComprehensionAttrEnumNumList(itemId)
  return _petFeedItemTpl:getTargetFruitItemAddComprehensionAttrEnumNumList(itemId)
end

function this:onBtnTrain()
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PetUpgrade))
    return
  end
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local curProperty = L_PetStore:getPetProperty(petItem)
  local selectedInfo = self:getSelectedExpInfo()
  local preUseFruitInfoList = self:getPreUseFruitInfoList()
  local selectedGeneFruitInfoList = self:getSelectedGeneFruitInfoList()
  if not selectedInfo[1] and table.isEmpty(preUseFruitInfoList) and table.isEmpty(selectedGeneFruitInfoList) then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getTplById("notice_need_select_kibo_fruit"))
    return
  end
  local bLevelUp = self.lv > petItem.lv
  local addExp = 0
  for _, v in ipairs(selectedInfo) do
    local exp = _commonItemTpl:getUseFunction(_commonItemTpl:getTplById(v.item_id))[1]
    addExp = addExp + v.item_num * exp
  end
  local params = {
    isPetLevelUp = bLevelUp,
    addExp = addExp,
    oldGrade = L_PetStore:getPetGradeNew(self.petGuid) or 0
  }
  self:petShowExpression()
  self:reqEatAttributeFruit(preUseFruitInfoList, curProperty, params)
  self:reqLevelUp(selectedInfo, curProperty, params)
  self:reqUseGeneFruit(selectedGeneFruitInfoList)
end

function this:reqEatAttributeFruit(preUseFruitInfoList, curProperty, params)
  self.parent.isSelectAttribute = false
  if table.isEmpty(preUseFruitInfoList) or self.parent.isAttrUpgrading then
    return
  end
  self.parent.isSelectAttribute = true
  self.parent:setIsAttrUpgrading(true)
  L_PetStore:req_CSProtoPetEatAttrFruit(preUseFruitInfoList, self.petGuid, function()
    self:onFeedPet(curProperty, params)
  end)
end

function this:checkShowLevelUpPage(oldProperty)
  local petItem = L_PetStore:getPetItem(self.petGuid)
  local newPetProperty = L_PetStore:getPetProperty(petItem)
  local all_Attribute = _petLearingEnumTpl:getAllEnum(true)
  local tmp = {}
  for i, v in pairs(all_Attribute) do
    local tpl = _petLearingEnumTpl:getTplById(i)
    local enumId = _petLearingEnumTpl:getEnumNum(tpl)
    local curValue = newPetProperty[enumId] or 0
    local oldValue = oldProperty[enumId] or 0
    if curValue ~= oldValue then
      table.insert(tmp, {
        oldValue = oldValue,
        newValue = curValue,
        enumId = enumId
      })
    end
  end
  return tmp
end

function this:reqLevelUp(selectedInfo, curProperty, params)
  if not selectedInfo[1] or self.parent.isLvUpgrading then
    return
  end
  self.parent:setIsLvUpgrading(true)
  L_PetStore:req_changeLvUpPet(self.petGuid, selectedInfo, function()
    if not self.parent.isAttrUpgrading then
      self:onFeedPet(curProperty, params)
    end
  end)
end

function this:openPetGeneChangePage(isChangeMode, geneFruitInfoList, confirmCallback)
  local function closeCallback()
    self:clearPetGeneFruitPreview()
  end
  
  if isChangeMode then
    L_UI:open("pagePetGeneChange", {
      petGuid = self.petGuid,
      geneFruitInfoList = geneFruitInfoList,
      confirmCallback = confirmCallback,
      closeCallback = closeCallback
    })
    return
  end
  L_UI:open("pagePetGeneMutation", {
    petId = self.petGuid,
    geneFruitInfoList = geneFruitInfoList,
    closeCallback = closeCallback,
    showAdd = true
  })
end

function this:reqUseSingleGeneFruit(selectedGeneFruitInfo, slotPos, callback)
  local data = {
    pet_id = self.petGuid,
    item_id = selectedGeneFruitInfo.itemId,
    slot_pos = slotPos or 0
  }
  L_Net:sendMessage(MsgGenCode.CSProtoUseGeneFruitReq, data, function(rspData, errorCode)
    if callback then
      callback(errorCode == L_Const.errorCode.ErrCodeSucc, rspData, errorCode)
    end
  end)
end

function this:finishUseGeneFruit()
  self.isGeneFruitUsing = false
  self:clearPetGeneFruitPreview()
  self:refreshPetGeneList()
  self:onPetGeneFruitSelectNumChange()
  if self.parent and self.parent.setLockGeneSkillsRefresh then
    self.parent:setLockGeneSkillsRefresh(false)
  end
end

function this:reqUseGeneFruit(selectedGeneFruitInfoList)
  if table.isEmpty(selectedGeneFruitInfoList) or self.isGeneFruitUsing then
    return
  end
  self:clearPetGeneFruitPreview()
  local isChangeMode = self:isPetGeneFull()
  if isChangeMode then
    local selectedGeneFruitInfo = selectedGeneFruitInfoList[1]
    local geneFruitInfoList = {
      {
        itemId = selectedGeneFruitInfo.itemId
      }
    }
    self:openPetGeneChangePage(true, geneFruitInfoList, function(selectedChangeModeGene, changeGeneData, callback)
      if self.isGeneFruitUsing then
        if callback then
          callback(false)
        end
        return
      end
      local slotPos = selectedChangeModeGene.genePos or selectedChangeModeGene.pos or selectedChangeModeGene.index
      if math.isEmpty(slotPos) then
        if callback then
          callback(false)
        end
        return
      end
      self.isGeneFruitUsing = true
      if self.parent and self.parent.setLockGeneSkillsRefresh then
        self.parent:setLockGeneSkillsRefresh(true)
      end
      self:reqUseSingleGeneFruit(selectedGeneFruitInfo, slotPos, function(isSuccess)
        self:finishUseGeneFruit()
        if callback then
          callback(isSuccess)
        end
      end)
    end)
    return
  end
  self.isGeneFruitUsing = true
  if self.parent and self.parent.setLockGeneSkillsRefresh then
    self.parent:setLockGeneSkillsRefresh(true)
  end
  local usedGeneFruitInfoList = {}
  local index = 1
  
  local function reqNext()
    local selectedGeneFruitInfo = selectedGeneFruitInfoList[index]
    if selectedGeneFruitInfo == nil then
      self:finishUseGeneFruit()
      self:openPetGeneChangePage(false, usedGeneFruitInfoList)
      return
    end
    self:reqUseSingleGeneFruit(selectedGeneFruitInfo, 0, function(isSuccess)
      if not isSuccess then
        self:finishUseGeneFruit()
        return
      end
      table.insert(usedGeneFruitInfoList, {
        itemId = selectedGeneFruitInfo.itemId
      })
      index = index + 1
      reqNext()
    end)
  end
  
  reqNext()
end

function this:playPetFeedItemEffect(effectParams)
  local isPetLevelUp = effectParams.isPetLevelUp
  local attrIdList = effectParams.attrIdList or {}
  if table.isEmpty(attrIdList) and isPetLevelUp == false then
    return
  end
  self.parent:playPetFeedItemEffect(effectParams)
end

function this:onFeedPet(curProperty, params)
  local data = self:checkShowLevelUpPage(curProperty)
  params.isPetAttrUp = 0 < #data
  params.attrIdList = {}
  for _, singleData in pairs(data) do
    local attrId = singleData.enumId
    table.insert(params.attrIdList, attrId)
  end
  local newGrade = L_PetStore:getPetGradeNew(self.petGuid) or 0
  params.isRatingUp = newGrade > (params.oldGrade or 0)
  self.parent:onFeedPet(params)
end

function this:petShowExpression()
  L_TimerManager:stopTimer(self, "expressionTimer")
  local randomIndex = math.random(1, #_randomKiboExpression)
  local randomExpression = _randomKiboExpression[randomIndex]
  L_PetManager:playExpression(randomExpression)
  L_TimerManager:newOrResetTimer(self, "expressionTimer", function()
    L_PetManager:playExpression()
  end, 2.0)
end

function this:initSortFilterModule()
  local function callback()
    self:refreshPetGeneList()
    
    self:onPetGeneFruitSelectNumChange()
    self:refreshFilterActiveState()
    FrameScheduler.add(function()
      self:refreshFilterActiveState()
    end, 1, self)
  end
  
  self._sortFilter = self._sortFilter or L_SortFilterManager:createSortFilter(L_SystemConst.enum.petFruitGene, callback, callback)
  self._sortFilter:bindModule(self.modules.module_sortFilter)
  local moduleSortFilter = self.modules.module_sortFilter
  if not moduleSortFilter._petGeneFruitOpenMultiplyPage then
    moduleSortFilter._petGeneFruitOpenMultiplyPage = moduleSortFilter.openMultiplyPage
    
    function moduleSortFilter.openMultiplyPage(mod, sortFilterStyle)
      if self:clearRecommendState() then
        self:refreshPetGeneList()
        self:onPetGeneFruitSelectNumChange()
      end
      mod._petGeneFruitOpenMultiplyPage(mod, sortFilterStyle)
    end
  end
end

function this:hide()
  C_IntegrateMgr.TopBarModule:SetResourceVisible(true)
  self:resetAttrFruitScrollPosition()
end

function this:close()
  C_IntegrateMgr.TopBarModule:SetResourceVisible(true)
  L_PetManager:playExpression()
  L_TimerManager:clearTimer(self)
  L_PetStore:unListenCallFunc(L_PetStore.event.getNewPetSkill, self.onEvent_showPetSkillInfo)
  L_PetStore:unListenCallFunc(L_PetStore.event.updatePetSkill, self.onEvent_showPetSkillInfo)
  L_PetStore:unListenCallFunc(L_PetStore.event.convertPetSkill, self.onEvent_showPetSkillInfo)
end

return this

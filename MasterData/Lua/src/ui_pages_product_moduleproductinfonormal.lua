local this = class("moduleProductInfoNormal", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _petEggTpl = L_GameTpl:getPetEggTpl()
local _accessoryCustomedTpl = L_GameTpl:getAccessoryCustomedTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()

function this.bind()
  return {
    module_productFormulaNormalNew = {
      moduleName = "pages/product/moduleProductFormulaNormalNew"
    },
    txt_time = "",
    preview_txt_time = "",
    txt_time_accessory = "",
    preview_txt_time_accessory = "",
    txt_time_egg = "",
    preview_txt_time_egg = "",
    active_moduleProductInfoDesc_normal = true,
    moduleProductInfoDesc_normal = {
      moduleName = "pages/product/moduleProductInfoDesc_normal"
    },
    active_moduleProductInfoDesc_accessory = true,
    moduleProductInfoDesc_accessory = {
      moduleName = "pages/product/moduleProductInfoDesc_accessory"
    },
    active_moduleProductInfoDesc_egg = true,
    moduleProductInfoDesc_egg = {
      moduleName = "pages/product/moduleProductInfoDesc_egg"
    },
    active_isEmpty = false,
    active_startBtn_accessory = true,
    active_startBtn_normal = true,
    acitve_startBtn_egg = true,
    acitve_startBtn_goto = true,
    active_wish = true,
    go_blockClick = false,
    lst_combineLink = nil,
    active_focusRect = false
  }
end

function this.methods()
  return {
    onClick_normal = function(self)
      self:onClickStart()
    end,
    onClick_goto = function(self)
      self:tryGotoTechnology()
    end,
    onClick_accessory = function(self)
      self:onClickStart()
    end,
    onClick_hatch = function(self)
      self:onClickStart()
    end,
    onClick_wishadd = function(self)
      self:onClickAddWish()
    end,
    onClick_wishlist = function(self)
      L_UI:open("pageWishlist")
    end,
    moduleProductInfoDesc_normal = {
      onShowFoodItemDesc = function(self, isShow)
        self.bindComponents.rect_descImg.anchoredPosition = C_Vector2(self.bindComponents.rect_descImg.anchoredPosition.x, isShow and -204 or -230)
      end
    }
  }
end

function this:checkCanAddWish(productId)
  local count, limitCnt = L_ProductManager:getLimitForBuildingItem(productId)
  if limitCnt ~= nil and count ~= nil and limitCnt <= count then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_building_reach_limit"))
    return false
  end
  local wishCount = AzurWorld.HomeMgr.WishModule:GetProductCount(productId)
  if limitCnt ~= nil and count ~= nil and wishCount ~= nil and limitCnt <= count + wishCount then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("home_wishlist_item_reachlimit"))
    return false
  end
  return true
end

function this:getMultiQuaProductNeedMaterial()
  local moduleProductFormulaNormalNew = self.modules.module_productFormulaNormalNew
  local targetTpl, selectRars = moduleProductFormulaNormalNew:getSelectFoodInfo()
  local materials = _foodTpl:getNeedMaterial(targetTpl)
  local items = {}
  for i = 1, 4 do
    local material = materials[i]
    if material then
      local itemId = _foodMaterialTpl:getItemId(material[1], selectRars[i])
      local oneNum = material[2]
      table.insert(items, {
        item_id = itemId,
        item_type = L_Const.resType.commonItem,
        item_num = oneNum
      })
    end
  end
  return items
end

function this:open()
  self:setIsEmpty(true)
  self.moduleData = {}
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshBuildPetWorkState, self.onEvent_refreshPet, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.productFinish, self.refreshMainView, self)
  self:registerShortCut("moduleProductionInfoNormal")
end

function this:refreshView()
  self:initSelectNum()
end

function this:hide()
  self.modules.module_productFormulaNormalNew:hide()
end

function this:close()
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshBuildPetWorkState, self.onEvent_refreshPet, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.productFinish, self.refreshMainView, self)
  self:unregisterShortCut("moduleProductionInfoNormal")
  if self._focusReturnToProductListTimer then
    Timer.remove(self._focusReturnToProductListTimer)
    self._focusReturnToProductListTimer = nil
  end
end

function this:refreshMainView()
  if self.parent.refreshBuildiCell then
    self.parent:refreshBuildiCell(self.singleQuaProductData.productId)
  end
end

function this:onEvent_refreshPet(home_builds)
  if home_builds == nil or type(home_builds) ~= "table" or self.singleQuaProductData == nil then
    return
  end
  if self.singleQuaProductData.buildingGuid ~= 0 then
    for k, v in pairs(home_builds) do
      if v.guid == self.singleQuaProductData.buildingGuid and v.station_pet_guid ~= nil and v.station_pet_guid ~= 0 then
        if self.parent.refreshBuildiCell then
          self.parent:refreshBuildiCell(self.singleQuaProductData.productId)
        end
        return
      end
    end
  end
  self:refreshTime()
  if self.singleQuaProductData and self.singleQuaProductData.buildingGuid == 0 then
    self.bind.go_blockClick = false
  else
    self:refreshTime()
    local serverData = L_HomeStore:getHomeBuildingByGuid(self.singleQuaProductData.buildingGuid)
    if not math.isEmpty(serverData.station_pet_guid) then
      return
    end
    local productId = self.singleQuaProductData.productId
    if productId ~= nil and 0 < productId then
      local productTpl = _productsTpl:getTplById(self.singleQuaProductData.productId)
      local groupList = _productsTpl:getGroupList(productTpl)
      local groupType = groupList and groupList[1]
      local buildFunctionType = groupType and L_ProductManager:onGetHomeBuildFunctionType(groupType)
      if buildFunctionType == L_HomeConst.HomeBuildFunctionType.EQUIP then
        self.bind.go_blockClick = true
        self.blockClick = L_WordsTpl:getTplById("ui_product_need_pet")
      end
    end
  end
end

function this:clickProcess()
  if self.singleQuaProductData.productId <= 0 then
    return
  end
  local tpl_pro = _productsTpl:getTplById(self.singleQuaProductData.productId)
  local notRelease = _productsTpl:getNotReleased(tpl_pro)
  if notRelease == 1 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_system_notdo"))
    return
  end
end

function this:setMultiQualityProduct(buildingGuid, foodGroupId, previewPetGuid)
  self.multiQuaProductData = self.multiQuaProductData or {}
  self.multiQuaProductData.buildingGuid = buildingGuid
  self.multiQuaProductData.foodGroupId = foodGroupId
  self.multiQuaProductData.previewPetGuid = previewPetGuid
  self.multiQuaProductData.selectNum = self.multiQuaProductData.selectNum or 1
  self:OnClearSingleQuaProductData()
  self.moduleData.productInfoDescType = L_HomeConst.ProductInfoDescType.Normal
  self.moduleData.isMultiQualityProduct = true
  local productIdList = _productsMultiQualityTpl:getProductIdListByFoodGroupId(foodGroupId)
  self.multiQuaProductData.productIdList = productIdList
  local productsTpl = _productsTpl:getTplById(productIdList[1])
  local condition = _productsTpl:getUnlockCondition(productsTpl)
  local isComplete, _ = L_ConditionManager:isComplete(condition)
  if isComplete then
    self:setUsingButton(L_HomeConst.ProductInfoDescType.Normal)
  else
    self:setButtonGoto()
  end
  self:setActiveInfoDescPart()
  self:setIsEmpty(false)
  local module_productFormulaNormalNew = self.modules.module_productFormulaNormalNew
  module_productFormulaNormalNew:setFoodGroup(foodGroupId)
end

function this:changeMultiQuaProductId(productId)
  self.multiQuaProductData.productId = productId
  local moduleProductInfoDesc_normal = self.modules.moduleProductInfoDesc_normal
  local parentTab = self.parentTab or nil
  moduleProductInfoDesc_normal:setData(self.multiQuaProductData.productId, self.multiQuaProductData.buildingGuid, self, parentTab, self.isProduct, self.multiQuaProductData.previewPetGuid)
  moduleProductInfoDesc_normal:refreshUI()
end

function this:OnClearSingleQuaProductData()
  self.singleQuaProductData = nil
end

function this:checkIfCanStartMultiQualityProduct()
  local groupTpl = _foodGroupTpl:getTplById(self.multiQuaProductData.foodGroupId)
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.multiQuaProductData.buildingGuid)
  if _foodGroupTpl:getIsNeedPet(groupTpl) and math.isEmpty(serverData.station_pet_guid) then
    L_FlyMsgManager:showNormalMsgByKey("notice_pageHomeCook_01")
    return false
  end
  if C_HomeUtil.CheckBuildCanProduct(self.multiQuaProductData.buildingGuid, self.multiQuaProductData.productId) then
    local moduleProductFormulaNormalNew = self.modules.module_productFormulaNormalNew
    return moduleProductFormulaNormalNew:checkItemSatisfy()
  end
end

function this:startMultiQualityProduct()
  local moduleProductFormulaNormalNew = self.modules.module_productFormulaNormalNew
  local targetTpl, selectRars = moduleProductFormulaNormalNew:getSelectFoodInfo()
  local guid = self.multiQuaProductData.buildingGuid
  local cookId = _foodTpl:getId(targetTpl)
  local count = self.multiQuaProductData.selectNum
  local materials = _foodTpl:getNeedMaterial(targetTpl)
  local items = {}
  for i = 1, 4 do
    local material = materials[i]
    if material then
      local itemId = _foodMaterialTpl:getItemId(material[1], selectRars[i])
      local oneNum = material[2]
      table.insert(items, {item_id = itemId, item_num = oneNum})
    end
  end
  L_CookStore:req_cook(guid, cookId, count, items)
end

function this:setSingleQualityProduct(buildingGuid, productId, buildType, productInfoType, blockClick, fromBuildId, previewPetGuid)
  if productId == nil or productId == 0 then
    return
  end
  self.singleQuaProductData = self.singleQuaProductData or {}
  self.singleQuaProductData.buildingGuid = buildingGuid
  self.singleQuaProductData.productId = productId
  self.singleQuaProductData.selectNum = 1
  self.singleQuaProductData.previewPetGuid = previewPetGuid
  self.moduleData.isMultiQualityProduct = false
  self.blockClick = blockClick
  self.bind.go_blockClick = blockClick ~= nil
  self.multiQuaProductData = nil
  self:setIsEmpty(false)
  if productInfoType then
    self.moduleData.productInfoDescType = productInfoType
  else
    self.moduleData.productInfoDescType = L_HomeConst.ProductInfoDescType.Normal
  end
  self.modules.module_productFormulaNormalNew:setProduct(buildingGuid, productId, buildType, fromBuildId)
  if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Accessory then
    local tpl = _productsTpl:getTplById(productId)
    local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
    if reward.itemType == L_Const.resType.customAccessory then
      self.modules.moduleProductInfoDesc_accessory:refreshProductAccessoryView(_accessoryCustomedTpl:getAccessoryIdById(reward.itemId))
    else
      self.modules.moduleProductInfoDesc_accessory:refreshProductAccessoryView(reward.itemId)
    end
    self:setUsingButton(L_HomeConst.ProductInfoDescType.Accessory)
  else
    local productsTpl = _productsTpl:getTplById(productId)
    if productsTpl == nil then
      C_MJLog.LogError(string.format("productId:%d 没配置", productId))
      self:setUsingButton(L_HomeConst.ProductInfoDescType.Normal)
    else
      local condition = _productsTpl:getUnlockCondition(productsTpl)
      local isComplete, _ = L_ConditionManager:isComplete(condition)
      if isComplete then
        self:setUsingButton(L_HomeConst.ProductInfoDescType.Normal)
      else
        self:setButtonGoto()
      end
    end
    self:setProductInfoDesc(productId, self.singleQuaProductData.buildingGuid, self.singleQuaProductData.previewPetGuid)
  end
  self:setActiveInfoDescPart()
  self:refreshTime()
end

function this:setProductInfoDesc(productId, buildingGuid, previewPetGuid)
  local moduleProductInfoDesc_normal = self.modules.moduleProductInfoDesc_normal
  local parentTab = self.parentTab or nil
  moduleProductInfoDesc_normal:setData(productId, buildingGuid, self, parentTab, self.isProduct, previewPetGuid)
  moduleProductInfoDesc_normal:refreshUI()
end

function this:refreshPreviewPetGuid(buildGuid, previewPetGuid)
  local moduleProductInfoDesc_normal = self.modules.moduleProductInfoDesc_normal
  moduleProductInfoDesc_normal:refreshPreviewPetGuid(buildGuid, previewPetGuid)
  if not self.eggData or self.eggData.buildingGuid ~= buildGuid then
    return
  end
  self.eggData.previewPetGuid = previewPetGuid
  self:refreshTime()
end

function this:OnGetParentTab(parentTab)
  self.parentTab = parentTab
end

function this:checkIfCanStartSingleQualityProduct()
  if self.singleQuaProductData.buildingGuid == 0 then
    local isHadIdle = L_ProductManager:onIsHadIdleQueueWithFastProduct()
    if not isHadIdle then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_lack_produce_queue"))
      return false
    end
    local tpl = _productsTpl:getTplById(self.singleQuaProductData.productId)
    local reward = _productsTpl:getRewardId(tpl)
    if not table.isEmpty(reward) then
      local itemData = L_DataUtil.parseRewardConfigItem(reward[1])
      if itemData.itemType == L_Const.resType.homeBuilding then
        local hadNum = L_ProductManager:onGetAllFastProductCount(self.singleQuaProductData.productId, true)
        local maxNum = L_ProductManager:onGetMaxCountFastProduct(self.singleQuaProductData.productId)
        if hadNum >= maxNum then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_building_reach_limit"))
          return false
        end
      end
    end
    return self.modules.module_productFormulaNormalNew:checkItemSatisfy()
  elseif C_HomeUtil.CheckBuildCanProduct(self.singleQuaProductData.buildingGuid, self.singleQuaProductData.productId) then
    return self.modules.module_productFormulaNormalNew:checkItemSatisfy()
  end
end

function this:getNormalProductMaxCanDo()
  local moduleProductFormulaNormalNew = self.modules.module_productFormulaNormalNew
  return moduleProductFormulaNormalNew:getMaxCanDo()
end

function this:setNormalProductSelectNum(selectNum)
  local moduleProductFormulaNormalNew = self.modules.module_productFormulaNormalNew
  moduleProductFormulaNormalNew:setSelectNum(selectNum)
  if self.moduleData.isMultiQualityProduct then
    self.multiQuaProductData.selectNum = selectNum
  else
    self.singleQuaProductData.selectNum = selectNum
  end
end

function this:setEggInfo(eggGuid, buildingGuid, previewPetGuid)
  self.eggData = self.eggData or {}
  self.eggData.eggGuid = eggGuid
  if L_PetStore:getPetEggItem(self.eggData.eggGuid).configId ~= nil then
    self.eggData.eggConfigId = L_PetStore:getPetEggItem(self.eggData.eggGuid).configId
  end
  self.eggData.buildingGuid = buildingGuid
  self.eggData.previewPetGuid = previewPetGuid
  self.moduleData.productInfoDescType = L_HomeConst.ProductInfoDescType.Egg
  self.moduleData.isMultiQualityProduct = false
  self:setUsingButton(L_HomeConst.ProductInfoDescType.Egg)
  self:setActiveInfoDescPart()
  self:setIsEmpty(false)
  local module_productFormulaNormalNew = self.modules.module_productFormulaNormalNew
  module_productFormulaNormalNew:setEggGuid(self.eggData.eggGuid)
  self:refreshTime()
  self:setEggInfoDesc()
  self.bind.active_wish = false
end

function this:setEggInfoDesc()
  local moduleProductInfoDesc_egg = self.modules.moduleProductInfoDesc_egg
  moduleProductInfoDesc_egg:setData(self.eggData.eggGuid, self.eggData.buildingGuid, self)
  moduleProductInfoDesc_egg:refreshUI()
end

function this:tryStartHatchEgg()
  local petEggData = L_PetStore:getPetEggItem(self.eggData.eggGuid)
  if petEggData.hatch_state ~= 0 then
    return
  end
  local petEggTpl = _petEggTpl:getTplById(petEggData.configId)
  local productId = _petEggTpl:getProduct(petEggTpl)
  if not C_HomeUtil.CheckBuildCanProduct(self.eggData.buildingGuid, productId) then
    return
  end
  L_PetStore:req_hatchPetEgg(self.eggData.buildingGuid, self.eggData.eggGuid)
end

function this:setButtonGoto()
  self.bind.active_startBtn_accessory = false
  self.bind.active_startBtn_normal = false
  self.bind.acitve_startBtn_egg = false
  self.bind.acitve_startBtn_goto = true
end

function this:setUsingButton(ProductInfoDescType)
  self.bind.acitve_startBtn_goto = false
  if ProductInfoDescType == L_HomeConst.ProductInfoDescType.Normal then
    self.bind.active_startBtn_accessory = false
    self.bind.active_startBtn_normal = true
    self.bind.acitve_startBtn_egg = false
  elseif ProductInfoDescType == L_HomeConst.ProductInfoDescType.Accessory then
    self.bind.active_startBtn_accessory = true
    self.bind.active_startBtn_normal = false
    self.bind.acitve_startBtn_egg = false
  elseif ProductInfoDescType == L_HomeConst.ProductInfoDescType.Egg then
    self.bind.active_startBtn_accessory = false
    self.bind.active_startBtn_normal = false
    self.bind.acitve_startBtn_egg = true
  end
end

function this:setActiveInfoDescPart()
  self.bind.active_moduleProductInfoDesc_normal = self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Normal
  self.bind.active_moduleProductInfoDesc_accessory = self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Accessory
  self.bind.active_moduleProductInfoDesc_egg = self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Egg
end

function this:setIsEmpty(isEmpty)
  self.bind.active_isEmpty = isEmpty
end

function this:onClickStart()
  if self.blockClick then
    L_FlyMsgManager:showNormalMsg(self.blockClick)
    return
  end
  local timeNowServer = C_TimeUtility.NowServer
  if self.moduleData.lastClickStartTime ~= nil and timeNowServer - self.moduleData.lastClickStartTime < 0.5 then
    return
  end
  self.moduleData.lastClickStartTime = timeNowServer
  if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Normal or self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Accessory then
    self:tryStartNormalProduct()
  elseif self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Egg then
    self:tryStartHatchEgg()
  end
  self._focusReturnToProductListTimer = Timer.once(0.01, function()
    if self.parent.setGamepadFocusModule and self.parent.getProductListModule and self.parent._navMgr and self.parent.getProductListAreaName then
      self.parent:setGamepadFocusModule(self.parent:getProductListModule())
      self.parent._navMgr:SelectArea(self.parent:getProductListAreaName())
    end
    if self._focusReturnToProductListTimer then
      Timer.remove(self._focusReturnToProductListTimer)
      self._focusReturnToProductListTimer = nil
    end
  end)
end

function this:tryStartNormalProduct()
  if self.singleQuaProductData and self.singleQuaProductData.buildingGuid == 0 then
    if not self:checkIfCanStartSingleQualityProduct() then
      return
    end
    local selectMaterial = self.modules.module_productFormulaNormalNew:getSelectMaterialTableIdList()
    L_ProductStore:req_CSProtoSimpleProductStart(self.singleQuaProductData.productId, self.singleQuaProductData.selectNum, selectMaterial)
  elseif self.moduleData.isMultiQualityProduct then
    if not self:checkIfCanStartMultiQualityProduct() then
      return
    end
    self:startMultiQualityProduct()
  else
    if not self:checkIfCanStartSingleQualityProduct() then
      return
    end
    local productId = self.singleQuaProductData.productId
    local buildingGuid = self.singleQuaProductData.buildingGuid
    local productTpl = _productsTpl:getTplById(productId)
    if productTpl == nil then
      return
    end
    local groupList = _productsTpl:getGroupList(productTpl)
    local groupType = groupList and groupList[1]
    local buildFunctionType = groupType and L_ProductManager:onGetHomeBuildFunctionType(groupType)
    if buildFunctionType == L_HomeConst.HomeBuildFunctionType.EQUIP then
      local selectGuid = self.modules.module_productFormulaNormalNew:getSelectedGuid()
      L_ProductStore:req_CSProtoAccessoryProductStart(buildingGuid, productId, selectGuid)
    else
      local selectMaterial = self.modules.module_productFormulaNormalNew:getSelectMaterialTableIdList()
      L_ProductStore:req_CSProtoNormalProductStart(buildingGuid, productId, self.singleQuaProductData.selectNum, selectMaterial)
    end
  end
end

function this:tryGotoTechnology()
  local productId = 0
  if self.singleQuaProductData then
    productId = self.singleQuaProductData.productId
  elseif self.multiQuaProductData then
    productId = self.multiQuaProductData.productIdList[1]
  end
  if productId == 0 then
    return
  end
  local techTreeId = L_ProductManager:getConditionTechTreeId(productId)
  L_UI:open("pageHomeScienceMain", {
    selectTreeId = techTreeId,
    productId = productId,
    isTopLayer = true
  })
end

function this:initSelectNum()
  if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Normal then
    local moduleProductInfoDesc_normal = self.modules.moduleProductInfoDesc_normal
    moduleProductInfoDesc_normal:initSelectNum()
    moduleProductInfoDesc_normal:setSelectNumGamepadShortCutEnable(false)
  end
end

function this:refreshTime()
  if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Accessory then
    local protectProcessProductTime = L_GameConstTpl:getData("HOME_PROCESS_PRODUCT_TIME")
    local onceNormalTime = L_ProductManager:getFastProduceOnceTime(self.singleQuaProductData.productId)
    if protectProcessProductTime > onceNormalTime then
      onceNormalTime = protectProcessProductTime
    end
    if self.singleQuaProductData.buildingGuid ~= 0 then
      local productId = self.singleQuaProductData.productId
      local buildingGuid = self.singleQuaProductData.buildingGuid
      local onceTime = L_ProductManager:getProduceOnceTime(buildingGuid, productId, self.isProduct)
      self.bind.preview_txt_time = string.format("%s", L_TimeUtil.secondToLangString(onceTime))
      self.bind.preview_txt_time_accessory = self.bind.preivew_txt_time
      self.bind.txt_time = string.format("<#afafaf><s><size=14>%s</size></s></color>", L_TimeUtil.secondToLangString(math.floor(onceNormalTime)))
      self.bind.txt_time_accessory = self.bind.txt_time
    else
      self.bind.txt_time = string.format("%s", L_TimeUtil.secondToLangString(onceNormalTime))
      self.bind.txt_time_accessory = string.format("%s", L_TimeUtil.secondToLangString(math.floor(onceNormalTime)))
      self.bind.preview_txt_time = " "
      self.bind.preview_txt_time_accessory = " "
    end
  elseif self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Egg then
    if self.eggData.eggConfigId == nil then
      return
    end
    local onceNormalTime = L_PetStore:getEggIncubationTime(self.eggData.eggConfigId)
    local onceTime = L_PetStore:getEggIncubationTime(self.eggData.eggConfigId, self.eggData.buildingGuid, self.isProduct, self.eggData.previewPetGuid)
    if onceTime ~= onceNormalTime then
      self.bind.txt_time_egg = string.format("<#afafaf><s><size=14>%s</size></s></color>", L_TimeUtil.secondToLangString(math.floor(onceNormalTime)))
      self.bind.preview_txt_time_egg = L_TimeUtil.secondToLangString(onceTime)
    else
      self.bind.txt_time_egg = L_TimeUtil.secondToLangString(onceNormalTime)
      self.bind.preview_txt_time_egg = " "
    end
  end
end

function this:setAttributionProduct(isProduct)
  self.isProduct = isProduct
end

function this:updateKiboWorkInfo(kiboExpInfos)
  self.modules.moduleProductInfoDesc_accessory:updateKiboWorkInfo(kiboExpInfos)
end

function this:onClickAddWish()
  local product_id, materials, selects
  if self.singleQuaProductData and self.singleQuaProductData.productId then
    product_id = self.singleQuaProductData.productId
    if not self:checkCanAddWish(product_id) then
      return
    end
    selects = L_ProductStore.cacheViewIndex2groupDataIndex[product_id]
    L_UI:open("pageWishAddDetail", {
      product_id = product_id,
      materials = materials,
      selects = selects,
      isMutiQua = false
    })
  elseif self.multiQuaProductData and self.multiQuaProductData.productId then
    product_id = self.multiQuaProductData.productId
    if not self:checkCanAddWish(product_id) then
      return
    end
    local _materials = self:getMultiQuaProductNeedMaterial()
    if 0 < #_materials then
      materials = _materials
    end
    selects = L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId]
    L_UI:open("pageWishAddDetail", {
      product_id = product_id,
      materials = materials,
      selects = selects,
      isMutiQua = true
    })
  end
end

function this:onPageTopChange(isTop, prevIsTop)
  self:setSelectNumGamepadShortCutEnable(self._gamepadFocus and isTop)
end

function this:setGamepadFocus(bFocus)
  local prevGamepadFocus = self._gamepadFocus
  self._gamepadFocus = bFocus
  self.bind.active_focusRect = self._gamepadFocus
  if self._gamepadFocus and not prevGamepadFocus and self.parent._navMgr then
    self.parent._navMgr.navigationEnabled = false
  end
  if self._gamepadFocus then
    self:addShortKeyFlag()
    self:refreshBottomShortCut()
  else
    self:clearShortKeyFlag()
  end
  self:setSelectNumGamepadShortCutEnable(self._gamepadFocus)
end

function this:setSelectNumGamepadShortCutEnable(bEnable)
  if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Normal then
    local moduleProductInfoDesc_normal = self.modules.moduleProductInfoDesc_normal
    moduleProductInfoDesc_normal:setSelectNumGamepadShortCutEnable(bEnable)
    if self._gamepadFocus then
      self:refreshBottomShortCut()
    end
  end
end

function this:isGamepadFocus()
  if self._gamepadFocus ~= nil then
    return self._gamepadFocus
  end
  return false
end

function this:registerShortCut(pageName)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EQuickProductStart, function()
    if self.parent.isTop == false then
      return
    end
    if not self:isGamepadFocus() then
      return
    end
    self:onClickStart()
  end)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EQuickProductAddWishlist, function()
    if self.parent.isTop == false then
      return
    end
    if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Egg then
      return
    end
    if not self:isGamepadFocus() then
      return
    end
    self:onClickAddWish()
  end)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EQuickProductOpenWishlist, function()
    if self.parent.isTop == false then
      return
    end
    if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Egg then
      return
    end
    if not self:isGamepadFocus() then
      return
    end
    L_UI:open("pageWishlist")
  end)
  L_ShortCutManager:registerShortCut(pageName, C_InputManager_KeyType.EQuickProductMaterialList, function()
    if self.parent.isTop == false then
      return
    end
    if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Egg then
      return
    end
    if not self:isGamepadFocus() then
      return
    end
    if self.parent._navMgr then
      if self.parent._navMgr.navigationEnabled then
        if self.moduleData.isMultiQualityProduct then
          self.modules.module_productFormulaNormalNew:onClickAutoSelectMaterialOfMultiQuaProduct()
        end
      else
        self.parent._navMgr.navigationEnabled = true
        self.parent._navMgr:SelectArea("AreaMaterialList")
        self:refreshBottomShortCut()
      end
    end
  end)
end

function this:unregisterShortCut(pageName)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EQuickProductStart)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EQuickProductAddWishlist)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EQuickProductOpenWishlist)
  L_ShortCutManager:unregisterShortCut(pageName, C_InputManager_KeyType.EQuickProductMaterialList)
  self:clearShortKeyFlag()
end

function this:addShortKeyFlag()
  if self.bind.active_startBtn_normal then
    L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductStart", L_Const.AnchorType.Right, self.bindComponents.rect_startBtnNormalText, L_Vector3.new(-15, -2), 1.2)
  elseif self.bind.active_startBtn_accessory then
    L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductStart", L_Const.AnchorType.Right, self.bindComponents.rect_startBtnAccessoryText, L_Vector3.new(-105, -1), 1.2)
  elseif self.bind.acitve_startBtn_egg then
    L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductStart", L_Const.AnchorType.Right, self.bindComponents.rect_startBtnEggText, L_Vector3.new(-105, -1), 1.2)
  else
    L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductStart", L_Const.AnchorType.Right, self.bindComponents.rect_startBtnGotoText, L_Vector3.new(-150, 0), 1.2)
  end
  L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductAddWishlist", L_Const.AnchorType.Left, self.bindComponents.rect_btnWishAdd, L_Vector3.new(0, 0))
  L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductOpenWishlist", L_Const.AnchorType.Right, self.bindComponents.rect_btnWishList, L_Vector3.new(-15, 2))
  L_ShortCutManager:addShortKeyFlag(self, "UI_QuickProductMaterialList", L_Const.AnchorType.Left, self.bindComponents.rect_btnQuality, L_Vector3.new(35, 1))
  self:refreshBottomShortCut()
end

function this:clearShortKeyFlag()
  L_ShortCutManager:clearShortKeyFlag(self)
end

function this:refreshBottomShortCut()
  self._inputActionBinding = self._inputActionBinding or self.gameObject:GetComponent(typeof(CS.Lens.Gameplay.UI.UIInputActionBinding))
  if self._inputActionBinding and self.parent._navMgr then
    if self.parent._navMgr.navigationEnabled then
      local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
      args.isLuaEvent = true
      args.luaTable = {
        moduleOrPageName = "moduleProductInfoNormal",
        changeGroupName = "GroupMaterial"
      }
      C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    else
      local selectNumActive = false
      if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Normal then
        selectNumActive = self.modules.moduleProductInfoDesc_normal.bind.active_moduleNum
      end
      local args = CS.Lens.Gameplay.UI.BottomGamepadCutsEventArgs()
      args.isLuaEvent = true
      args.luaTable = {
        moduleOrPageName = "moduleProductInfoNormal",
        changeGroupName = selectNumActive and "GroupInfo" or "GroupInfoNoSelectNum"
      }
      C_ExternalManager.DispatchEvent(C_EExternalEventType.BottomGamepadCutsGroupChange, args)
    end
  end
end

return this

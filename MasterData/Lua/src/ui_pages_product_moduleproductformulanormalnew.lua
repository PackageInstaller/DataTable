local this = class("moduleProductFormulaNormalNew", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _productsMaterialGroupTpl = L_GameTpl:getProductsMaterialGroupTpl()
local _commonTabTpl = L_GameTpl:getCommonTabTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _petEggTpl = L_GameTpl:getPetEggTpl()
local _accessoryTpl = L_GameTpl:getAccessoryTpl()

function this.bind()
  return {
    txt_envName = "",
    txt_name = "",
    txt_count = "",
    img_quality = "",
    img_icon = "",
    img_iconFilter = "",
    list_star = {},
    pos_arrow = C_Vector2(-128, 35.5),
    list_materials = {
      moduleName = "pages/product/cellProductMaterial"
    },
    active_heroIcon = false,
    img_heroIcon = "",
    moduleProductInfoDesc_normal = {
      moduleName = "pages/product/moduleProductInfoDesc_normal"
    },
    active_autoSelectMaterialOfMultiQuaProduct = false,
    txt_autoSelectMaterialOfMultiQuaProduct = L_WordsTpl:getValue("ui_moduleProduct_02")
  }
end

function this.methods()
  return {
    onClick_autoSelectMaterialOfMultiQuaProduct = function(self)
      self:onClickAutoSelectMaterialOfMultiQuaProduct()
      self:refreshAutoSelectMultiQuaProductMaterialBtnText()
    end
  }
end

function this:open()
  self.moduleData = {}
  self._selectNum = 1
  self:refreshView()
  
  function self._onBagNumChange()
    self:refreshMaterial()
    if self._itemType and self._itemId then
      self:refreshHasCount(self._itemType, self._itemId)
    end
  end
  
  self._onBagNumChangeHandle = handler(self, self._onBagNumChange)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
  
  function self._onAccessoryPartChange()
    if self._itemType and self._itemId then
      self:refreshHasCount(self._itemType, self._itemId)
    end
  end
  
  self._onAccessoryPartChangeHandle = handler(self, self._onAccessoryPartChange)
  C_BagEvent.instance:Listen(C_EBagEvent.AccessoryPartChange, self._onAccessoryPartChangeHandle)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshView, self)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self._onBagNumChangeHandle)
end

function this:close()
  L_PhotoManager:clearPhotoEntity(self)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._onBagNumChangeHandle)
  C_BagEvent.instance:Cancel(C_EBagEvent.AccessoryPartChange, self._onAccessoryPartChangeHandle)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self.refreshView, self)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self._onBagNumChangeHandle)
end

function this:setProduct(buildingGuid, id, buildType, fromBuildId)
  self.moduleData.isMultiQuality = false
  self.moduleData.productInfoDescType = L_HomeConst.ProductInfoDescType.Normal
  self.multiQuaProductData = {}
  self._buildingGuid = buildingGuid
  self._id = id
  self._fromBuildId = fromBuildId
  self._selectNum = 1
  if L_ProductStore.cacheViewIndex2groupDataIndex[self._id] == nil then
    L_ProductStore.cacheViewIndex2groupDataIndex[self._id] = {
      1,
      1,
      1,
      1
    }
  end
  self:refreshView()
end

function this:refreshSingleQuaProductView()
  if not self.isBind or not self._id then
    return
  end
  local id = self._id
  local tpl = _productsTpl:getTplById(id)
  local tabId = _productsTpl:getTabId(tpl)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self:InitItemInfo(reward.itemType, reward.itemId, tabId)
  self.bind.petIconActive = _productsTpl:getIsNeedPet(tpl)
  self:refreshMaterial()
  self.bind.active_autoSelectMaterialOfMultiQuaProduct = false
end

function this:InitItemInfo(itemType, itemId, tabId)
  self._itemType = itemType
  self._itemId = itemId
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  local tabTpl = _commonTabTpl:getTplById(tabId)
  if not math.isEmpty(self._buildingGuid) then
    if tabTpl then
      local buildTag = _commonTabTpl:getProductBuild(tabTpl)
      self.bind.txt_envName = string.format("~%s~", buildTag)
    else
      local buildingData = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
      local buildingTpl = _homeBuildingTpl:getTplById(buildingData.build_id)
      local buildingGroupTpl = _homeBuildingGroupTpl:getTplById(_homeBuildingTpl:getGroupId(buildingTpl))
      self.bind.txt_envName = string.format("~%s~", _homeBuildingGroupTpl:getProduceTypeTitle(buildingGroupTpl))
    end
  else
    self.bind.txt_envName = L_WordsTpl:getValue("ui_moduleProductFormulaCookNew")
  end
  local pattern1 = string.match(conf.name, " %a+.%d+")
  local pattern2 = string.match(conf.name, "%a+.%d+")
  if pattern1 then
    self.bind.txt_name = string.gsub(conf.name, pattern1, "")
  elseif pattern2 then
    self.bind.txt_name = string.gsub(conf.name, pattern2, "")
  else
    self.bind.txt_name = conf.name
  end
  self:refreshHasCount(itemType, itemId)
  local commonItemTpl = _commonItemTpl:getTplById(itemId)
  if not commonItemTpl then
    self.bind.img_iconFilter = ""
  else
    self.bind.img_iconFilter = _commonItemTpl:getFilterIcon(commonItemTpl)
  end
  self.bind.img_icon = conf.icon
  self.bind.img_quality = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", tostring(conf.quality))
  local starNum = L_ItemTplManager:getItemShowStarNum(itemType, itemId)
  self:_setStars(starNum)
end

function this:refreshHasCount(itemType, itemId)
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  local countFormat = "<color=#9c968d>拥有数量：</color> %d"
  local hasCount
  if conf.itemType == L_Const.resType.homeBuilding then
    hasCount = L_HomeStore:getTotalNumByBuildingId(conf.itemId)
  elseif conf.itemType == L_Const.resType.collectionTool then
    hasCount = 0
  elseif conf.itemType == L_Const.resType.commonItem then
    hasCount = C_BagMgr:getItemNumByItemId(conf.itemId)
  elseif conf.itemType == L_Const.resType.mountSaddle then
    local isHas = AzurWorld.mountMgr:GetIdMountSaddleUnlock(conf.itemId) == true
    hasCount = isHas and 1 or 0
  elseif conf.itemType == L_Const.resType.currency then
    hasCount = L_ItemTplManager:getItemNum(L_Const.resType.currency, conf.itemId)
  elseif conf and conf.itemType and conf.itemId then
    hasCount = L_ItemTplManager:getItemNum(conf.itemType, conf.itemId)
  end
  if hasCount then
    self.bind.txt_count = string.format(countFormat, hasCount)
  else
    self.bind.txt_count = string.format(countFormat, 0)
    error(debug.traceback("item type" .. tostring(conf.itemType) .. "|" .. tostring(itemType)))
  end
end

function this:refreshSingleQuaProductMaterial()
  if self._id == nil then
    return
  end
  local tpl = _productsTpl:getTplById(self._id)
  if not tpl then
    return
  end
  local fixedMaterialList = _productsTpl:getMaterial(tpl)
  local materialSelectList = _productsTpl:getMaterialSelectList(tpl)
  local groupDataList = {}
  for _, materialGroupId in ipairs(materialSelectList) do
    local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
    table.insert(groupDataList, groupData)
  end
  local tmp = L_DataUtil.getEmptyModuleDatas(4)
  local index = 0
  local tempId = self._id
  self.bind.pos_arrow = C_Vector2(-128, 35.5)
  for _, v in ipairs(fixedMaterialList) do
    local reward = L_DataUtil.parseRewardConfigItem(v)
    local isHasSelected = false
    if not math.isEmpty(L_ProductStore.cacheAccessorySelectedUid[self._id]) then
      local acc = C_AccessoryMgr:getAccessory(L_ProductStore.cacheAccessorySelectedUid[self._id])
      if acc ~= nil then
        isHasSelected = true
      else
        L_ProductStore.cacheAccessorySelectedUid[self._id] = 0
      end
    end
    if reward.itemType == L_Const.resType.accessory then
      tmp[1] = {
        singleNum = 1,
        needNum = 1,
        hadNum = isHasSelected and 1 or 0,
        itemType = reward.itemType,
        parentId = self._id,
        fromBuildId = self._fromBuildId,
        guid = self._buildingGuid,
        color = _accessoryTpl:getRarity(_accessoryTpl:getTplById(reward.itemId)),
        itemId = reward.itemId,
        changeCallback = function()
          local guids = C_AccessoryMgr:getAccessoryGuidsById(reward.itemId)
          if guids.Count > 0 then
            L_UI:open("pageAccessorySelect", {
              id = reward.itemId,
              callback = function(guid)
                L_ProductStore.cacheAccessorySelectedUid[self._id] = guid
                self:refreshMaterial()
              end,
              select = L_ProductStore.cacheAccessorySelectedUid[self._id] or 0
            })
          else
            L_FlyMsgManager:showNormalMsgByKey("notice_moduleProductFormulaNormalNew")
          end
        end
      }
      index = 1
      self.bind.pos_arrow = C_Vector2(-79.4, 35.5)
    end
  end
  for _, groupData in ipairs(groupDataList) do
    index = index + 1
    if 4 < index then
      break
    end
    local viewIndex = index
    if not L_ProductStore.cacheViewIndex2groupDataIndex[tempId] then
      L_ProductStore.cacheViewIndex2groupDataIndex[tempId] = {
        1,
        1,
        1,
        1
      }
    end
    local itemData = groupData[L_ProductStore.cacheViewIndex2groupDataIndex[tempId][viewIndex]]
    if itemData == nil then
      L_ProductStore.cacheViewIndex2groupDataIndex[tempId][viewIndex] = 1
      itemData = groupData[1]
    end
    local itemConfig = L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
    tmp[viewIndex] = {
      singleNum = itemData.itemNum,
      needNum = itemData.itemNum * self._selectNum,
      hadNum = L_ItemTplManager:getItemNum(itemData.itemType, itemData.itemId),
      color = itemConfig.quality,
      itemType = itemData.itemType,
      itemId = itemData.itemId,
      parentId = self._id,
      fromBuildId = self._fromBuildId,
      guid = self._buildingGuid,
      changeCallback = function()
        L_UI:open("pageHomeProductSelectMaterial", {
          groupData = groupData,
          selectNum = self._selectNum,
          callback = function(selectIndex)
            L_ProductStore.cacheViewIndex2groupDataIndex[tempId][viewIndex] = selectIndex
            self:refreshMaterial()
            self.parent:initSelectNum()
          end,
          select = L_ProductStore.cacheViewIndex2groupDataIndex[tempId][viewIndex]
        })
      end
    }
  end
  for i, v in ipairs(fixedMaterialList) do
    local reward = L_DataUtil.parseRewardConfigItem(v)
    if reward.itemType ~= L_Const.resType.accessory then
      local itemConfig = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
      index = index + 1
      if 4 < index then
        break
      end
      tmp[index] = {
        singleNum = reward.itemNum,
        needNum = reward.itemNum * self._selectNum,
        color = itemConfig.quality,
        hadNum = L_ItemTplManager:getItemNum(reward.itemType, reward.itemId),
        itemType = reward.itemType,
        itemId = reward.itemId,
        parentId = self._id,
        fromBuildId = self._fromBuildId,
        guid = self._buildingGuid
      }
    end
  end
  if not math.isEmpty(L_ProductStore.cacheAccessorySelectedUid[self._id]) then
    local acc = C_AccessoryMgr:getAccessory(L_ProductStore.cacheAccessorySelectedUid[self._id])
    if acc ~= nil then
      self._heroId = acc.wearHero
    end
  else
    self._heroId = nil
  end
  self.bind.active_heroIcon = not math.isEmpty(self._heroId)
  if self.bind.active_heroIcon then
    local heroData = L_HeroStore:getHero(self._heroId)
    local heroConf = L_ItemTplManager:getHeroItem(L_HeroStore:getHeroConfigId(heroData))
    self.bind.img_heroIcon = heroConf.icon
    if self._heroId == L_HeroStore:getDefaultHeroGuid() then
      L_PhotoManager:newOrBindPhotoEntity(self, self.bindComponents.img_heroIcon, L_PlayerStore:getPlayerModHeadImgName())
    else
      L_PhotoManager:clearPhotoEntity(self)
    end
  end
  self:refreshMaterialList(tmp)
end

function this:checkIsMaterialDataChanged(oldMaterialData, curMaterialData)
  if oldMaterialData == nil and curMaterialData == nil then
    return false
  end
  if oldMaterialData == nil and curMaterialData ~= nil then
    return true
  end
  if oldMaterialData ~= nil and curMaterialData == nil then
    return true
  end
  if oldMaterialData.itemId ~= curMaterialData.itemId then
    return true
  end
  if oldMaterialData.hadNum ~= curMaterialData.hadNum then
    return true
  end
  if oldMaterialData.needNum ~= curMaterialData.needNum then
    return true
  end
  if oldMaterialData.guid ~= curMaterialData.guid then
    return true
  end
  return false
end

function this:getSelectedGuid()
  return L_ProductStore.cacheAccessorySelectedUid[self._id]
end

function this:getSelectedHeroId()
  return self._heroId
end

function this:getSelectMaterialTableIdList()
  local tpl = _productsTpl:getTplById(self._id)
  local materialSelectList = _productsTpl:getMaterialSelectList(tpl)
  if materialSelectList == nil or table.isEmpty(materialSelectList) then
    return {}
  end
  local result = {}
  for i, materialGroupId in pairs(materialSelectList) do
    local groupDataIndex = L_ProductStore.cacheViewIndex2groupDataIndex[self._id][i]
    local groupData = table.clone(_productsMaterialGroupTpl:getGroupDataByMaterialGroupId(materialGroupId))
    local itemData = groupData[groupDataIndex]
    local tableId = itemData.tableId
    table.insert(result, tableId)
  end
  return result
end

function this:getSingleQualityProductMaxCanDo()
  local canNum = L_Const.maxInt
  for _, cellProductMaterial in ipairs(self.modules.list_materials) do
    if cellProductMaterial.bind.itemId then
      local oneNum = cellProductMaterial.bind.singleNum
      local haveNum = cellProductMaterial.bind.hadNum
      canNum = math.min(canNum, math.floor(haveNum / oneNum))
    end
  end
  if self._itemType == L_Const.resType.homeBuilding then
    local tpl_building = _homeBuildingTpl:getTplById(self._itemId)
    local groupId = _homeBuildingTpl:getGroupId(tpl_building)
    local limitCnt = L_HomeStore:getBuildingLimitCount(groupId)
    local count = L_HomeStore:getCurNumByBuildingGroupId(groupId)
    local restCount = limitCnt - count
    return math.min(canNum, restCount)
  end
  return canNum
end

function this:setFoodGroup(groupId)
  self.moduleData.isMultiQuality = true
  self.moduleData.productInfoDescType = L_HomeConst.ProductInfoDescType.Normal
  self._id = nil
  self._fromBuildId = nil
  self.multiQuaProductData = self.multiQuaProductData or {}
  if self.multiQuaProductData.foodGroupId == groupId then
    return
  end
  local oldFoodGroupId = self.multiQuaProductData.foodGroupId
  self.multiQuaProductData.foodGroupId = groupId
  self.multiQuaProductData.isFoodAutoReverse = oldFoodGroupId == self.multiQuaProductData.foodGroupId and self.multiQuaProductData.isFoodAutoReverse or nil
  self.multiQuaProductData.selectNum = oldFoodGroupId == self.multiQuaProductData.foodGroupId and self.multiQuaProductData.selectNum or 1
  self:refreshAutoSelectMaterialOfMultiQualityProduct()
end

function this:refreshAutoSelectMaterialOfMultiQualityProduct(isOnClickAutoSelect)
  if not math.isEmpty(self.multiQuaProductData.foodGroupId) then
    if L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId] == nil then
      L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId] = {
        0,
        0,
        0,
        0
      }
    end
    local foodIdList = _productsMultiQualityTpl:getItemIdListByFoodGroupId(self.multiQuaProductData.foodGroupId)
    local foodId = foodIdList[1]
    local materials = _productsMultiQualityTpl:getNeedMaterialByConfigId(foodId)
    for x = 1, 4 do
      local material = materials[x]
      if material then
        local materialGroupId = material[1]
        local needNum = material[2]
        local needRarity = material[3]
        local itemIds = _foodMaterialTpl:getGroupItemIds(materialGroupId)
        local tempCacheIndex = L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][x]
        if isOnClickAutoSelect or needRarity > tempCacheIndex or itemIds[tempCacheIndex] == nil or needNum > C_BagMgr:getItemNumByItemId(itemIds[tempCacheIndex]) then
          L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][x] = material[3]
          tempCacheIndex = material[3]
          if self.multiQuaProductData.isFoodAutoReverse then
            for i = 5, 1, -1 do
              if i >= needRarity and itemIds[i] and needNum < C_BagMgr:getItemNumByItemId(itemIds[i]) then
                L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][x] = i
                break
              end
            end
          else
            for i = 1, 5 do
              if i >= needRarity and itemIds[i] and needNum < C_BagMgr:getItemNumByItemId(itemIds[i]) then
                L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][x] = i
                break
              end
            end
          end
        end
      end
    end
  end
  self:initMultiQuaProduct()
end

function this:initMultiQuaProduct()
  self.multiQuaProductData.productsMultiQualityTpl = _productsMultiQualityTpl:getCanDoTpl(self.multiQuaProductData.foodGroupId, L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId])
  self.multiQuaProductData.productId = _productsMultiQualityTpl:getProductIdByConfigId(self.multiQuaProductData.productsMultiQualityTpl.id)
  self.parent:changeMultiQuaProductId(self.multiQuaProductData.productId)
end

function this:getSelectFoodInfo()
  return self.multiQuaProductData.productsMultiQualityTpl, L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId]
end

function this:refreshMultiQuaProductView()
  if not self.isBind or not self.multiQuaProductData.productId then
    return
  end
  local id = self.multiQuaProductData.productId
  local tpl = _productsTpl:getTplById(id)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  self:refreshMultiQuaProductInfo(reward.itemType, reward.itemId, {
    itemNumTxt = item.name
  })
  self:refreshMaterial()
  self:refreshAutoSelectMultiQuaProductMaterialBtnText()
end

function this:refreshMultiQuaProductMaterial()
  if not self.multiQuaProductData.productsMultiQualityTpl then
    return
  end
  local tmp = L_DataUtil.getEmptyModuleDatas(4)
  local materials = _foodTpl:getNeedMaterial(self.multiQuaProductData.productsMultiQualityTpl)
  local productsIdList = _productsMultiQualityTpl:getProductIdListByFoodGroupId(self.multiQuaProductData.foodGroupId)
  local jumpTab = {
    parentPageGuid = self.parent.parent._buildingGuid,
    parentId = productsIdList and productsIdList[1] or nil,
    itemId = 0,
    fromBuildId = self.parent.parent._selectbuildingId
  }
  for i, material in ipairs(materials) do
    local itemId = _foodMaterialTpl:getItemId(material[1], L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][i])
    local item_tmp = L_ItemTplManager:getCommonItem(itemId)
    local itemIds = _foodMaterialTpl:getGroupItemIds(material[1])
    tmp[i] = {
      hadNum = C_BagMgr:getItemNumByItemId(itemId),
      needNum = material[2] * self.multiQuaProductData.selectNum,
      color = item_tmp.quality,
      itemType = L_Const.resType.commonItem,
      itemId = itemId,
      changeCallback = 1 < #itemIds and function()
        jumpTab.itemId = itemId
        L_UI:open("pageCookSelectMaterial", {
          groupId = material[1],
          callback = function(selectIndex)
            L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][i] = selectIndex
            self:initMultiQuaProduct()
          end,
          select = L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId][i],
          parentTab = jumpTab
        })
      end or nil
    }
  end
  self:refreshMaterialList(tmp)
end

function this:refreshMultiQuaProductInfo(itemType, itemId, params)
  self._itemType = itemType
  self._itemId = itemId
  local conf = L_ItemTplManager:getItemConfig(itemType, itemId)
  self.bind.txt_envName = L_WordsTpl:getValue("ui_moduleProductFormulaCookNew")
  local pattern = string.match(conf.name, " %a+.%d+")
  if pattern then
    self.bind.txt_name = string.gsub(conf.name, pattern, "")
  else
    self.bind.txt_name = conf.name
  end
  self:refreshHasCount(itemType, itemId)
  local commonItemTpl = _commonItemTpl:getTplById(itemId)
  self.bind.img_iconFilter = commonItemTpl and _commonItemTpl:getFilterIcon(commonItemTpl) or ""
  self.bind.img_icon = conf.icon
  self.bind.img_quality = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", tostring(conf.quality))
  local starNum = L_ItemTplManager:getItemShowStarNum(itemType, itemId)
  self:_setStars(starNum)
end

function this:onClickAutoSelectMaterialOfMultiQuaProduct()
  self.multiQuaProductData.isFoodAutoReverse = not self.multiQuaProductData.isFoodAutoReverse
  self:refreshAutoSelectMaterialOfMultiQualityProduct(true)
end

function this:refreshAutoSelectMultiQuaProductMaterialBtnText()
  self.bind.active_autoSelectMaterialOfMultiQuaProduct = true
  self.bind.txt_autoSelectMaterialOfMultiQuaProduct = self:isFoodAutoReverse() and L_WordsTpl:getValue("ui_moduleProduct_02") or L_WordsTpl:getValue("ui_moduleProduct_01")
end

function this:isFoodAutoReverse()
  return self.multiQuaProductData.isFoodAutoReverse
end

function this:getMultiQualityProductMaxCanDo()
  return _productsMultiQualityTpl:getCanDoMaxNum(self.multiQuaProductData.productsMultiQualityTpl.id, L_ProductStore.cacheViewIndex2groupDataIndex[self.multiQuaProductData.foodGroupId])
end

function this:setEggGuid(eggGuid)
  self.moduleData.isMultiQuality = false
  self.moduleData.productInfoDescType = L_HomeConst.ProductInfoDescType.Egg
  self.eggData = self.eggData or {}
  self.eggData.eggGuid = eggGuid
  self.eggData.petEggData = L_PetStore:getPetEggItem(self.eggData.eggGuid)
  self:refreshEggInfoView()
end

function this:refreshEggInfoView()
  if self.eggData == nil or self.eggData.eggGuid == nil then
    return
  end
  self.bind.active_autoSelectMaterialOfMultiQuaProduct = false
  self.bind.txt_envName = L_WordsTpl:getValue("ui_modulePetHatchEggInfoNew_01")
  self.bind.txt_name = self.eggData.petEggData.type
  self.bind.img_quality = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", tostring(0))
  local petEggTpl = _petEggTpl:getTplById(self.eggData.petEggData.configId)
  self.bind.img_icon = _petEggTpl:getEggImgIcon(petEggTpl)
  local starNum = L_ItemTplManager:getItemShowStarNum(L_Const.resType.petEgg, self.eggData.petEggData.configId)
  self:_setStars(starNum)
end

function this:refreshView()
  if self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Normal or self.moduleData.productInfoDescType == L_HomeConst.ProductInfoDescType.Accessory then
    if self.moduleData.isMultiQuality then
      self:refreshMultiQuaProductView()
    else
      self:refreshSingleQuaProductView()
    end
  else
    self:refreshEggInfoView()
  end
end

function this:refreshMaterial()
  if self.moduleData.isMultiQuality then
    self:refreshMultiQuaProductMaterial()
  else
    self:refreshSingleQuaProductMaterial()
  end
end

function this:refreshMaterialList(materialDataList)
  for _, materialData in pairs(materialDataList) do
    if table.isEmpty(materialData) then
      materialData.itemId = -1
    end
  end
  C_MJLog.LogInfo("刷新材料 材料数据个数: " .. tostring(#materialDataList), C_ELogModule.Home)
  self.bind.list_materials:freshAll(materialDataList)
  for i = 1, #self.bind.list_materials do
    local cellProductMaterial = self.bind.list_materials:getItemCls(i)
    cellProductMaterial:refreshChangeCallback(materialDataList[i].changeCallback)
    if cellProductMaterial.bind.itemType == L_Const.resType.accessory then
      cellProductMaterial:refreshCellAnchorPos("accessory")
    else
      cellProductMaterial:refreshCellAnchorPos(i)
    end
  end
end

function this:checkItemSatisfy()
  for _, module in ipairs(self.modules.list_materials) do
    if not module:isSatisfy() then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_product_lack_material"))
      return false
    end
  end
  return true
end

function this:setSelectNum(num)
  if self.moduleData.isMultiQuality then
    self.multiQuaProductData.selectNum = num
  else
    self._selectNum = num
  end
  self:refreshView()
end

local stars = {
  {},
  {},
  {},
  {},
  {},
  {},
  {}
}

function this:_setStars(num)
  if not self.isBind then
    return
  end
  local values = {}
  for i = 1, num do
    table.insert(values, {})
  end
  self.bind.list_star:freshAll(values)
end

function this:getMaxCanDo()
  if self.moduleData.isMultiQuality then
    return self:getMultiQualityProductMaxCanDo()
  else
    return self:getSingleQualityProductMaxCanDo()
  end
end

return this

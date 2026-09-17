local this = class("moduleProductInfoDesc_normal", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _homeLaborCapacityTpl = L_GameTpl:getHomeLaborCapacityTpl()
local _buildingTypeTpl = L_GameTpl:getHomeBuildingTypeTpl()
local _mountSaddleTpl = L_GameTpl:getMountSaddleTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _productsMaterialGroupTpl = L_GameTpl:getProductsMaterialGroupTpl()
local _accessoryCustomedTpl = L_GameTpl:getAccessoryCustomedTpl()

function this.bind()
  return {
    txt_itemDesc = "",
    active_itemDesc = false,
    active_topItemDesc = false,
    txt_topItemDesc = "",
    active_topItemDescHero = false,
    txt_topItemDescHero = "",
    active_bottomItemDesc = false,
    txt_bottomItemDesc = "",
    txt_longDesc = "",
    txt_longNum = "",
    active_longNum = false,
    rect_longDesc = C_Vector2(0, 0),
    txt_limitDesc = "",
    active_descLayout = false,
    active_moduleNum = false,
    active_moduleSelectNum = false,
    active_moduleSelectNumMobile = false,
    module_num = L_Const.ModuleInfo.SelectNum,
    module_numMobile = L_Const.ModuleInfo.SelectNum,
    txt_time = "",
    preview_txt_time = "",
    active_startBtn_New = true,
    active_trans_canNotStart = false,
    text_canNotStart = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  self.isPc = L_DeviceTpl:getIsPc()
  self.bind.active_moduleSelectNum = self.isPc
  self.bind.active_moduleSelectNumMobile = not self.isPc
  
  function self._refreshSelectNum()
    if self.UIData == nil or self.UIData.moduleProductInfo.moduleData.productInfoDescType ~= L_HomeConst.ProductInfoDescType.Normal then
      return
    end
    L_TimerManager:newOrResetTimer(self, "initSelectNum", function()
      self:initSelectNum()
    end, 0.1)
  end
  
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshSelectNum)
  L_PetStore:listenCallFunc(L_PetStore.event.refreshPet, self._refreshSelectNum, self)
end

function this:close()
  L_TimerManager:clearTimer(self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshHomeProduct, self._refreshSelectNum)
  L_PetStore:unListenCallFunc(L_PetStore.event.refreshPet, self._refreshSelectNum)
end

function this:setData(productId, buildingGuid, moduleProductInfo, parentTab, isProduct, previewPetGuid)
  self.UIData = self.UIData or {}
  self.UIData.lastProductId = self.UIData.productId
  self.UIData.productId = productId
  self.UIData.selectNum = self.UIData.lastProductId == self.UIData.productId and self.UIData.selectNum or 1
  self.UIData.lastNumMax = self.UIData.lastProductId == self.UIData.productId and self.UIData.lastNumMax or 1
  self.UIData.buildingGuid = buildingGuid
  self.UIData.moduleProductInfo = moduleProductInfo
  self.UIData.isProduct = isProduct
  self.UIData.previewPetGuid = previewPetGuid
  if parentTab ~= nil then
    self.UIData.parentId = parentTab.parentId
    self.UIData.jumpId = parentTab.itemId
  end
end

function this:refreshPreviewPetGuid(buildGuid, previewPetGuid)
  if not self.UIData then
    return
  end
  if self.UIData.buildingGuid == buildGuid then
    self.UIData.previewPetGuid = previewPetGuid
    self:refreshCostInfo()
  end
end

function this:refreshUI()
  local tpl = _productsTpl:getTplById(self.UIData.productId)
  local reward = L_DataUtil.parseRewardConfigItem(_productsTpl:getRewardId(tpl)[1])
  local item = L_ItemTplManager:getItemConfig(reward.itemType, reward.itemId)
  local itemTpl
  if reward.itemType == L_Const.resType.commonItem then
    itemTpl = _commonItemTpl:getTplById(reward.itemId)
  end
  self.bind.active_itemDesc = false
  if itemTpl ~= nil then
    self.bind.txt_itemDesc = _commonItemTpl:getDesc(itemTpl)
    self.bind.active_itemDesc = true
  end
  self.bind.active_topItemDesc = false
  self.bind.active_topItemDescHero = false
  self.bind.active_bottomItemDesc = false
  self:emit("onShowFoodItemDesc", false)
  self.bindComponents.rect_itemDesPart.sizeDelta = C_Vector2(self.bindComponents.rect_itemDesPart.sizeDelta.x, 384)
  self:restBtnState()
  if item.itemType == L_Const.resType.homeBuilding then
    self.bind.txt_longDesc = item.desc
  elseif item.itemType == L_Const.resType.collectionTool then
    local td = CS.Azur.Gameplay.Table.TDCollectionToolTable.GetData(reward.itemId)
    self.bind.txt_longDesc = td.specialDesc.value
  elseif item.itemType == L_Const.resType.mountSaddle then
    local itemTpl = _mountSaddleTpl:getTplById(reward.itemId)
    self.bind.txt_longDesc = _mountSaddleTpl:getSpecialDesc(itemTpl)
    local isInProduction = false
    if self.UIData.buildingGuid == 0 then
      isInProduction = L_ProductManager:onHadInFastProduct()
    else
      local isProductQueue = C_HomeUtil.CheckProductInQueue(self.UIData.productId, true)
      if isProductQueue then
        isInProduction = true
      end
    end
    local isHas = AzurWorld.mountMgr:GetIdMountSaddleUnlock(item.itemId) == true
    self.bind.active_startBtn_New = isInProduction == false and isHas == false
    self.bind.active_trans_canNotStart = isInProduction or isHas
    if isInProduction then
      self.bind.text_canNotStart = L_Lang:get(L_WordsTpl:getValue("notice_home_product_willreachlimit"))
    elseif isHas then
      self.bind.text_canNotStart = L_Lang:get(L_WordsTpl:getValue("tag_home_product_reachlimit"))
    end
  elseif item.itemType == L_Const.resType.accessory then
    self.bind.txt_longDesc = item.desc
  elseif item.itemType == L_Const.resType.customAccessory then
    self.bind.txt_longDesc = item.desc
  elseif item.itemType == L_Const.resType.currency then
    local currencyTpl = L_GameTpl:getCurrencyTpl()
    local tpl = currencyTpl:getTplById(reward.itemId)
    self.bind.txt_itemDesc = currencyTpl:getDesc(tpl)
    self.bind.active_itemDesc = true
    self.bind.txt_longDesc = currencyTpl:getSpecialDesc(tpl)
  else
    if itemTpl == nil then
      C_MJLog.LogError(string.format("itemId:%d 没有common_item配置", reward.itemId))
      return
    end
    local itemType = _commonItemTpl:getType(itemTpl)
    local isFood = itemType == L_BagConst.bagItemType.food
    self.bind.active_topItemDesc = isFood
    self.bind.active_topItemDescHero = false
    self.bind.active_bottomItemDesc = isFood
    if isFood then
      self.bind.active_itemDesc = false
      local foodTpl = _foodTpl:getTplById(reward.itemId)
      local satiety = _foodTpl:getSatietyScore(foodTpl)
      local heroSatiety = _foodTpl:getCharge(foodTpl)
      self.bind.txt_topItemDesc = string.concat(L_WordsTpl:getValue("ui_pet_food_desc"), satiety)
      self.bind.txt_topItemDescHero = string.concat(L_WordsTpl:getValue("ui_hero_food_desc"), heroSatiety)
      if string.isEmpty(item.desc) then
        self.bind.active_bottomItemDesc = false
      else
        self.bind.active_bottomItemDesc = true
        self.bind.txt_bottomItemDesc = item.desc
      end
      self:emit("onShowFoodItemDesc", true)
      self.bindComponents.rect_itemDesPart.sizeDelta = C_Vector2(self.bindComponents.rect_itemDesPart.sizeDelta.x, 406)
    end
    if itemTpl ~= nil then
      self.bind.txt_longDesc = _commonItemTpl:getSpecialDesc(itemTpl)
    else
      self.bind.txt_longDesc = ""
    end
  end
  self.bind.rect_longDesc = C_Vector2(0, 0)
  self:initSelectNum()
end

function this:restBtnState()
  self.bind.active_startBtn_New = true
  self.bind.active_trans_canNotStart = false
end

function this:initSelectNum()
  if self.UIData.productId == nil or self.UIData.productId <= 0 then
    return
  end
  local tpl = _productsTpl:getTplById(self.UIData.productId)
  local limit = _productsTpl:getNumberLimit(tpl)
  local isComplete = L_ConditionManager:isComplete(_productsTpl:getUnlockCondition(tpl))
  self.bind.active_moduleNum = 1 < limit and isComplete
  if self.UIData.selectNum and self.UIData.lastProductId == self.UIData.productId then
    self.UIData.selectNum = limit and math.min(limit, self.UIData.selectNum) or self.UIData.selectNum
  elseif math.isEmpty(self.UIData.parentId) then
    self.UIData.selectNum = 1
  else
    local rewardList = _productsTpl:getRewardId(tpl)
    local data = L_DataUtil.parseRewardConfigItem(rewardList[1])
    local isSame = data.itemId == self.UIData.jumpId
    self.bind.active_longNum = isSame
    if isSame then
      local parentTpl = _productsTpl:getTplById(self.UIData.parentId)
      local parentFixedMaterialList = _productsTpl:getMaterial(parentTpl)
      local haveNum, parentData
      for i, v in ipairs(parentFixedMaterialList) do
        parentData = L_DataUtil.parseRewardConfigItem(v)
        if parentData.itemId == data.itemId then
          break
        end
      end
      if parentData ~= nil then
        haveNum = L_ItemTplManager:getItemNum(parentData.itemType, parentData.itemId)
        self.UIData.selectNum = haveNum < parentData.itemNum and parentData.itemNum - haveNum or 1
        self.needNum = parentData.itemNum
      else
        self.UIData.selectNum = 1
      end
    end
  end
  self:refreshCostInfo()
  if self.bind.active_moduleNum then
    local maxCanDo = self:getMaxCanDo()
    local max = math.min(maxCanDo, limit)
    if self.UIData.lastProductId == self.UIData.productId and self.UIData.lastNumMax == max then
      return
    end
    local isHadMax, canProductMaxNum = L_ProductManager:getIsExistMaxProductLimitById(self.UIData.productId)
    max = not isHadMax or max < canProductMaxNum and max or 0 < canProductMaxNum and canProductMaxNum or 1
    self.UIData.lastProductId = self.UIData.productId
    self.UIData.lastNumMax = max
    
    local function func(num)
      self.UIData.selectNum = num
      self:refreshCostInfo()
    end
    
    if self.isPc then
      self.modules.module_num:initModule(func, math.max(1, max), 1, self.UIData.selectNum)
    else
      self.modules.module_numMobile:initModule(func, math.max(1, max), 1, self.UIData.selectNum)
    end
  end
  self:setNeedNumBySelect()
end

function this:refreshCostInfo()
  local protectProcessProductTime = L_GameConstTpl:getData("HOME_PROCESS_PRODUCT_TIME", L_Const.GameTplType.int)
  local onceNormalTime = L_ProductManager:getFastProduceOnceTime(self.UIData.productId)
  if protectProcessProductTime > onceNormalTime then
    onceNormalTime = protectProcessProductTime
  end
  local allCostNormalTime = math.ceil(onceNormalTime * self.UIData.selectNum)
  if self.UIData.buildingGuid == 0 then
    self.bind.txt_time = string.format("%s", L_TimeUtil.secondToLangString(allCostNormalTime))
    self:setSelectNum(self.UIData.selectNum)
  else
    self:setSelectNum(self.UIData.selectNum)
    local onceTime
    if not math.isEmpty(self.UIData.previewPetGuid) then
      onceTime = L_ProductManager:getProduceOnceTimeWithPetGuid(self.UIData.buildingGuid, self.UIData.productId, self.UIData.isProduct, self.UIData.previewPetGuid)
    else
      onceTime = L_ProductManager:getProduceOnceTime(self.UIData.buildingGuid, self.UIData.productId, self.UIData.isProduct)
    end
    if protectProcessProductTime > onceTime then
      onceTime = protectProcessProductTime
    end
    local allCostTime = math.ceil(onceTime * self.UIData.selectNum)
    if onceTime == onceNormalTime then
      self.bind.txt_time = string.format("%s", L_TimeUtil.secondToLangString(allCostNormalTime))
      self.bind.preview_txt_time = " "
    else
      self.bind.preview_txt_time = string.format("%s", L_TimeUtil.secondToLangString(allCostTime))
      self.bind.txt_time = string.format("<#afafaf><s><size=14>%s</size></s></color>", L_TimeUtil.secondToLangString(math.floor(allCostNormalTime)))
    end
    self:setNeedNumBySelect()
  end
end

function this:setNeedNumBySelect()
  if self.UIData.parentId == nil then
    return
  end
  local tpl = _productsTpl:getTplById(self.UIData.productId)
  local rewardList = _productsTpl:getRewardId(tpl)
  local reward = L_DataUtil.parseRewardConfigItem(rewardList[1])
  local haveNum = L_ItemTplManager:getItemNum(L_Const.resType.commonItem, reward.itemId)
  if reward.itemType == L_Const.resType.commonItem then
    local allNum = self.needNum
    if self.needNum == nil then
      return
    end
    if haveNum < allNum then
      self.bind.txt_longNum = L_WordsTpl:getValue("residual_code_moduleproductinfodesc_normal_01") .. haveNum .. "</color>/" .. allNum
    else
      self.bind.txt_longNum = L_WordsTpl:getValue("residual_code_moduleproductinfodesc_normal_02") .. haveNum .. "</color>/" .. allNum
    end
  end
end

function this:getMaxCanDo()
  return self.UIData.moduleProductInfo:getNormalProductMaxCanDo()
end

function this:setSelectNum(selectNum)
  self.UIData.moduleProductInfo:setNormalProductSelectNum(selectNum)
end

function this:showSelf()
end

function this:hideSelf()
end

function this:getProductId()
  return self.UIData.productId
end

function this:getSelectNum()
  return self.UIData.selectNum
end

function this:setSelectNumGamepadShortCutEnable(bEnable)
  if self.isPc then
    self.modules.module_num:setGamepadShortCutEnable(bEnable)
  end
end

return this

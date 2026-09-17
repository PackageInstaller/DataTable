local this = class("cellProduceTarget", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _taskTpl = L_GameTpl:getTaskTpl()
local _taskTypeTpl = L_GameTpl:getTaskTypeTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()

function this.bind()
  return {
    emptyActive = true,
    contentActive = false,
    commonIcon = nil,
    commonIconActive = true,
    buildingIcon = nil,
    buildingIconActive = false,
    starList = {},
    itemName = "",
    itemNameActive = true,
    selectIconActive = false,
    lockIconActive = false,
    petNeededIconActive = false,
    iconBg = nil,
    limitCountActive = false,
    limitText = "",
    unlockText = "",
    icon_foodType = "",
    active_iconHasGet = false,
    active_iconHasWish = false,
    text_hasGet = "",
    active_taskNode = false,
    img_taskType = nil,
    img_journeyTarget = "",
    active_journeyTarget = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind, self.bindComponents)
      self:emit("onClick_selectId", self.bind.id, self.bind.isFood)
      if self._callback then
        self._callback()
      end
    end
  }
end

function this:open()
  if self.bind.emptyActive == false then
    return
  end
  if self.bindComponents.cellAnimation then
    self.bindComponents.cellAnimation:Play("anim_productTarget_show")
  end
  L_MountStore:listenCallFunc(L_MountStore.event.syncMountSaddleData, self.OnSyncMountSaddleData, self)
end

function this:close()
  L_MountStore:unListenCallFunc(L_MountStore.event.syncMountSaddleData, self.OnSyncMountSaddleData, self)
end

function this:refresh()
  if not self.isBind then
    return
  end
  self.iconBg = "UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_none"
  self.limitCountActive = false
  self.active_iconHasGet = false
  self.active_iconHasWish = false
  self.itemNameActive = false
  self.icon_foodType = ""
  if self.bind.isFood then
    self.bind.contentActive = true
    self.bind.emptyActive = false
    local tpl = _foodGroupTpl:getTplById(self.bind.id)
    self.bind.commonIcon = _foodGroupTpl:getIcon(tpl)
    self.icon_foodType = _foodGroupTpl:getFoodType(tpl) ~= 0 and string.format("UI/Atlas/FoodType/tex_icon_foodtype_tag_0%s.png", _foodGroupTpl:getFoodType(tpl)) or nil
    self.itemNameActive = true
    local foodGroupId = self.bind.id
    local foodGroupTpl = _foodGroupTpl:getTplById(foodGroupId)
    self.bind.itemName = _foodGroupTpl:getName(foodGroupTpl)
    local foodId = _productsMultiQualityTpl:getItemIdListByFoodGroupId(foodGroupId)[1]
    local commonItemTpl = _commonItemTpl:getTplById(foodId)
    local foodQuality = _commonItemTpl:getRarity(commonItemTpl)
    self.iconBg = string.format("UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_%s.png", foodQuality or 0)
    self:setStars(L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, foodId))
    self:UpdateRedDotShowState()
  elseif self.bind.itemData then
    self.bind.contentActive = true
    self.bind.emptyActive = true
    self.bind.commonIconActive = self.bind.itemData.itemType ~= L_Const.resType.homeBuilding
    self.bind.buildingIconActive = self.bind.itemData.itemType == L_Const.resType.homeBuilding
    local conf = L_ItemTplManager:getItemConfig(self.bind.itemData.itemType, self.bind.itemData.itemId)
    if self.bind.itemData.itemType == L_Const.resType.homeBuilding then
      self:refreshCellOfHomeBuildingType(conf)
    elseif self.bind.itemData.itemType == L_Const.resType.mountSaddle then
      self:refreshCellOfMountSaddleType(conf)
    else
      self:refreshCellOfCommon(conf)
    end
    self:UpdateRedDotShowState()
  else
    self.bind.contentActive = false
    self.bind.emptyActive = true
  end
  if self.bind.playCellRefreshAnim and self.bindComponents.anim then
    self.bindComponents.anim:Play("anim_productTarget_show")
    self.bind.playCellRefreshAnim = false
  end
  if self.bind.iconBg ~= self.iconBg then
    self.bind.iconBg = self.iconBg
  end
  if self.bind.limitCountActive ~= self.limitCountActive then
    self.bind.limitCountActive = not self.bind.isLock and self.limitCountActive
  end
  if self.bind.active_iconHasGet ~= self.active_iconHasGet then
    self.bind.active_iconHasGet = self.active_iconHasGet
  end
  if self.bind.itemNameActive ~= self.itemNameActive then
    self.bind.itemNameActive = self.itemNameActive
  end
  if self.bind.icon_foodType ~= self.icon_foodType then
    self.bind.icon_foodType = self.icon_foodType
  end
  self:setGrayEffect(self.bind.isGray and not self.bind.isLock)
  self.bind.lockIconActive = self.bind.isLock
  self.bind.unlockText = ""
  self.bind.active_iconHasWish = self:isHasWish() and not self.active_iconHasGet
end

function this:isHasWish()
  local productId = self.bind.productId
  if productId then
    return AzurWorld.HomeMgr.WishModule:GetProductCount(productId) > 0
  end
  local productIdList = self.bind.productIdList
  if productIdList then
    local wishModule = AzurWorld.HomeMgr.WishModule
    for _, _productId in ipairs(productIdList) do
      if wishModule:GetProductCount(_productId) > 0 then
        return true
      end
    end
  end
  return false
end

function this:onEvent_refreshBag()
  if self.bind and self.bind.id then
    self:checkRefreshGray()
  end
end

function this:OnSyncMountSaddleData()
  if self.bind and self.bind.id and (self.bind.itemData or {}).itemType == L_Const.resType.mountSaddle then
    self:checkRefreshGray()
  end
end

function this:checkRefreshGray()
  local isGray = L_ProductManager:GetProductGrayState(self.bind.id)
  if self.bind.isGray ~= isGray then
    if self.parent and self.parent.onChildDirty then
      self.parent:onChildDirty()
    else
      self.bind.isGray = isGray
      self:setGrayEffect(isGray and not self.bind.isLock)
      self.bind.lockIconActive = self.bind.isLock
    end
  end
end

function this:setGrayEffect(isGray)
  if isGray then
    local color = C_Color(0.5058823529411764, 0.5686274509803921, 0.6235294117647059, 0.6)
    if self.bindComponents.buildingIcon then
      self.bindComponents.buildingIcon.color = color
    end
    if self.bindComponents.commonIcon then
      self.bindComponents.commonIcon.color = color
    end
  else
    if self.bindComponents.buildingIcon then
      self.bindComponents.buildingIcon.color = C_Color(1, 1, 1, 0.85)
    end
    if self.bindComponents.commonIcon then
      self.bindComponents.commonIcon.color = C_Color(1, 1, 1, 0.75)
    end
  end
end

function this:refreshCellOfHomeBuildingType(conf)
  self.bind.buildingIcon = conf.icon
  local tpl_building = _homeBuildingTpl:getTplById(self.bind.itemData.itemId)
  local groupId = _homeBuildingTpl:getGroupId(tpl_building)
  local limitCnt = L_HomeStore:getBuildingLimitCount(groupId)
  local count = L_HomeStore:getCurNumByBuildingGroupId(groupId)
  if limitCnt == nil then
    self.limitCountActive = false
    self.itemNameActive = true
  else
    self.limitCountActive = not self.bind.isLock
    self.itemNameActive = true
    self.bind.limitText = string.format("%d/%d", count, limitCnt)
  end
  self:setStars(0)
end

function this:refreshCellOfMountSaddleType(conf)
  self:refreshCellOfCommon(conf)
  local isHas = AzurWorld.mountMgr:GetIdMountSaddleUnlock(self.bind.itemData.itemId) == true
  self.active_iconHasGet = isHas
  self.bind.limitCountActive = not self.bind.isLock
  self.bind.limitText = string.format("%d/%d", isHas and 1 or 0, 1)
  self.itemNameActive = true
end

function this:refreshCellOfCommon(conf)
  self.itemNameActive = true
  self.bind.commonIcon = conf.icon
  self.iconBg = string.format("UI/Atlas/HomeProductBuilding/tex_homebuilding_bg_raritysqrtd_%s.png", conf.quality or 0)
  self:setStars(L_ItemTplManager:getItemShowStarNum(self.bind.itemData.itemType, self.bind.itemData.itemId))
end

function this:setStars(num)
  if not self.isBind then
    return
  end
  local stars = {}
  for i = 1, num do
    table.insert(stars, {})
  end
  self.bind.starList:clear()
  self.bind.starList:insert_array(stars)
end

function this:checkNeedShowTraceTaskNodeByTraceProductId(traceProductId)
  if self.bind.productId then
    if self.bind.productId == traceProductId then
      return true
    end
  elseif self.bind.productIdList then
    for _, productId in ipairs(self.bind.productIdList) do
      if productId == traceProductId then
        return true
      end
    end
  end
  return false
end

function this:refreshTraceTaskNode(traceTaskId)
  if traceTaskId ~= nil then
    self.bind.active_taskNode = true
    local taskTpl = _taskTpl:getTplById(traceTaskId)
    local tabType = _taskTpl:getTabType(taskTpl)
    local taskTypeTpl = _taskTypeTpl:getTplById(tabType)
    self.bind.img_taskType = _taskTypeTpl:getMapIcon(taskTypeTpl)
    if self.isBind then
      self.bindComponents.reddotNew.gameObject:SetActive(false)
    end
  else
    self.bind.active_taskNode = false
  end
end

function this:hideTraceTaskNode()
  self.bind.active_taskNode = false
end

function this:setSelectIconActive(isActive)
  if self.bind.selectIconActive ~= isActive then
    self.bind.selectIconActive = isActive
  end
end

function this:SetReadNewReddot()
  local dirty = false
  if not self.bind.isFood and self.bind.productId then
    if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, self.bind.productId) then
      L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, self.bind.productId)
      dirty = true
    end
  elseif self.bind.isFood and self.bind.id then
    local foodKey = string.format("foodGroup_%d", self.bind.id)
    if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, foodKey) then
      L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, foodKey)
      dirty = true
    end
  end
  if dirty then
    self:UpdateRedDotShowState()
  end
end

function this:UpdateRedDotShowState()
  if not self.bindComponents or not self.isBind then
    return
  end
  if self.bind.isFood then
    local foodKey = string.format("foodGroup_%d", self.bind.id)
    self.bindComponents.reddotNew.gameObject:SetActive(not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, foodKey) and not self.bind.active_taskNode)
  elseif self.bind.itemData then
    self.bindComponents.reddotNew.gameObject:SetActive(not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, self.bind.productId) and not self.bind.active_taskNode)
  end
end

function this:getId()
  return self.bind.id
end

return this

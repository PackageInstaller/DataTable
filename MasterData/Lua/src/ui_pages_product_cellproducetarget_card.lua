local this = class("cellProduceTarget_card", G_UIModuleBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _taskTpl = L_GameTpl:getTaskTpl()
local _taskTypeTpl = L_GameTpl:getTaskTypeTpl()
local _productsMultiQualityTpl = L_GameTpl:getProductsMultiQualityTpl()
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local descImgColorMap = {
  [0] = "#b8b5acb2",
  [1] = "#5bc493b2",
  [2] = "#78a8d3b2",
  [3] = "#8886c3b2",
  [4] = "#e9b549b2"
}

function this.bind()
  return {
    emptyActive = true,
    contentActive = false,
    color_descImg = nil,
    img_icon = "",
    starList = {},
    itemName = "",
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
    color_taskTypeImg = nil,
    active_unproducibleMask = false,
    img_journeyTarget = false,
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
  self.onEvent_refreshBagHandle = handler(self, self.onEvent_refreshBag)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.onEvent_refreshBagHandle)
end

function this:close()
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.onEvent_refreshBagHandle)
end

function this:refresh()
  self.quality = 0
  self.bind.limitCountActive = false
  self.bind.active_iconHasGet = false
  self.bind.active_iconHasWish = false
  if self.bind.isFood then
    self.bind.contentActive = true
    self.bind.emptyActive = false
    local tpl = _foodGroupTpl:getTplById(self.bind.id)
    self.bind.img_icon = _foodGroupTpl:getIcon(tpl)
    self.bind.icon_foodType = _foodGroupTpl:getFoodType(tpl) ~= 0 and string.format("UI/Atlas/FoodType/tex_icon_foodtype_tag_0%s.png", _foodGroupTpl:getFoodType(tpl)) or nil
    local foodGroupId = self.bind.id
    local foodGroupTpl = _foodGroupTpl:getTplById(foodGroupId)
    self.bind.itemName = _foodGroupTpl:getName(foodGroupTpl)
    local foodId = _productsMultiQualityTpl:getItemIdListByFoodGroupId(foodGroupId)[1]
    local commonItemTpl = _commonItemTpl:getTplById(foodId)
    local foodQuality = _commonItemTpl:getRarity(commonItemTpl)
    self.quality = foodQuality or 0
    self:setStars(L_ItemTplManager:getItemShowStarNum(L_Const.resType.commonItem, foodId))
    local foodKey = string.format("foodGroup_%d", self.bind.id)
    self.bindComponents.reddotNew.gameObject:SetActive(not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, foodKey) and not self.bind.active_taskNode)
  elseif self.bind.itemData then
    self.bind.contentActive = true
    self.bind.emptyActive = true
    self.bind.commonIconActive = self.bind.itemData.itemType ~= L_Const.resType.homeBuilding
    self.bind.buildingIconActive = self.bind.itemData.itemType == L_Const.resType.homeBuilding
    local conf = L_ItemTplManager:getItemConfig(self.bind.itemData.itemType, self.bind.itemData.itemId)
    local pattern1 = string.match(conf.name, " %a+.%d+")
    local pattern2 = string.match(conf.name, "%a+.%d+")
    if pattern1 then
      self.bind.itemName = string.gsub(conf.name, pattern1, "")
    elseif pattern2 then
      self.bind.itemName = string.gsub(conf.name, pattern2, "")
    else
      self.bind.itemName = conf.name
    end
    if self.bind.itemData.itemType == L_Const.resType.homeBuilding then
      self:refreshCellOfHomeBuildingType(conf)
    elseif self.bind.itemData.itemType == L_Const.resType.mountSaddle then
      self:refresCellOfMounSaddleType(conf)
    else
      self:refreshCellOfCommon(conf)
    end
    self.bindComponents.reddotNew.gameObject:SetActive(not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, self.bind.productId) and not self.bind.active_taskNode)
  else
    self.bind.contentActive = false
    self.bind.emptyActive = true
  end
  self:setGrayEffect(self.bind.isGray and not self.bind.isLock)
  self.bind.lockIconActive = self.bind.isLock
  self.bind.iconBg = string.format("UI/Atlas/BSCommon/tex_homecommontip_bg_quality_%s.png", self.quality)
  local _, color = C_ColorUtility.TryParseHtmlString(descImgColorMap[self.quality])
  self.bind.color_descImg = color
  self.bind.active_iconHasWish = self:isHasWish()
  if self.bind.playCellRefreshAnim and self.bindComponents.anim then
    self.bindComponents.anim:Play("anim_productTarget_show")
    self.bind.playCellRefreshAnim = false
  end
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
    local isGray = L_ProductManager:GetProductGrayState(self.bind.id)
    if self.bind.isGray ~= isGray then
      if self.parent and self.parent.onChildDirty then
        self.parent:onChildDirty()
      else
        self.bind.isGray = isGray
        self:setGrayEffect(self.bind.isGray and not self.bind.isLock)
        self.bind.lockIconActive = self.bind.isLock
      end
    end
  end
end

function this:setGrayEffect(isGray)
  if isGray then
    self.bind.active_unproducibleMask = true
    self.bindComponents.img_icon.color = C_Color(0.5058823529411764, 0.5686274509803921, 0.6235294117647059, 0.6)
  else
    self.bind.active_unproducibleMask = false
    self.bindComponents.img_icon.color = C_Color(1, 1, 1, 1)
  end
end

function this:refreshCellOfHomeBuildingType(conf)
  self.bind.img_icon = conf.icon
  local tpl_building = _homeBuildingTpl:getTplById(self.bind.itemData.itemId)
  local groupId = _homeBuildingTpl:getGroupId(tpl_building)
  local limitCnt = L_HomeStore:getBuildingLimitCount(groupId)
  local count = L_HomeStore:getCurNumByBuildingGroupId(groupId)
  if limitCnt == nil then
    self.bind.limitCountActive = false
  else
    self.bind.limitCountActive = not self.bind.isLock
    self.bind.limitText = string.format("%d/%d", count, limitCnt)
  end
end

function this:refresCellOfMounSaddleType(conf)
  self:refreshCellOfCommon(conf)
  local isHas = AzurWorld.mountMgr:GetIdMountSaddleUnlock(self.bind.itemData.itemId) == true
  self.bind.active_iconHasGet = isHas
  self.bind.limitCountActive = not self.bind.isLock
  self.bind.limitText = string.format("%d/%d", isHas and 1 or 0, 1)
end

function this:refreshCellOfCommon(conf)
  self.bind.img_icon = conf.icon
  self.quality = conf.quality or 0
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
  else
    self.bind.active_taskNode = false
  end
end

function this:hideTraceTaskNode()
  self.bind.active_taskNode = false
end

return this

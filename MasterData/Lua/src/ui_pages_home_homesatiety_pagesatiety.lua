local this = class("pageSatiety", G_UIPageBase)
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local foodTpl = L_GameTpl:getFoodTpl()
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle

function this.bind()
  return {
    bagCloseMaskActive = false,
    selectCloseMaskActive = false,
    selectNodeActive = false,
    upgradeBtnActive = true,
    maxNodeAcitve = false,
    levelNodeActive = true,
    arrowAcitve = false,
    buildingNameText = "",
    buildingLevelText = "",
    active_canUpgrade = false,
    bagList = {
      moduleName = "modulePages/cellIconItemSatiety"
    },
    leftItemList = {
      moduleName = "pages/home/homeSatiety/cellSatietyItem"
    },
    moduleSelect = {
      moduleName = "modulePages/moduleSelectNum"
    },
    dotList = {
      moduleName = "pages/home/homeSatiety/cellSatietyDot"
    },
    active_showDot = true,
    satietyImageFill = 0,
    currentSatiety = "",
    totalSatiety = "",
    numSelectPos = C_Vector2.zero,
    arrowPos = C_Vector2.zero,
    active_rightBtn = false,
    active_leftBtn = false
  }
end

function this.methods()
  return {
    onClick_closeBtn = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_selectNodeCloseMask = function(self)
      self:setSelectNodeActive(false)
    end,
    onClick_rightBtn = function(self)
      self:dealPageIndexChange(true)
      self:refreshPageTurning()
    end,
    onClick_leftBtn = function(self)
      self:dealPageIndexChange()
      self:refreshPageTurning()
    end,
    onClick_autoBtn = function(self)
      self:dealAuto()
    end,
    onClick_checkBtn = function(self)
      self:dealCheckBtn()
    end,
    onClick_upgrade = function(self)
      if self.isBuildingMax then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_manage_13"))
        return
      end
      L_UI:open("pageBuildingUpgrade", {
        keepCamera = true,
        guid = self.buildingGuid
      })
    end,
    leftItemList = {
      onClick_item = function(self, itemData)
        self:minusFoodAllByItem(itemData)
      end,
      onClick_minus = function(self, itemData)
        self:minusFoodAllByItem(itemData)
      end
    },
    bagList = {
      onClick_item = function(self, item)
        local currentSatiety, maxSatiety = L_SatietyManager:getBuildingSatiety(self.buildingGuid)
        if maxSatiety <= currentSatiety then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_building_foodenough"))
          return
        end
        local maxCanUse = L_SatietyManager:getMaxFoodCanUse(self.buildingGuid, item.bind.itemId)
        if maxCanUse == 0 then
          L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_building_foodenough"))
          return
        end
        self.selectItemId = item.bind.itemId
        self.operationType = L_Const.satietyOperationType.add
        self.selectNum = maxCanUse
        self:refreshBagListSelectState()
        self:dealCheckBtn()
      end
    }
  }
end

function this:preOpen(options)
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshBuild, self)
  self.refreshBagListHandle = handler(self, self.refreshBagList)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self.refreshBagListHandle)
  L_HomeStore:listenCallFunc(L_HomeStore.event.refreshPetEatFinishList, self.refreshPetEatFinishList, self)
  self.buildingGuid = options.buildingGuid
  C_HomeUtil.FocusBuild(self.buildingGuid, L_HomeConst.FocusType.CENTER)
  self.foodPageIndex = 1
  self:initPage()
  self:refreshBagList()
end

function this:open()
  C_BattleUIManager.SetUIRoot(false)
  if self.bindComponents.anim then
    self.bindComponents.anim:Play("anim_pagesatiety_loop")
  end
end

function this:close()
  C_BattleUIManager.SetUIRoot(true)
  C_HomeUtil.FocusBuild(0, L_HomeConst.FocusType.CENTER)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshBuild)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self.refreshBagListHandle)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.refreshPetEatFinishList, self.refreshPetEatFinishList, self)
end

function this:dealAuto()
  local currentSatiety, maxSatiety = L_SatietyManager:getBuildingSatiety(self.buildingGuid)
  if maxSatiety <= currentSatiety then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_building_foodenough"))
    return
  end
  local data = L_SatietyManager:getFoodList()
  local items = {}
  for _, food in ipairs(data) do
    local fTpl = foodTpl:getTplById(food.itemId)
    if fTpl then
      local satietyScore = foodTpl:getSatietyScore(fTpl)
      local needNum = math.floor((maxSatiety - currentSatiety) / satietyScore)
      local addNum = math.min(needNum, food.itemNum)
      if 0 < addNum then
        table.insert(items, {
          itemtype = L_Const.resType.commonItem,
          itemid = food.itemId,
          itemnum = addNum
        })
      end
      currentSatiety = currentSatiety + satietyScore * addNum
    end
  end
  if 0 < #items then
    self.operationType = L_Const.satietyOperationType.add
    self:reqAddFood(items, true)
  end
end

function this:reqAddFood(items, isAuto)
  L_SatietyStore:req_CSProtoAddPetFood(self.operationType, items, self.buildingGuid, function()
    if isAuto then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_home_building_foodputfinish"))
    end
    local isAdd = self.operationType == L_Const.satietyOperationType.add
    L_HomeStore:updateBuildPetCanteenFood(self.buildingGuid, items, isAdd)
    self.changeItem = items[1].itemid
    self.operationType = nil
    self:initPage()
  end)
end

function this:dealPageIndexChange(isAdd)
  if not self.foods then
    return
  end
  if isAdd then
    if self.foodPageIndex >= #self.foods then
      return
    end
    self.foodPageIndex = self.foodPageIndex + 1
  else
    if self.foodPageIndex <= 1 then
      return
    end
    self.foodPageIndex = self.foodPageIndex - 1
  end
  self:setFoodList()
end

function this:dealCheckBtn()
  if self.operationType == nil then
    return
  end
  local item = {
    itemtype = L_Const.resType.commonItem,
    itemid = self.selectItemId,
    itemnum = self.selectNum
  }
  local maxNum = self:getCurBuildMaxNum(self.operationType, self.selectItemId)
  if maxNum < self.selectNum then
    L_FlyMsgManager:showNormalMsgByKey("notice_common_lackItem")
    self.selectNum = 0 < maxNum and maxNum or 1
    return
  end
  self:reqAddFood({item})
end

function this:setSelectNodeActive(isActive)
  self.bind.selectNodeActive = isActive
  self.bind.selectCloseMaskActive = isActive
  self.bind.arrowAcitve = isActive
  for _, v in pairs(self.modules.bagList) do
    local isSelect = self.bind.selectNodeActive and v.bind.itemId == self.selectItemId
    v:changeSelect(isSelect)
  end
end

function this:refreshBagListSelectState()
  for _, v in pairs(self.modules.bagList) do
    local isSelect = v.bind.itemId == self.selectItemId
    v:changeSelect(isSelect)
  end
end

function this:setNumModulePosition(cellRect)
  if not cellRect then
    return
  end
  local worldPosition = cellRect.transform.position
  local screenPos = C_CameraManager.uiCamera:WorldToScreenPoint(worldPosition)
  local _, arrowUiPos = _screenPosToUI(self.bindComponents.board, C_Vector2(screenPos.x, screenPos.y), C_CameraManager.uiCamera)
  arrowUiPos.y = arrowUiPos.y + 30
  local diff = screenPos.x + self.bindComponents.numSelectRect.sizeDelta.x * 0.45 - C_Screen.width
  if 0 < diff then
    screenPos.x = C_Screen.width - self.bindComponents.numSelectRect.sizeDelta.x * 0.45
  end
  local _, uiPos = _screenPosToUI(self.bindComponents.board, C_Vector2(screenPos.x, screenPos.y), C_CameraManager.uiCamera)
  uiPos.y = uiPos.y + 10 + cellRect.sizeDelta.y / 2
  arrowUiPos.y = arrowUiPos.y + 10 + cellRect.sizeDelta.y / 2
  self.bind.numSelectPos = uiPos
  self.bind.arrowPos = arrowUiPos
end

function this:initModuleNum(isRefresh)
  local max = self:getCurBuildMaxNum(self.operationType, self.selectItemId)
  if self.operationType == L_Const.satietyOperationType.minus and max == 0 then
    self:setSelectNodeActive(false)
    return
  end
  local min = 1
  if max < min then
    min = max
  end
  local defaultSelectNum = min
  local selectNum = self.selectNum or 1
  defaultSelectNum = max >= selectNum and selectNum or max
  self.selectNum = defaultSelectNum
  if isRefresh and defaultSelectNum == selectNum then
    return
  end
  
  local function func(num)
    self.selectNum = num
  end
  
  self.modules.moduleSelect:initModule(func, max, min, defaultSelectNum)
end

function this:refreshBuildingInfo()
  if not self.buildingGuid then
    return
  end
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.buildingGuid)
  local tpl = _homeBuildingTpl:getTplById(serverData.build_id)
  local groupId = _homeBuildingTpl:getGroupId(tpl)
  local homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
  local tpl_buildingGroup = homeBuildingGroupTpl:getTplById(groupId)
  self.bind.buildingNameText = homeBuildingGroupTpl:getName(tpl_buildingGroup)
  local isMax = math.isEmpty(_homeBuildingTpl:getNextLevel(tpl))
  local levelStr = string.concat("Lv.", _homeBuildingTpl:getLevel(tpl))
  self.bind.upgradeBtnActive = not isMax
  self.bind.maxNodeAcitve = isMax
  self.bind.levelNodeActive = not isMax
  self.bind.buildingLevelText = levelStr
  self.bind.active_canUpgrade = false
  self.isBuildingMax = isMax
end

function this:refreshBuild()
  self:initPage()
end

function this:initPage()
  self:refreshBuildingInfo()
  self:refreshBuildSatiety()
  self:refreshFoodListData()
  self:refreshPageTurning()
end

function this:refreshBuildSatiety()
  local currentSatiety, maxSatiety = L_SatietyManager:getBuildingSatiety(self.buildingGuid)
  local icon, color
  if currentSatiety / maxSatiety <= 0.2 then
    icon = string.format("Atlas/Satiety/tex_homecanteen_dec_guo0%d.png", 3)
    color = L_Const.colorHtml.red001
  elseif currentSatiety / maxSatiety <= 0.5 then
    icon = string.format("Atlas/Satiety/tex_homecanteen_dec_guo0%d.png", 2)
    color = L_Const.colorHtml.yellow017
  else
    icon = string.format("Atlas/Satiety/tex_homecanteen_dec_guo0%d.png", 1)
    color = L_Const.colorHtml.green002
  end
  self.bind.currentSatiety = L_GameUtil.fillColor(tostring(currentSatiety), color)
  self.bind.totalSatiety = string.format("/%d", maxSatiety)
  self.bind.satietyImageFill = currentSatiety / maxSatiety
end

function this:refreshBagList()
  local data = L_SatietyManager:getFoodList()
  local bagMax = 10
  for i = 1, bagMax - #data do
    table.insert(data, {empty = true})
  end
  self.bind.bagList:clear()
  self.bind.bagList:insert_array(data)
  if #data == 0 then
    self.bind.bagCloseMaskActive = false
  end
end

function this:refreshFoodListData()
  local serverData = L_HomeStore:getHomeBuildingByGuid(self.buildingGuid)
  self.foods = {}
  local foods = {}
  if serverData and serverData.pet_canteen and serverData.pet_canteen.foods then
    for _, food in pairs(serverData.pet_canteen.foods) do
      table.insert(foods, {
        itemid = food.itemid,
        itemnum = food.itemnum,
        itemtype = food.itemtype,
        guid = food.guid
      })
    end
    table.sort(foods, function(a, b)
      local aTpl, bTpl = foodTpl:getTplById(a.itemid), foodTpl:getTplById(b.itemid)
      if foodTpl:getSatietyScore(aTpl) == foodTpl:getSatietyScore(bTpl) then
        return a.itemid < b.itemid
      end
      return foodTpl:getSatietyScore(aTpl) < foodTpl:getSatietyScore(bTpl)
    end)
    self.foods = self:splitFoods(foods)
    if self.changeItem then
      self.foodPageIndex = self:findSelectedFoodPage(self.foods, self.changeItem)
    end
  end
  self:setFoodList()
end

function this:findSelectedFoodPage(foods, selectItemId)
  for i, group in ipairs(foods) do
    for _, food in pairs(group) do
      if food.itemid == selectItemId then
        return i
      end
    end
  end
  return 1
end

function this:setFoodList()
  local minEmptyDataNum = 6
  if #self.modules.leftItemList ~= minEmptyDataNum then
    self.bind.leftItemList:clear()
    self.bind.leftItemList:insert_array(L_DataUtil.getEmptyModuleDatas(minEmptyDataNum))
  end
  local leftData = {}
  if self.foods and self.foods[self.foodPageIndex] then
    leftData = self.foods[self.foodPageIndex][1] or {}
  end
  for _ = 1, minEmptyDataNum - #leftData do
    table.insert(leftData, {})
  end
  for i, module in ipairs(self.modules.leftItemList) do
    module:refreshByItem(leftData[i], leftData[i].itemid == self.selectItemId)
  end
  self:refreshPageTurning()
end

function this:splitFoods(foods)
  local subListSize = 6
  local topListSubLists = 1
  
  local function splitList(list, subListSize, topListSubLists)
    local result = {}
    local sublistGroupIndex = 1
    local currentSublistGroup = {}
    local currentSubList = {}
    local subListCount = 0
    local subListElementCount = 0
    for _, value in ipairs(list) do
      currentSubList[#currentSubList + 1] = value
      subListElementCount = subListElementCount + 1
      if subListElementCount == subListSize then
        currentSublistGroup[#currentSublistGroup + 1] = currentSubList
        currentSubList = {}
        subListElementCount = 0
        subListCount = subListCount + 1
        if subListCount == topListSubLists then
          result[sublistGroupIndex] = currentSublistGroup
          currentSublistGroup = {}
          subListCount = 0
          sublistGroupIndex = sublistGroupIndex + 1
        end
      end
    end
    if 0 < #currentSubList then
      currentSublistGroup[#currentSublistGroup + 1] = currentSubList
    end
    if 0 < #currentSublistGroup then
      result[sublistGroupIndex] = currentSublistGroup
    end
    return result
  end
  
  local chunks = splitList(foods, subListSize, topListSubLists)
  return chunks
end

function this:refreshPetEatFinishList(eventData)
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.petEatFinishMsg, eventData)
end

function this:getCurBuildMaxNum(operationType, itemId)
  if itemId == nil then
    return 0
  end
  local maxNum = 0
  if operationType == L_Const.satietyOperationType.add then
    maxNum = L_SatietyManager:getMaxFoodCanUse(self.buildingGuid, itemId)
  elseif operationType == L_Const.satietyOperationType.minus then
    maxNum = L_SatietyManager:getMaxFoodCanDelete(self.buildingGuid, itemId)
  end
  return maxNum
end

function this:minusFoodAllByItem(itemData)
  self.selectItemId = itemData.itemid
  self.selectNum = itemData.itemnum
  self.operationType = L_Const.satietyOperationType.minus
  local item = {
    itemtype = L_Const.resType.commonItem,
    itemid = self.selectItemId,
    itemnum = self.selectNum
  }
  local maxNum = self:getCurBuildMaxNum(self.operationType, self.selectItemId)
  if maxNum < self.selectNum then
    L_FlyMsgManager:showNormalMsgByKey("notice_common_lackItem")
    self.selectNum = 0 < maxNum and maxNum or 1
    return
  end
  self:reqAddFood({item})
end

function this:refreshPageTurning()
  if not self.foods then
    return
  end
  if not self.foods[self.foodPageIndex] then
    return
  end
  if #self.foods >= 2 then
    if self.foodPageIndex <= 1 then
      self.bind.active_rightBtn = true
      self.bind.active_leftBtn = false
    elseif self.foodPageIndex >= #self.foods then
      self.bind.active_leftBtn = true
      self.bind.active_rightBtn = false
    else
      self.bind.active_rightBtn = true
      self.bind.active_leftBtn = true
    end
    self.bind.active_showDot = true
  else
    self.bind.active_rightBtn = false
    self.bind.active_leftBtn = false
    self.bind.active_showDot = false
  end
  local dotData = {}
  for i = 1, #self.foods do
    table.insert(dotData, {itemIndex = i})
  end
  self.bind.dotList:clear()
  self.bind.dotList:insert_array(dotData)
  for i, v in pairs(self.modules.dotList) do
    v:refreshIsWhiteDot(self.foodPageIndex == v:getItemIndex())
  end
end

return this

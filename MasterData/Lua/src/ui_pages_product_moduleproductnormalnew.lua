local this = class("moduleProductNormalNew", G_UIModuleBase)
local _ProductsTpl = L_GameTpl:getProductsTpl()
local _HomeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _HomeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
local _HomeBuildingProductTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _taskConditionTpl = L_GameTpl:getTaskConditionTpl()
local csHomeStore = L_HomeStore:getCsHomeStore()
local columnNum = 5
local columnNum_card = 2
local minLineNum = 5
local REFRESH_INTERVAL = 0.5
local REFRESH_INTERVAL_FIRST = 2
local REFRESH_INTERVAL_DEFAULT = 0.5
local SelectIconActiveParamTable = {}

function this.bind()
  return {
    module_commonTab = {
      moduleName = "modulePages/tabList/modulePageProductTabList"
    },
    active_tab = false,
    formulaList_normal = {
      moduleName = "pages/product/cellProduceTarget"
    },
    active_formulaList_normal = false,
    formulaList_card = {
      moduleName = "pages/product/cellProduceTarget_card"
    },
    active_formulaList_card = false,
    formulaList_egg = {
      moduleName = "Pages/Pet/cellPetEggItem"
    },
    active_formulaList_egg = false,
    active_smelting = false,
    active_focusRect = false
  }
end

function this.methods()
  return {
    formulaList_normal = {
      onClick_select = function(self, bind, bindComponents)
        if not bind.isFood then
          if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, bind.productId) then
            L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, bind.productId)
            if bindComponents then
              bindComponents.reddotNew.gameObject:SetActive(false)
            end
          end
        else
          local foodKey = string.format("foodGroup_%d", bind.id)
          if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, foodKey) then
            L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, foodKey)
            if bindComponents then
              bindComponents.reddotNew.gameObject:SetActive(false)
            end
          end
        end
      end,
      onClick_selectId = function(self, id)
        self:onSelectTarget(id, self.bind.formulaList_normal, L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickItem)
      end
    },
    formulaList_card = {
      onClick_select = function(self, bind, bindComponents)
        if not bind.isFood then
          if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, bind.productId) then
            L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, bind.productId)
            if bindComponents then
              bindComponents.reddotNew.gameObject:SetActive(false)
            end
          end
        else
          local foodKey = string.format("foodGroup_%d", bind.id)
          if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.productionNew, foodKey) then
            L_ReddotManager:markNew(L_ReddotManager.DotDef.productionNew, foodKey)
            if bindComponents then
              bindComponents.reddotNew.gameObject:SetActive(false)
            end
          end
        end
      end,
      onClick_selectId = function(self, id)
        self:onSelectTarget(id, self.bind.formulaList_card, L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickItem)
      end
    },
    formulaList_egg = {
      onClick_selectId = function(self, id)
        self:onSelectEgg(id, self.modules.formulaList_egg, L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickItem)
      end
    },
    onClick_smelting = function()
      L_UI:open("pageAccessorySmelting")
    end
  }
end

function this:open()
  self._refreshThrottlePending = false
  
  function self._refreshView()
    self:requestRefreshList()
  end
  
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self._refreshView)
  self._refreshTaskHandler = self._refreshTaskHandler or handler(self, self.refreshTraceTaskNode)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  L_ProductStore:listenCallFunc(L_ProductStore.event.productStartCb, self._refreshView, self)
  
  function self.onHomeProductSync()
    if table.containsValue(self.tabs, L_Const.FoodProductConst.recent) then
      self:_refreshView()
    end
  end
  
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeProductSync, self.onHomeProductSync)
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncRefreshWishLists, self._refreshView)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshMaxLimitProductFormulaInfo, self._refreshView, self)
  self._onBagOrAttrChangeHandle = handler(self, self._onBagOrAttrChange)
  C_BagEvent.instance:Listen(C_EBagEvent.BagChange, self._onBagOrAttrChangeHandle)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.refreshAttr, self._onBagOrAttrChangeHandle, self)
end

function this:close()
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self._refreshView)
  if self._refreshTaskHandler then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  end
  L_ProductStore:unListenCallFunc(L_ProductStore.event.productStartCb, self._refreshView, self)
  C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeProductSync, self.onHomeProductSync)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncRefreshWishLists, self._refreshView)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.refreshMaxLimitProductFormulaInfo, self._refreshView, self)
  C_BagEvent.instance:Cancel(C_EBagEvent.BagChange, self._onBagOrAttrChangeHandle)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.refreshAttr, self._onBagOrAttrChangeHandle)
  L_TimerManager:clearTimer(self)
  self._refreshThrottlePending = false
end

function this:initModule(guid, selectId, isJump, isJourneyJump)
  if not guid then
    return
  end
  self._guid = guid
  self._data = L_HomeStore:getHomeBuildingByGuid(guid)
  self._tpl = _HomeBuildingProductTpl:getTplById(self._data.build_id)
  self._type = C_HomeUtil.GetBuildingType(guid)
  self._lestSelectedId = selectId or nil
  self._isJump = isJump or false
  self._isJourneyJump = isJourneyJump or false
  self._needFocusTraceTaskOnRefresh = true
  self._lastTraceSelectedIndex = nil
  self:refreshtraceTaskId2TraceFormulaIdListDic()
  self.objId = _HomeBuildingTpl:getObjId(_HomeBuildingTpl:getTplById(self._data.build_id))
  self.selTabIndex = 1
  self.tabs = self:getTabs()
  self.bind.active_tab = #self.tabs > 0
  if #self.tabs > 0 then
    local tabParam = {
      idList = self.tabs,
      tabType = "product",
      selectId = self.bOwnRecent and self._isJump and 2 or 1,
      callback = function(tabId, index)
        self.selTabIndex = index
        self._selectedId = 0
        local isDiffTab = self._currTabId ~= tabId
        self._currTabId = tabId
        self:refreshList(L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickTab, true, isDiffTab)
      end
    }
    local moduleTab = self.modules.module_commonTab
    moduleTab:setData(tabParam)
    self:refreshTabListTaskTraceNode()
  else
    self:refreshList(nil, true)
  end
  if self._tpl.groupId == L_HomeConst.HomeBuildGroupType.TABLE_SMELTER or self._tpl.groupId == L_HomeConst.HomeBuildGroupType.SHOP_SMELTER or self._tpl.groupId == L_HomeConst.HomeBuildGroupType.MILL_SMELTER then
    self.bind.active_smelting = true
  else
    self.bind.active_smelting = false
  end
  if self._isJump then
    self:setTabIdByProductId(self._lestSelectedId)
  end
  self._isJump = false
end

function this:getTabs()
  local tableTabs = _HomeBuildingProductTpl:getTab(self._tpl)
  local tabs = {}
  if self.objId == 2119 or self.objId == 2039 then
    local productList = csHomeStore:GetRecentProductData(self._guid)
    if productList ~= nil and productList.Count >= 0 then
      self.bOwnRecent = true
      for _, value in ipairs(tableTabs) do
        table.insert(tabs, value)
      end
    else
      self.bOwnRecent = false
      for _, value in ipairs(tableTabs) do
        if value ~= L_Const.FoodProductConst.recent then
          table.insert(tabs, value)
        end
      end
    end
  else
    for key, value in ipairs(tableTabs) do
      table.insert(tabs, value)
    end
    self.bOwnRecent = false
  end
  if self._isJump and table.containsValue(tabs, L_Const.FoodProductConst.all) then
    self._currTabId = L_Const.FoodProductConst.all
  end
  return tabs
end

function this:refreshList(sourceOfPlayModuleProductInfoAnimation, playCellRefreshAnim, forceRefreshListPos)
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleProductNormalNew refreshList")
  if not self._guid then
    return
  end
  self:hideTaskNode()
  if self._type == L_Const.WorldMapBuildType.WMBT_HATCH then
    self.focusList = self.bind.formulaList_egg
    self:showEggList()
    self:setEggProductList(self:getSortPetEggList(), sourceOfPlayModuleProductInfoAnimation)
  else
    self.listType = _HomeBuildingProductTpl:getProductListType(self._tpl)
    if self.listType == 2 then
      self.focusList = self.bind.formulaList_card
      self:showCardList()
    else
      self.focusList = self.bind.formulaList_normal
      self:showNormalList()
    end
    if self._currTabId == 7001 then
      self:setProductList(L_ProductManager:getProductDataListForPageProduct(self._data.build_id, nil), sourceOfPlayModuleProductInfoAnimation, playCellRefreshAnim, forceRefreshListPos)
    else
      self:setProductList(L_ProductManager:getProductDataListForPageProduct(self._data.build_id, self._currTabId), sourceOfPlayModuleProductInfoAnimation, playCellRefreshAnim, forceRefreshListPos)
    end
  end
  if sourceOfPlayModuleProductInfoAnimation == L_HomeConst.SourceOfPlayModuleProductInfoAnimation.OnClickTab and self.parent._navMgr then
    self.parent._navMgr:SetSelectedIndex(0)
  end
  self:refreshProductTaskTraceNode(self._needFocusTraceTaskOnRefresh == true)
  self._needFocusTraceTaskOnRefresh = false
  CS.UnityEngine.Profiling.Profiler.EndSample()
  self._lastRefreshListTime = C_Time.realtimeSinceStartup or C_Time.time or 0
end

function this:showEggList()
  local curEggListValue = self.bind.active_formulaList_egg
  if not curEggListValue then
    self.bind.active_formulaList_egg = true
  end
  self.bind.active_formulaList_card = false
  self.bind.active_formulaList_normal = false
end

function this:showNormalList()
  local curNormalListValue = self.bind.active_formulaList_normal
  if not curNormalListValue then
    self.bind.active_formulaList_normal = true
  end
  self.bind.active_formulaList_egg = false
  self.bind.active_formulaList_card = false
end

function this:showCardList()
  local curCardListValue = self.bind.active_formulaList_card
  if not curCardListValue then
    self.bind.active_formulaList_card = true
  end
  self.bind.active_formulaList_egg = false
  self.bind.active_formulaList_normal = false
end

function this:setTabIdByProductId(targetId)
  local buildProductionTpl = _HomeBuildingProductTpl:getTplById(self._data.build_id)
  local products = _ProductsTpl:getTplsByGroup(_HomeBuildingProductTpl:getGroupId(buildProductionTpl))
  for i, v in pairs(products) do
    local tpl_pro = v
    local rewards = _ProductsTpl:getRewardId(tpl_pro)
    local rewardId
    if rewards ~= nil and rewards[1] ~= nil then
      rewardId = rewards[1][2]
    else
      error("setTabIdByProductId" .. tonumber(tpl_pro.id))
    end
    if rewardId == targetId then
      if tpl_pro.type == 3 then
        local foodTpl = L_GameTpl:getFoodTpl()
        local tpl = foodTpl:getTplById(targetId)
        if tpl then
          local foodType = foodTpl:getFoodType(tpl)
          if foodType == 1 then
            self._currTabId = L_Const.FoodProductConst.satiety
          elseif foodType == 3 then
            self._currTabId = L_Const.FoodProductConst.defend
          elseif foodType == 4 then
            self._currTabId = L_Const.FoodProductConst.attack
          end
          self._targetFoodId = _ProductsTpl:getId(tpl_pro)
          self:refreshList(nil, false)
          self.modules.module_commonTab:setSelect(self._currTabId)
        end
        return
      else
        local tabId = _ProductsTpl:getTabId(tpl_pro)
        self._currTabId = tabId
        self:refreshList(nil, false)
        self.modules.module_commonTab:setSelect(self._currTabId)
      end
      return
    end
  end
end

function this:setProductList(targetProductDatas, sourceOfPlayModuleProductInfoAnimation, playCellRefreshAnim, refreshListPos)
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleProductNormalNew setProductList")
  local datas = targetProductDatas
  local list = self.focusList or self.bind.formulaList_normal
  local gridView = self.listType == 2 and self.bindComponents.produceTargetList_card or self.bindComponents.produceTargetList_normal
  if #datas <= 0 then
    list:clear()
    self:onSelectTarget(0, list, sourceOfPlayModuleProductInfoAnimation)
    return
  end
  local selectedIndex = 0
  if self._isJump then
    self._selectedId = self._lestSelectedId or self._selectedId
    local productRewardMap = _ProductsTpl:getProductRewardMap()
    local proId = -1
    for key, value in pairs(productRewardMap) do
      if value == self._selectedId then
        proId = key
      end
    end
    for i = 1, #datas do
      if datas[i].itemData and datas[i].itemData.itemId == self._lestSelectedId then
        self._selectedId = datas[i].productId
        break
      end
      if datas[i].productIdList and table.containsValue(datas[i].productIdList, proId) then
        self._selectedId = datas[i].id
        break
      end
    end
    for i = 1, #datas do
      if self._isJourneyJump then
        if datas[i].itemData and datas[i].itemData.itemId == self._lestSelectedId then
          datas[i].active_journeyTarget = true
        else
          datas[i].active_journeyTarget = false
        end
      end
    end
  end
  local colNum = self.listType == 2 and columnNum_card or columnNum
  local lineNum = math.ceil(#datas / colNum)
  lineNum = math.max(lineNum, minLineNum)
  local dataCount = #datas
  for i = 1, lineNum * colNum do
    if i > dataCount then
      table.insert(datas, {isFood = false, itemData = false})
    end
    datas[i].playCellRefreshAnim = playCellRefreshAnim
  end
  local a = ""
  local textHasGet = L_WordsTpl:getValue("tag_home_product_reachlimit")
  for k, v in ipairs(datas) do
    if v.isFood == nil then
      v.isFood = false
    end
    v.text_hasGet = textHasGet
  end
  if list == self.bind.formulaList_normal then
    local needRefreshImmediately = self._isJump
    self.bindComponents.produceTargetList_normal.IsRefreshType = not needRefreshImmediately
  end
  list:freshAll(datas)
  if refreshListPos then
    if gridView and gridView.content then
      gridView.content:SetAnchoredPosition(0, 0)
    end
    REFRESH_INTERVAL = REFRESH_INTERVAL_FIRST
  end
  self._focusListDatas = datas
  if math.isEmpty(self._selectedId) then
    if 0 < #list then
      self:onSelectTarget(list:getValue(1, "id"), list, sourceOfPlayModuleProductInfoAnimation)
    else
      self:onSelectTarget(0, list, sourceOfPlayModuleProductInfoAnimation)
    end
  elseif not math.isEmpty(self._selectedId) then
    local selectIdIsInList = false
    local foodTargetId = list:getValue(1, "id")
    for i = 1, #list do
      local isFood = list:getValue(i, "isFood")
      local itemData = list:getValue(i, "itemData")
      local isValid = isFood or itemData
      if isValid then
        local itemId = list:getValue(i, "id")
        if itemId == self._selectedId then
          selectIdIsInList = true
          selectedIndex = i
        end
        local productList = list:getValue(i, "productIdList")
        if productList then
          for k, v in pairs(productList) do
            if v == self._targetFoodId then
              foodTargetId = itemId
            end
          end
        end
      end
    end
    self._selectedId = self._targetFoodId and foodTargetId or self._selectedId
    selectIdIsInList = selectIdIsInList or self._targetFoodId and true or false
    self._targetFoodId = nil
    self:onSelectTarget(selectIdIsInList and self._selectedId or list:getValue(1, "id"), list, sourceOfPlayModuleProductInfoAnimation)
    if 0 < selectedIndex and self._isJump then
      gridView:FocusItemIndex(selectedIndex - 1, true, true)
    end
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:setEggProductList(targetProductDatas, sourceOfPlayModuleProductInfoAnimation)
  local list = self.focusList or self.bind.formulaList_egg
  local listModule = self.modules.formulaList_egg
  local lineNum = math.ceil(#targetProductDatas / columnNum)
  lineNum = math.max(lineNum, minLineNum)
  if lineNum * columnNum ~= #list then
    list:clear()
    list:insert_array(L_DataUtil.getEmptyModuleDatas(lineNum * columnNum))
  end
  if self._selectedGuid then
    local hasSelectedGuid = false
    for i = 1, #targetProductDatas do
      if targetProductDatas[i].guid == self._selectedGuid then
        hasSelectedGuid = true
      end
    end
    if not hasSelectedGuid then
      self._selectedGuid = nil
    end
  end
  for i, module in ipairs(listModule) do
    module:refreshView(targetProductDatas[i] and targetProductDatas[i].guid, self._guid)
  end
  if 0 < #targetProductDatas then
    self:onSelectEgg(self._selectedGuid or targetProductDatas[1].guid, listModule, sourceOfPlayModuleProductInfoAnimation)
  else
    self:onSelectEgg(self._selectedGuid or 0, listModule, sourceOfPlayModuleProductInfoAnimation)
  end
end

function this:GetCurListModulesByCurType()
  local result
  if self._type == L_Const.WorldMapBuildType.WMBT_HATCH then
    result = (self.modules or {}).formulaList_egg
  elseif self.listType == 2 then
    result = (self.modules or {}).formulaList_card
  else
    result = (self.modules or {}).formulaList_normal
  end
  result = result or {}
  return result
end

function this:onSelectTarget(id, list, isOnClickTab)
  if not list then
    return
  end
  self._selectedId = id
  for i = 1, #list do
    local bindId = list:getValue(i, "id")
    local bindSelectIconActive = list:getValue(i, "selectIconActive")
    local isSelectIconActive = id == bindId
    if isSelectIconActive then
      local curModules = self:GetCurListModulesByCurType()
      local targetCell = curModules[i]
      if targetCell and targetCell.SetReadNewReddot then
        targetCell:SetReadNewReddot()
      end
    end
    if isSelectIconActive ~= bindSelectIconActive then
      SelectIconActiveParamTable.selectIconActive = isSelectIconActive
      list:change(i, SelectIconActiveParamTable)
    end
  end
  local isMultiQuality = false
  for i = 1, #list do
    if list:getValue(i, "id") == id and list:getValue(i, "isFood") == true then
      isMultiQuality = true
    end
  end
  self.parent:onSelectId(id, isMultiQuality, isOnClickTab)
end

function this:onSelectEgg(guid, list, isOnClickTab)
  C_MJLog.LogImportant("[家园生产] moduleProductNormalNew 选择奇波蛋 guid:" .. guid, C_ELogModule.Home)
  if not list then
    return
  end
  self._selectedGuid = guid
  for i, module in ipairs(list) do
    module:setSelect(guid == module.guid)
  end
  self.parent:onSelectId(guid, false, isOnClickTab)
end

function this:onSelectDecoTarget(id)
  self._selectedId = id
  for i = 1, #self.bind.list_decoration do
    local bindId = self.bind.list_decoration:getValue(i, "id")
    local bindSelectIconActive = self.bind.list_decoration:getValue(i, "selectIconActive")
    local isSelectIconActive = id == bindId
    if isSelectIconActive ~= bindSelectIconActive then
      SelectIconActiveParamTable.selectIconActive = isSelectIconActive
      self.bind.list_decoration:change(i, SelectIconActiveParamTable)
    end
  end
  self.parent:onSelectId(id)
end

function this:getSortPetEggList()
  local petEggsDic = L_PetStore:getPetEggList()
  local petEggsList = {}
  for _, v in pairs(petEggsDic) do
    if self:checkPetEggShow(v.guid) then
      table.insert(petEggsList, v)
    end
  end
  table.sort(petEggsList, function(a, b)
    local productGuidA = L_ProductManager:getProductGuidBySpecialGuid(self._guid, a.guid)
    local stateA = L_ProductManager:getProductState(self._guid, productGuidA)
    local productGuidB = L_ProductManager:getProductGuidBySpecialGuid(self._guid, b.guid)
    local stateB = L_ProductManager:getProductState(self._guid, productGuidB)
    local eggHatchTimeA = L_PetStore:getEggIncubationTime(a.configId)
    local eggHatchTimeB = L_PetStore:getEggIncubationTime(b.configId)
    local weightA = stateA * 10000000 - eggHatchTimeA * 100 - L_PetStore:getEggElementId(a.configId)
    local weightB = stateB * 10000000 - eggHatchTimeB * 100 - L_PetStore:getEggElementId(b.configId)
    if weightA == weightB then
      return a.guid < b.guid
    end
    return weightA > weightB
  end)
  return petEggsList
end

function this:checkPetEggShow(eggUid)
  local eggInfo = L_PetStore:getPetEggItem(eggUid)
  if eggInfo and eggInfo.hatch_state == 0 then
    return true
  end
  return false
end

function this:refreshTraceTaskNode(type, list)
  if not self._guid then
    return
  end
  self:refreshtraceTaskId2TraceFormulaIdListDic()
  self:refreshTabListTaskTraceNode()
  self:refreshProductTaskTraceNode(true)
end

function this:refreshtraceTaskId2TraceFormulaIdListDic()
  self.traceTaskIdAndTraceFormulaIdListInfo = self.traceTaskIdAndTraceFormulaIdListInfo or {
    traceTaskIds = {},
    traceFormulaIdList = {}
  }
  table.clear(self.traceTaskIdAndTraceFormulaIdListInfo.traceTaskIds)
  table.clear(self.traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList)
  local traceTaskId2TaskTraceInfosDic = AzurWorld.TaskMgr:GetAllTaskTraceInfos()
  for traceTaskId, taskTraceInfos in pairs(traceTaskId2TaskTraceInfosDic) do
    for j = 0, taskTraceInfos.Count - 1 do
      local traceInfo = taskTraceInfos[j]
      local taskConditionTpl = _taskConditionTpl:getTplById(traceInfo.TriggerData.targetId)
      if taskConditionTpl ~= nil and _taskConditionTpl:getFormulaId(taskConditionTpl) ~= 0 then
        local traceFormulaId = _taskConditionTpl:getFormulaId(taskConditionTpl)
        if self.traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList[traceTaskId] == nil then
          table.insert(self.traceTaskIdAndTraceFormulaIdListInfo.traceTaskIds, traceTaskId)
          self.traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList[traceTaskId] = {}
        end
        table.insert(self.traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList[traceTaskId], traceFormulaId)
      end
    end
  end
  table.sort(self.traceTaskIdAndTraceFormulaIdListInfo.traceTaskIds)
end

function this:refreshTabListTaskTraceNode()
  if self.bind.active_tab then
    self.modules.module_commonTab:refreshTabItemTraceNode(self.traceTaskIdAndTraceFormulaIdListInfo)
  end
end

function this:refreshProductTaskTraceNode(needFocus)
  CS.UnityEngine.Profiling.Profiler.BeginSample("moduleProductNormalNew refreshTraceNode")
  local traceTaskIds = self.traceTaskIdAndTraceFormulaIdListInfo.traceTaskIds
  local traceFormulaIdList = self.traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList
  local list = self.focusList or self.bind.formulaList_normal
  local gridView = self.listType == 2 and self.bindComponents.produceTargetList_card or self.bindComponents.produceTargetList_normal
  local selectedIndex = 0
  if list == self.bind.formulaList_egg then
    return
  end
  for i = 1, #list do
    local cellProduceTarget = list:getItemCls(i)
    if traceTaskIds == nil or traceFormulaIdList == nil then
      cellProduceTarget:hideTraceTaskNode()
    else
      local needShowTraceTaskNode = false
      local _taskId = 0
      for _, taskId in pairs(traceTaskIds) do
        if needShowTraceTaskNode then
          break
        end
        _taskId = taskId
        for _, traceFormulaId in pairs(traceFormulaIdList[taskId]) do
          local traceProductId = traceFormulaId
          if cellProduceTarget:checkNeedShowTraceTaskNodeByTraceProductId(traceProductId) == true then
            needShowTraceTaskNode = true
            selectedIndex = i
            break
          end
        end
      end
      if needShowTraceTaskNode then
        cellProduceTarget:refreshTraceTaskNode(_taskId)
      else
        cellProduceTarget:hideTraceTaskNode()
      end
    end
  end
  if needFocus and 0 < selectedIndex and selectedIndex ~= self._lastTraceSelectedIndex then
    self._lastTraceSelectedIndex = selectedIndex
    gridView:FocusItemIndex(selectedIndex - 1, true, true)
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function this:hideTaskNode()
  local list = self.focusList or self.bind.formulaList_normal
  if list == nil or list == self.bind.formulaList_egg then
    return
  end
  for i = 1, #list do
    local cellProduceTarget = list:getItemCls(i)
    cellProduceTarget:hideTraceTaskNode()
  end
end

function this:FindTargetCellItem(guideSerializeId, guideParam)
  if guideSerializeId == L_Const.GuideSerializeId.ProductCooking then
    if self._data.build_id == 10000 and self._currTabId ~= L_Const.commonTag.BUILDING_PRODUCT then
      self._currTabId = L_Const.commonTag.BUILDING_PRODUCT
      self:refreshList(nil, false)
      self.modules.module_commonTab:setSelect(self._currTabId)
    end
    if self._data.build_id == 100011 and self._currTabId ~= L_Const.FoodProductConst.all then
      self._currTabId = L_Const.FoodProductConst.all
      self:refreshList(nil, false)
      self.modules.module_commonTab:setSelect(self._currTabId)
    end
    local selectedIndex = -1
    if not self._focusListDatas then
      return nil
    end
    for _, data in ipairs(self._focusListDatas) do
      if data.productIdList ~= nil then
        for __, v in pairs(data.productIdList) do
          if v == guideParam then
            selectedIndex = _
            break
          end
        end
      end
      if 0 <= selectedIndex then
        break
      end
      if data.productId == guideParam then
        selectedIndex = _
        break
      end
    end
    if selectedIndex == -1 then
      return nil
    end
    local item = self.bindComponents.produceTargetList_normal:GetItemById(selectedIndex - 1)
    return item and item.uiBinding and item.uiBinding.gameObject.transform:Find("AnimRoot/content")
  end
  return nil
end

function this:onChildDirty()
  self:requestRefreshList()
end

function this:requestRefreshList()
  if self._refreshThrottlePending then
    return
  end
  local now = C_Time.realtimeSinceStartup or C_Time.time or 0
  local elapsed = now - (self._lastRefreshListTime or 0)
  if elapsed >= REFRESH_INTERVAL then
    if self.bind then
      self:refreshList()
    end
  else
    self._refreshThrottlePending = true
    L_TimerManager:newOrResetTimer(self, "refreshListThrottle", function()
      self._refreshThrottlePending = false
      if self and self.bind then
        self:refreshList()
      end
    end, REFRESH_INTERVAL - elapsed)
  end
  REFRESH_INTERVAL = REFRESH_INTERVAL_DEFAULT
end

function this:_onBagOrAttrChange()
  if not self._guid or not self.bind then
    return
  end
  L_TimerManager:newOrResetTimer(self, "bagOrAttrChangeDebounce", function()
    self:_checkGrayStateDirty()
  end, 0.5)
end

function this:_checkGrayStateDirty()
  local list = self.focusList
  if not list or not self.bind then
    return
  end
  if list == self.bind.formulaList_egg then
    return
  end
  for i = 1, #list do
    local cell = list:getItemCls(i)
    if cell and cell.bind and cell.bind.id then
      if cell.bind.isFood then
        self:onChildDirty()
        return
      else
        local newGray = L_ProductManager:GetProductGrayState(cell.bind.id)
        if cell.bind.isGray ~= newGray then
          self:onChildDirty()
          return
        end
      end
    end
  end
end

function this:setGamepadFocus(bFocus)
  self._gamepadFocus = bFocus
  self.bind.active_focusRect = self._gamepadFocus
  if self.modules.module_commonTab and self.modules.module_commonTab.setEnableGamepadShortcut then
    self.modules.module_commonTab:setEnableGamepadShortcut(self._gamepadFocus)
  end
end

function this:isGamepadFocus()
  if self._gamepadFocus ~= nil then
    return self._gamepadFocus
  end
  return false
end

return this

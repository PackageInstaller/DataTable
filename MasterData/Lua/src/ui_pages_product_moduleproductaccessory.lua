local this = class("moduleProductAccessory", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()
local _homeBuildingProductionTpl = L_GameTpl:getHomeBuildingProductionTpl()
local _homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
local _taskConditionTpl = L_GameTpl:getTaskConditionTpl()
local Cell = require("ui/pages/product/cellProductAccessorySmall")
local BigCell = require("ui/pages/product/cellProductAccessoryBig")

function this.bind()
  return {
    list_cellRootBg = {
      moduleName = "pages/product/cellProductAccessoryBg"
    },
    list_cellRoot = {
      moduleName = "pages/product/cellProductAccessorySmall"
    },
    list_bigCellRoot = {
      moduleName = "pages/product/cellProductAccessoryBig"
    },
    size_scrollContent = C_Vector2(0, 0),
    module_tabList = {
      moduleName = "modulePages/tabList/moduleNewCommonTabListVertical"
    },
    normalizedPosition = C_Vector2.one,
    scrollArrow_Active = false
  }
end

function this.methods()
  return {}
end

function this:open()
  self._productIds = {}
  self.bindComponents.ScrollArrow:OnSetAction(function(state, onComplete)
    self:onPlayArrayAnim("anim_startNode", state)
  end, function(state, onComplete)
    self:onPlayArrayAnim("anim_endNode", state)
  end)
  L_HomeStore:listenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshBuildingInfo, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.accessoryProductCb, self.onEventMessageRefreshMainView, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.productCancel, self.onEventMessageRefreshMainView, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.productFinish, self.onEventMessageRefreshMainView, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.refreshAccessory, self.onEventMessageRefreshMainView, self)
  self._refreshTaskHandler = self._refreshTaskHandler or handler(self, self.refreshTraceTaskNode)
  AzurWorld.TaskMgr:RegisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
end

function this:close()
  if self.timer1 then
    Timer.remove(self.timer1)
    self.timer1 = nil
  end
  L_ProductStore:unListenCallFunc(L_ProductStore.event.productFinish, self.onEventMessageRefreshMainView, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.accessoryProductCb, self.onEventMessageRefreshMainView, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.productCancel, self.onEventMessageRefreshMainView, self)
  L_HomeStore:unListenCallFunc(L_HomeStore.event.syncWorldMapHomeItem, self.refreshBuildingInfo, self)
  L_HomeStore:unListenCallFunc(L_ProductStore.event.refreshAccessory, self.onEventMessageRefreshMainView, self)
  if self._refreshTaskHandler then
    AzurWorld.TaskMgr:UnregisterEvent(C_ETaskEvent.RefreshUITask, self._refreshTaskHandler)
  end
end

function this:onPlayArrayAnim(bindName, state)
  self.bindComponents[bindName]:Stop()
  self.bindComponents[bindName]:Play(state and "anim_product_more_in" or "anim_product_more_out")
end

function this:initModule(guid, selectTabId, selProductId)
  self._buildingGuid = guid
  self._selProductId = selProductId
  local buildingInfo = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
  local buildProductionTpl = _homeBuildingProductionTpl:getTplById(buildingInfo.build_id)
  self:refreshtraceTaskId2TraceFormulaIdListDic()
  local tabs = _homeBuildingProductionTpl:getTab(buildProductionTpl)
  self.modules.module_tabList:setData(tabs, handler(self, self.onSelectTabId))
  self.modules.module_tabList:setSelectTabId(selectTabId or tabs[1])
  self:refreshBuildingInfo()
  self:refreshTabListTaskTraceNode()
  self:refreshProductTaskTraceNode()
end

function this:refreshBuildingInfo()
  local buildingInfo = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
  if not buildingInfo then
    return
  end
  local tpl = _homeBuildingTpl:getTplById(buildingInfo.build_id)
  local groupId = _homeBuildingTpl:getGroupId(tpl)
  local homeBuildingGroupTpl = L_GameTpl:getHomeBuildingGroupTpl()
  local tpl_buildingGroup = homeBuildingGroupTpl:getTplById(groupId)
  self.bind.txt_buildingName = homeBuildingGroupTpl:getName(tpl_buildingGroup)
  local levelStr = string.concat("Lv.", _homeBuildingTpl:getLevel(tpl))
  self.bind.txt_buildingLv = levelStr
  self.bind.toggle_isMax = math.isEmpty(_homeBuildingTpl:getNextLevel(tpl))
  self.bind.active_canUpgrade = false
end

function this:onSelectTabId(tab)
  self.parent:refreshInfo(false)
  self.bind.normalizedPosition = C_Vector2.one
  local buildingInfo = L_HomeStore:getHomeBuildingByGuid(self._buildingGuid)
  local buildProductionTpl = _homeBuildingProductionTpl:getTplById(buildingInfo.build_id)
  local products = _productsTpl:getTplsByGroup(_homeBuildingProductionTpl:getGroupId(buildProductionTpl))
  self._productIds = {}
  for _, tpl in ipairs(products) do
    if _productsTpl:getTabId(tpl) == tab or _productsTpl:getTabId(tpl) == 0 then
      table.insert(self._productIds, tpl.id)
    end
  end
  self:hideTaskNode()
  self:refreshMainView()
  self:refreshProductTaskTraceNode()
  if not self.accessoryInit then
    self.parent:initProductInfo()
    self.accessoryInit = true
  end
end

function this:refreshMainView(resetTab)
  if resetTab == nil then
    resetTab = true
  end
  local mapTreeList, mapIdList, maxRow, maxCol = _productsTpl:generateWeaponStationMapByIds(self._productIds)
  self:preCalPosInfos(mapTreeList, maxRow, maxCol)
  local colWidths = self.cacheColWidths
  local dataList = {}
  local bigDataList = {}
  for row = 1, maxRow do
    for col = 1, maxCol do
      local item
      if mapTreeList[row] ~= nil and mapTreeList[row][col] ~= nil then
        local mapData = mapTreeList[row][col]
        local isBigCell = self:isBigCell(mapData.curProductId)
        item = {
          curRow = row,
          curCol = col,
          curProductId = mapData.curProductId,
          lastRow = 0,
          lastCol = 0,
          lastProductId = mapData.lastProductId,
          nextRow = 0,
          nextCol = 0,
          nextProductId = mapData.nextProductId,
          isBigCell = isBigCell
        }
        if 0 < item.lastProductId and mapIdList[item.lastProductId] ~= nil then
          local lastData = mapIdList[item.lastProductId]
          item.lastRow = lastData.curRow
          item.lastCol = lastData.curCol
        end
        if 0 < item.nextProductId and mapIdList[item.nextProductId] ~= nil then
          local nextData = mapIdList[item.nextProductId]
          item.nextRow = nextData.curRow
          item.nextCol = nextData.curCol
        end
      else
      end
      if item ~= nil then
        local curPosInfo = self:getCellPosByRowCol(row, col)
        if curPosInfo then
          item.posX = curPosInfo.posX
          item.posY = curPosInfo.posY
        end
        if 0 < item.lastProductId and mapIdList[item.lastProductId] == nil then
          item.lastProductId = 0
          item.lastRow = 0
          item.lastCol = 0
        end
        
        function item.callback(clickId, pos, blockClick, kiboExpInfos)
          self:onSelectProduct(clickId, pos, blockClick, kiboExpInfos)
          self.parent:refreshInfo(true)
        end
        
        item.guid = self._buildingGuid
        if item.isBigCell then
          table.insert(bigDataList, item)
        else
          table.insert(dataList, item)
        end
      end
    end
  end
  local widthContent = -25 + Cell.CellColOffset * 2
  for col = 1, maxCol do
    widthContent = widthContent + colWidths[col] + Cell.CellSpaceWidth
  end
  local HeightContent = maxRow * (Cell.CellHeight + Cell.CellSpaceHeight) + Cell.CellSpaceHeight - 25
  self.bind.size_scrollContent = C_Vector2(widthContent, HeightContent)
  if resetTab then
    self.bind.list_cellRoot:clear()
    self.bind.list_cellRoot:insert_array(dataList)
    self.bind.list_bigCellRoot:clear()
    self.bind.list_bigCellRoot:insert_array(bigDataList)
  else
    self.bind.list_cellRoot:freshAll(dataList)
    self.bind.list_bigCellRoot:freshAll(bigDataList)
  end
  local selRow = 1
  local selCol = 1
  local offset = C_Vector2.zero
  if self._selProductId then
    for key, value in pairs(dataList) do
      if value.curProductId == tonumber(self._selProductId) then
        selRow = value.curRow
        selCol = value.curCol
      end
    end
    for _, value in pairs(bigDataList) do
      if value.curProductId == tonumber(self._selProductId) then
        selRow = value.curRow
        selCol = value.curCol
      end
    end
    if 5 < selRow then
      offset.y = 750
    end
    if 4 < selCol then
      offset.x = -1000
    end
  end
  self.bind.scrollArrow_Active = 5 < maxRow
  self.timer1 = Timer.once(0.1, function()
    self.bindComponents.ScrollArrow:OnScroll(C_Vector2(0, 0))
  end, self)
  self.bindComponents.ScrollView.vertical = 4 <= maxRow
  self.bindComponents.ScrollView.horizontal = 4 <= maxCol
  if resetTab then
    self.bindComponents.ScrollContent.anchoredPosition = offset
    if self.bindComponents.animModuleProductAccessory then
      self.bindComponents.animModuleProductAccessory:Stop()
      self.bindComponents.animModuleProductAccessory:Play("anim_product_accessory_change")
    end
  end
end

function this:onSelectProduct(id, pos, blockClick, kiboExpInfos)
  for _, module in ipairs(self.modules.list_cellRoot) do
    module:refreshSelect(id)
  end
  for _, module in ipairs(self.modules.list_bigCellRoot) do
    module:refreshSelect(id)
  end
  self.parent:onSelectId(id, pos, blockClick, kiboExpInfos)
end

function this:selectSelectNone()
  local noneId = 0
  for _, module in ipairs(self.modules.list_cellRoot) do
    module:refreshSelect(noneId)
  end
  for _, module in ipairs(self.modules.list_bigCellRoot) do
    module:refreshSelect(noneId)
  end
end

function this:manualSIMSelAndClick(id)
  for _, module in ipairs(self.modules.list_cellRoot) do
    if module.bind.curProductId == id then
      module:clickProcess()
    end
  end
  for _, module in ipairs(self.modules.list_bigCellRoot) do
    if module.bind.curProductId == id then
      module:clickProcess()
    end
  end
end

function this:refreshBuildiCell(buildId)
  for _, module in ipairs(self.modules.list_cellRoot) do
    module:refreshBuildiCell(buildId)
  end
  for _, module in ipairs(self.modules.list_bigCellRoot) do
    module:refreshBuildiCell(buildId)
  end
end

function this:refreshTraceTaskNode(type, list)
  if not self._buildingGuid then
    return
  end
  self:refreshtraceTaskId2TraceFormulaIdListDic()
  self:refreshTabListTaskTraceNode()
  self:refreshProductTaskTraceNode()
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
  if self.modules.module_tabList then
    self.modules.module_tabList:refreshTabItemTraceNode(self.traceTaskIdAndTraceFormulaIdListInfo)
  end
end

function this:refreshProductTaskTraceNode()
  local traceTaskIds = self.traceTaskIdAndTraceFormulaIdListInfo.traceTaskIds
  local traceFormulaIdList = self.traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList
  local list = self.bind.list_cellRoot
  for i = 1, #list do
    local cellProductAccessory = list:getItemCls(i)
    self:refreshSingleTaskTraceNode(cellProductAccessory, traceTaskIds, traceFormulaIdList)
  end
  list = self.bind.list_bigCellRoot
  for i = 1, #list do
    local cellProductAccessory = list:getItemCls(i)
    self:refreshSingleTaskTraceNode(cellProductAccessory, traceTaskIds, traceFormulaIdList)
  end
end

function this:refreshSingleTaskTraceNode(node, traceTaskIds, traceFormulaIdList)
  if traceTaskIds == nil or traceFormulaIdList == nil then
    node:hideTraceTaskNode()
  else
    local needShowTraceTaskNode = false
    local _taskId = 0
    for _, taskId in pairs(traceTaskIds) do
      if needShowTraceTaskNode then
        break
      end
      _taskId = taskId
      for _, traceFormulaId in pairs(traceFormulaIdList) do
        local traceProductId = traceFormulaId
        if node:checkNeedShowTraceTaskNodeByTraceProductId(traceProductId) == true then
          needShowTraceTaskNode = true
          break
        end
      end
    end
    if needShowTraceTaskNode then
      node:refreshTraceTaskNode(_taskId)
    else
      node:hideTraceTaskNode()
    end
  end
end

function this:hideTaskNode()
  local list = self.bind.list_cellRoot
  if list ~= nil then
    for i = 1, #list do
      local cellProductAccessory = list:getItemCls(i)
      cellProductAccessory:hideTraceTaskNode()
    end
  end
  list = self.bind.list_bigCellRoot
  if list ~= nil then
    for i = 1, #list do
      local cellProductAccessory = list:getItemCls(i)
      cellProductAccessory:hideTraceTaskNode()
    end
  end
end

function this:onEventMessageRefreshMainView()
  self:refreshMainView(false)
end

function this:isBigCell(productId)
  local tpl_pro = _productsTpl:getTplById(productId)
  if not tpl_pro then
    return false
  end
  local reward = _productsTpl:getRewardId(tpl_pro)
  local itemData = reward and L_DataUtil.parseRewardConfigItem(reward[1])
  local conf = itemData and L_ItemTplManager:getItemConfig(itemData.itemType, itemData.itemId)
  return conf and conf.quality > 2
end

function this:preCalPosInfos(mapTreeList, maxRow, maxCol)
  self.cacheWidthInfos = {}
  self.cacheColWidths = {}
  for col = 1, maxCol do
    self.cacheColWidths[col] = 0
    for row = 1, maxRow do
      if mapTreeList[row] and mapTreeList[row][col] then
        local mapData = mapTreeList[row][col]
        local isBig = self:isBigCell(mapData.curProductId)
        local cellWidth = isBig and BigCell.CellWidth or Cell.CellWidth
        self.cacheColWidths[col] = math.max(self.cacheColWidths[col], cellWidth)
        self.cacheWidthInfos[row] = self.cacheWidthInfos[row] or {}
        self.cacheWidthInfos[row][col] = cellWidth
      end
    end
  end
  self.cacheItemPos = {}
  local baseColOffset = -25 + Cell.CellColOffset
  local baseRowOffset = -(30 + Cell.CellHeight / 2)
  for col = 1, maxCol do
    if 1 < col then
      baseColOffset = baseColOffset + self.cacheColWidths[col - 1] + Cell.CellSpaceWidth
    end
    for row = 1, maxRow do
      if mapTreeList[row] and mapTreeList[row][col] then
        local cellWidth = self.cacheWidthInfos[row][col]
        local posX = baseColOffset + cellWidth / 2
        local posY = baseRowOffset + -(row - 1) * (Cell.CellHeight + Cell.CellSpaceHeight)
        self.cacheItemPos[row] = self.cacheItemPos[row] or {}
        self.cacheItemPos[row][col] = {
          posX = posX,
          posY = posY,
          width = cellWidth,
          height = Cell.CellHeight
        }
      end
    end
  end
end

function this:getCellWidthByRowCol(row, col)
  return self.cacheWidthInfos and self.cacheWidthInfos[col] and self.cacheWidthInfos[col][row] or 0
end

function this:getWidthByCol(col)
  return self.cacheColWidths and self.cacheColWidths[col] or 0
end

function this:getCellPosByRowCol(row, col)
  return self.cacheItemPos and self.cacheItemPos[row] and self.cacheItemPos[row][col] or nil
end

function this:CheckTargetProductIsSelected(productID)
  local isSelected = false
  local getTarget = false
  for _, module in ipairs(self.modules.list_cellRoot) do
    if module.bind and module.bind.curProductId == productID then
      isSelected = module:IsCurSelected()
      getTarget = true
      break
    end
  end
  if not getTarget then
    for _, module in ipairs(self.modules.list_bigCellRoot) do
      if module.bind and module.bind.curProductId == productID then
        isSelected = module:IsCurSelected()
        getTarget = true
        break
      end
    end
  end
  return isSelected
end

function this:setGamepadFocus(bFocus)
  self._gamepadFocus = bFocus
  if self.modules.module_tabList and self.modules.module_tabList.setEnableGamepadShortcut then
    self.modules.module_tabList:setEnableGamepadShortcut(self._gamepadFocus)
  end
end

function this:isGamepadFocus()
  if self._gamepadFocus ~= nil then
    return self._gamepadFocus
  end
  return false
end

return this

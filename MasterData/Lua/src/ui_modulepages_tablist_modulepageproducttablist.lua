local module = class("modulePageProductTabList", require("ui.modulePages.tabList.moduleCommonTabList"))
local _productsTpl = L_GameTpl:getProductsTpl()
local tabParams = {
  building = {
    iconColorKey_normal = "#806e5b7b",
    nameColorKey_normal = "#806e5b7b",
    iconColorKey_select = "#fbffb8",
    nameColorKey_select = "#fbffb8"
  },
  product = {
    iconColorKey_normal = "#806e5b7b",
    nameColorKey_normal = "#806e5b7b",
    iconColorKey_select = "#E0923E",
    nameColorKey_select = "#E0923E"
  }
}

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "modulePages/tabList/cellPageProductTabItem"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      if self._callback then
        local index = 1
        for i = 1, #self.bind.list_tab do
          local cellPageProductTabItem = self.bind.list_tab:getItemCls(i)
          cellPageProductTabItem:onSelect(cellPageProductTabItem:getTabId() == id, self.tabParam)
          if cellPageProductTabItem:getTabId() == id then
            index = i
          end
        end
        self._callback(id, index)
      end
      Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.root)
    end
  }
end

function module:open()
  self:registerShortCut()
end

function module:close()
  self:unregisterShortCut()
  self:clearShortKeyFlag()
end

function module:refreshTabItemTraceNode(traceTaskIdAndTraceFormulaIdListInfo)
  for i = 1, #self.bind.list_tab do
    local cellPageProductTabItem = self.bind.list_tab:getItemCls(i)
    cellPageProductTabItem:hideTraceTaskNode()
  end
  local traceTaskIds = traceTaskIdAndTraceFormulaIdListInfo.traceTaskIds
  local traceFormulaIdList = traceTaskIdAndTraceFormulaIdListInfo.traceFormulaIdList
  if traceTaskIds == nil or traceFormulaIdList == nil then
    return
  end
  local tabIndexLst = {}
  for taskIndex, taskId in pairs(traceTaskIds) do
    for index, traceFormulaId in pairs(traceFormulaIdList[taskId]) do
      local traceProductId = traceFormulaId
      local productsTplOfTraceProductId = _productsTpl:getTplById(traceProductId)
      if productsTplOfTraceProductId == nil then
        C_MJLog.LogError(string.format("traceTaskId:%d, 追踪的productId:%d 不存在配置", taskId, traceProductId))
      else
        local tabId = _productsTpl:getTabId(productsTplOfTraceProductId)
        if tabId and 0 < tabId and table.containsValue(tabIndexLst, taskIndex) == false then
          local cellPageProductTabItem = self:getCellPageProductTabItemByTabId(tabId)
          if cellPageProductTabItem then
            table.insert(tabIndexLst, taskIndex)
            cellPageProductTabItem:refreshTraceTaskNode(taskId)
          end
        end
      end
    end
  end
end

function module:getCellPageProductTabItemByTabId(tabId)
  for i = 1, #self.bind.list_tab do
    local cellPageProductTabItem = self.bind.list_tab:getItemCls(i)
    local tabIdOfTabItem = cellPageProductTabItem:getTabId()
    if tabIdOfTabItem == tabId then
      return cellPageProductTabItem
    end
  end
  C_MJLog.LogWarning(string.format("modulePageProductTabList can not found cellPageProductTabItem by tabId: %d", tabId))
  return nil
end

function module:setData(param)
  self.tabParam = tabParams[param.tabType or "product"]
  self.super.setData(self, param.idList, param.callback, param.selectId, param.redKeys)
  self:setEnableGamepadShortcut(self._enableGamepadShortcut or true)
end

function module:setSelect(id)
  for i = 1, #self.bind.list_tab do
    local cellPageProductTabItem = self.bind.list_tab:getItemCls(i)
    cellPageProductTabItem:onSelect(cellPageProductTabItem:getTabId() == id, self.tabParam)
  end
  self.bind.selectTab = id
end

function module:getCurrentCellPageProductTabItemIndex()
  for i = 1, #self.bind.list_tab do
    local cellPageProductTabItem = self.bind.list_tab:getItemCls(i)
    if cellPageProductTabItem:getTabId() == self.bind.selectTab then
      return i
    end
  end
  return 1
end

function module:setSelectByIndex(index)
  if 1 <= index and index <= #self.bind.list_tab then
    local cellPageProductTabItem = self.bind.list_tab:getItemCls(index)
    self:setSelect(cellPageProductTabItem:getTabId())
  end
end

function module:setEnableGamepadShortcut(bEnable)
  self._enableGamepadShortcut = bEnable
  self:refreshShortKeyFlag()
end

function module:registerShortCut()
  L_ShortCutManager:registerShortCut("modulePageProductTabList", C_InputManager_KeyType.ECommonPrevTab, function()
    if not self._enableGamepadShortcut then
      return
    end
    if #self.bind.list_tab < 0 then
      return
    end
    local id = self:getCurrentCellPageProductTabItemIndex() - 1
    if id < 1 then
      id = #self.bind.list_tab
    end
    self:setSelectByIndex(id)
  end)
  L_ShortCutManager:registerShortCut("modulePageProductTabList", C_InputManager_KeyType.ECommonNextTab, function()
    if not self._enableGamepadShortcut then
      return
    end
    if #self.bind.list_tab < 0 then
      return
    end
    local id = self:getCurrentCellPageProductTabItemIndex() + 1
    if id > #self.bind.list_tab then
      id = 1
    end
    self:setSelectByIndex(id)
  end)
end

function module:unregisterShortCut()
  L_ShortCutManager:unregisterShortCut("modulePageProductTabList", C_InputManager_KeyType.ECommonPrevTab)
  L_ShortCutManager:unregisterShortCut("modulePageProductTabList", C_InputManager_KeyType.ECommonNextTab)
end

function module:refreshShortKeyFlag()
  self:clearShortKeyFlag()
  if self._enableGamepadShortcut and #self.bind.list_tab > 0 then
    local cellLeft = self.bind.list_tab:getItemCls(1)
    local cellRight = self.bind.list_tab:getItemCls(#self.bind.list_tab)
    L_ShortCutManager:addShortKeyFlag(self, "Common_PrevTab", L_Const.AnchorType.Left, cellLeft.gameObject.transform, L_Vector3.new(-10, 0))
    L_ShortCutManager:addShortKeyFlag(self, "Common_NextTab", L_Const.AnchorType.Right, cellRight.gameObject.transform, L_Vector3.new(-70, 0))
  end
end

function module:clearShortKeyFlag()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return module

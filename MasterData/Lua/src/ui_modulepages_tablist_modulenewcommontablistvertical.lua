local module = class("moduleNewCommonTabListVertical", G_UIModuleBase)
local _productsTpl = L_GameTpl:getProductsTpl()

function module.bind()
  return {
    selectTab = -1,
    list_tab = {
      moduleName = "modulePages/tabList/cellNewCommonTabItemVertical"
    }
  }
end

function module.methods()
  return {
    onTabId = function(self, id)
      if self._callback then
        self._callback(id)
      end
      for key, value in pairs(self.modules.list_tab) do
        if value.bind.id == id then
          Timer.once(0.03, function()
            self.bindComponents.selEfftectTrans.position = value.bindComponents.root.position
            self.bindComponents.selEfftectTrans.localPosition = self.bindComponents.selEfftectTrans.localPosition + L_Vector3.new(10, -15, 0)
          end)
          break
        end
      end
      if self.bindComponents.tabAnim == nil then
        return
      end
      self.bindComponents.tabAnim:Stop()
      self.bindComponents.tabAnim:Play("anim_commontablistvertical_selecteffect")
    end
  }
end

function module:setData(idList, callback, selectId, redKeys, IslimitList, CustomList)
  IslimitList = IslimitList or {}
  self.bind.list_tab:clear()
  self._callback = nil
  if #idList <= 0 then
    return
  end
  local dataList = {}
  for i, id in ipairs(idList) do
    table.insert(dataList, {
      id = id,
      isLast = i == #idList,
      redKey = redKeys and redKeys[i],
      show = i ~= #idList,
      Islimit = IslimitList[i],
      CustomData = CustomList and CustomList[i]
    })
  end
  self.bind.list_tab:insert_array(dataList)
  self._callback = callback
  if self.bindComponents.rect_List then
    Unity.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bindComponents.rect_List)
  end
  self.bind.selectTab = idList[selectId or 1]
end

function module:refreshLimitInfo(IslimitList)
  local index = 1
  for i, limit in ipairs(IslimitList) do
    self.modules.list_tab[index]:refreshLimit(limit)
    index = index + 1
  end
end

function module:setSelectTabId(id)
  self.bind.selectTab = id
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
  for _, taskId in pairs(traceTaskIds) do
    for index, traceFormulaId in pairs(traceFormulaIdList[taskId]) do
      local traceProductId = traceFormulaId
      local productsTplOfTraceProductId = _productsTpl:getTplById(traceProductId)
      if productsTplOfTraceProductId == nil then
        C_MJLog.LogError(string.format("traceTaskId:%d, 追踪的productId:%d 不存在配置", taskId, traceProductId))
      else
        local tabId = _productsTpl:getTabId(productsTplOfTraceProductId)
        if tabId and 0 < tabId and table.containsValue(tabIndexLst, index) == false then
          local cellPageProductTabItem = self:getCellPageProductTabItemByTabId(tabId)
          if cellPageProductTabItem then
            table.insert(tabIndexLst, index)
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
  return nil
end

function module:open()
end

function module:close()
end

return module

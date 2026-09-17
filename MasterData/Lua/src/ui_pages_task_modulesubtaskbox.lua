local this = class("moduleSubtaskBox", require("ui.pages.task.moduleSubmitBase"))
local _commonItemTpl = L_GameTpl:getCommonItemTpl()
local _taskTargetTpl = L_GameTpl:getTaskTargetTpl()
local _taskStepTpl = L_GameTpl:getTaskStepTpl()
local _taskTpl = L_GameTpl:getTaskTpl()

function this:bind()
  return {
    activeEmpty = false,
    txtTarget = "",
    itemList = true,
    txtDesc = "",
    txtConditionObj = true,
    txtConditionDesc = "",
    submitBg = true,
    fastSelectActive = false,
    scrollList_goods = {
      moduleName = "modulePages/cellSubmitItem"
    },
    submitList = {
      moduleName = "modulePages/cellSubmitItem"
    }
  }
end

function this:methods()
  return {
    clickSubmit = function(self)
      self:submitItem()
    end,
    clickFastSelect = function(self)
      self:fastSelect()
    end
  }
end

function this:initUI()
  self.super.initUI(self)
  self.needSelect = self.subType ~= L_Const.taskClientEvent.submitItem or not self.subData.autoFill
  self.summitItemShowType = self.needSelect and L_Const.submitItemShowType.select or L_Const.submitItemShowType.submitTarget
  self:refreshBagItems()
  self:refreshSubmitItems()
  local tplTask = _taskTpl:getTplById(self.taskId)
  self.bind.txtTarget = _taskTpl:getName(tplTask)
  local stepId = self.subData.conditionInfoId
  local tplTaskStep = _taskStepTpl:getTplById(stepId)
  if tplTaskStep then
    self.bind.txtDesc = _taskStepTpl:getDesc(tplTaskStep)
  end
  if self.subType == L_Const.taskClientEvent.submitItem then
    self.bind.txtConditionObj = false
    self.bind.submitBg = true
  else
    self.bind.txtConditionObj = true
    self.bind.submitBg = false
    local infos = AzurWorld.TaskMgr:GetNodeInfoParam(self.taskId, self.nodeId)
    local tplTaskTarget = _taskTargetTpl:getTplById(infos[0].conditionInfoId)
    if tplTaskTarget then
      self.taskDesc = _taskTargetTpl:getDesc(tplTaskTarget)
      self:SetConditionDesc(self.taskDesc, 0, self.subData.needCount)
    end
  end
  self.bind.fastSelectActive = self.needSelect
end

function this:addSubmitCell(cell)
  self.bind.submitList:insert(#self.bind.submitList + 1, cell)
  if cell.curCount then
    self.modules.submitList[#self.modules.submitList]:setCount(cell.curCount)
  end
end

function this:onBagItemClick(item)
  self:onBagItemAdd(item, 1)
end

function this:getMaxSelectNum(itemId)
  local maxSelect = 0
  local currentSelect = 0
  if self.subType == L_Const.taskClientEvent.submitItem then
    for _, itemData in ipairs(self.subData.subItemData.itemDatas) do
      if itemData.itemId == itemId then
        maxSelect = itemData.count
      end
    end
    currentSelect = self:getCurrentSubmitNumber(itemId)
    maxSelect = maxSelect - currentSelect
  else
    currentSelect = self:getCurrentSubmitNumber()
    maxSelect = self.subData.needCount - currentSelect
  end
  return maxSelect
end

function this:onBagItemAdd(item, changeValue)
  local maxSelect = self:getMaxSelectNum(item.bind.itemId)
  if maxSelect <= 0 then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_task_submit_enough"))
    return
  elseif item.bind.itemNum <= item:getSelectNum() then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_task_submit_none"))
    return
  end
  local realChangeValue = math.min(maxSelect, item.bind.itemNum - item:getSelectNum(), changeValue)
  local num = item:getSelectNum() + realChangeValue
  item:setSelect(0 < num, num)
  local hasAdd = false
  if self.subData.autoFill then
    for _, submitItem in pairs(self.modules.submitList) do
      if submitItem.bind.itemId == item.bind.itemId then
        submitItem:setCount(submitItem:getCount() + realChangeValue)
        hasAdd = true
        break
      end
    end
  end
  if not hasAdd then
    local clickHandle = handler(self, self.onSubmitItemClick)
    local cell = {
      itemType = item.bind.itemType,
      itemId = item.bind.itemId,
      itemNum = item.bind.itemNum,
      needCount = nil,
      curCount = realChangeValue,
      clickCallback = clickHandle,
      itemShowType = self.summitItemShowType,
      guid = item.bind.guid
    }
    for _, submitItem in pairs(self.modules.submitList) do
      if not submitItem.bind.itemId then
        submitItem:resetData(cell)
        submitItem:refresh()
        submitItem:setCount(realChangeValue)
        hasAdd = true
        break
      end
    end
    if not hasAdd then
      self:addSubmitCell(cell)
    end
  end
  local currentNum = self:getCurrentSubmitNumber()
  self:SetConditionDesc(self.taskDesc, currentNum, self.subData.needCount)
  if currentNum >= self.subData.needCount then
    self.canSubmit = true
  end
end

function this:getCurrentSubmitNumber(itemId)
  local currentNum = 0
  for _, submitItem in pairs(self.modules.submitList) do
    if submitItem.bind.itemId and submitItem:getCount() and (not itemId or itemId == submitItem.bind.itemId) then
      currentNum = currentNum + submitItem:getCount()
    end
  end
  return currentNum
end

function this:onBagItemRemoveClick(item)
  self:onBagItemRemove(item, -1)
end

function this:onBagItemRemove(item, changeValue)
  self.canSubmit = false
  local num = item:getSelectNum() + changeValue
  item:setSelect(0 < num, num)
  local submitItem
  local removeIndex = 0
  for i = 1, #self.modules.submitList do
    submitItem = self.modules.submitList[i]
    if submitItem.bind.itemId == item.bind.itemId and submitItem.bind.guid == item.bind.guid then
      submitItem:setCount(submitItem:getCount() + changeValue)
      removeIndex = i
      break
    end
  end
  if self.needSelect and submitItem and (not submitItem:getCount() or 0 >= submitItem:getCount()) then
    local tran = submitItem.gameObject:TryGetComponent(typeof(C_RectTransform))
    tran:SetAsLastSibling()
    self.bind.submitList:remove(removeIndex)
    local cell = {
      itemShowType = L_Const.submitItemShowType.waitAdd
    }
    self:addSubmitCell(cell)
  end
  local currentNum = self:getCurrentSubmitNumber()
  self:SetConditionDesc(self.taskDesc, currentNum, self.subData.needCount)
end

function this:refreshBagItems()
  local items = {}
  local targetItemInfos = {}
  local clickHandle = handler(self, self.onBagItemClick)
  local clickRemoveHandle = handler(self, self.onBagItemRemoveClick)
  if self.subType == L_Const.taskClientEvent.submitItem then
    if self.subData.autoFill then
      self.bind.itemList = false
    else
      self.bind.itemList = true
      local itemIds = {}
      for _, itemData in ipairs(self.subData.subItemData.itemDatas) do
        table.insert(itemIds, itemData.itemId)
      end
      targetItemInfos = self:getItemsOfIds(self.subData.itemBigType, itemIds)
    end
  elseif self.subType == L_Const.taskClientEvent.submitTypeItem then
    local itemTypes = {}
    itemTypes[self.subData.subItemData.itemType] = true
    targetItemInfos = self:getItemsOfTypes(self.subData.itemBigType, itemTypes)
  elseif self.subType == L_Const.taskClientEvent.submitGroupItem then
    targetItemInfos = self:getItemsOfIds(self.subData.itemBigType, self.subData.subItemData.itemIds)
  end
  for _, itemInfo in ipairs(targetItemInfos) do
    local cell = {
      itemType = self.subData.itemBigType,
      itemId = itemInfo.itemId,
      itemNum = itemInfo.itemNum,
      activeMask = false,
      quality = itemInfo.quality,
      clickCallback = clickHandle,
      clickRemoveCallback = clickRemoveHandle,
      itemShowType = L_Const.submitItemShowType.select,
      itemSubType = itemInfo.itemType,
      guid = itemInfo.guid
    }
    table.insert(items, cell)
  end
  table.sort(items, function(a, b)
    if a.activeMask ~= b.activeMask then
      return b.activeMask
    end
    if a.quality ~= b.quality then
      return a.quality < b.quality
    end
    return a.itemId < b.itemId
  end)
  self.bind.scrollList_goods:clear()
  if 0 < #items then
    self.bind.scrollList_goods:insert_array(items)
  end
  self.bind.activeEmpty = #items == 0
end

function this:onSubmitItemClick(item)
  L_ItemTplManager:showInfoTip(item.bind.itemType, item.bind.itemId)
end

function this:refreshSubmitItems()
  local items = {}
  local clickHandle = handler(self, self.onSubmitItemClick)
  if not self.needSelect then
    self.canSubmit = true
    for _, itemData in ipairs(self.subData.subItemData.itemDatas) do
      local curCount = 0
      if self.subData.autoFill then
        local tempData = L_ItemTplManager:getItemConfig(self.subData.itemBigType, itemData.itemId)
        local bagNum = tempData.num
        curCount = bagNum >= itemData.count and itemData.count or bagNum
      end
      self.canSubmit = self.canSubmit and curCount >= itemData.count
      local cell = {
        itemType = self.subData.itemBigType,
        itemId = itemData.itemId,
        needCount = itemData.count,
        curCount = curCount,
        clickCallback = clickHandle,
        itemShowType = self.summitItemShowType
      }
      table.insert(items, cell)
    end
  else
    for i = 1, self.subData.needCount do
      local cell = {
        itemShowType = L_Const.submitItemShowType.waitAdd
      }
      table.insert(items, cell)
    end
  end
  self.bind.submitList:clear()
  self.bind.submitList:insert_array(items)
end

function this:submitItem()
  if self.canSubmit then
    if self:hasGreaterQuality(self.subData.showTipsQuality) then
      local data_tip = {
        txtTitle = L_WordsTpl:getValue("ui_task_submit_confirm"),
        txtContent = L_WordsTpl:getValue("ui_task_submit_quality"),
        confirmCallback = handler(self, self.confirmSubmit)
      }
      L_GameUtil.showCommonTip(data_tip)
    else
      self:confirmSubmit()
    end
  else
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_task_submit_not"))
  end
end

function this:confirmSubmit()
  if self.subType == L_Const.taskClientEvent.submitItem and self.subData.autoFill then
    L_TaskStore:req_creatSubmitItemData(self.subType, self.taskId, self.nodeId, self.subData.index)
  else
    local submitDatas = {}
    for _, bagItem in ipairs(self.modules.scrollList_goods) do
      if bagItem.bind.itemId and bagItem:getSelectNum() and bagItem:getSelectNum() > 0 then
        local data = {}
        data.itemId = bagItem.bind.itemId
        data.itemType = bagItem.bind.itemType
        data.count = bagItem.selectNum
        data.itemGuid = bagItem.bind.guid
        table.insert(submitDatas, data)
      end
    end
    L_TaskStore:req_creatSubmitItemData(self.subType, self.taskId, self.nodeId, self.subData.index, submitDatas)
  end
  L_UI:close("pageTaskSubmit")
end

function this:fastSelect()
  for _, bagItem in ipairs(self.modules.scrollList_goods) do
    if bagItem.bind.itemId then
      local maxSelect = self:getMaxSelectNum(bagItem.bind.itemId)
      local leftNum = bagItem:getSelectNum() and bagItem.bind.itemNum - bagItem:getSelectNum() or bagItem.bind.itemNum
      local selectNum = math.min(leftNum, maxSelect)
      if 0 < selectNum then
        self:onBagItemAdd(bagItem, selectNum)
      end
    end
  end
end

function this:hasGreaterQuality(quality)
  if self.subType == L_Const.taskClientEvent.submitItem and self.subData.autoFill then
    return false
  else
    for _, bagItem in ipairs(self.modules.scrollList_goods) do
      if bagItem.bind.itemId and bagItem:getSelectNum() and bagItem:getSelectNum() > 0 and bagItem.bind.quality and quality <= bagItem.bind.quality then
        return true
      end
    end
  end
  return false
end

function this:SetConditionDesc(desc, curNum, maxNum)
  local colorKey = curNum < maxNum and "#ff878f" or "#a1ffd2"
  if desc then
    self.bind.txtConditionDesc = desc .. L_GameUtil.fillColor(string.format("  %s/%s", tostring(curNum), tostring(maxNum)), colorKey)
  end
end

function this:getItemsOfTypes(itemBigType, itemSmallTypes)
  local allItems = L_ItemTplManager:getAllItemsOfBigType(itemBigType)
  local toInfoFunction = L_ItemTplManager:getToInfoFunction(itemBigType)
  local result = {}
  if toInfoFunction == nil then
    error(string.format("No toInfoFunction %s", tostring(itemBigType)))
    return result
  end
  for _, item in pairs(allItems) do
    local itemInfo = toInfoFunction(item)
    if itemInfo and not itemInfo.hide and itemInfo.itemNum > 0 and itemSmallTypes[itemInfo.itemType] then
      local itemConfig = L_ItemTplManager:getItemConfig(itemBigType, itemInfo.itemId)
      itemInfo.quality = itemConfig.quality
      table.insert(result, itemInfo)
    end
  end
  return result
end

function this:getItemsOfIds(itemBigType, itemIds)
  local allItems = L_ItemTplManager:getAllItemsOfBigType(itemBigType)
  local toInfoFunction = L_ItemTplManager:getToInfoFunction(itemBigType)
  local result = {}
  if toInfoFunction == nil then
    error(string.format("No toInfoFunction %s", tostring(itemBigType)))
    return result
  end
  local trueIds = {}
  for _, id in ipairs(itemIds) do
    trueIds[id] = true
  end
  for _, item in pairs(allItems) do
    if item then
      local itemInfo = toInfoFunction(item)
      if itemInfo and not itemInfo.hide and itemInfo.itemNum > 0 and trueIds[itemInfo.itemId] then
        local itemConfig = L_ItemTplManager:getItemConfig(itemBigType, itemInfo.itemId)
        itemInfo.quality = itemConfig.quality
        table.insert(result, itemInfo)
      end
    end
  end
  return result
end

return this

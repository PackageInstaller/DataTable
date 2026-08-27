local UINActivityDivergentTaskNode = class("UINActivityDivergentTaskNode", UIBaseNode)
local base = UIBaseNode
local UINActivityDivergentTaskItem = require("Game.ActivityDivergent.UI.Task.UINActivityDivergentTaskItem")
local CS_MessageCommon = CS.MessageCommon

function UINActivityDivergentTaskNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._taskItemPool = UIItemPool.New(UINActivityDivergentTaskItem, self.ui.obj_TaskItem, false)
  self._taskDatas = {}
  self._existTaskID = {}
  self._needAnimTaskID = 0
  self.__GetNewDivergentTaskCallback = BindCallback(self, self.__GetNewDivergentTask)
  self.__ExchangeDivergentTaskCallback = BindCallback(self, self.__ExchangeDivergentTask)
  self._priceItemIds = {}
  self._payBeforeNums = {}
  self._payAfterNums = {}
end

function UINActivityDivergentTaskNode:InitDivergentTaskNode(divergentData)
  self._data = divergentData
  if self._data:GetDivergentTaskProgress() ~= nil then
    self._existTaskID = self._data:GetDivergentTaskProgress().questIds
  end
end

function UINActivityDivergentTaskNode:RefreshDivergentTaskNode(divergentHeroId, isSortTasks)
  local canShow = self._data:GetDivergentCurrentHeroId() == divergentHeroId
  local divergentTaskProgress = self._data:GetDivergentTaskProgress()
  if self._data:GetDivergentCurrentHeroId() ~= divergentHeroId or self._data:GetDivergentHeroFragAllGet(divergentHeroId) or self._data:GetDivergentTaskProgress() == nil then
    self:Hide()
    return
  end
  local divergentTaskDatas = self._data:GetDivergentTaskDatas()
  local mainCfg = self._data:GetDivergentMainCfg()
  local maxTaskItemNum = math.min(#divergentTaskDatas + mainCfg.task_extra_num - divergentTaskProgress.extraGetQuestNum, mainCfg.task_own_num)
  if maxTaskItemNum <= 0 then
    canShow = false
    self:Hide()
    return
  end
  self:Show()
  self.ui.tex_TaskCount:SetIndex(0, tostring(divergentTaskProgress.completedNum), tostring(mainCfg.task_complete_num))
  self._taskItemPool:HideAll()
  self:__CheckIDdiffForAnimation()
  for iTaskData = 1, maxTaskItemNum do
    local needAnim = false
    local taskData = divergentTaskDatas[iTaskData]
    local taskItem = self._taskItemPool:GetOne()
    if taskData ~= nil then
      needAnim = self._needAnimTaskID == taskData.id
    end
    taskItem:InitDivergentTaskItem(self._data, taskData, self.__GetNewDivergentTaskCallback, self.__ExchangeDivergentTaskCallback, needAnim)
  end
  self._existTaskID = self._data:GetDivergentTaskProgress().questIds
  self._needAnimTaskID = 0
end

function UINActivityDivergentTaskNode:__CheckIDdiffForAnimation()
  local newTasksID = self._data:GetDivergentTaskProgress().questIds
  if #self._existTaskID == #newTasksID then
    for task = 1, #self._existTaskID do
      if newTasksID[task] ~= self._existTaskID[task] then
        self._needAnimTaskID = newTasksID[task]
        return
      end
    end
  end
  if #self._existTaskID < #newTasksID then
    self._needAnimTaskID = newTasksID[#newTasksID]
  end
end

function UINActivityDivergentTaskNode:__SortDivergentTaskData(divergentTaskDatas)
  table.sort(divergentTaskDatas, function(taskDataA, taskDataB)
    local taskCfgA = self._data:GetDivergentTaskGroupCfg(taskDataA.id)
    local taskCfgB = self._data:GetDivergentTaskGroupCfg(taskDataB.id)
    return taskCfgA.task_rank < taskCfgB.task_rank
  end)
end

function UINActivityDivergentTaskNode:__GetNewDivergentTask()
  local divergentTaskProgress = self._data:GetDivergentTaskProgress()
  local mainCfg = self._data:GetDivergentMainCfg()
  if #self._data:GetDivergentTaskDatas() >= mainCfg.task_own_num then
    return
  end
  if divergentTaskProgress.extraGetQuestNum >= mainCfg.task_extra_num then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9604))
    return
  end
  local newItemPriceCfg, newItemPriceNum
  for kItemId, vItemNum in pairs(mainCfg.extra_price) do
    newItemPriceCfg = ConfigData.item[kItemId]
    newItemPriceNum = vItemNum
  end
  local msg = string.format(ConfigData:GetTipContent(9603), tostring(newItemPriceNum) .. LanguageUtil.GetLocaleText(newItemPriceCfg.name))
  local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  local priceBeforeItemIds, payBeforeNums, priceAfterItemIds, payAfterNums, isUsedPaidItem = self:__GetDivergentPriceItemChange(mainCfg.extra_price)
  if isUsedPaidItem and Consts.GameChannelType.IsJp() then
    msg = msg .. ConfigData:GetTipContent(334)
  end
  msgWindow:ShowItemConvert(msg, priceBeforeItemIds, payBeforeNums, priceAfterItemIds, payAfterNums, function()
    ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true):ReqBuyDivergentQuest(self._data:GetActId())
  end)
end

function UINActivityDivergentTaskNode:__ExchangeDivergentTask(taskData)
  local mainCfg = self._data:GetDivergentMainCfg()
  local refreshItemCfg, refreshItemNum
  for kRefreshItemId, vRefreshItemNum in pairs(mainCfg.refresh_price) do
    refreshItemCfg = ConfigData.item[kRefreshItemId]
    refreshItemNum = vRefreshItemNum
  end
  local msg = string.format(ConfigData:GetTipContent(9602), tostring(refreshItemNum) .. LanguageUtil.GetLocaleText(refreshItemCfg.name))
  local msgWindow = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  local priceBeforeItemIds, payBeforeNums, priceAfterItemIds, payAfterNums, isUsedPaidItem = self:__GetDivergentPriceItemChange(mainCfg.refresh_price)
  if isUsedPaidItem and Consts.GameChannelType.IsJp() then
    msg = msg .. ConfigData:GetTipContent(334)
  end
  msgWindow:ShowItemConvert(msg, priceBeforeItemIds, payBeforeNums, priceAfterItemIds, payAfterNums, function()
    ControllerManager:GetController(ControllerTypeId.ActivityDivergent, true):ReqRefreshDivergentQuest(self._data:GetActId(), taskData.id)
  end)
end

function UINActivityDivergentTaskNode:__GetDivergentPriceItemChange(cfgDic)
  table.clearmap(self._priceItemIds)
  table.clearmap(self._payBeforeNums)
  table.clearmap(self._payAfterNums)
  local isUsedPaidItem = false
  local usedPaidItemNumOffset = 0
  for kItemId, vItemNum in pairs(cfgDic) do
    local itemHasNum = PlayerDataCenter:GetItemCount(kItemId)
    local itemAfterNum = itemHasNum - vItemNum
    if kItemId == ConstGlobalItem.PaidSubItem and itemAfterNum < 0 then
      isUsedPaidItem = true
      usedPaidItemNumOffset = usedPaidItemNumOffset + itemAfterNum
    end
    if itemHasNum ~= 0 then
      table.insert(self._priceItemIds, kItemId)
      table.insert(self._payBeforeNums, itemHasNum)
      table.insert(self._payAfterNums, math.max(itemAfterNum, 0))
    end
  end
  if isUsedPaidItem then
    local paidItemNum = PlayerDataCenter:GetItemCount(ConstGlobalItem.PaidItem)
    table.insert(self._priceItemIds, ConstGlobalItem.PaidItem)
    table.insert(self._payBeforeNums, paidItemNum)
    table.insert(self._payAfterNums, math.max(paidItemNum + usedPaidItemNumOffset, 0))
  end
  return self._priceItemIds, self._payBeforeNums, self._priceItemIds, self._payAfterNums, isUsedPaidItem
end

function UINActivityDivergentTaskNode:OnDelete()
  for _, item in pairs(self._taskItemPool.listItem) do
    TimerManager:StopTimer(item.animTimer)
  end
  if self._taskItemPool ~= nil then
    self._taskItemPool = nil
  end
end

return UINActivityDivergentTaskNode

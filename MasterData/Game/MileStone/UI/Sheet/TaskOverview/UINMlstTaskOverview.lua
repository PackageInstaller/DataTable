local base = UIBaseNode
local UINMlstTaskOverview = class("UINMlstTaskOverview", base)
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")
local UINMlstTaskOverviewItem = require("Game.MileStone.UI.Sheet.TaskOverview.UINMlstTaskOverviewItem")
local UINMlstTaskOverModuleTogItem = require("Game.MileStone.UI.Sheet.TaskOverview.UINMlstTaskOverModuleTogItem")
local JumpManager = require("Game.Jump.JumpManager")

function UINMlstTaskOverview:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  self._taskItemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self._OnTaskJumpFunc = BindCallback(self, self._OnTaskJump)
  self._OnSelectModule = BindCallback(self, self._OnSelectModule)
  self._moduleItemPool = UIItemPool.New(UINMlstTaskOverModuleTogItem, self.ui.moduleItem, false)
end

function UINMlstTaskOverview:InitMlstTaskOverview(msData, mlstDemitionData)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):PushTopStatusDataToBackStack()
  self.msData = msData
  self._mlstDemitionData = nil
  self.ui.togGroup:SetAllTogglesOff()
  self._moduleItemPool:HideAll()
  for i = 1, ConfigData.milestone_module.maxModuleId do
    local moduleData = msData:GetMilestoneDimensionData(i)
    local item = self._moduleItemPool:GetOne()
    local isSelect = mlstDemitionData == moduleData
    item:InitMlstTaskOverModuleTogItem(moduleData, self._OnSelectModule, isSelect)
  end
end

function UINMlstTaskOverview:_UpdData()
  self._taskOverviewDataList = {}
  self._allCommend = false
  local highestPercent = 0
  local moduleId = self._mlstDemitionData:GetMlstDimensionId()
  local typeNum = #ConfigData.milestones_mile_task[moduleId]
  for i = 1, typeNum do
    local mlstTaskCfg = ConfigData.milestones_mile_task[moduleId][i]
    local allTaskNum = 0
    local completeTaskNum = 0
    local taskType = MilestoneUtil.GetMlstTaskType(moduleId, i)
    local taskIdDic = ConfigData.milestones_mile_task.mlstTaskTypeIdDic[taskType] or table.emptytable
    for taskId, _ in pairs(taskIdDic) do
      allTaskNum = allTaskNum + 1
      if PlayerDataCenter.allTaskData.completedMilestoneTaskDic[taskId] then
        completeTaskNum = completeTaskNum + 1
      else
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
        if taskData ~= nil and taskData:IsPickedTaskReward() then
          completeTaskNum = completeTaskNum + 1
        end
      end
    end
    local progress = completeTaskNum / allTaskNum
    if highestPercent < progress and progress < 1 then
      highestPercent = progress
    end
    local taskOverviewData = {
      id = i,
      mlstTaskCfg = mlstTaskCfg,
      allTaskNum = allTaskNum,
      progress = progress,
      completeTaskNum = completeTaskNum,
      isRecommend = false
    }
    table.insert(self._taskOverviewDataList, taskOverviewData)
  end
  if self:_IsProgressAllSame() then
    self._allCommend = true
  end
  for index, data in ipairs(self._taskOverviewDataList) do
    if 1 <= data.progress then
    end
    if data.progress < highestPercent - ConfigData.game_config.mlstTaskRecommondValue or self._allCommend then
      data.isRecommend = true
    end
  end
  table.sort(self._taskOverviewDataList, function(a, b)
    if a.progress == b.progress then
      return a.id < b.id
    end
    return a.progress < b.progress
  end)
end

function UINMlstTaskOverview:_RefillScrollRect(refill)
  self.ui.scrollRect.totalCount = #self._taskOverviewDataList
  if refill then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
end

function UINMlstTaskOverview:__OnNewItem(go)
  local item = UINMlstTaskOverviewItem.New()
  item:Init(go)
  self._taskItemDic[go] = item
end

function UINMlstTaskOverview:__OnChangeItem(go, index)
  local item = self._taskItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local taskOverviewData = self._taskOverviewDataList[index + 1]
  if taskOverviewData == nil then
    error("Can't find taskOverviewData by index, index = " .. tonumber(index))
  end
  item:InitMlstTaskOverviewItem(taskOverviewData, self._OnTaskJumpFunc)
end

function UINMlstTaskOverview:_OnSelectModule(mlstDemitionData)
  if self._mlstDemitionData == mlstDemitionData then
    return
  end
  self._mlstDemitionData = mlstDemitionData
  self:_UpdData()
  self:_RefillScrollRect(true)
end

function UINMlstTaskOverview:_OnTaskJump(jumpId, jumpArgs)
  if jumpId ~= nil and jumpId ~= 0 then
    JumpManager:Jump(jumpId, function(jumpCallback)
      if jumpCallback ~= nil then
        jumpCallback()
      end
    end, nil, jumpArgs, false)
  end
end

function UINMlstTaskOverview:_IsProgressAllSame()
  local firstData = self._taskOverviewDataList[1]
  for i = 2, #self._taskOverviewDataList do
    if self._taskOverviewDataList[i].progress ~= firstData.progress then
      return false
    end
  end
  return true
end

function UINMlstTaskOverview:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINMlstTaskOverview:OnDelete()
  for k, v in pairs(self._taskItemDic) do
    v:Delete()
  end
  self._moduleItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINMlstTaskOverview

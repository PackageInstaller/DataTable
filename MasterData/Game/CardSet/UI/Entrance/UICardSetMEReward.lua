local base = UIBaseWindow
local UICardSetMEReward = class("UICardSetMEReward", UIBaseWindow)
local UINCardSetMERewardTaskItemNode = require("Game.CardSet.UI.Entrance.UINCardSetMERewardTaskItemNode")
local color_orange = Color.New(1.0, 0.4196078431372549, 0.06274509803921569)

function UICardSetMEReward:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(BindCallback(self, self.Delete)):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.__SendPickAll)
  self.__sendPickTask = BindCallback(self, self.__SendPickTask)
  self.ui.taskList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.taskList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.taskItemDic = {}
end

function UICardSetMEReward:InitCSMERewardNode(actCardData)
  self.actCardData = actCardData
  self:__RefreshAllTask()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = actCardData:GetActId()
  saveUserData:SetCardSetIsEnterRankTask(actId)
  actCardData:RefreshCardSetBlueFirstEnterRankTask()
end

function UICardSetMEReward:__RefreshAllTask()
  local taskList = self.actCardData:GetActCardSetRewardTaskIdList()
  local isHaveCouldPickOne = false
  local taskDataList = {}
  for _, taskId in ipairs(taskList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(taskDataList, taskData)
    if not isHaveCouldPickOne and taskData:CheckComplete() then
      isHaveCouldPickOne = true
    end
  end
  table.sort(taskDataList, function(a, b)
    if a.isPicked ~= b.isPicked then
      return not a.isPicked
    end
    local aComplete = a:CheckComplete()
    if aComplete ~= b:CheckComplete() then
      return aComplete
    end
    return a.id < b.id
  end)
  self.taskDataList = taskDataList
  self.ui.taskList.totalCount = #self.taskDataList
  self.ui.taskList:RefillCells()
  self.ui.btn_GetAll.targetGraphic.color = isHaveCouldPickOne and color_orange or Color.gray
end

function UICardSetMEReward:m_OnNewItem(go)
  local taskItem = UINCardSetMERewardTaskItemNode.New()
  taskItem:Init(go)
  self.taskItemDic[go] = taskItem
end

function UICardSetMEReward:m_OnChangeItem(go, index)
  local taskItem = self.taskItemDic[go]
  if taskItem == nil then
    error("Can't find taskItem by gameObject")
    return
  end
  local taskData = self.taskDataList[index + 1]
  if taskData == nil then
    error("Can't find taskData by index, index = " .. tonumber(index))
  end
  taskItem:RefreshCSMERTaskItem(taskData, self.__sendPickTask)
end

function UICardSetMEReward:__SendPickTask(taskData)
  if not taskData:CheckComplete() then
    return
  end
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtrl:SendCommitQuestReward(taskData, true, function()
    self:__RefreshAllTask()
    self.actCardData:RefreshCardSetRedRankTask()
  end)
end

function UICardSetMEReward:__SendPickAll()
  local isHaveCouldPickOne = false
  local completedTaskIdDic = {}
  for key, taskData in pairs(self.taskDataList) do
    local isComplete = taskData:CheckComplete()
    if isComplete then
      completedTaskIdDic[taskData.id] = true
      isHaveCouldPickOne = true
    end
  end
  if not isHaveCouldPickOne then
    return
  end
  local taskctl = ControllerManager:GetController(ControllerTypeId.Task, true)
  taskctl:SendOneKeyPick(completedTaskIdDic, function()
    self:__RefreshAllTask()
    self.actCardData:RefreshCardSetRedRankTask()
  end)
end

function UICardSetMEReward:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UICardSetMEReward:OnDelete()
  base.OnDelete(self)
end

return UICardSetMEReward

local UINActivityHazeGiftRewardGroup = class("UINActivityHazeGiftRewardGroup", UIBaseNode)
local base = UIBaseNode
local UINActivityHazeGiftTaskItem = require("Game.ActivityHazeGift.UI.UINActivityHazeGiftTaskItem")

function UINActivityHazeGiftRewardGroup:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBack)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnGetAllTaskDataCallback = BindCallback(self, self.__OnGetAllTaskData)
  self.__OnGetTaskDataCallback = BindCallback(self, self.__OnGetTaskData)
  self.__OnGotoTaskDataCallback = BindCallback(self, self.__OnGotoTaskData)
  self.__RefillFromExternalCallback = BindCallback(self, self.__RefillFromExternal)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self.__TaskDeleteCallback = BindCallback(self, self.__TaskProcessDelete)
  MsgCenter:AddListener(eMsgEventId.TaskDelete, self.__TaskDeleteCallback)
  self.ui.btn_ReceiveAll.gameObject:SetActive(false)
  self.ui.go_cantGetAll:SetActive(true)
  self._itemDic = {}
end

function UINActivityHazeGiftRewardGroup:InitHazeGiftRewardWindow(taskIdList, allGetCallback, singleGetCallback)
  self._taskIdDic = {}
  for i, v in ipairs(taskIdList) do
    self._taskIdDic[v] = true
  end
  self._allGetCallback = allGetCallback
  self._singleGetCallback = singleGetCallback
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.__OnGetAllTaskDataCallback)
  self:__Refill()
end

function UINActivityHazeGiftRewardGroup:__Refill()
  self._taskDataList = {}
  local totalCount = 0
  local finishCount = 0
  local isCanGet = false
  for taskId, _ in pairs(self._taskIdDic) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(self._taskDataList, taskData)
    totalCount = totalCount + 1
    if taskData.isPicked then
      finishCount = finishCount + 1
    end
    isCanGet = isCanGet or taskData:CheckComplete()
  end
  table.sort(self._taskDataList, function(a, b)
    if a.isPicked ~= b.isPicked then
      return b.isPicked
    end
    local isComplete = a:CheckComplete()
    if isComplete ~= b:CheckComplete() then
      return isComplete
    end
    return a.id < b.id
  end)
  self._taskItemDic = {}
  self.ui.loop_scroll.totalCount = totalCount
  self.ui.loop_scroll:RefillCells()
  self.ui.btn_ReceiveAll.gameObject:SetActive(isCanGet)
  self.ui.go_cantGetAll:SetActive(not isCanGet)
end

function UINActivityHazeGiftRewardGroup:__RefillFromExternal()
  if not IsNull(self.transform) then
    self:__Refill()
  end
end

function UINActivityHazeGiftRewardGroup:SetEnvTaskTitle(titleName)
  self.ui.tex_SkillName.text = titleName
end

function UINActivityHazeGiftRewardGroup:__OnNewItem(go)
  local taskItem = UINActivityHazeGiftTaskItem.New()
  taskItem:Init(go)
  self._itemDic[go] = taskItem
end

function UINActivityHazeGiftRewardGroup:__OnChangeItem(go, index)
  local taskItem = self._itemDic[go]
  local taskData = self._taskDataList[index + 1]
  taskItem:InitHazeGiftTaskItem(taskData, self.__OnGetTaskDataCallback, self.__OnGotoTaskDataCallback)
  self._taskItemDic[taskData.id] = taskItem
end

function UINActivityHazeGiftRewardGroup:__OnGetAllTaskData()
  if self._allGetCallback then
    local taskIdDic = {}
    for _, data in ipairs(self._taskDataList) do
      if data:CheckComplete() then
        taskIdDic[data.id] = true
      end
    end
    self._allGetCallback(taskIdDic, self.__RefillFromExternalCallback)
  end
end

function UINActivityHazeGiftRewardGroup:__OnGetTaskData(taskData)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtr:SendCommitQuestReward(taskData, true, function()
    if self._singleGetCallback ~= nil then
      self._singleGetCallback(taskData.id, self.__RefillFromExternalCallback)
    end
  end, nil)
end

function UINActivityHazeGiftRewardGroup:__OnGotoTaskData(taskData)
  if taskData.stcData.jump_id ~= nil and taskData.stcData.jump_id > 0 then
    JumpManager:Jump(taskData.stcData.jump_id, nil, nil, taskData.stcData.jumpArgs)
  end
end

function UINActivityHazeGiftRewardGroup:__TaskProcessUpdate(taskData)
  if self._taskIdDic == nil or self._taskIdDic[taskData.id] == nil then
    return
  end
  if taskData:CheckComplete() then
    self:__Refill()
    return
  end
  local item = self._taskItemDic[taskData.id]
  if item ~= nil and item:GetEnvTaskId() == taskData.id then
    item:RefreshHazeGiftTaskItem()
  end
end

function UINActivityHazeGiftRewardGroup:__TaskProcessDelete(taskID)
  if self._taskIdDic == nil or self._taskIdDic[taskID] == nil then
    return
  end
  self:__Refill()
end

function UINActivityHazeGiftRewardGroup:OnClickBack()
  self.gameObject:SetActive(false)
  UIUtil.RemoveButtonListener(self.ui.btn_ReceiveAll)
end

function UINActivityHazeGiftRewardGroup:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.TaskDelete, self.__TaskDeleteCallback)
  base.OnDelete(self)
end

return UINActivityHazeGiftRewardGroup

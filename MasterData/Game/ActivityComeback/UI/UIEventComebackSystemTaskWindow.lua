local UIEventComebackSystemTaskWindow = class("UIEventComebackSystemTaskWindow", UIBaseWindow)
local base = UIBaseWindow
local UINEventComebackTaskItem = require("Game.ActivityComeback.UI.UINEventComebackTaskItem")

function UIEventComebackSystemTaskWindow:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  UIUtil.RefreshTopResId(nil)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickBack)
  self.ui.taskList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.taskList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__TaskClickCallback = BindCallback(self, self.__TaskClick)
  self.__TaskUpdateCallback = BindCallback(self, self.__TaskUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  self.__RefreshCallback = BindCallback(self, self.__Refresh)
  MsgCenter:AddListener(eMsgEventId.ActivityTaskUpdate, self.__RefreshCallback)
end

function UIEventComebackSystemTaskWindow:InitComebackSystemTaskWindow(taskIdList, singleGetCallback)
  self._taskIdDic = {}
  self._goItem = {}
  self._taskitemDic = {}
  for i, v in ipairs(taskIdList) do
    self._taskIdDic[v] = true
  end
  self._singleGetCallback = singleGetCallback
  self:__Refill()
end

function UIEventComebackSystemTaskWindow:__Refill()
  local taskDataList = {}
  for taskId, _ in pairs(self._taskIdDic) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(taskDataList, taskData)
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
  self._taskDataList = taskDataList
  self.ui.taskList.totalCount = #self._taskDataList
  self.ui.taskList:RefillCells()
end

function UIEventComebackSystemTaskWindow:__OnInstantiateItem(go)
  local item = UINEventComebackTaskItem.New()
  item:Init(go)
  self._goItem[go] = item
end

function UIEventComebackSystemTaskWindow:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local taskData = self._taskDataList[index + 1]
  item:InitCombackTaskItem(taskData, self.__TaskClickCallback)
  self._taskitemDic[taskData.id] = item
end

function UIEventComebackSystemTaskWindow:__TaskClick(taskData)
  if self._singleGetCallback ~= nil then
    self._singleGetCallback(taskData, BindCallback(self, self.__Refresh))
  end
end

function UIEventComebackSystemTaskWindow:__Refresh()
  self:__Refill()
end

function UIEventComebackSystemTaskWindow:__TaskUpdate(taskData)
  if self._taskitemDic == nil then
    return
  end
  local item = self._taskitemDic[taskData.id]
  if item == nil then
    return
  end
  if taskData:CheckComplete() then
    self:__Refill()
    return
  end
  item:RefreshCombackTaskItem()
end

function UIEventComebackSystemTaskWindow:OnClickBack()
  self:Delete()
end

function UIEventComebackSystemTaskWindow:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityTaskUpdate, self.__RefreshCallback)
  base.OnDelete(self)
end

return UIEventComebackSystemTaskWindow

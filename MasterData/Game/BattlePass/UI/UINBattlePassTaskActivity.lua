local UINBattlePassTaskActivity = class("UINBattlePassTaskActivity", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local UINBattlePassTaskListItemActivity = require("Game.BattlePass.UI.UINBattlePassTaskListItemActivity")

function UINBattlePassTaskActivity:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.slotItemDic = {}
  self.dataList = {}
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_ReceiveAll, self, self.OnClickReceiveAll)
  self.__BpTaskUpdateCallback = BindCallback(self, self.__BpTaskUpdate)
  MsgCenter:AddListener(eMsgEventId.BattlePassTaskUpdate, self.__BpTaskUpdateCallback)
  self.ui.loop_scroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loop_scroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__BpRunningEndCallback = BindCallback(self, self.__BpRunningEnd)
  MsgCenter:AddListener(eMsgEventId.BattlePassRunningEnd, self.__BpRunningEndCallback)
end

function UINBattlePassTaskActivity:InitBattlePassTask(passInfo)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  self.passInfo = passInfo
  self.passInfoCfg = self.passInfo:GetPassCfg()
  self.ui.tex_Title:SetIndex(0, LanguageUtil.GetLocaleText(self.passInfoCfg.name))
  self:__RefreshAllTaskUI()
end

function UINBattlePassTaskActivity:__RefreshAllTaskUI()
  self.completedTaskIdDic = {}
  self.bpTaskIdDic = {}
  if self.dataList == nil then
    self.dataList = {}
  else
    table.removeall(self.dataList)
  end
  for _, taskData in ipairs(self.passInfo:GetBpTaskData()) do
    local taskId = taskData.id
    table.insert(self.dataList, taskData)
    self.bpTaskIdDic[taskId] = taskData
    if taskData:CheckComplete() then
      self.completedTaskIdDic[taskId] = true
    end
  end
  self:__SortTaskData(self.dataList)
  local num = #self.dataList
  self.ui.loop_scroll.totalCount = num
  self.ui.loop_scroll:RefillCells()
  self.ui.btn_ReceiveAll.interactable = self.passInfo:GetHasBpTaskComplete()
  self.ui.btn_ReceiveAll.gameObject:SetActive(self.passInfo:GetHasBpTaskComplete())
end

function UINBattlePassTaskActivity:__SortTaskData(taskDataList)
  table.sort(taskDataList, function(a, b)
    if a.state == TaskEnum.eTaskState.Picked then
      return false
    elseif b.state == TaskEnum.eTaskState.Picked then
      return true
    end
    local aComplete = a:CheckComplete()
    local bComplete = b:CheckComplete()
    if aComplete ~= bComplete then
      return aComplete
    end
    return a.id < b.id
  end)
end

function UINBattlePassTaskActivity:__BpTaskUpdate(passInfo)
  if self.passInfo ~= passInfo then
    return
  end
  self:__RefreshAllTaskUI()
end

function UINBattlePassTaskActivity:__BpRunningEnd(passInfo)
  if self.passInfo ~= passInfo then
    return
  end
  if self.gameObject.activeSelf then
    self:OnClickClose()
  end
end

function UINBattlePassTaskActivity:__OnNewItem(go)
  local taskItem = UINBattlePassTaskListItemActivity.New()
  taskItem:Init(go)
  self.slotItemDic[go] = taskItem
end

function UINBattlePassTaskActivity:__OnChangeItem(go, index)
  local taskItem = self.slotItemDic[go]
  if taskItem == nil then
    error("Can't find taskItem by gameObject")
    return
  end
  local taskData = self.dataList[index + 1]
  if taskData == nil then
    error("Can't find taskData by index, index = " .. tonumber(index))
  end
  taskItem:InitTaskItem(taskData)
end

function UINBattlePassTaskActivity:OnClickReceiveAll()
  if table.count(self.completedTaskIdDic) > 0 then
    local taskctl = ControllerManager:GetController(ControllerTypeId.Task, true)
    taskctl:SendOneKeyPick(self.completedTaskIdDic)
    table.removeall(self.completedTaskIdDic)
    return
  end
end

function UINBattlePassTaskActivity:_BackAction()
  self:Hide()
end

function UINBattlePassTaskActivity:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINBattlePassTaskActivity:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.BattlePassTaskUpdate, self.__BpTaskUpdateCallback)
  MsgCenter:RemoveListener(eMsgEventId.BattlePassRunningEnd, self.__BpRunningEndCallback)
  base.OnDelete(self)
end

return UINBattlePassTaskActivity

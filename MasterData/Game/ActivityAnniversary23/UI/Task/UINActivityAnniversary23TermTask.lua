local base = require("Game.CommonUI.Activity.UINActivityCommonTermTaskNode")
local UINActivityAnniversary23TermTask = class("UINActivityAnniversary23TermTask", base)
local JumpManager = require("Game.Jump.JumpManager")
local UINActivityAnniversary23TermTaskItem = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23TermTaskItem")
local UINActivityAnniversary23TermPeriodListNode = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23TermPeriodListNode")

function UINActivityAnniversary23TermTask:BindAnniversary23TermTaskOpenFunc(func)
  self._openFunc = func
end

function UINActivityAnniversary23TermTask:InitTermTaskNode(actTermTaskData, term, actData)
  self._actTermTaskData = actTermTaskData
  self._term = term
  self._actData = actData
  self._taskItemDic = {}
  self._taskIdDic = {}
  local onceTaskIds = self._actTermTaskData:GetTermTaskIds(self._term)
  for _, taskId in pairs(onceTaskIds) do
    self._taskIdDic[taskId] = true
  end
  self.ui.btn_GetAll.gameObject:SetActive(false)
  self.ui.PeroidListNode:SetActive(false)
  local allCfg = ConfigData.activity_general_quest_bp[actTermTaskData._frameId]
  if allCfg ~= nil and self._peroidListNode == nil then
    self._peroidListNode = UINActivityAnniversary23TermPeriodListNode.New()
    self._peroidListNode:Init(self.ui.PeroidListNode)
    self.ui.PeroidListNode:SetActive(true)
  end
  self:RefreshTermPeroidListNode()
end

function UINActivityAnniversary23TermTask:RefillTermTaskNode()
  self:__SortTaskList()
  self.ui.taskList.totalCount = #self._taskDataList
  self.ui.taskList:RefillCells()
  self:PlayTaskNodeAnim()
end

function UINActivityAnniversary23TermTask:RefreshTermPeroidListNode()
  if self._openFunc ~= nil then
    self._openFunc()
  end
  if self._peroidListNode ~= nil then
    self._peroidListNode:InitTermPeroidList(self._actTermTaskData, self._term, BindCallback(self, self.RefreshTermPeroidListNode))
  end
end

function UINActivityAnniversary23TermTask:__OnInstantiateItem(go)
  local item = UINActivityAnniversary23TermTaskItem.New()
  item:Init(go)
  self._goItem[go] = item
end

function UINActivityAnniversary23TermTask:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local taskData = self._taskDataList[index + 1]
  local isSpecail, textIndex = self._actData:CheckIsSpecialTaskByTaskId(taskData.id)
  item:InitTermTaskItem(taskData, self.__TaskClickCallback, index, isSpecail, textIndex)
  self._taskItemDic[taskData.id] = item
end

function UINActivityAnniversary23TermTask:RefreshTermTaskChange(taskData)
  local item = self._taskItemDic[taskData.id]
  if item ~= nil and item:GetTermTaskId() == taskData.id then
    if taskData:CheckComplete() then
      self:RefillTermTaskNode()
    else
      item:RefreshTermTaskItem()
    end
    if taskData:CheckComplete() then
      self.ui.btn_GetAll.gameObject:SetActive(true)
    end
  end
end

function UINActivityAnniversary23TermTask:__RefreshGetAllBtn(getAllActive)
  self.ui.GetAllItem:SetActive(getAllActive)
  self.ui.btn_GetAll.gameObject:SetActive(getAllActive)
end

function UINActivityAnniversary23TermTask:__TaskClick(taskData)
  if not taskData:CheckComplete() then
    local flag, jumpId, jumpArgs = taskData:GetTaskJumpArg()
    if flag then
      JumpManager:Jump(jumpId, nil, nil, jumpArgs)
    end
    return
  end
  self._actTermTaskData:ReqCommitTermOnceTask(taskData.id, function()
    if not IsNull(self.transform) then
      self:RefillTermTaskNode()
    end
    self:RefreshTermPeroidListNode()
  end)
end

function UINActivityAnniversary23TermTask:OnClickGetAll()
  self._actTermTaskData:ReqCommitTermAllTask(self._term, function()
    if not IsNull(self.transform) then
      self:RefillTermTaskNode()
    end
    self:RefreshTermPeroidListNode()
  end)
end

function UINActivityAnniversary23TermTask:__SortTaskList()
  local function showCurrectTaskFunc(taskId)
    local taskCfg = ConfigData.task[taskId]
    
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskCfg == nil or taskData == nil then
      error("cant find taskCfg or taskData!")
      return nil
    end
    if taskCfg ~= nil and taskCfg.show_pre > 0 then
      local preTaskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskCfg.show_pre, true)
      return preTaskData.isPicked and showCurrectTaskFunc(taskCfg.show_pre)
    end
    return true
  end
  
  local taskDataList = {}
  local getAllActive = false
  for taskId, _ in pairs(self._taskIdDic) do
    local canShow = showCurrectTaskFunc(taskId)
    if canShow then
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
      table.insert(taskDataList, taskData)
      if not getAllActive and taskData:CheckComplete() then
        getAllActive = true
      end
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
    local aIsSpecial = self._actData:CheckIsSpecialTaskByTaskId(a.id)
    local bIsSpecial = self._actData:CheckIsSpecialTaskByTaskId(b.id)
    if aIsSpecial ~= bIsSpecial then
      return aIsSpecial
    end
    return a.id < b.id
  end)
  self._taskDataList = taskDataList
  self:__RefreshGetAllBtn(getAllActive)
end

return UINActivityAnniversary23TermTask

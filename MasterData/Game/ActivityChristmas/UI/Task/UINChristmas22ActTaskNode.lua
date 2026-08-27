local UINChristmas22ActTaskNode = class("UINChristmas22ActTaskNode", UIBaseNode)
local base = UIBaseNode
local UINChristmas22ActTaskItem = require("Game.ActivityChristmas.UI.Task.UINChristmas22ActTaskItem")

function UINChristmas22ActTaskNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnClickGetAll)
  self.ui.taskList.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.taskList.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__TaskClickCallback = BindCallback(self, self.__TaskClick)
  self._goItem = {}
end

function UINChristmas22ActTaskNode:InitChristmas22ActTaskNode(hallowmasData)
  self._hallowmasData = hallowmasData
  self._taskitemDic = {}
  self._taskIdDic = {}
  local achieveCfg = self._hallowmasData:GetHallowmasAchievementCfg()
  for taskId, _ in pairs(achieveCfg) do
    self._taskIdDic[taskId] = true
  end
end

function UINChristmas22ActTaskNode:RefillChristmas22ActTaskNode()
  local taskDataList = {}
  local getAllActive = false
  for taskId, _ in pairs(self._taskIdDic) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    table.insert(taskDataList, taskData)
    if not getAllActive and taskData:CheckComplete() then
      getAllActive = true
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
  self._taskDataList = taskDataList
  self.ui.taskList.totalCount = #self._taskDataList
  self.ui.taskList:RefillCells()
  self:__RefreshGetAllBtn(getAllActive)
  self:PlayChristmasActTaskNodeAnim()
end

function UINChristmas22ActTaskNode:__RefreshGetAllBtn(getAllActive)
  self.ui.btn_GetAll.gameObject:SetActive(getAllActive)
end

function UINChristmas22ActTaskNode:__OnInstantiateItem(go)
  local item = UINChristmas22ActTaskItem.New()
  item:Init(go)
  self._goItem[go] = item
end

function UINChristmas22ActTaskNode:__OnChangeItem(go, index)
  local item = self._goItem[go]
  local taskData = self._taskDataList[index + 1]
  item:InitChristmas22ActTaskItem(taskData, self.__TaskClickCallback, index)
  self._taskitemDic[taskData.id] = item
end

function UINChristmas22ActTaskNode:RefreshChristmas22ActTaskChange(taskData)
  local item = self._taskitemDic[taskData.id]
  if item ~= nil and item:GetChristmasActTaskId() == taskData.id then
    if taskData:CheckComplete() then
      self:RefillChristmas22ActTaskNode()
    else
      item:RefreshChristmas22ActTaskItem()
    end
    if taskData:CheckComplete() then
      self.ui.btn_GetAll.gameObject:SetActive(true)
    end
  end
end

function UINChristmas22ActTaskNode:OnClickGetAll()
  self._hallowmasData:ReqHallowmasAllChievement(function()
    if not IsNull(self.transform) then
      self:RefillChristmas22ActTaskNode()
    end
  end)
end

function UINChristmas22ActTaskNode:__TaskClick(taskData)
  self._hallowmasData:ReqHallowmasCommitTask(taskData.id, function()
    if not IsNull(self.transform) then
      self:RefillChristmas22ActTaskNode()
    end
  end)
end

function UINChristmas22ActTaskNode:PlayChristmasActTaskNodeAnim()
  for _, item in pairs(self._taskitemDic) do
    if not IsNull(item) then
      item:PlayChristmasActTaskAnim()
    end
  end
end

function UINChristmas22ActTaskNode:OnDelete()
  for _, item in pairs(self._taskitemDic) do
    item:Delete()
  end
end

return UINChristmas22ActTaskNode

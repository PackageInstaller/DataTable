local UIChristmas22Task = class("UIChristmas22Task", UIBaseWindow)
local base = UIBaseWindow
local ActivityHallowmasEnum = require("Game.ActivityHallowmas.ActivityHallowmasEnum")
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local titleTypeEnum = {onceTask = 1, dailyTask = 2}

function UIChristmas22Task:__SetNodeClass()
  self._LimitTaskNodeClass = require("Game.ActivityChristmas.UI.Task.UINChristmas22LimitTaskNode")
  self._ActTaskNodeClass = require("Game.ActivityChristmas.UI.Task.UINChristmas22ActTaskNode")
  self._pageNodeClass = require("Game.ActivityChristmas.UI.Task.UINChristmasTaskPageItem")
end

function UIChristmas22Task:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseTaskUI)
  self:__SetNodeClass()
  self._pageItemPool = UIItemPool.New(self._pageNodeClass, self.ui.pageItem)
  self.ui.pageItem:SetActive(false)
  self.__SetPageCallback = BindCallback(self, self.__SetPage)
  self._typeFunc = {
    [titleTypeEnum.onceTask] = self.__OpenOnceTask,
    [titleTypeEnum.dailyTask] = self.__OpenDailyTask
  }
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
end

function UIChristmas22Task:InitChristmas22Task(hallowmasData, closeEvent)
  self._hallowmasData = hallowmasData
  self._closeEvent = closeEvent
  self._pageItemPool:HideAll()
  local count = table.count(titleTypeEnum)
  for i = 1, count do
    local item = self._pageItemPool:GetOne()
    item:InitChristmasTaskPageItem(i, self.__SetPageCallback)
    item:ShowChristmasTaskPageLine(i ~= count)
  end
  if not IsNull(self.ui.obj_ListNode) then
    self.ui.obj_ListNode.transform:SetAsLastSibling()
  end
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.pageList)
  self._reddot = self._hallowmasData:GetActivityReddot()
  if self._reddot ~= nil then
    self._reddotFunc = BindCallback(self, self.__RefreshReddot)
    RedDotController:AddListener(self._reddot.nodePath, self._reddotFunc)
    self:__RefreshReddot(self._reddot)
  end
  self:__FirstOpenPage()
end

function UIChristmas22Task:__FirstOpenPage()
  self:__SetPage(titleTypeEnum.onceTask)
end

function UIChristmas22Task:__SetPage(titleType)
  if self._titleType == titleType then
    return
  end
  self._titleType = titleType
  for i, v in ipairs(self._pageItemPool.listItem) do
    v:SetChristmasTaskPageSelect(self._titleType)
  end
  local item = self._pageItemPool.listItem[self._titleType]
  self.ui.img_Selected.anchoredPosition = item.transform.anchoredPosition
  self._typeFunc[titleType](self)
end

function UIChristmas22Task:__OpenOnceTask()
  if self._dailyNode ~= nil and self._dailyNode.active then
    self._dailyNode:Hide()
  else
    self.ui.limitTaskNode:SetActive(false)
  end
  if self._onceNode == nil then
    self.ui.actTaskNode:SetActive(true)
    self._onceNode = self._ActTaskNodeClass.New()
    self._onceNode:Init(self.ui.actTaskNode)
    self._onceNode:InitChristmas22ActTaskNode(self._hallowmasData)
  else
    self._onceNode:Show()
  end
  self._onceNode:RefillChristmas22ActTaskNode()
  if not IsNull(self.ui.obj_ListNode) then
    self.ui.obj_ListNode:SetActive(false)
  end
end

function UIChristmas22Task:__OpenDailyTask()
  if self._onceNode ~= nil and self._onceNode.active then
    self._onceNode:Hide()
  else
    self.ui.actTaskNode:SetActive(false)
  end
  if self._dailyNode == nil then
    self.ui.limitTaskNode:SetActive(true)
    self._dailyNode = self._LimitTaskNodeClass.New()
    self._dailyNode:Init(self.ui.limitTaskNode)
    self._dailyNode:InitChristmas22LimitTaskNode(self._hallowmasData)
  else
    self._dailyNode:Show()
  end
  self._dailyNode:RefillChristmas22LimitTaskNode()
  if not IsNull(self.ui.obj_ListNode) then
    self.ui.obj_ListNode:SetActive(true)
  end
end

function UIChristmas22Task:__RefreshReddot(reddot)
  local taskRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.DailyTask)
  local achievementRed = reddot:GetChild(ActivityHallowmasEnum.reddotType.Achievement)
  local achievementPage = self._pageItemPool.listItem[titleTypeEnum.onceTask]
  if achievementPage ~= nil and achievementRed ~= nil then
    achievementPage:SetChristmasTaskPageRed(achievementRed:GetRedDotCount() > 0)
  end
  local dailyPage = self._pageItemPool.listItem[titleTypeEnum.dailyTask]
  if dailyPage ~= nil and taskRed ~= nil then
    dailyPage:SetChristmasTaskPageRed(taskRed:GetRedDotCount() > 0)
  end
end

function UIChristmas22Task:__TaskProcessUpdate(taskData)
  if self._titleType == titleTypeEnum.onceTask then
    self._onceNode:RefreshChristmas22ActTaskChange(taskData)
  elseif self._titleType == titleTypeEnum.dailyTask then
    self._dailyNode:RefreshChristmas22LimitTaskChange(taskData)
  end
end

function UIChristmas22Task:OnCloseTaskUI(tohome)
  self:Delete()
  if self._closeEvent ~= nil then
    self._closeEvent(tohome)
    self._closeEvent = nil
  end
end

function UIChristmas22Task:OnDelete()
  if self._onceNode ~= nil then
    self._onceNode:Delete()
  end
  if self._dailyNode ~= nil then
    self._dailyNode:Delete()
  end
  if self._reddot ~= nil then
    RedDotController:RemoveListener(self._reddot.nodePath, self._reddotFunc)
    self._reddot = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  base.OnDelete(self)
end

return UIChristmas22Task

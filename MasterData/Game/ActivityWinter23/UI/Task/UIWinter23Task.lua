local UIWinter23Task = class("UIWinter23Task", UIBaseWindow)
local base = UIBaseWindow
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local UINSpring23TaskPageItem = require("Game.ActivitySpring.UI.Task.UINSpring23TaskPageItem")
local UINWinter23DailyTask = require("Game.ActivityWinter23.UI.Task.UINWinter23DailyTask")
local UINWinter23TermTask = require("Game.ActivityWinter23.UI.Task.UINWinter23TermTask")
local cs_ResLoader = CS.ResLoader
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local DefaultDailyTaskTitle = 6
local DefaultTermTaskTitles = {7, 8}
local DailyTaskTitle = {
  [ActivityFrameEnum.eActivityType.Winter23] = 4
}
local TermTaskTitles = {
  [ActivityFrameEnum.eActivityType.Winter23] = {3, 5}
}

function UIWinter23Task:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseTaskUI)
  self._pageItemPool = UIItemPool.New(UINSpring23TaskPageItem, self.ui.pageItem)
  self.ui.pageItem:SetActive(false)
  self.__SetPageCallback = BindCallback(self, self.__SetPage)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  self.__RefreshDailyTaskWhenExpireCallback = BindCallback(self, self.__RefreshDailyTaskWhenExpire)
  MsgCenter:AddListener(eMsgEventId.ActivityDailyTaskExpired, self.__RefreshDailyTaskWhenExpireCallback)
  self.__RefreshTermTaskWhenExpireCallback = BindCallback(self, self.__RefreshTermTaskWhenExpire)
  MsgCenter:AddListener(eMsgEventId.ActivityTermTaskExpired, self.__RefreshTermTaskWhenExpireCallback)
  self._actBgNode = UINCommonActivityBG.New()
  self._actBgNode:Init(self.ui.uI_CommonActivityBG)
  self._resloader = cs_ResLoader.Create()
end

function UIWinter23Task:InitWinter23Task(actFrameId, dailyTaskData, termTaskData, closeEvent)
  self._dailyTaskData = dailyTaskData
  self._termTaskData = termTaskData
  self._closeEvent = closeEvent
  self.actFrameId = actFrameId
  local frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._frameData = frameCtrl:GetActivityFrameData(actFrameId)
  self._pageOpenFuncMap = {}
  self._pageRedFuncMap = {}
  self._pageItemPool:HideAll()
  local firstEnterPageItem
  self._nextTermPageIndex = nil
  if termTaskData ~= nil then
    local count = termTaskData:GetTermTaskStageCount()
    for i = 1, count do
      if termTaskData:GetTermOpenTime(i) > PlayerDataCenter.timestamp then
        self._nextTermPageIndex = i
        break
      end
      firstEnterPageItem = self:__CreateTermPage(i)
    end
  end
  if dailyTaskData ~= nil then
    firstEnterPageItem = self:__CreateDailyPage()
  end
  for k, func in pairs(self._pageRedFuncMap) do
    func()
  end
  self.ui.obj_ListNode.transform:SetAsLastSibling()
  cs_LayoutRebuilder.ForceRebuildLayoutImmediate(self.ui.pageList)
  firstEnterPageItem:OnClickSelect()
  self._actBgNode:InitActivityBG(actFrameId, self._resloader)
  self:PlayPageListAnim()
end

function UIWinter23Task:__CreateTermPage(index, isAddModel)
  local item = self._pageItemPool:GetOne()
  local func = BindCallback(self, self.__OpenTermTask, index)
  self._pageOpenFuncMap[item] = func
  local redFunc = BindCallback(self, self.__RefreshRedTermTask, item, index)
  self._pageRedFuncMap[item] = redFunc
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self.actFrameId)
  local actType = actFrameData:GetActivityFrameCat()
  local termTaskTitle = TermTaskTitles[actType] or DefaultTermTaskTitles
  item:InitChristmasTaskPageItemParam2(termTaskTitle[index] or 0, 1, self.__SetPageCallback)
  item:ShowChristmasTaskPageLine(true)
  if isAddModel then
    item.transform:SetSiblingIndex(index)
  end
  return item
end

function UIWinter23Task:__CreateDailyPage()
  local item = self._pageItemPool:GetOne()
  local func = BindCallback(self, self.__OpenDailyTask)
  self._pageOpenFuncMap[item] = func
  local redFunc = BindCallback(self, self.__RefreshRedDailyTask, item)
  self._pageRedFuncMap[item] = redFunc
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self.actFrameId)
  local actType = actFrameData:GetActivityFrameCat()
  local dailyTaskTitle = DailyTaskTitle[actType] or DefaultDailyTaskTitle
  item:InitChristmasTaskPageItemParam2(dailyTaskTitle, 2, self.__SetPageCallback)
  item:ShowChristmasTaskPageLine(false)
  return item
end

function UIWinter23Task:__TaskProcessUpdate(taskData)
  if self._dailyTaskNode ~= nil and self._dailyTaskNode.active then
    self._dailyTaskNode:RefreshChristmas22LimitTaskChange(taskData)
  elseif self._termTaskNode ~= nil and self._termTaskNode.active then
    self._termTaskNode:RefreshChristmas22ActTaskChange(taskData)
  end
  if taskData:CheckComplete() then
    for k, func in pairs(self._pageRedFuncMap) do
      func()
    end
  end
end

function UIWinter23Task:__RefreshDailyTaskWhenExpire(frameId)
  if self._frameData ~= nil and frameId == self._frameData:GetActivityFrameId() and self._dailyTaskNode ~= nil then
    self._dailyTaskNode:RefillChristmas22LimitTaskNode()
  end
end

function UIWinter23Task:__RefreshTermTaskWhenExpire(frameId)
  if self._frameData ~= nil and frameId == self._frameData:GetActivityFrameId() and self._nextTermPageIndex ~= nil then
    local count = self._termTaskData:GetTermTaskStageCount()
    local start = self._nextTermPageIndex
    self._nextTermPageIndex = nil
    for i = start, count do
      if self._termTaskData:GetTermOpenTime(i) > PlayerDataCenter.timestamp then
        self._nextTermPageIndex = i
        break
      end
      self:__CreateTermPage(i, true)
    end
  end
end

function UIWinter23Task:__SetPage(titleType, item)
  if self._selectItem == item then
    return
  end
  local reddotFunc = self._pageRedFuncMap[item]
  local openFunc = self._pageOpenFuncMap[item]
  local coundOpen = openFunc ~= nil and openFunc(reddotFunc)
  if coundOpen then
    for i, v in ipairs(self._pageItemPool.listItem) do
      v:SetChristmasTaskPageSelectFlag(v == item)
    end
    self._selectItem = item
    local pos = self.ui.img_Selected.anchoredPosition
    pos.y = item.transform.anchoredPosition.y
    self.ui.img_Selected.anchoredPosition = pos
    self.ui.img_Selected.transform:SetAsLastSibling()
  end
  self.ui.img_Selected.gameObject:SetActive(coundOpen)
end

function UIWinter23Task:__OpenDailyTask(reddotFunc)
  if self._termTaskNode ~= nil then
    self._termTaskNode:Hide()
  else
    self.ui.actTaskNode:SetActive(false)
  end
  if self._dailyTaskNode == nil then
    self.ui.limitTaskNode:SetActive(true)
    self._dailyTaskNode = UINWinter23DailyTask.New()
    self._dailyTaskNode:Init(self.ui.limitTaskNode)
    self._dailyTaskNode:InitWinter23LimitTaskNode(self._dailyTaskData, self._frameData)
  else
    self._dailyTaskNode:Show()
  end
  self._dailyTaskNode:RefillChristmas22LimitTaskNode()
  self._dailyTaskNode:BindWinter23DailyTaskOperFunc(reddotFunc)
  self.ui.obj_ListNode:SetActive(true)
  return true
end

function UIWinter23Task:__RefreshRedDailyTask(pageItem)
  pageItem:SetChristmasTaskPageRed(self._dailyTaskData ~= nil and self._dailyTaskData:IsExistDailyCompleteTask())
end

function UIWinter23Task:__OpenTermTask(term, reddotFunc)
  if self._termTaskData:GetTermOpenTime(term) > PlayerDataCenter.timestamp then
    return false
  end
  if self._dailyTaskNode ~= nil then
    self._dailyTaskNode:Hide()
  else
    self.ui.limitTaskNode:SetActive(false)
  end
  if self._termTaskNode == nil then
    self.ui.actTaskNode:SetActive(true)
    self._termTaskNode = UINWinter23TermTask.New()
    self._termTaskNode:Init(self.ui.actTaskNode)
  else
    self._termTaskNode:Show()
  end
  self._termTaskNode:InitChristmas22ActTaskNode(self._termTaskData, term)
  self._termTaskNode:RefillChristmas22ActTaskNode()
  self._termTaskNode:BindWinter23TermTaskOperFunc(reddotFunc)
  self.ui.obj_ListNode:SetActive(false)
  return true
end

function UIWinter23Task:__RefreshRedTermTask(pageItem, term)
  pageItem:SetChristmasTaskPageRed(self._termTaskData ~= nil and self._termTaskData:IsExistTermCompleteTaskInTerm(term))
end

function UIWinter23Task:OnCloseTaskUI(tohome)
  self:Delete()
  if self._closeEvent ~= nil then
    self._closeEvent(tohome)
    self._closeEvent = nil
  end
end

function UIWinter23Task:PlayPageListAnim()
  if IsNull(self.ui.anim_pageList) then
    return
  end
  self:__StopAnim()
  self.ui.anim_pageList:DOFade(0, 0.25):From():SetDelay(0.05):SetLink(self.gameObject)
  self.ui.anim_pageList.gameObject.transform:DOLocalMoveX(-740, 0.25):From():SetDelay(0.05):SetLink(self.gameObject)
end

function UIWinter23Task:__StopAnim()
  if IsNull(self.ui.anim_pageList) then
    return
  end
  self.ui.anim_pageList:DOComplete()
  self.ui.anim_pageList.gameObject.transform:DOComplete()
end

function UIWinter23Task:OnDelete()
  if self._termTaskNode ~= nil then
    self._termTaskNode:Delete()
  end
  if self._dailyTaskNode ~= nil then
    self._dailyTaskNode:Delete()
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self:__StopAnim()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.ActivityDailyTaskExpired, self.__RefreshDailyTaskWhenExpireCallback)
  base.OnDelete(self)
end

return UIWinter23Task

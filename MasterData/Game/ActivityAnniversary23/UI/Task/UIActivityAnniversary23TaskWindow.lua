local UIActivityAnniversary23TaskWindow = class("UIActivityAnniversary23TaskWindow", UIBaseWindow)
local base = UIBaseWindow
local cs_LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local cs_ResLoader = CS.ResLoader
local UINSpring23TaskPageItem = require("Game.ActivitySpring.UI.Task.UINSpring23TaskPageItem")
local UINCommonActivityBG = require("Game.ActivityFrame.UI.UINCommonActivityBG")
local UINAnniversary23DailyTask = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23DailyTask")
local UINAnniversary23TermTask = require("Game.ActivityAnniversary23.UI.Task.UINActivityAnniversary23TermTask")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local DefaultDailyTaskTitle = 6
local DefaultTermTaskTitles = {7, 8}
local DailyTaskTitle = {
  [ActivityFrameEnum.eActivityType.Anniversary23] = 4
}
local TermTaskTitles = {
  [ActivityFrameEnum.eActivityType.Anniversary23] = {3, 5}
}

function UIActivityAnniversary23TaskWindow:OnInit()
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

function UIActivityAnniversary23TaskWindow:InitAnniversary23Task(actFrameId, dailyTaskData, termTaskData, closeEvent, isFirstSelectTermTask)
  self._dailyTaskData = dailyTaskData
  self._termTaskData = termTaskData
  self._closeEvent = closeEvent
  self._actFrameId = actFrameId
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
    local item = self:__CreateDailyPage()
    if not isFirstSelectTermTask then
      firstEnterPageItem = item
    end
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

function UIActivityAnniversary23TaskWindow:__CreateTermPage(index, isAddModel)
  local item = self._pageItemPool:GetOne()
  local func = BindCallback(self, self.__OpenTermTask, index)
  self._pageOpenFuncMap[item] = func
  local redFunc = BindCallback(self, self.__RefreshRedTermTask, item, index)
  self._pageRedFuncMap[item] = redFunc
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self._actFrameId)
  local actType = actFrameData:GetActivityFrameCat()
  local termTaskTitle = TermTaskTitles[actType] or DefaultTermTaskTitles
  item:InitChristmasTaskPageItemParam2(termTaskTitle[index] or 0, 1, self.__SetPageCallback)
  item:ShowChristmasTaskPageLine(true)
  if isAddModel then
    item.transform:SetSiblingIndex(index)
  end
  return item
end

function UIActivityAnniversary23TaskWindow:__CreateDailyPage()
  local item = self._pageItemPool:GetOne()
  local func = BindCallback(self, self.__OpenDailyTask)
  self._pageOpenFuncMap[item] = func
  local redFunc = BindCallback(self, self.__RefreshRedDailyTask, item)
  self._pageRedFuncMap[item] = redFunc
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local actFrameData = actFrameCtrl:GetActivityFrameData(self._actFrameId)
  local actType = actFrameData:GetActivityFrameCat()
  local dailyTaskTitle = DailyTaskTitle[actType] or DefaultDailyTaskTitle
  item:InitChristmasTaskPageItemParam2(dailyTaskTitle, 2, self.__SetPageCallback)
  item:ShowChristmasTaskPageLine(false)
  return item
end

function UIActivityAnniversary23TaskWindow:__TaskProcessUpdate(taskData)
  if self._dailyTaskNode ~= nil and self._dailyTaskNode.active then
    self._dailyTaskNode:RefreshDailyTaskChange(taskData)
  elseif self._termTaskNode ~= nil and self._termTaskNode.active then
    self._termTaskNode:RefreshTermTaskChange(taskData)
  end
  if taskData:CheckComplete() then
    for k, func in pairs(self._pageRedFuncMap) do
      func()
    end
  end
end

function UIActivityAnniversary23TaskWindow:__RefreshDailyTaskWhenExpire(frameId)
  if self._frameData ~= nil and frameId == self._frameData:GetActivityFrameId() and self._dailyTaskNode ~= nil then
    self._dailyTaskNode:RefillDailyTaskNode()
  end
end

function UIActivityAnniversary23TaskWindow:__RefreshTermTaskWhenExpire(frameId)
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

function UIActivityAnniversary23TaskWindow:__SetPage(titleType, item)
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

function UIActivityAnniversary23TaskWindow:__OpenDailyTask(reddotFunc)
  if self._termTaskNode ~= nil then
    self._termTaskNode:Hide()
  else
    self.ui.actTaskNode:SetActive(false)
  end
  if self._dailyTaskNode == nil then
    self.ui.limitTaskNode:SetActive(true)
    self._dailyTaskNode = UINAnniversary23DailyTask.New()
    self._dailyTaskNode:Init(self.ui.limitTaskNode)
    self._dailyTaskNode:InitDailyTaskNode(self._dailyTaskData, self._frameData)
  else
    self._dailyTaskNode:Show()
  end
  self._dailyTaskNode:RefillDailyTaskNode()
  self._dailyTaskNode:BindAnniversary23DailyTaskOpenFunc(reddotFunc)
  self.ui.obj_ListNode:SetActive(true)
  return true
end

function UIActivityAnniversary23TaskWindow:__RefreshRedDailyTask(pageItem)
  pageItem:SetChristmasTaskPageRed(self._dailyTaskData ~= nil and self._dailyTaskData:IsExistDailyCompleteTask())
end

function UIActivityAnniversary23TaskWindow:__OpenTermTask(term, reddotFunc)
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
    self._termTaskNode = UINAnniversary23TermTask.New()
    self._termTaskNode:Init(self.ui.actTaskNode)
  else
    self._termTaskNode:Show()
  end
  local actData = self._frameData:GetActivityData()
  self._termTaskNode:InitTermTaskNode(self._termTaskData, term, actData)
  self._termTaskNode:RefillTermTaskNode()
  self._termTaskNode:BindAnniversary23TermTaskOpenFunc(reddotFunc)
  self.ui.obj_ListNode:SetActive(false)
  return true
end

function UIActivityAnniversary23TaskWindow:__RefreshRedTermTask(pageItem, term)
  local periodFlag = true
  if self._frameData then
    local actData = self._frameData:GetActivityData()
    if actData.CheckTaskBpCanGetReward then
      periodFlag = actData:CheckTaskBpCanGetReward()
    else
      periodFlag = false
    end
  end
  local termFlag = self._termTaskData ~= nil and self._termTaskData:IsExistTermCompleteTaskInTerm(term)
  pageItem:SetChristmasTaskPageRed(termFlag or periodFlag)
end

function UIActivityAnniversary23TaskWindow:OnCloseTaskUI(tohome)
  self:Delete()
  if self._closeEvent ~= nil then
    self._closeEvent(tohome)
    self._closeEvent = nil
  end
end

function UIActivityAnniversary23TaskWindow:PlayPageListAnim()
  if IsNull(self.ui.anim_pageList) then
    return
  end
  self:__StopAnim()
  self.ui.anim_pageList:DOFade(0, 0.25):From():SetDelay(0.05):SetLink(self.gameObject)
  self.ui.anim_pageList.gameObject.transform:DOLocalMoveX(-740, 0.25):From():SetDelay(0.05):SetLink(self.gameObject)
end

function UIActivityAnniversary23TaskWindow:__StopAnim()
  if IsNull(self.ui.anim_pageList) then
    return
  end
  self.ui.anim_pageList:DOComplete()
  self.ui.anim_pageList.gameObject.transform:DOComplete()
end

function UIActivityAnniversary23TaskWindow:OnDelete()
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

return UIActivityAnniversary23TaskWindow

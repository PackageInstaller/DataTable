local UIActivityHazeGiftMain = class("UIActivityHazeGiftMain", UIBaseWindow)
local base = UIBaseWindow
local UINActivityHazeGiftProgressItem = require("Game.ActivityHazeGift.UI.UINActivityHazeGiftProgressItem")
local UINActivityHazeGiftToggleItem = require("Game.ActivityHazeGift.UI.UINActivityHazeGiftToggleItem")
local UINActivityHazeGiftTaskItem = require("Game.ActivityHazeGift.UI.UINActivityHazeGiftTaskItem")
local UINActivityHazeGiftRewardGroup = require("Game.ActivityHazeGift.UI.UINActivityHazeGiftRewardGroup")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")
local Score_MAX = "MAX"

function UIActivityHazeGiftMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):SetTopStatusVisible(true):PushTopStatusDataToBackStack()
  self.progressPool = UIItemPool.New(UINActivityHazeGiftProgressItem, self.ui.progressItem)
  self.ui.progressItem:SetActive(false)
  self.togglePool = UIItemPool.New(UINActivityHazeGiftToggleItem, self.ui.toggleItem)
  self.ui.toggleItem:SetActive(false)
  self._taskItemDic = {}
  self._taskDataList = {}
  self._fixedItemList = {}
  self.ui.taskScrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.taskScrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.__OnGetHazeGiftReward = BindCallback(self, self.OnGetHazeGiftReward)
  self.__OnGetAllHazeGiftReward = BindCallback(self, self.OnGetAllHazeGiftReward)
  self.__OnClickHazeGiftToggleItem = BindCallback(self, self.OnClickHazeGiftToggleItem)
  self.__OnGetTaskDataCallback = BindCallback(self, self.__OnGetTaskData)
  self.__OnGotoTaskDataCallback = BindCallback(self, self.__OnGotoTaskData)
  self.__OnItemChangeFunc = BindCallback(self, self.__ItemUpdate)
  self.__RefreshTaskList = BindCallback(self, self.RefreshHazeGiftTaskList)
  UIUtil.AddButtonListener(self.ui.btn_heroDetail, self, self.__OnClickHeroDetail)
  UIUtil.AddButtonListener(self.ui.btn_rewardDetail, self, self.__OnClickRewardDetail)
  UIUtil.AddButtonListener(self.ui.btn_tips, self, self.__OnClickBtnTips)
  UIUtil.AddButtonListener(self.ui.Btn_Buy, self, self.__OnClickBtnBuy)
  self.__TaskChangeCallback = BindCallback(self, self.__TaskProcessUpdate)
  MsgCenter:AddListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemChangeFunc)
end

function UIActivityHazeGiftMain:InitHazeGiftMain(actId)
  local hazeGiftCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHazeGift)
  if hazeGiftCtrl == nil then
    return
  end
  local hazeGiftData = hazeGiftCtrl:GetHazeGiftDataByActId(actId)
  if hazeGiftData == nil then
    return
  end
  self._hazeGiftData = hazeGiftData
  self._hazeGiftData:SetActHazeGiftLooked()
  self.ui.text_des.text = ConfigData:GetTipContent(self._hazeGiftData:GetHazeGiftActivityDes())
  self:OnHazeGiftTimerEnd()
  self:__OnUpdateHazeGiftTimer()
  self._hazeGiftTimer = TimerManager:StartTimer(1, self.__OnUpdateHazeGiftTimer, self)
  self:InitHazeGiftRewardInfoGroup()
  self:InitHazeGiftToggleGroup()
  self:InitHazeGiftTaskGroup()
  self:RefreshHazeGiftRewardRedDot()
end

function UIActivityHazeGiftMain:InitHazeGiftRewardInfoGroup()
  local scoreId = self._hazeGiftData:GetHazeGiftScoreId()
  local haveNum = PlayerDataCenter:GetItemCount(scoreId)
  local nextScore = -1
  local rewardCfg = self._hazeGiftData:GetHazeGiftRewardCfg()
  for index, cfg in ipairs(rewardCfg) do
    if haveNum < cfg.score then
      nextScore = cfg.score
      break
    end
  end
  if nextScore < 0 then
    self.ui.text_nextPoint:SetIndex(0, Score_MAX)
    self.ui.text_curPoint:SetIndex(0, Score_MAX)
  else
    self.ui.text_nextPoint:SetIndex(0, tostring(nextScore))
    self.ui.text_curPoint:SetIndex(0, tostring(haveNum))
  end
  self.progressPool:HideAll()
  for index, cfg in ipairs(rewardCfg) do
    local progressItem = self.progressPool:GetOne()
    progressItem:InitHazeGiftProgressItem(cfg.score)
    if index == #rewardCfg then
      progressItem:HideProgressItemLine()
    end
  end
  local fixedRewardList = self._hazeGiftData:GetHazeGiftFixedRewardList()
  if fixedRewardList == nil then
    error("cant find hazeGiftRewardCfg!")
    return
  end
  for index, rewardCfg in ipairs(fixedRewardList) do
    local itemGo = self.ui.fixedReward[index]
    local item = UINBaseItemWithReceived.New()
    item:Init(itemGo)
    local itemCfg = ConfigData.item[rewardCfg.id]
    item:InitItemWithCount(itemCfg, rewardCfg.num)
    if self._fixedItemList[rewardCfg.task] == nil then
      self._fixedItemList[rewardCfg.task] = {}
    end
    table.insert(self._fixedItemList[rewardCfg.task], item)
  end
  self._rewardWindow = UINActivityHazeGiftRewardGroup.New()
  self._rewardWindow:Init(self.ui.rewardWindow)
  self:RefreshHazeGiftScore()
end

function UIActivityHazeGiftMain:InitHazeGiftToggleGroup()
  local taskCfg = self._hazeGiftData:GetHazeGiftTaskGroupCfg()
  self.togglePool:HideAll()
  for _, cfg in ipairs(taskCfg) do
    local toggleItem = self.togglePool:GetOne()
    toggleItem:InitHazeGiftToggleItem(cfg.day, cfg.day_des, self.__OnClickHazeGiftToggleItem)
    local isLooked = self._hazeGiftData:GetActHazeGiftDayLooked(cfg.day)
    local isUnlock = self._hazeGiftData:CheckHazeGiftDayIsUnlock(cfg.day)
    toggleItem:SetToggleItemIsSelected(false)
    toggleItem:UpdateToggleItemBlueDot(not isLooked and isUnlock)
    toggleItem:SetToggleItemIsUnlock(isUnlock)
  end
  self._curSelectDay = 1 or self._curSelectDay
  local firstItem = self.togglePool.listItem[self._curSelectDay]
  firstItem:SetToggleItemIsSelected(true)
  self._hazeGiftData:SetActHazeGiftDayLooked(self._curSelectDay)
  firstItem:UpdateToggleItemBlueDot(false)
  self:RefreshHazeGiftTaskList(self._curSelectDay)
end

function UIActivityHazeGiftMain:InitHazeGiftTaskGroup()
  self._taskDataList = self._hazeGiftData:GetActHazeGiftTaskDataListByDayIndex(self._curSelectDay)
  self:__SortTaskData()
  self.ui.taskScrollRect.totalCount = #self._taskDataList
  self.ui.taskScrollRect:RefillCells()
end

function UIActivityHazeGiftMain:RefreshHazeGiftTaskList(dayIndex)
  self._curSelectDay = dayIndex or self._curSelectDay
  self._taskDataList = self._hazeGiftData:GetActHazeGiftTaskDataListByDayIndex(self._curSelectDay)
  self:__SortTaskData()
  self.ui.taskScrollRect.totalCount = #self._taskDataList
  self.ui.taskScrollRect:RefreshCells()
end

function UIActivityHazeGiftMain:RefreshHazeGiftScore()
  local scoreId = self._hazeGiftData:GetHazeGiftScoreId()
  local haveNum = PlayerDataCenter:GetItemCount(scoreId)
  local nextScore = -1
  local rewardCfg = self._hazeGiftData:GetHazeGiftRewardCfg()
  for index, cfg in ipairs(rewardCfg) do
    if haveNum < cfg.score then
      nextScore = cfg.score
      break
    end
  end
  if nextScore < 0 then
    self.ui.text_nextPoint:SetIndex(0, Score_MAX)
    self.ui.text_curPoint:SetIndex(0, Score_MAX)
  else
    self.ui.text_nextPoint:SetIndex(0, tostring(nextScore))
    self.ui.text_curPoint:SetIndex(0, tostring(haveNum))
  end
  self:RefreshHazeGiftScoreProgress()
  self:RefreshHazeGiftFixedReward()
end

function UIActivityHazeGiftMain:RefreshHazeGiftScoreProgress()
  local scoreId = self._hazeGiftData:GetHazeGiftScoreId()
  local haveNum = PlayerDataCenter:GetItemCount(scoreId)
  local rewardCfg = self._hazeGiftData:GetHazeGiftRewardCfg()
  for index, cfg in ipairs(rewardCfg) do
    local value = -1
    if haveNum >= cfg.score then
      local nextScore = index < #rewardCfg - 1 and rewardCfg[index + 1].score or -1
      if haveNum >= nextScore then
        value = 1
      else
        value = (haveNum - cfg.score) / (nextScore - cfg.score)
      end
    end
    local item = self.progressPool.listItem[index]
    item:RefreshProgressItem(value)
    if index == #rewardCfg then
      item:HideProgressItemLine()
    end
  end
end

function UIActivityHazeGiftMain:RefreshHazeGiftFixedReward()
  if self._fixedItemList == nil then
    return
  end
  for taskId, itemList in pairs(self._fixedItemList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    local isPicked = taskData:IsPickedTaskReward()
    for _, item in ipairs(itemList) do
      item:SetPickedUIActive(isPicked)
    end
  end
end

function UIActivityHazeGiftMain:__OnClickHeroDetail()
  if self._hazeGiftData == nil then
    return
  end
  local heroId = self._hazeGiftData:GetHazeGiftShowHeroId()
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroInfoState, function(win)
    if win == nil then
      return
    end
    win:InitHeroInfoState(heroId)
  end)
end

function UIActivityHazeGiftMain:__OnClickRewardDetail()
  if self._rewardWindow == nil then
    return
  end
  if self.ui.rewardWindow.activeSelf then
    return
  end
  self.ui.rewardWindow:SetActive(true)
  local rewardIdList = self._hazeGiftData:GetHazeGiftRewardIdList()
  self._rewardWindow:InitHazeGiftRewardWindow(rewardIdList, self.__OnGetAllHazeGiftReward, self.__OnGetHazeGiftReward)
end

function UIActivityHazeGiftMain:__OnClickBtnTips()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    local title = ConfigData:GetTipContent(self._hazeGiftData:GetHazeGiftRuleTitle())
    local tip = ConfigData:GetTipContent(self._hazeGiftData:GetHazeGiftRuleTip())
    window:InitCommonInfo(tip, title)
  end)
end

function UIActivityHazeGiftMain:__OnClickBtnBuy()
  local shopId = self._hazeGiftData:GetBuyShopJumpId()
  if shopId ~= nil then
    JumpManager:Jump(JumpManager.eJumpTarget.DynShop, nil, nil, {shopId})
  end
end

function UIActivityHazeGiftMain:OnClickHazeGiftToggleItem(dayIndex)
  if not self._hazeGiftData:GetActHazeGiftDayLooked(dayIndex) then
    self._hazeGiftData:SetActHazeGiftDayLooked(dayIndex)
  end
  self:RefreshHazeGiftTaskList(dayIndex)
  for index, item in ipairs(self.togglePool.listItem) do
    item:SetToggleItemIsSelected(false)
    local day = item:GetItemDayIndex()
    local isLooked = self._hazeGiftData:GetActHazeGiftDayLooked(day)
    local isUnlock = self._hazeGiftData:CheckHazeGiftDayIsUnlock(day)
    item:UpdateToggleItemBlueDot(not isLooked and isUnlock)
  end
end

function UIActivityHazeGiftMain:OnGetHazeGiftReward()
  self._hazeGiftData:RefreshHazeGiftShow()
  self:RefreshHazeGiftFixedReward()
  self:RefreshHazeGiftRewardRedDot()
end

function UIActivityHazeGiftMain:OnGetAllHazeGiftReward(taskIds, callback)
  if taskIds == nil or table.IsEmptyTable(taskIds) then
    return
  end
  local taskNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Task)
  taskNetCtrl:CS_QUEST_OneKeyPick(taskIds, function()
    if not IsNull(self.transform) then
      callback()
      self:OnGetHazeGiftReward()
    end
  end)
end

function UIActivityHazeGiftMain:RefreshHazeGiftRewardRedDot()
  local isShowRedDot = self._hazeGiftData:IsCanGetReward()
  self.ui.RewardRedDot:SetActive(isShowRedDot)
  for index, item in ipairs(self.togglePool.listItem) do
    local day = item:GetItemDayIndex()
    local isUnlock = self._hazeGiftData:CheckHazeGiftDayIsUnlock(day)
    local isHaveCouldCollectReraeds = self._hazeGiftData:IsCanGetTask(day)
    item:UpdateToggleItemRedDot(isUnlock and isHaveCouldCollectReraeds)
  end
end

function UIActivityHazeGiftMain:__SortTaskData()
  table.sort(self._taskDataList, function(a, b)
    if a.state ~= b.state then
      if a:IsPickedTaskReward() then
        return false
      elseif b:IsPickedTaskReward() then
        return true
      end
    end
    local aComplect = a:CheckComplete()
    local bComplect = b:CheckComplete()
    if aComplect ~= bComplect then
      return aComplect
    end
    if a.stcData.order ~= b.stcData.order then
      return a.stcData.order < b.stcData.order
    end
    return a.id < b.id
  end)
end

function UIActivityHazeGiftMain:__OnNewItem(go)
  local item = UINActivityHazeGiftTaskItem.New()
  item:Init(go)
  self._taskItemDic[go] = item
end

function UIActivityHazeGiftMain:__OnChangeItem(go, index)
  local item = self._taskItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local taskData = self._taskDataList[index + 1]
  item:InitHazeGiftTaskItem(taskData, self.__OnGetTaskDataCallback, self.__OnGotoTaskDataCallback)
end

function UIActivityHazeGiftMain:__OnGetTaskData(taskData)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtr:SendCommitQuestReward(taskData, true, function()
    self:RefreshHazeGiftScore()
    self:RefreshHazeGiftTaskList()
  end, nil)
end

function UIActivityHazeGiftMain:__OnGotoTaskData(taskData)
  if taskData.stcData.jump_id ~= nil and taskData.stcData.jump_id > 0 then
    JumpManager:Jump(taskData.stcData.jump_id, nil, nil, taskData.stcData.jumpArgs)
  end
end

function UIActivityHazeGiftMain:__ItemUpdate(itemDic)
  local itemId = self._hazeGiftData:GetHazeGiftScoreId()
  if itemDic[itemId] ~= nil then
    self:RefreshHazeGiftScore()
    self:OnGetHazeGiftReward()
  end
end

function UIActivityHazeGiftMain:__TaskProcessUpdate(taskData)
  local rewardIdList = self._hazeGiftData:GetHazeGiftRewardIdList()
  local needRefresh = false
  for _, id in ipairs(rewardIdList) do
    if id == taskData.id then
      needRefresh = true
      break
    end
  end
  if needRefresh then
    self._hazeGiftData:RefreshHazeGiftShow()
    self:RefreshHazeGiftRewardRedDot()
  end
end

function UIActivityHazeGiftMain:UpdateActHazeGiftByDayPass()
  self:InitHazeGiftRewardInfoGroup()
  self:InitHazeGiftToggleGroup()
  self:InitHazeGiftTaskGroup()
  self:RefreshHazeGiftRewardRedDot()
end

function UIActivityHazeGiftMain:__OnUpdateHazeGiftTimer()
  local d, h, m = TimeUtil:TimestampToTimeInter(self._hazeGiftData:GetActivityEndTime() - PlayerDataCenter.timestamp, false, true)
  if m <= 0 then
    self.ui.text_day:SetIndex(2, tostring(0))
    self:OnHazeGiftTimerEnd()
  end
  if 0 < d then
    self.ui.text_day:SetIndex(0, tostring(d))
  elseif 0 < h then
    self.ui.text_day:SetIndex(1, tostring(h))
  elseif 0 < m then
    self.ui.text_day:SetIndex(2, tostring(m))
  end
end

function UIActivityHazeGiftMain:OnHazeGiftTimerEnd()
  if self._hazeGiftTimer ~= nil then
    TimerManager:StopTimer(self._hazeGiftTimer)
    self._hazeGiftTimer = nil
  end
end

function UIActivityHazeGiftMain:OnDelete()
  if self._rewardWindow then
    self._rewardWindow:Delete()
  end
  if self.progressPool then
    self.progressPool:DeleteAll()
  end
  if self.togglePool then
    self.togglePool:DeleteAll()
  end
  self:OnHazeGiftTimerEnd()
  MsgCenter:RemoveListener(eMsgEventId.TaskUpdate, self.__TaskChangeCallback)
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemChangeFunc)
  base.OnDelete(self)
end

return UIActivityHazeGiftMain

_class("UICN13GetPiecePopUp", UIController)
UICN13GetPiecePopUp = UICN13GetPiecePopUp

function UICN13GetPiecePopUp:LoadDataOnEnter(TT, res)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._questModule = GameGlobal.GetModule(QuestModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST, ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERSON_PROCESS)
  if res and res:GetSucc() then
    self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE)
    self._questComponent = self._localProcess:GetComponent(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
    self.questcmptInfo = self._localProcess:GetComponentInfo(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_QUEST)
  end
end

function UICN13GetPiecePopUp:OnShow(uiParams)
  self:InitWidget()
  self:InitUI()
end

function UICN13GetPiecePopUp:OnHide()
  self:DetachEvent(GameEventType.UIQuestDailyVigorous, self.UIQuestDailyVigorous)
  self:UnLock("UICN13PerfectPuzzle:UIQuestGet")
end

function UICN13GetPiecePopUp:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.titleText = self:GetUIComponent("UILocalizedTMP", "TitleText")
  self.itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self.closeBtn = self:GetUIComponent("Image", "CloseBtn")
  self.questPool = self:GetUIComponent("UISelectObjectPath", "QuestPool")
end

function UICN13GetPiecePopUp:InitUI()
  self._questInfoList = self._questComponent:GetQuestInfo()
  self._questComponent:SortQuestInfoByCampaignQuestStatus(self._questInfoList)
  self._dynamicListSize = table.count(self._questInfoList)
  self._itemCountPerRow = 1
  self._dynamicListRowSize = math.floor((self._dynamicListSize - 1) / self._itemCountPerRow + 1)
  if not self._isDynamicInited then
    self._isDynamicInited = true
    self._taskList = self:GetUIComponent("UIDynamicScrollView", "taskList")
    self._taskList:InitListView(self._dynamicListRowSize, function(scrollView, index)
      return self:_SpawnListItem(scrollView, index)
    end)
  else
    self:_RefreshList(self._dynamicListRowSize, self._taskList, nil)
  end
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local resetTime = self._questModule:GetQuestDailyRefreshTime(svrTime)
  local timeStamp = resetTime - svrTime
  if 0 < timeStamp then
    local timeStr = self:Second2TimeStr(timeStamp)
    self.titleText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_quest_refresh_countdown") .. timeStr)
  else
    local timeStr = self:Second2TimeStr(timeStamp)
    self.titleText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_quest_refresh_countdown") .. timeStr)
  end
  self.taskId = self:StartTask(function(TT)
    while true do
      self:_OnValue()
      YIELD(TT, 1000)
    end
  end)
  self:AttachEvent(GameEventType.UIQuestDailyVigorous, self.UIQuestDailyVigorous)
end

function UICN13GetPiecePopUp:UIQuestDailyVigorous()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._questComponent:HandleCamQuestDailyReset(TT, res)
    if res:GetSucc() then
      self:_RefreshList(self._dynamicListRowSize, self._taskList, nil)
    end
  end, self)
end

function UICN13GetPiecePopUp:_OnValue()
  local svrTime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local resetTime = self._questModule:GetQuestDailyRefreshTime(svrTime)
  local timeStamp = resetTime - svrTime
  if 0 < timeStamp then
    local timeStr = UIActivityHelper.GetFormatTimerStr(timeStamp)
    self.titleText:SetText(StringTable.Get("str_cn13_PerfectPuzzle_quest_refresh_countdown") .. timeStr)
    if self.reset then
      self.reset = false
    end
  else
    self.reset = true
  end
end

function UICN13GetPiecePopUp:_RefreshList(count, list, resetPos)
  self._questInfoList = self._questComponent:GetQuestInfo()
  self._questComponent:SortQuestInfoByCampaignQuestStatus(self._questInfoList)
  list:SetListItemCount(count)
  list:MovePanelToItemIndex(0, 0)
  if not resetPos then
  end
end

function UICN13GetPiecePopUp:_SpawnListItem(scrollView, index)
  if index < 0 then
    return nil
  end
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UICN13PerfectPuzzleGetItem", self._itemCountPerRow)
  end
  local rowList = rowPool:GetAllSpawnList()
  for i = 1, self._itemCountPerRow do
    local listItem = rowList[i]
    local itemIndex = index * self._itemCountPerRow + i
    if itemIndex > self._dynamicListSize then
      listItem:GetGameObject():SetActive(false)
    else
      listItem:GetGameObject():SetActive(true)
      self:_SetListItemData(listItem, itemIndex)
    end
  end
  return item
end

function UICN13GetPiecePopUp:_SetListItemData(listItem, index)
  local quest = self._questInfoList[index]
  listItem:SetData(self._campaign, quest, function(v)
    self:ListItemOnClick(v)
  end, function(matid, pos)
    UIWidgetHelper.SetAwardItemTips(self, "ItemTips", matid, pos)
  end, self._questComponent)
end

function UICN13GetPiecePopUp:ListItemOnClick(questID)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    self:CloseDialog()
    return
  end
  self._questComponent:Start_HandleQuestTake(questID, function(res, rewards)
    self:_OnReceiveRewards(res, rewards)
    self:UnLock("UICN13PerfectPuzzle:UIQuestGet")
    self:_RefreshList(self._dynamicListRowSize, self._taskList, nil)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PerfectPuzzleEntryRefresh)
  end)
end

function UICN13GetPiecePopUp:Second2TimeStr(second)
  local sec = math.floor(second % 60)
  local min = math.floor(second / 60 % 60)
  local hour = math.floor(second / 60 / 60)
  local secStr
  if sec < 10 then
    secStr = "0" .. sec
  else
    secStr = sec
  end
  local minStr
  if min < 10 then
    minStr = "0" .. min
  else
    minStr = min
  end
  local hourStr
  if hour < 10 then
    hourStr = "0" .. hour
  else
    hourStr = hour
  end
  local str = hourStr .. ":" .. minStr .. ":" .. secStr
  return str
end

function UICN13GetPiecePopUp:_OnReceiveRewards(res, rewards)
  if self.view == nil then
    return
  end
  if res:GetSucc() then
    UIActivityHelper.ShowUIGetRewards(rewards)
  else
    self._campaign:CheckErrorCode(res.m_result, function()
      self:_RefreshList(self._dynamicListRowSize, self._taskList, nil)
    end, function()
      self:CloseDialog()
    end)
  end
end

function UICN13GetPiecePopUp:BgOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
  self:CloseDialog()
end

function UICN13GetPiecePopUp:CloseBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
  end
  self:CloseDialog()
end

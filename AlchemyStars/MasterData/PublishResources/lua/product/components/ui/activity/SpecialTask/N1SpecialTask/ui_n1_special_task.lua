_class("UIN1SpecialTask", UISideEnterCenterContentBase)
UIN1SpecialTask = UIN1SpecialTask

function UIN1SpecialTask:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._preSelectedItem = nil
  self._sortConst = {
    [QuestStatus.QUEST_NotStart] = 2,
    [QuestStatus.QUEST_Accepted] = 3,
    [QuestStatus.QUEST_Completed] = 4,
    [QuestStatus.QUEST_Taken] = 1
  }
  self:AttachEvent(GameEventType.QuestUpdate, self.Refresh)
end

function UIN1SpecialTask:DoInit()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_SPECIAL)
  self._localProcess = self._campaign:GetLocalProcess()
  self._questComponent = self._localProcess:GetComponent(ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST)
  self._questComponentInfo = self._questComponent:GetComponentInfo()
  self:_GetComponents()
  self:_OnValue()
end

function UIN1SpecialTask:DoShow(uiParams)
  self._callback = uiParams[1]
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self._timeEvent = GameGlobal.Timer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_RefreshRemainTime()
  end)
  self:_DynamicListPlayAnimation(true)
  self:_CheckQuestDailyReset()
end

function UIN1SpecialTask:_GetComponents()
  self._titleText = self:GetUIComponent("UILocalizationText", "Title")
  self._remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
end

function UIN1SpecialTask:_OnValue()
  self._titleText:SetText(StringTable.Get("str_n24_specialtask_title"))
  self:_RefreshRemainTime()
  self._questList = self._questComponent:GetQuestInfo()
  self:_QuestSort()
  self:_InitDynamicScrollView()
end

function UIN1SpecialTask:_RefreshRemainTime()
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local remainTime = self._questComponentInfo.m_close_time - curtime
  if 0 < remainTime then
    self._remainTimeText:SetText(StringTable.Get("str_sakura_specialtask_remaintime", UIN1SpecialTaskToolFunctions.GetRemainTime(remainTime)))
  else
    self._campaign:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED, self._campaign._id)
  end
end

function UIN1SpecialTask:_QuestSort()
  local val = {}
  val[QuestStatus.QUEST_Completed] = 0
  val[QuestStatus.QUEST_Accepted] = 1
  val[QuestStatus.QUEST_Taken] = 2
  val[QuestStatus.QUEST_NotStart] = 3
  table.sort(self._questList, function(a, b)
    local a_status = a:Status()
    local b_status = b:Status()
    if val[a_status] == val[b_status] then
      return a:ID() < b:ID()
    end
    return val[a_status] < val[b_status]
  end)
end

function UIN1SpecialTask:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._questList, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UIN1SpecialTask:_OnGetItemByIndex(scrollview, index)
  local quest = self._questList[index + 1]
  local item = scrollview:NewListViewItem("UIN1SpecialTaskItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UIN1SpecialTaskItem", 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  local itemWidget = itemWidgets[1]
  if itemWidget then
    itemWidget:SetData(self._questComponent, quest, function(widget)
      self:OnSelectItem(widget)
    end, function(id, position)
      self:_ShowTips(id, position)
    end, function()
      self:Refresh()
    end, function()
      self:CloseDialog()
    end, function(result)
      self:ErrorCheck(result)
    end)
  end
  return item
end

function UIN1SpecialTask:_CheckQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local nextTime = self._questComponent:GetEarliestEndTimeInDailyQuest()
  local stamp = nextTime - curTime
  if 0 < stamp then
    return
  end
  self:Lock("UIN1SpecialTask:_CheckQuestDailyReset")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._questComponent:HandleCamQuestDailyReset(TT, res)
    self:UnLock("UIN1SpecialTask:_CheckQuestDailyReset")
    if res:GetSucc() then
      self:Refresh(TT, res)
    end
  end, self)
end

function UIN1SpecialTask:Refresh()
  self._questList = self._questComponent:GetQuestInfo()
  self:_QuestSort()
  self._scrollView:SetListItemCount(#self._questList)
  self._scrollView:RefreshAllShownItem()
  if self._callback then
    self._callback()
  end
end

function UIN1SpecialTask:ErrorCheck(result)
  self._campaign:CheckErrorCode(result, nil, nil)
end

function UIN1SpecialTask:DoHide()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self._callback then
    self._callback()
  end
  self._tips:closeOnClick()
end

function UIN1SpecialTask:OnSelectItem(widget)
  if self._preSelectedItem and self._preSelectedItem ~= widget then
    self._preSelectedItem:OnSelect(false)
  end
  self._preSelectedItem = widget
end

function UIN1SpecialTask:_ShowTips(id, pos)
  self._tips:SetData(id, pos)
end

function UIN1SpecialTask:DoDestroy()
end

function UIN1SpecialTask:_DynamicListPlayAnimation(isPlay)
  if not isPlay then
    return
  end
  local showTabIds = self._scrollView:GetVisibleItemIDsInScrollView()
  for index = 0, showTabIds.Count - 1 do
    local id = math.floor(showTabIds[index])
    local item = self._scrollView:GetShownItemByItemIndex(id)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local rowList = rowPool:GetAllSpawnList()
    local itemCountPerRow = 1
    for i = 1, itemCountPerRow do
      local listItem = rowList[i]
      local itemIndex = index * itemCountPerRow + i
      listItem:PlayAnimationInSequence(itemIndex)
    end
  end
end

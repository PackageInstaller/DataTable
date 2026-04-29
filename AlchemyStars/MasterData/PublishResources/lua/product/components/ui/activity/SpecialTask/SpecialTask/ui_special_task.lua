_class("UISpecialTask", UISideEnterCenterContentBase)
UISpecialTask = UISpecialTask

function UISpecialTask:Constructor()
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

function UISpecialTask:DoInit()
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_SPECIAL)
  self._localProcess = self._campaign:GetLocalProcess()
  self._questComponent = self._localProcess:GetComponent(ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST)
  self._questComponentInfo = self._questComponent:GetComponentInfo()
  self.id = self._data._id
  self:_GetComponents()
  self:_OnValue()
end

function UISpecialTask:DoShow(uiParams)
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

function UISpecialTask:_GetComponents()
  self._remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
  self._Bg = self:GetUIComponent("RawImageLoader", "BG")
  self._IntroBG = self:GetUIComponent("RawImageLoader", "IntroBG")
  self._Title = self:GetUIComponent("RawImageLoader", "Title")
  self._Pet = self:GetUIComponent("RawImageLoader", "Pet")
  self._PetTrans = self:GetUIComponent("RectTransform", "Pet")
  self._RightBg = self:GetUIComponent("RawImageLoader", "RightBg")
  self._IntrTxt = self:GetUIComponent("UILocalizationText", "IntrTxt")
end

function UISpecialTask:_OnValue()
  local cfg = Cfg.cfg_special_task[self.id]
  self._Bg:LoadImage(cfg.MainBG)
  self._RightBg:LoadImage(cfg.RightBG)
  self._IntroBG:LoadImage(cfg.PlayIntroBG)
  self._IntrTxt:SetText(StringTable.Get(cfg.PlayIntro))
  self._Title:LoadImage(cfg.MainTitle)
  self._Pet:LoadImage(cfg.Pet)
  if cfg.PetTransform then
    self._PetTrans.localPosition = Vector3(cfg.PetTransform[1], cfg.PetTransform[2], 0)
    self._PetTrans.localScale = Vector3(cfg.PetTransform[3], cfg.PetTransform[3], cfg.PetTransform[3])
  end
  self:_RefreshRemainTime()
  self._questList = self._questComponent:GetQuestInfo()
  self:_QuestSort()
  self:_InitDynamicScrollView()
end

function UISpecialTask:_RefreshRemainTime()
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local remainTime = self._questComponentInfo.m_close_time - curtime
  if 0 < remainTime then
    self._remainTimeText:SetText(StringTable.Get("str_sakura_specialtask_remaintime", UISpecialTaskToolFunctions.GetRemainTime(remainTime)))
  else
    self._campaign:CheckErrorCode(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED, self._campaign._id)
  end
end

function UISpecialTask:_QuestSort()
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

function UISpecialTask:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._questList, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UISpecialTask:_OnGetItemByIndex(scrollview, index)
  local quest = self._questList[index + 1]
  local item = scrollview:NewListViewItem("UISpecialTaskItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UISpecialTaskItem", 1)
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
    end, self.id)
  end
  return item
end

function UISpecialTask:_CheckQuestDailyReset()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local nextTime = self._questComponent:GetEarliestEndTimeInDailyQuest()
  local stamp = nextTime - curTime
  if 0 < stamp then
    return
  end
  self:Lock("UISpecialTask:_CheckQuestDailyReset")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    self._questComponent:HandleCamQuestDailyReset(TT, res)
    self:UnLock("UISpecialTask:_CheckQuestDailyReset")
    if res:GetSucc() then
      self:Refresh(TT, res)
    end
  end, self)
end

function UISpecialTask:Refresh()
  self._questList = self._questComponent:GetQuestInfo()
  self:_QuestSort()
  self._scrollView:SetListItemCount(#self._questList)
  self._scrollView:RefreshAllShownItem()
  if self._callback then
    self._callback()
  end
end

function UISpecialTask:ErrorCheck(result)
  self._campaign:CheckErrorCode(result, nil, nil)
end

function UISpecialTask:DoHide()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self._callback then
    self._callback()
  end
  self._tips:closeOnClick()
end

function UISpecialTask:OnSelectItem(widget)
  if self._preSelectedItem and self._preSelectedItem ~= widget then
    self._preSelectedItem:OnSelect(false)
  end
  self._preSelectedItem = widget
end

function UISpecialTask:_ShowTips(id, pos)
  self._tips:SetData(id, pos)
end

function UISpecialTask:DoDestroy()
end

function UISpecialTask:_DynamicListPlayAnimation(isPlay)
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

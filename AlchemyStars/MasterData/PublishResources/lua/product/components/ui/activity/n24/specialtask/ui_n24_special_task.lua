_class("UIN24SpecialTask", UIController)
UIN24SpecialTask = UIN24SpecialTask

function UIN24SpecialTask:Constructor()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._preSelectedItem = nil
end

function UIN24SpecialTask:LoadDataOnEnter(TT, res)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_SPECIAL, ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._localProcess = self._campaign:GetLocalProcess()
  self._questComponent = self._localProcess:GetComponent(ECampaignSpecialComponentID.ECAMPAIGN_SPECIAL_QUEST)
  self._questComponentInfo = self._questComponent:GetComponentInfo()
end

function UIN24SpecialTask:OnShow(uiParams)
  self._callback = uiParams[1]
  self:_GetComponents()
  self:_OnValue()
end

function UIN24SpecialTask:_GetComponents()
  self._titleText = self:GetUIComponent("RollingText", "Title")
  self._remainTimeText = self:GetUIComponent("UILocalizationText", "RemainTimeText")
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "ScrollView")
  self._itemTips = self:GetUIComponent("UISelectObjectPath", "ItemTips")
  self._tips = self._itemTips:SpawnObject("UISelectInfo")
end

function UIN24SpecialTask:_OnValue()
  self._titleText:RefreshText(StringTable.Get("str_n24_specialtask_title"))
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local remainTime = self._questComponentInfo.m_close_time - curtime
  self._remainTimeText:SetText(StringTable.Get("str_n24_specialtask_remaintime", UIN24SpecialTaskToolFunctions.GetRemainTime(remainTime)))
  self._questList = self._questComponent:GetQuestInfo()
  self:_InitDynamicScrollView()
end

function UIN24SpecialTask:_InitDynamicScrollView()
  self._scrollView:InitListView(#self._questList, function(scrollview, index)
    return self:_OnGetItemByIndex(scrollview, index)
  end)
end

function UIN24SpecialTask:_OnGetItemByIndex(scrollview, index)
  local quest = self._questList[index + 1]
  local item = scrollview:NewListViewItem("UIN24SpecialTaskItem")
  local itemPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if not item.IsInitHandlerCalled then
    item.IsInitHandlerCalled = true
    itemPool:SpawnObjects("UIN24SpecialTaskItem", 1)
  end
  local itemWidgets = itemPool:GetAllSpawnList()
  local itemWidget = itemWidgets[1]
  if itemWidget then
    itemWidget:SetData(self._questComponent, quest, function(widget)
      self:OnSelectItem(widget)
    end, function(id, position)
      self:_ShowTips(id, position)
    end)
  end
  return item
end

function UIN24SpecialTask:_RefreshScrollView()
  self._scrollView:SetListItemCount(#self._questList)
  self._scrollView:RefreshAllShownItem()
end

function UIN24SpecialTask:OnHide()
  if self._callback then
    self._callback()
  end
end

function UIN24SpecialTask:CloseBtnOnClick(go)
  self:CloseDialog()
end

function UIN24SpecialTask:OnSelectItem(widget)
  if self._preSelectedItem and self._preSelectedItem ~= widget then
    self._preSelectedItem:OnSelect(false)
  end
  self._preSelectedItem = widget
end

function UIN24SpecialTask:_ShowTips(id, pos)
  self._tips:SetData(id, pos)
end

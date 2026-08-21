_class("UIActivityAnniversaryLoginTabMain", UICustomWidget)
UIActivityAnniversaryLoginTabMain = UIActivityAnniversaryLoginTabMain

function UIActivityAnniversaryLoginTabMain:OnShow(uiParams)
  self._isOpen = true
end

function UIActivityAnniversaryLoginTabMain:OnHide()
  self._isOpen = false
end

function UIActivityAnniversaryLoginTabMain:SetData(campaign, component, refreshCallback, closeCallback, tipsCallback, btnCallback)
  self._campaign = campaign
  self._component = component
  self._refreshCallback = refreshCallback
  self._closeCallback = closeCallback
  self._tipsCallback = tipsCallback
  self._btnCallback = btnCallback
end

function UIActivityAnniversaryLoginTabMain:Refresh()
  self:_SetDynamicListData()
  self:_SetDynamicList()
end

function UIActivityAnniversaryLoginTabMain:_SetDynamicListData()
  self._infos = self._component:GetTimeRewardsList()
end

function UIActivityAnniversaryLoginTabMain:_SetDynamicList()
  if not self._dynamicListHelper then
    self._dynamicListHelper = UIActivityDynamicListHelper:New(self, self:GetUIComponent("UIDynamicScrollView", "_dynamicList"), "UIActivityAnniversaryLoginTabMainListItem", function(listItem, itemIndex)
      local info = self._infos[itemIndex]
      listItem:SetData(self._component, info.reward_id, info, self._refreshCallback, self._tipsCallback, self._btnCallback)
    end)
  end
  local itemCount = #self._infos
  local itemCountPerRow = 1
  self._dynamicListHelper:Refresh(itemCount, itemCountPerRow)
end

function UIActivityAnniversaryLoginTabMain:LookBtnOnClick(go)
  self._refreshCallback(UIActivityAnniversaryLoginState.TabPre)
end

function UIActivityAnniversaryLoginTabMain:PreviewBtnOnClick(go)
  local story_id = UIActivityHelper.GetCampaignFirstEnterStoryID(self._campaign, 1)
  self:ShowDialog("UIStoryController", story_id)
end

function UIActivityAnniversaryLoginTabMain:CloseBtnOnClick(go)
  self._closeCallback()
end

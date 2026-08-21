_class("UISummerActivityTwoScoreItem", UICustomWidget)
UISummerActivityTwoScoreItem = UISummerActivityTwoScoreItem

function UISummerActivityTwoScoreItem:OnShow()
  self._hasGetGo = self:GetGameObject("HasGet")
  self._canGetGo = self:GetGameObject("CanGet")
  self._unCompleteGo = self:GetGameObject("UnComplete")
  self._desLabel = self:GetUIComponent("UILocalizationText", "Des")
  self._scoreLabel = self:GetUIComponent("UILocalizationText", "Score")
  self._rewardPanel = self:GetUIComponent("CanvasGroup", "RewardPanel")
  self._iconImg = self:GetUIComponent("RawImageLoader", "Icon")
  self._scrollRect = self:GetUIComponent("ScrollRect", "RewardList")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._status2img = {
    [UISummerActivityTwoScoreRewardStatus.UnComplete] = "summer_xiahuo2_di21",
    [UISummerActivityTwoScoreRewardStatus.HasGet] = "summer_xiahuo2_di22",
    [UISummerActivityTwoScoreRewardStatus.UnGet] = "summer_xiahuo2_di20"
  }
  self:InitList()
  self:AttachEvent(GameEventType.SummerTwoRewardRefresh, self.SummerTwoRewardRefresh)
end

function UISummerActivityTwoScoreItem:SummerTwoRewardRefresh(idx)
  if idx == self._idx then
    self:RefreshButtonStatus()
  end
end

function UISummerActivityTwoScoreItem:Refresh(idx, rewardData, itemIcon, callback, showtips, anim, yieldTime)
  self._idx = idx
  self._showtips = showtips
  self._callback = callback
  self._rewardData = rewardData
  self._rewards = rewardData:GetRewards()
  self._rewardCount = #self._rewards
  self._scrollView:SetListItemCount(self._rewardCount, false)
  self._scrollView:RefreshAllShownItem()
  self._scrollView:MovePanelToItemIndex(0, 0)
  if self._rewardCount <= 3 then
    self._scrollRect.enabled = false
  else
    self._scrollRect.enabled = true
  end
  self:RefreshButtonStatus()
  self._iconImg:LoadImage(itemIcon)
  if anim then
    local rect = self:GetUIComponent("RectTransform", "rect")
    rect.gameObject:SetActive(false)
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._event = nil
    end
    self._event = GameGlobal.Timer():AddEvent(yieldTime, function()
      local anim = self:GetUIComponent("Animation", "UISummerActivityTwoScoreItem")
      if anim then
        local lockIdx = self._idx or "nil"
        self:Lock("UISummerActivityTwoScoreItem_play_anim_" .. lockIdx)
        local rect = self:GetUIComponent("RectTransform", "rect")
        rect.gameObject:SetActive(true)
        anim:Play("uieff_Summer2_Score_ActivityItem_In")
        if self._event2 then
          GameGlobal.Timer():CancelEvent(self._event2)
          self._event2 = nil
        end
        self._event2 = GameGlobal.Timer():AddEvent(600, function()
          local lockIdx = self._idx or "nil"
          self:UnLock("UISummerActivityTwoScoreItem_play_anim_" .. lockIdx)
        end)
      end
    end)
  else
    local rect = self:GetUIComponent("RectTransform", "rect")
    rect.anchoredPosition = Vector2(0, 0)
    rect.gameObject:SetActive(true)
  end
end

function UISummerActivityTwoScoreItem:OnHide()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  if self._event2 then
    GameGlobal.Timer():CancelEvent(self._event2)
    self._event2 = nil
  end
end

function UISummerActivityTwoScoreItem:ShowTips(itemId, pos)
  if self._showtips then
    self._showtips(itemId, pos)
  end
end

function UISummerActivityTwoScoreItem:RefreshButtonStatus()
  self._hasGetGo:SetActive(false)
  self._canGetGo:SetActive(false)
  self._unCompleteGo:SetActive(false)
  local score = self._rewardData:GetScoreValue()
  local scoreStr = ""
  local status = self._rewardData:GetStatus()
  if status == UISummerActivityTwoScoreRewardStatus.UnComplete then
    self._unCompleteGo:SetActive(true)
    scoreStr = "<color=#ff3e3e>" .. score .. "</color>"
  elseif status == UISummerActivityTwoScoreRewardStatus.HasGet then
    self._hasGetGo:SetActive(true)
    scoreStr = "<color=#fbf6de>" .. score .. "</color>"
  elseif status == UISummerActivityTwoScoreRewardStatus.UnGet then
    self._canGetGo:SetActive(true)
    scoreStr = "<color=#fbf6de>" .. score .. "</color>"
  end
  self._scoreLabel:SetText(scoreStr)
  self._bg:LoadImage(self._status2img[status])
end

function UISummerActivityTwoScoreItem:InitList()
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "RewardList")
  self._scrollView:InitListView(0, function(scrollview, index)
    return self:OnGetRewardItem(scrollview, index)
  end)
end

function UISummerActivityTwoScoreItem:OnGetRewardItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UISummerActivityTwoScoreRewardItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._rewardCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      self:RefreshRewardItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UISummerActivityTwoScoreItem:RefreshRewardItemInfo(itemWidget, index)
  itemWidget:Refresh(self._rewards[index], function(id, pos)
    self:ShowTips(id, pos)
  end)
end

function UISummerActivityTwoScoreItem:CanGetOnClick()
  if self._callback then
    self._callback(self._idx)
  end
end

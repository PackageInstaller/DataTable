_class("UIMailContentController", UIController)
UIMailContentController = UIMailContentController

function UIMailContentController:OnShow(uiParams)
  self._mailData = uiParams[1]
  self._mailController = uiParams[2]
  self._isCollect = uiParams[3]
  if not self._mailData then
    return
  end
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._senderLabel = self:GetUIComponent("UILocalizationText", "Sender")
  self._sendTimeLabel = self:GetUIComponent("UILocalizationText", "SendTime")
  self._contentNormalLabel = self:GetUIComponent("UILocalizedTMP", "ContentNormal")
  self._linkSelectorComp = self:GetUIComponent("UILinkSelectorTMP", "ContentNormal")
  self._hasRewards = self:GetGameObject("hasRewards")
  self._noRewards = self:GetGameObject("noRewards")
  self._itemParentGo = self:GetGameObject("ItemParent")
  self._gotTips = self:GetGameObject("gotTips")
  self._getBtn = self:GetGameObject("getBtn")
  self._delBtn = self:GetGameObject("delBtn")
  self._itemTemplate = self:GetGameObject("ItemTemplate")
  self._rewardListGo = self:GetGameObject("RewardList")
  local s = self:GetUIComponent("UISelectObjectPath", "itemTips")
  self._header = self:GetUIComponent("RawImageLoader", "header")
  self._mailImg = self:GetGameObject("mail")
  self._tips = s:SpawnObject("UISelectInfo")
  self._rewardCount = 0
  self._titleLabel.text = self._mailData.title
  self._senderLabel.text = self._mailData.senderName
  self._sendTimeLabel.text = self._mailData.createTime
  local content = string.gsub(self._mailData.content, "|u00A0", " ")
  local content2 = string.gsub(content, "|u0020", " ")
  local content3 = string.gsub(content2, "|u3000", "　")
  self._contentNormalLabel:SetText(content3)
  if self._mailData.mailIcon and self._mailData.mailIcon ~= "" then
    self._header.gameObject:SetActive(true)
    self._header:LoadImage(self._mailData.mailIcon)
    self._mailImg:SetActive(false)
  else
    self._header.gameObject:SetActive(false)
    self._mailImg:SetActive(true)
  end
  if self._mailData.hasReward then
    self._rewardCount = #self._mailData.rewards
    self._rewardItemList = {}
    self:_InitSrollView()
    self._rewardListGo:SetActive(true)
  else
    self._rewardListGo:SetActive(false)
  end
  self:_RefreshButtonStatus()
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
  self._linkSelectorComp:SetLinkSelectCallback(function(link)
    self:OnClickLink(link)
  end)
end

function UIMailContentController:OnClickLink(link)
  Log.fatal(link)
  HelperProxy:GetInstance():OpenUrl(link)
end

function UIMailContentController:OnHide()
  self._scrollView = nil
  self:DetachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
end

function UIMailContentController:_ShowTips(itemId, pos)
  self._tips:SetData(itemId, pos)
end

function UIMailContentController:_InitSrollView()
  local itemParentRect = self._itemParentGo:GetComponent("RectTransform")
  if self._rewardCount > 3 then
    itemParentRect.pivot = Vector2(0, 0.5)
  else
    itemParentRect.pivot = Vector2(0.5, 0.5)
  end
  for i = 1, self._rewardCount do
    local item = UnityEngine.GameObject.Instantiate(self._itemTemplate, self._itemParentGo.transform)
    item:SetActive(true)
    local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
    local itemWidget = rowPool:SpawnObject("UIMailRewardItem")
    self._rewardItemList[i] = itemWidget
    itemWidget:Refresh(self._mailData.rewards[i])
  end
end

function UIMailContentController:_RefreshButtonStatus()
  if not self._mailData then
    return
  end
  if self._mailData.hasReward then
    self._hasRewards:SetActive(true)
    self._noRewards:SetActive(false)
    local rewardsCanvasGroup = self:GetUIComponent("CanvasGroup", "RewardList")
    if self._mailData.isGain == false then
      self._getBtn:SetActive(true)
      self._delBtn:SetActive(false)
      rewardsCanvasGroup.alpha = 1
      self._gotTips:SetActive(false)
    else
      self._getBtn:SetActive(false)
      self._delBtn:SetActive(true)
      rewardsCanvasGroup.alpha = 0.4
      self._gotTips:SetActive(true)
    end
  else
    self._hasRewards:SetActive(false)
    self._noRewards:SetActive(true)
    self._getBtn:SetActive(false)
    self._delBtn:SetActive(true)
    self._gotTips:SetActive(false)
  end
end

function UIMailContentController:_RefreshRewardStatus()
  if self._rewardItemList then
    for i = 1, #self._rewardItemList do
      self._rewardItemList[i]:Refresh(self._mailData.rewards[i], self._mailData.isGain)
    end
  end
end

function UIMailContentController:ButtonGetOnClick(go)
  if not self._mailController then
    return
  end
  self._mailController:CollectedReward(self._mailData, function(success)
    if not success then
      self:CloseDialog()
      return
    end
    self:_RefreshButtonStatus()
    self:_RefreshRewardStatus()
  end)
end

function UIMailContentController:MaskOnClick(go)
  self:CloseDialog()
end

function UIMailContentController:ButtonDeleteOnClick(go)
  if not self._mailController then
    return
  end
  if self._isCollect then
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_mail_name1_delete"), function()
      self._mailController:DeleteMail(self._mailData, function(success)
        self:CloseDialog()
      end)
    end)
    return
  end
  self._mailController:DeleteMail(self._mailData, function(success)
    self:CloseDialog()
  end)
end

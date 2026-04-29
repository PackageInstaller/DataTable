_class("UIShopGiftPackTabBtn", UICustomWidget)
UIShopGiftPackTabBtn = UIShopGiftPackTabBtn

function UIShopGiftPackTabBtn:OnShow()
  self._isSelected = false
  self._uiUnsel = self:GetUIComponent("RectTransform", "uiUnsel")
  self._uiSel = self:GetUIComponent("RectTransform", "uiSel")
  self._unselName = self:GetUIComponent("UILocalizedTMP", "unselName")
  self._selName = self:GetUIComponent("UILocalizedTMP", "selName")
  self._limitedTime = self:GetUIComponent("RectTransform", "limitedTime")
  self._new = self:GetGameObject("new")
  self.animation = self:GetGameObject():GetComponent("Animation")
  self:AttachEvent(GameEventType.ShopNew, self.ShopNew)
end

function UIShopGiftPackTabBtn:GiftPackTabDetachEvent()
  self:DetachEvent(GameEventType.ShopNew, self.ShopNew)
end

function UIShopGiftPackTabBtn:FlushNew(isNew)
  self._new:SetActive(isNew)
end

function UIShopGiftPackTabBtn:OnHide()
  self:DetachEvent(GameEventType.ShopNew, self.ShopNew)
end

function UIShopGiftPackTabBtn:Init(tabId, name, onClickTabBtn, param)
  self.tabId = tabId
  self.onClickTabBtn = onClickTabBtn
  self.param = param
  self._unselName:SetText(name or "")
  self._selName:SetText(name or "")
  self._limitedTime.gameObject:SetActive(tabId ~= nil and tabId >= MarketType.Shop_CampaignMarket)
  self:Select(false)
end

function UIShopGiftPackTabBtn:SetData(tabId, k, name, onClickTabBtn)
  self.onClickTabBtn = onClickTabBtn
  self.param = k
  self._unselName:SetText(name or "")
  self._selName:SetText(name or "")
  self.tabId = tabId
  self.giftPackTabId = k
  self._limitedTime.gameObject:SetActive(false)
  self:Select(false)
end

function UIShopGiftPackTabBtn:GetTabId()
  return self.tabId
end

function UIShopGiftPackTabBtn:GetTiftPackTabId()
  return self.giftPackTabId
end

function UIShopGiftPackTabBtn:Select(isSelect)
  local preSelected = self._isSelected
  self._isSelected = isSelect
  self._uiUnsel.gameObject:SetActive(not isSelect)
  self._uiSel.gameObject:SetActive(isSelect)
  if preSelected ~= self._isSelected then
    if self._isSelected then
      self:PlayInAnimation()
    else
      self:PlayOutAnimation()
    end
  end
end

function UIShopGiftPackTabBtn:SetSelected(isSelect)
  self:Select(isSelect)
end

function UIShopGiftPackTabBtn:IsSelected()
  return self._isSelected
end

function UIShopGiftPackTabBtn:BtnOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  self.onClickTabBtn(self.tabId, go)
end

function UIShopGiftPackTabBtn:PlayInAnimation()
  self.animation:Play("uianim_UIShopSecretTabBtn_in")
  return 333
end

function UIShopGiftPackTabBtn:PlayOutAnimation()
  self._uiSel.gameObject:SetActive(true)
  self.animation:Play("uianim_UIShopSecretTabBtn_out")
  local animLength = 250
  self:StartSafeTask("UIShopSecretTabBtn::PlayOutAnimation", function(lockName, TT)
    self:Lock(lockName)
    YIELD(TT, animLength)
    self:UnLock(lockName)
    self._uiSel.gameObject:SetActive(self._isSelected)
  end)
  return animLength
end

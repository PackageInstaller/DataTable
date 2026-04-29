_class("UIShopRechargeGainItem", UICustomWidget)
UIShopRechargeGainItem = UIShopRechargeGainItem

function UIShopRechargeGainItem:OnShow()
  self._root = self:GetGameObject("root")
  self._root:SetActive(false)
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self._imgIconRect = self:GetUIComponent("RectTransform", "imgIcon")
  self._imgIconRectDefaultSize = Vector2(self._imgIconRect.sizeDelta.x, self._imgIconRect.sizeDelta.y)
  self._txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
end

function UIShopRechargeGainItem:OnHide()
  self._root = nil
end

function UIShopRechargeGainItem:ReadyToFlush(item, stamp)
  self:StartTask(function(TT)
    YIELD(TT, stamp)
    self:Flush(item)
  end, self)
end

function UIShopRechargeGainItem:Flush(item)
  if not self._root then
    return
  end
  self._root:SetActive(true)
  self._itemData = item
  self:FlushImage()
  self._txtName:SetText(self._itemData.item_name)
  self._txtCount:SetText(self._itemData.item_count)
end

function UIShopRechargeGainItem:FlushImage()
  self._imgIcon:LoadImage(self._itemData.icon)
  local isHead = false
  local itemId = self._itemData.item_id
  if 3750000 <= itemId and itemId <= 3759999 then
    isHead = true
  end
  if isHead then
    local whRate = 1
    if 3751000 <= itemId and itemId <= 3751999 then
      whRate = 0.8421052631578947
    elseif 3752000 <= itemId and itemId <= 3752999 then
      whRate = 0.6388888888888888
    elseif 3753000 <= itemId and itemId <= 3753999 then
      whRate = 0.6388888888888888
    end
    self._imgIconRect.sizeDelta = Vector2(self._imgIconRect.sizeDelta.x, self._imgIconRect.sizeDelta.x * whRate)
  else
    self._imgIconRect.sizeDelta = self._imgIconRectDefaultSize
  end
end

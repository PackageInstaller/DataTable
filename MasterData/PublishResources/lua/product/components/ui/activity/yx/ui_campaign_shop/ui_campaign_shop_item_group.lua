_class("UICampaignShopItemGroup", UICustomWidget)
UICampaignShopItemGroup = UICampaignShopItemGroup

function UICampaignShopItemGroup:OnShow(uiParams)
  self:InitWidget()
end

function UICampaignShopItemGroup:InitWidget()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._lockArea = self:GetGameObject("LockArea")
  self._cellGenGo = self:GetGameObject("ShopItemList")
  self._shopItemList = self:GetUIComponent("UISelectObjectPath", "ShopItemList")
  self._countDownText = self:GetUIComponent("UILocalizationText", "CountDownText")
  self._setAlphaArea = self:GetUIComponent("CanvasGroup", "ShopItemList")
  self._event = nil
end

function UICampaignShopItemGroup:OnHide()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
end

function UICampaignShopItemGroup:SetData()
end

function UICampaignShopItemGroup:GetRealSize()
  local width = 0
  for index, value in ipairs(self._data) do
    if value.GetIsSpecial and value:GetIsSpecial() then
      width = width + 400
    else
      width = width + 350
    end
  end
  return Vector2(width, 800)
end

function UICampaignShopItemGroup:InitData(data)
  self:DisposeCustomWidgets()
  self._shopItemList = self:GetUIComponent("UISelectObjectPath", "ShopItemList")
  self._data = data
  local cellSize = #data
  self._cellSize = cellSize
  local itemList = self._shopItemList:SpawnObjects("UICampaignShopItemGroupCell", cellSize)
  for index, value in ipairs(itemList) do
    value:InitData(data[index])
  end
  UIHelper.SetAsLastSibling(self._lockArea)
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  if ClientCampaignShop.CheckIsGoodsGroupUnlock(self._data._unlockTime, nowTime) then
    self._lockArea:SetActive(false)
    self._setAlphaArea.alpha = 1
    self._setAlphaArea.blocksRaycasts = true
  else
    self._setAlphaArea.alpha = 0.5
    self._setAlphaArea.blocksRaycasts = false
    self._lockArea:SetActive(true)
    self:_OnValueRemainingTime()
  end
end

function UICampaignShopItemGroup:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UICampaignShopItemGroup:_ShowRemainingTime()
  local stopTime = self._data._unlockTime
  local nowTime = math.floor(self._svrTimeModule:GetServerTime() / 1000)
  local remainingTime = stopTime - nowTime
  if remainingTime <= 0 then
    if self._event then
      GameGlobal.RealTimer():CancelEvent(self._event)
      self._event = nil
    end
    remainingTime = 0
  end
  self._countDownText:SetText(self:_GetFormatString(remainingTime))
end

function UICampaignShopItemGroup:_GetFormatString(stamp)
  local formatStr = "%s <color=#%s>%s</color>"
  local descStr = StringTable.Get("str_activity_evesinsa_shop_group_unlock_time")
  local colorStr = "FFE42D"
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, colorStr, timeStr)
  return showStr
end

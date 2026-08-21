_class("UIActivityShopItemGroup", UICustomWidget)
UIActivityShopItemGroup = UIActivityShopItemGroup

function UIActivityShopItemGroup:OnShow(uiParams)
  self:InitWidget()
end

function UIActivityShopItemGroup:InitWidget()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._lockArea = self:GetGameObject("LockArea")
  self._cellGenGo = self:GetGameObject("ShopItemList")
  self._shopItemList = self:GetUIComponent("UISelectObjectPath", "ShopItemList")
  self._countDownText = self:GetUIComponent("UILocalizationText", "CountDownText")
  self._setAlphaArea = self:GetUIComponent("CanvasGroup", "ShopItemList")
  self._event = nil
end

function UIActivityShopItemGroup:OnHide()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIActivityShopItemGroup:SetData()
end

function UIActivityShopItemGroup:GetRealSize()
  local campaignId = self._data._campaignId
  local commonCfg
  if campaignId then
    commonCfg = Cfg.cfg_activity_shop_common_client[campaignId]
  end
  local spWidth = 400
  local normalWidth = 350
  if commonCfg then
    spWidth = commonCfg.SpecialCellWidth
    normalWidth = commonCfg.NormalCellWidth
  end
  local width = 0
  for index, value in ipairs(self._data) do
    if value.GetIsSpecial and value:GetIsSpecial() then
      width = width + spWidth
    else
      width = width + normalWidth
    end
  end
  return Vector2(width, UIActivityShopControllerBase.ItemGroupHeight)
end

function UIActivityShopItemGroup:InitData(data)
  self:DisposeCustomWidgets()
  self._shopItemList = self:GetUIComponent("UISelectObjectPath", "ShopItemList")
  self._data = data
  local cellSize = #data
  self._cellSize = cellSize
  local itemList = self._shopItemList:SpawnObjects("UIActivityShopItemGroupCell", cellSize)
  for index, value in ipairs(itemList) do
    value:InitData(data[index])
    self:CheckAnimation(index, value, data)
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

function UIActivityShopItemGroup:_OnValueRemainingTime()
  self:_ShowRemainingTime()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
  self._event = GameGlobal.RealTimer():AddEventTimes(1000, TimerTriggerCount.Infinite, function()
    self:_ShowRemainingTime()
  end)
end

function UIActivityShopItemGroup:_ShowRemainingTime()
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

function UIActivityShopItemGroup:_GetFormatString(stamp)
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = StringTable.Get("str_activity_common_shop_group_unlock_time", timeStr)
  return showStr
end

function UIActivityShopItemGroup:CheckAnimation(index, ui, data)
  if self._data._campaignId == 1069 then
    local dataUI = data[index]
    if dataUI.GetIsSpecial and dataUI:GetIsSpecial() then
    else
      local go = ui:GetGameObject()
      go:SetActive(false)
      self:StartTask(function(TT)
        YIELD(TT, 20 + index * 50)
        if ui.view then
          go:SetActive(true)
        end
      end, self)
    end
  end
end

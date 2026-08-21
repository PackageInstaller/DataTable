_class("UIXH1ShopItemGroup", UICustomWidget)
UIXH1ShopItemGroup = UIXH1ShopItemGroup

function UIXH1ShopItemGroup:OnShow(uiParams)
  self:InitWidget()
end

function UIXH1ShopItemGroup:InitWidget()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._lockArea = self:GetGameObject("LockArea")
  self._cellGenGo = self:GetGameObject("ShopItemList")
  self._shopItemList = self:GetUIComponent("UISelectObjectPath", "ShopItemList")
  self._setAlphaArea = self:GetUIComponent("CanvasGroup", "ShopItemList")
  self._event = nil
end

function UIXH1ShopItemGroup:OnHide()
  if self._event then
    GameGlobal.RealTimer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIXH1ShopItemGroup:SetData()
end

function UIXH1ShopItemGroup:GetRealSize()
  local width = 0
  for index, value in ipairs(self._data) do
    if value.GetIsSpecial and value:GetIsSpecial() then
      width = width + 366
    else
      width = width + 366
    end
  end
  return Vector2(width, 800)
end

function UIXH1ShopItemGroup:InitData(data)
  self:DisposeCustomWidgets()
  self._shopItemList = self:GetUIComponent("UISelectObjectPath", "ShopItemList")
  self._data = data
  local cellSize = #data
  self._cellSize = cellSize
  local itemList = self._shopItemList:SpawnObjects("UIXH1ShopItemGroupCell", cellSize)
  for index, value in ipairs(itemList) do
    value:InitData(data[index])
  end
end

function UIXH1ShopItemGroup:_GetFormatString(stamp)
  local formatStr = "%s <color=#%s>%s</color>"
  local descStr = StringTable.Get("str_activity_evesinsa_shop_group_unlock_time")
  local colorStr = "FFE42D"
  local timeStr = UIActivityHelper.GetFormatTimerStr(stamp)
  local showStr = string.format(formatStr, descStr, colorStr, timeStr)
  return showStr
end

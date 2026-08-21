_class("UICN20N49Ryza_ShopWarning", UIController)
UICN20N49Ryza_ShopWarning = UICN20N49Ryza_ShopWarning

function UICN20N49Ryza_ShopWarning:OnShow(uiParams)
  self._map = uiParams[1]
  self._saveCb = uiParams[2]
  self._passCb = uiParams[3]
  self:GetItemList()
  self:InitWidgets()
  self:RefreshUI()
end

function UICN20N49Ryza_ShopWarning:GetItemList()
  local list = {}
  if self._map and next(self._map) then
    for k, v in pairs(self._map) do
      local data = UICN20N49RyzaItemData:New()
      data.id = k
      data.count = v
      local price, color = UICN20N49Ryza_Shop.GetItemPriceColor(k)
      data.price = price
      data.color = color
      table.insert(list, data)
    end
    UICN20N49Ryza_Shop.SortItemDataLsit(list)
  end
  self._list = list
end

function UICN20N49Ryza_ShopWarning:InitWidgets()
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
end

function UICN20N49Ryza_ShopWarning:RefreshUI()
  self._pool:SpawnObjects("UICN20N49Ryza_ShopCell", #self._list)
  local pools = self._pool:GetAllSpawnList()
  for i = 1, #self._list do
    local item = pools[i]
    local data = self._list[i]
    item:SetData(i, data)
  end
end

function UICN20N49Ryza_ShopWarning:SaveBtnOnClick(go)
  if self._saveCb then
    self._saveCb()
  end
  self:CloseDialog()
end

function UICN20N49Ryza_ShopWarning:PassBtnOnClick(go)
  if self._passCb then
    self._passCb()
  end
  self:CloseDialog()
end

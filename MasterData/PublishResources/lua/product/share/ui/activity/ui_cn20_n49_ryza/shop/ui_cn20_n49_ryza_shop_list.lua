_class("UICN20N49Ryza_ShopList", UIController)
UICN20N49Ryza_ShopList = UICN20N49Ryza_ShopList

function UICN20N49Ryza_ShopList:OnShow(uiParams)
  self._oriInfo = uiParams[1]
  self._oriCount = 0
  if self._oriInfo and next(self._oriInfo) then
    for k, v in pairs(self._oriInfo) do
      self._oriCount = self._oriCount + v
    end
  end
  self._callback = uiParams[2]
  self._comCfgID = uiParams[3]
  self._newInfo = {}
  for k, v in pairs(self._oriInfo) do
    self._newInfo[k] = v
  end
  self._maxCount = Cfg.cfg_global.AlchemyShopShelfMax.IntValue or 100
  self:InitWidgets()
  self:RefreshUI()
end

function UICN20N49Ryza_ShopList:InitWidgets()
  self._countTex = self:GetUIComponent("UILocalizationText", "countTex")
  self._pool = self:GetUIComponent("UISelectObjectPath", "Content")
end

function UICN20N49Ryza_ShopList:BtnOnClick(go)
  if self._callback then
    self._callback(self._newInfo)
  end
  self:CloseDialog()
end

function UICN20N49Ryza_ShopList:RefreshUI()
  self:RefreshCountTex()
  self:RefreshPool()
end

function UICN20N49Ryza_ShopList:RefreshCountTex()
  local newCount = 0
  if self._newInfo and next(self._newInfo) then
    for k, v in pairs(self._newInfo) do
      newCount = newCount + v
    end
  end
  local countStr = ""
  if newCount > self._oriCount and 0 < self._oriCount then
    local delta = newCount - self._oriCount
    countStr = self._oriCount .. "+" .. "<color=#00ffea>" .. delta .. "</color>/" .. self._maxCount
  elseif newCount == self._oriCount then
    countStr = newCount .. "/" .. self._maxCount
  else
    countStr = "<color=#00ffea>" .. newCount .. "</color>/" .. self._maxCount
  end
  local str = StringTable.Get("str_cn20_n49_shop_list_limit", countStr)
  self._countTex:SetText(str)
end

function UICN20N49Ryza_ShopList:RefreshNewInfo(itemid, count)
  local tmpInfo = {}
  for k, v in pairs(self._newInfo) do
    tmpInfo[k] = v
  end
  tmpInfo[itemid] = count
  local succ = true
  local allCout = 0
  for k, v in pairs(tmpInfo) do
    allCout = allCout + v
    if allCout > self._maxCount then
      succ = false
      break
    end
  end
  if succ then
    self._newInfo[itemid] = count
    self:RefreshCountTex()
  end
  return succ
end

function UICN20N49Ryza_ShopList:OnUpdate(dms)
  if self._pools and next(self._pools) then
    for k, v in pairs(self._pools) do
      v:OnUpdate(dms)
    end
  end
end

function UICN20N49Ryza_ShopList:RefreshPool()
  local allItemList = UICN20N49Ryza_ShopList.GetItemList(self._comCfgID)
  self._pool:SpawnObjects("UICN20N49Ryza_ShopListCell", #allItemList)
  self._pools = self._pool:GetAllSpawnList()
  for i = 1, #allItemList do
    local item = self._pools[i]
    local id = allItemList[i].id
    local inventory = allItemList[i].count
    local price = allItemList[i].price
    local color = allItemList[i].color
    local count = self._oriInfo[id] or 0
    item:SetData(i, id, price, color, inventory, count, function(id, count)
      return self:RefreshNewInfo(id, count)
    end, function(id, count)
      return self:GetLessCount(id, count)
    end)
  end
end

function UICN20N49Ryza_ShopList:GetLessCount(id, count)
  if self._newInfo and next(self._newInfo) then
    local nowCount = 0
    for k, v in pairs(self._newInfo) do
      if k == id then
      else
        nowCount = nowCount + v
      end
    end
    return self._maxCount - nowCount
  end
  return self._maxCount
end

function UICN20N49Ryza_ShopList.GetItemList(comCfgID, noSort)
  local itemModule = GameGlobal.GetModule(ItemModule)
  local list = {}
  local cfgs = Cfg.cfg_component_alchemy_item({ComponentID = comCfgID})
  if cfgs and next(cfgs) then
    for k, v in pairs(cfgs) do
      local id = v.ID
      local price = v.Price
      local color = v.Quality
      local count = itemModule:GetItemCount(id)
      if 0 < count then
        local UICN20N49RyzaItemData = UICN20N49RyzaItemData:New(id, color, price, count)
        table.insert(list, UICN20N49RyzaItemData)
      end
    end
  end
  if list and next(list) then
    if noSort then
      return list
    end
    table.sort(list, function(a, b)
      local color_a = a.color
      local color_b = b.color
      if color_a == color_b then
        local price_a = a.price
        local price_b = b.price
        if price_a == price_b then
          return a.id < b.id
        else
          return price_a > price_b
        end
      else
        return color_a > color_b
      end
    end)
  end
  return list
end

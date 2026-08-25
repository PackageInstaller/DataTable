local ShopOneKeyPurchaseModel = NewClass("ShopOneKeyPurchaseModel", BaseModel)

function ShopOneKeyPurchaseModel:OnInit()
  self.showShopItemList = {}
  self.shopItemList = {}
  self.shopTypeId = 0
  self._totalCostNum = 0
end

function ShopOneKeyPurchaseModel:OnReset()
  self:OnInit()
end

function ShopOneKeyPurchaseModel:Set_shopTypeId(num)
  self.shopTypeId = num
end

function ShopOneKeyPurchaseModel:Get_shopTypeId()
  return self.shopTypeId
end

function ShopOneKeyPurchaseModel:SetDefaultShopItemList(tbl)
  self:Set_shopItemList(tbl)
  self:Set_showShopItemList(tbl)
  local defaultItems = self:GetSaveSelectItems()
  if defaultItems then
    local rst = self.shopItemList
    local defaultSelectItems = {}
    for i = 1, #rst do
      local shopItem = rst[i]
      if table.contains(defaultItems, shopItem.tid) then
        table.insert(defaultSelectItems, shopItem)
      end
    end
    if #defaultSelectItems > 0 then
      self:Set_shopItemList(defaultSelectItems)
    end
  end
end

function ShopOneKeyPurchaseModel:Set_shopItemList(tbl)
  self.shopItemList = tbl
  self:Update_totalCostNum(self.shopItemList)
end

function ShopOneKeyPurchaseModel:Set_showShopItemList(tbl)
  self.showShopItemList = table.deepclone(tbl)
end

function ShopOneKeyPurchaseModel:Get_showShopItemList()
  return self.showShopItemList
end

function ShopOneKeyPurchaseModel:Get_shopItemList()
  return self.shopItemList
end

function ShopOneKeyPurchaseModel:Get_totalCostNum()
  return self._totalCostNum
end

function ShopOneKeyPurchaseModel:GetGoodTid2NumMap()
  local rst = {}
  for _, shopItemData in pairs(self.shopItemList) do
    rst[shopItemData.tid] = MainShopDataUtils.GetGoodRemaining(shopItemData)
  end
  return rst
end

function ShopOneKeyPurchaseModel:IsInShopItemList(shopItemData)
  local rst = self.shopItemList
  for i = 1, #rst do
    local shopItem = rst[i]
    if shopItemData.tid == shopItem.tid then
      return true
    end
  end
  return false
end

function ShopOneKeyPurchaseModel:CheckCurrencyEnough()
  local haveNum = ItemDataUtils.GetItemNum(self:GetCostCurrecyTid())
  local totalCostNum = self:Get_totalCostNum()
  return haveNum >= totalCostNum
end

function ShopOneKeyPurchaseModel:GetCostCurrecyTid()
  local showMoney = ShopTypeDataUtils.GetCfgByField("ShowMoney", self.shopTypeId)
  return showMoney and showMoney[1] or CommonDefine.CurrencyType.JuniorMoney
end

function ShopOneKeyPurchaseModel:Update_totalCostNum(shopItemList)
  local rst = 0
  for _, shopData in pairs(shopItemList) do
    local remainNum = MainShopDataUtils.GetGoodRemaining(shopData) or 0
    local price = shopData.price or 0
    rst = rst + remainNum * price
  end
  self._totalCostNum = rst
end

function ShopOneKeyPurchaseModel:Remove_shopItemList(targetData)
  local rst = self.shopItemList
  for i = 1, #rst do
    local shopItem = rst[i]
    if targetData.tid == shopItem.tid then
      table.remove(rst, i)
      break
    end
  end
  self:Set_shopItemList(rst)
end

function ShopOneKeyPurchaseModel:Add_shopItemList(targetData)
  local rst = self.shopItemList
  if not self:IsInShopItemList(targetData) then
    table.insert(rst, targetData)
  end
  self:Set_shopItemList(rst)
end

function ShopOneKeyPurchaseModel:GetSaveSelectItems()
  local saveKey = CommonDefine.LocalSaveKey.ShopOneKeyPurchaseIds
  do return MobileFileDataManager.Instance.GetPlayerFileValue, MobileFileDataManager.Instance end
  return MobileFileDataManager.Instance.GetPlayerFileValue, MobileFileDataManager.Instance, saveKey
end

function ShopOneKeyPurchaseModel:SaveSelectItems()
  local saveKey = CommonDefine.LocalSaveKey.ShopOneKeyPurchaseIds
  local saveList = {}
  local rst = self.shopItemList
  for i = 1, #rst do
    table.insert(saveList, rst[i].tid)
  end
  local saveKey = CommonDefine.LocalSaveKey.ShopOneKeyPurchaseIds
  MobileFileDataManager.Instance:SetPlayerFileValue(saveKey, saveList)
end

return ShopOneKeyPurchaseModel

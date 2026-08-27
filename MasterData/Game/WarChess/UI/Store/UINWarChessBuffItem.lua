local UINWarChessBuffItem = class("UINWarChessBuffItem", UIBaseNode)
local base = UIBaseNode

function UINWarChessBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINWarChessBuffItem:InitWarchessStoreBuffItem(storeData, MoneyIconId, clickFunc)
  self.clickFunc = clickFunc
  self.epStoreItemData = storeData
  local dynBuffData = storeData.epBuffData
  self.ui.tex_ItemName.text = dynBuffData:GetWCBuffName()
  local buffIcon = dynBuffData:GetWCBuffIcon()
  if not string.IsNullOrEmpty(buffIcon) then
    self.ui.img_Icon.sprite = CRH:GetSprite(buffIcon, CommonAtlasType.ExplorationIcon)
  end
  local buyPrice = dynBuffData:GetWCBuffPrice()
  local discount = storeData.discount
  self:__ShowPrice(buyPrice, discount, MoneyIconId)
  self.ui.img_SellOut:SetActive(storeData.saled)
end

function UINWarChessBuffItem:__ShowPrice(price, discount, MoneyIconId)
  self.price = price
  local hasDiscount = false
  if discount == 100 then
  else
    hasDiscount = true
    self.ui.tex_Discount:SetIndex(0, tostring(100 - discount))
    self.ui.tex_originalCost.text = tostring(self.price)
    self.price = math.ceil(self.price * discount / 100)
  end
  self.ui.discountNode:SetActive(hasDiscount)
  self.ui.originalPrice:SetActive(hasDiscount)
  self.ui.tex_Money.text = tostring(self.price)
  self.ui.img_Money.sprite = CRH:GetSprite(MoneyIconId)
end

function UINWarChessBuffItem:SetStoreBuffItemSelect(selected)
  if selected then
    self.ui.img_OnSelect.transform:SetParent(self.transform)
    self.ui.img_OnSelect.transform.anchoredPosition = Vector2.zero
  end
end

function UINWarChessBuffItem:UpdateSellOutActive()
  self.ui.img_SellOut:SetActive(self.epStoreItemData.saled)
end

function UINWarChessBuffItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self)
  end
end

function UINWarChessBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessBuffItem

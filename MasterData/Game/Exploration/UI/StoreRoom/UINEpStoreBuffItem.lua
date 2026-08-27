local UINEpStoreBuffItem = class("UINEpStoreBuffItem", UIBaseNode)
local base = UIBaseNode

function UINEpStoreBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINEpStoreBuffItem:InitEpStoreBuffItem(storeData, MoneyIconId, clickFunc)
  self.clickFunc = clickFunc
  self.epStoreItemData = storeData
  local dynBuffData = storeData.epBuffData
  self.ui.tex_ItemName.text = dynBuffData:GetEpBuffName()
  self.ui.img_Icon.sprite = dynBuffData:GetEpBuffIcon()
  local buyPrice = dynBuffData:GetEpBuffBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
  local discount = storeData.discount
  self:__ShowPrice(buyPrice, discount, MoneyIconId)
  self.ui.img_SellOut:SetActive(storeData.saled)
end

function UINEpStoreBuffItem:__ShowPrice(price, discount, MoneyIconId)
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

function UINEpStoreBuffItem:SetStoreBuffItemSelect(selected)
  if selected then
    self.ui.img_OnSelect.transform:SetParent(self.transform)
    self.ui.img_OnSelect.transform.anchoredPosition = Vector2.zero
  end
end

function UINEpStoreBuffItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self)
  end
end

function UINEpStoreBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINEpStoreBuffItem

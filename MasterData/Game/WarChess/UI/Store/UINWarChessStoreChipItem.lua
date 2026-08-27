local UINWarChessStoreChipItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINWarChessStoreChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_storeItem, self, self.__OnStoreItemClicked)
end

function UINWarChessStoreChipItem:InitWCStoreChipItem(storeData, MoneyIconId, clickAction, isSell)
  self.ui.img_SellOut:SetActive(false)
  if isSell then
    self.chipData = storeData
    local buyPrice = self.chipData:GetChipBuyPriceForWarChess()
    self.epDiscountPriceCfg = nil
    self.salePrice = self.chipData:GetChipSellPriceForWarChess()
    self:__showSellPrice(buyPrice, self.salePrice, MoneyIconId)
    self.ui.itemTitle.gameObject:SetActive(true)
  else
    self.epStoreItemData = storeData
    self.chipData = storeData.chipData
    local buyPrice = self.chipData:GetChipBuyPriceForWarChess()
    self:__ShowPrice(buyPrice, storeData.discount, MoneyIconId)
    self:WCRefreshShowSaledType(storeData.saled)
    self.ui.itemTitle.gameObject:SetActive(not storeData.saled)
  end
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(self.chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.ui.itemTitle:SetIndex(isSell and 1 or 0)
  self.ui.img_ChipTypeIcon.sprite = CRH:GetSprite(self.chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  self.index = storeData.idx
  self.clickAction = clickAction
  if not isSell then
  end
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self:SetNewTagActive(false)
end

function UINWarChessStoreChipItem:__showSellPrice(originPrice, price, MoneyIconId)
  self.price = price
  self.ui.discountNode:SetActive(false)
  self.ui.originalPrice:SetActive(false)
  self.ui.tex_Money.text = tostring(self.price)
  self.ui.img_Money.sprite = CRH:GetSprite(MoneyIconId)
end

function UINWarChessStoreChipItem:WCRefreshShowSaledType(isSaled)
  self.ui.img_SellOut:SetActive(isSaled)
  self.ui.btn_storeItem.enabled = not isSaled
end

function UINWarChessStoreChipItem:__ShowPrice(price, discount, MoneyIconId)
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

function UINWarChessStoreChipItem:SetStoreItemSelect(selected)
  if selected then
    self.ui.img_OnSelect.transform:SetParent(self.transform)
    self.ui.img_OnSelect.transform.anchoredPosition = Vector2.zero
  end
end

function UINWarChessStoreChipItem:__OnStoreItemClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UINWarChessStoreChipItem:SetNewTagActive(active, chipShowState)
  if IsNull(self.ui.tex_isNew) then
    return
  end
  self.ui.obj_isNew:SetActive(active)
  if active then
    if chipShowState == ChipEnum.eChipShowState.UpState then
      self.ui.tex_isNew:SetIndex(1)
    elseif chipShowState == ChipEnum.eChipShowState.NewState then
      self.ui.tex_isNew:SetIndex(0)
    else
      self.ui.obj_isNew:SetActive(false)
    end
  end
end

function UINWarChessStoreChipItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
    self.baseEpChipItem = nil
  end
  base.OnDelete(self)
end

return UINWarChessStoreChipItem

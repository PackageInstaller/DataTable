local UIEpStoreRoomItem = class("UINChipDisplaceItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UIEpStoreRoomItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_storeItem, self, self.__OnStoreItemClicked)
end

function UIEpStoreRoomItem:InitStoreRoomItem(roomId, storeData, MoneyIconId, clickAction, isSell, dynPlayer)
  self.ui.img_SellOut:SetActive(false)
  self.storeRoomId = roomId
  if isSell then
    self.chipData = storeData
    local buyPrice = self.chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
    self.epDiscountPriceCfg = ConfigData.exploration_shop[self.storeRoomId]
    self.salePrice = ConfigData:CalculateEpChipSalePrice(self.storeRoomId, self.chipData:GetCount(), buyPrice, dynPlayer)
    self:__showSellPrice(buyPrice, self.salePrice, ConfigData.item[self.epDiscountPriceCfg.currency].icon)
    self.ui.itemTitle.gameObject:SetActive(true)
  else
    self.epStoreItemData = storeData
    self.chipData = storeData.chipData
    local buyPrice = self.chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId())
    self:__ShowPrice(buyPrice, storeData.discount, MoneyIconId)
    self:__ShowSaledType(storeData.saled)
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
    self.chipItem:UpdateChipItem(dynPlayer)
  end
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self:SetNewTagActive(false)
end

function UIEpStoreRoomItem:__ShowSaledType(isSaled)
  self.ui.img_SellOut:SetActive(isSaled)
end

function UIEpStoreRoomItem:__showSellPrice(originPrice, price, MoneyIconId)
  self.price = price
  self.ui.discountNode:SetActive(false)
  self.ui.originalPrice:SetActive(false)
  self.ui.tex_Money.text = tostring(self.price)
  self.ui.img_Money.sprite = CRH:GetSprite(MoneyIconId)
end

function UIEpStoreRoomItem:__ShowPrice(price, discount, MoneyIconId)
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

function UIEpStoreRoomItem:SetStoreItemSelect(selected)
  if selected then
    self.ui.img_OnSelect.transform:SetParent(self.transform)
    self.ui.img_OnSelect.transform.anchoredPosition = Vector2.zero
  end
end

function UIEpStoreRoomItem:__OnStoreItemClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UIEpStoreRoomItem:GetStoreItemName()
  return self.chipData:GetName()
end

function UIEpStoreRoomItem:GetStoreChipItem()
  return self.chipItem
end

function UIEpStoreRoomItem:SetNewTagActive(active, chipShowState)
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

function UIEpStoreRoomItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
  end
  base.OnDelete(self)
end

return UIEpStoreRoomItem

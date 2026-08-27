local UINWarChessDiscardChipItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")

function UINWarChessDiscardChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_storeItem, self, self.__OnStoreItemClicked)
end

function UINWarChessDiscardChipItem:InitWCDiscardChipItem(chipData, discardPrice, MoneyIconId, clickAction)
  self.chipData = chipData
  self.ui.img_SellOut:SetActive(false)
  self:__ShowPrice(discardPrice, 0, MoneyIconId)
  self.ui.itemTitle:SetIndex(0)
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.ui.img_ChipTypeIcon.sprite = CRH:GetSprite(self.chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  self.clickAction = clickAction
  self.ui.tex_ItemName.text = self.chipData:GetName()
end

function UINWarChessDiscardChipItem:__ShowPrice(price, discount, MoneyIconId)
  self.price = price
  local hasDiscount = false
  self.ui.discountNode:SetActive(hasDiscount)
  self.ui.originalPrice:SetActive(hasDiscount)
  self.ui.tex_Money.text = price
  self.ui.img_Money.sprite = CRH:GetSpriteByItemId(MoneyIconId, false)
end

function UINWarChessDiscardChipItem:SetStoreItemSelect(selected)
  self.ui.img_OnSelect:SetActive(selected)
end

function UINWarChessDiscardChipItem:__OnStoreItemClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UINWarChessDiscardChipItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
    self.baseEpChipItem = nil
  end
  base.OnDelete(self)
end

return UINWarChessDiscardChipItem

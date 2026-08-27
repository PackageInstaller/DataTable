local UIEpUpgradeRoomItem = class("UINEpOverclockChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")

function UIEpUpgradeRoomItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_chipItem, self, self.__OnChipItemClicked)
end

function UIEpUpgradeRoomItem:InitUpgradeRoomItem(roomId, moneyIconId, price, chipData, clickAction)
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(chipData, true)
  self.chipItem = self.baseEpChipItem.chipItem
  self.upgradeRoomId = roomId
  self.chipData = chipData
  self.index = chipData.idx
  self.clickAction = clickAction
  self.upgradePrice = price
  self:__ShowPrice(self.upgradePrice, moneyIconId)
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self.ui.img_ChipTypeIcon.sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
  self.ui.Obj_LevelMax:SetActive(self.chipData:IsChipFullLevel())
end

function UIEpUpgradeRoomItem:__ShowPrice(price, MoneyIconId)
  self.ui.originalPrice:SetActive(false)
  self.ui.tex_Money.text = tostring(price)
  self.ui.img_Money.sprite = CRH:GetSprite(MoneyIconId)
end

function UIEpUpgradeRoomItem:SetChipItemSelect(selected)
  self.ui.img_OnSelect:SetActive(selected)
end

function UIEpUpgradeRoomItem:__OnChipItemClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UIEpUpgradeRoomItem:GetChipItemName()
  return self.chipData:GetName()
end

function UIEpUpgradeRoomItem:GetChipItem()
  return self.chipItem
end

function UIEpUpgradeRoomItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
    self.baseEpChipItem = nil
  end
  base.OnDelete(self)
end

return UIEpUpgradeRoomItem

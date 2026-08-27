local UINFairyCultivateCardItemList = require("Game.Fairy.UI.UINFairyCultivateCardItemList")
local UINFairyCultivateCardItemMulList = class("UINFairyCultivateCardItemMulList", UINFairyCultivateCardItemList)
local base = UINFairyCultivateCardItemList
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")

function UINFairyCultivateCardItemMulList:OnInit()
  base.OnInit(self)
end

function UINFairyCultivateCardItemMulList:InitFairyCultivateCardItemList(resloader, clickItemCallback, mainUiData)
  base.InitFairyCultivateCardItemList(self, resloader, clickItemCallback, mainUiData)
  self:SetIsMaskFavouriteFairy(true)
end

function UINFairyCultivateCardItemMulList:SetSelectedObj(index, fairyCardItem)
  local go = fairyCardItem and fairyCardItem.gameObject or self.ui.loopList:GetCellByIndex(index - 1)
  self.selectedIndex = index
  self:SetSelected(false)
  local realFairyCardItem = self.fairyCardItemDic[go]
  self.selectCardItem = realFairyCardItem
  self.selectCardItem:SetInteriorSelected(true)
end

function UINFairyCultivateCardItemMulList:SetSelected(bool)
  if not IsNull(self.selectCardItem) then
    self.selectCardItem:SetInteriorSelected(bool)
  end
end

function UINFairyCultivateCardItemMulList:OnDelete()
  base.OnDelete(self)
end

return UINFairyCultivateCardItemMulList

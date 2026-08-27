local base = UIBaseNode
local UINFairyFormationCardItem = class("UINFairyFormationCardItem", base)
local UINFairyCultivateCardItem = require("Game.Fairy.UI.UINFairyCultivateCardItem")

function UINFairyFormationCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.fairyCardItem = UINFairyCultivateCardItem.New()
  self.fairyCardItem:Init(self.ui.uINFairyCardItem)
end

function UINFairyFormationCardItem:InitFairyCultivateCardItem(fairyData, index, resloader, clickCallback)
  self.fairyData = fairyData
  self.fairyCardItem:InitFairyCultivateCardItem(fairyData, index, resloader, clickCallback)
end

function UINFairyFormationCardItem:SetInteriorSelected(bool)
  self.fairyCardItem:SetInteriorSelected(bool)
end

function UINFairyFormationCardItem:FFCI_SetIsCardSetUsed(isCardSetUsed)
  self.ui.cantBattle:SetActive(isCardSetUsed)
end

function UINFairyFormationCardItem:OnDelete()
  if self.fairyCardItem ~= nil then
    self.fairyCardItem:Delete()
    self.fairyCardItem = nil
  end
  base.OnDelete(self)
end

return UINFairyFormationCardItem

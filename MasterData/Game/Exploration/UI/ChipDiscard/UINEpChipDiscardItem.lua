local UINEpChipDiscardItem = class("UINBaseEpChipItem", UIBaseNode)
local base = UIBaseNode
local UINBaseEpChipItem = require("Game.Exploration.UI.Base.UINBaseEpChipItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UINEpChipDiscardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_storeItem, self, self.__OnStoreItemClicked)
end

function UINEpChipDiscardItem:InitDiscardChipItem(discardId, chipData, clickAction, dynPlayer)
  self:__InitDiscardChipDefault(discardId, chipData, clickAction, dynPlayer)
  self.price = ConfigData:CalculateEpChipDiscardSalePrice(discardId, self.chipData.chipBattleData.level, self.chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true), self.dynPlayer)
  self:__showSellPrice(ConfigData.item[self.discardCfg.discard_scaleId].icon)
end

function UINEpChipDiscardItem:InitDiscardChipItemInSellout(discardId, chipData, clickAction, dynPlayer)
  self:__InitDiscardChipDefault(discardId, chipData, clickAction, dynPlayer)
  local epTypeCfg = ExplorationManager:GetEpTypeCfg()
  local buyPrice = chipData:GetChipBuyPrice(ExplorationManager:GetEpModuleTypeCfgId(), true)
  self.price = ConfigData:CalculateEpChipSalePrice(epTypeCfg.store_pool, chipData:GetCount(), buyPrice, ExplorationManager:GetDynPlayer())
  self:__showSellPrice(ConfigData.item[self.discardCfg.discard_scaleId].icon)
end

function UINEpChipDiscardItem:__InitDiscardChipDefault(discardId, chipData, clickAction, dynPlayer)
  self.chipData = chipData
  self.clickAction = clickAction
  self.discardCfg = ConfigData.exploration_discard[discardId]
  self.dynPlayer = dynPlayer
  self.baseEpChipItem = UINBaseEpChipItem.New()
  self.baseEpChipItem:Init(self.ui.UINEpChipItem)
  self.baseEpChipItem:InitBaseEpChipUI(chipData, true)
  self.ui.tex_ItemName.text = self.chipData:GetName()
  self.ui.img_ChipTypeIcon.sprite = CRH:GetSprite(chipData:GetChipMarkIcon(), CommonAtlasType.ExplorationIcon)
end

function UINEpChipDiscardItem:__showSellPrice(MoneyIconId)
  self.ui.tex_Money.text = tostring(self.price)
  self.ui.img_Money.sprite = CRH:GetSprite(MoneyIconId)
end

function UINEpChipDiscardItem:SetItemSelect(selected)
  self.ui.img_OnSelect:SetActive(selected)
end

function UINEpChipDiscardItem:__OnStoreItemClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UINEpChipDiscardItem:GetEpChipDiscardItemMoneyIconSpriteNum()
  return self.ui.img_Money.sprite, self.ui.tex_Money.text
end

function UINEpChipDiscardItem:OnDelete()
  if self.baseEpChipItem ~= nil then
    self.baseEpChipItem:Delete()
  end
  base.OnDelete(self)
end

return UINEpChipDiscardItem

local UINEpRewardBagItem = class("UINEpRewardBagItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local EpRewardBagUtil = require("Game.Exploration.UI.EpRewardBag.EpRewardBagUtil")

function UINEpRewardBagItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.baseItem = UINBaseItemWithCount.New()
  self.baseItem:Init(self.ui.baseItemWithCount)
end

function UINEpRewardBagItem:InitEpRewardBagItem(index, itemCfg, itemNum, price, originalPrice, selectFunc, selectable)
  self.itemCfg = itemCfg
  self.index = index
  self.selectFunc = selectFunc
  self.selectable = selectable
  self.baseItem:InitItemWithCount(itemCfg, itemNum)
  self.ui.tex_originalCost.text = EpRewardBagUtil:GetEpRewardItemPriceStr(originalPrice)
  self.ui.tex_Money.text = EpRewardBagUtil:GetEpRewardItemPriceStr(price)
  self.ui.originalPrice:SetActive(originalPrice ~= price)
  self.ui.tex_ItemName.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.img_QuailtyColor.color = ItemQualityColor[itemCfg.quality]
  self.ui.selecttable:SetActive(selectable)
end

function UINEpRewardBagItem:_OnClickRoot()
  if self.selectable and self.selectFunc ~= nil then
    self.selectFunc(self, self.index)
  end
end

function UINEpRewardBagItem:SetEpRewardBagItemSelected(selected)
  self.ui.img_IsSelect:SetActive(selected)
end

function UINEpRewardBagItem:SetEpRewardBagItemCurrencyIcon(sprite)
  self.ui.img_Money.sprite = sprite
end

function UINEpRewardBagItem:OnDelete()
  self.baseItem:Delete()
  self.baseItem = nil
  base.OnDelete(self)
end

return UINEpRewardBagItem

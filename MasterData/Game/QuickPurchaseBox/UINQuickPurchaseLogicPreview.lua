local UILogicPreviewNodeBase = require("Game.CommonUI.LogicPreviewNode.UILogicPreviewNodeBase")
local UINQuickPurchaseLogicPreview = class("UINQuickPurchaseLogicPreview", UILogicPreviewNodeBase)
local base = UILogicPreviewNodeBase
local UINQuickPurchaseLogicLvRowItem = require("Game.QuickPurchaseBox.UINQuickPurchaseLogicLvRowItem")

function UINQuickPurchaseLogicPreview:OnInit()
  base.OnInit(self)
  base.InitWithClass(self, nil, UINQuickPurchaseLogicLvRowItem)
end

function UINQuickPurchaseLogicPreview:InitBuyFragPreview(intervalList, priceList, curIndex)
  UIUtil.SetTopStatus(self, self._Close)
  self.ui.tex_SkillName:SetIndex(1)
  self.ui.obj_Current.gameObject:SetActive(true)
  self.headAttrPool:HideAll()
  self.rowItemPool:HideAll()
  local str = string.split(ConfigData:GetTipContent(TipContent.Shop_fragPriceDes), "|")
  local intervaTitleItem = self.headAttrPool:GetOne()
  intervaTitleItem:InitAttrItem(str[1])
  local priceTitleItem = self.headAttrPool:GetOne()
  priceTitleItem:InitAttrItem(str[2])
  for index = 1, #intervalList do
    local isCur = curIndex == index
    local rowItem = self.rowItemPool:GetOne()
    rowItem:InitWithClass()
    local str
    if intervalList[index].y == -1 then
      str = intervalList[index].x .. "~"
    else
      str = intervalList[index].x .. "~" .. intervalList[index].y
    end
    rowItem:InitShopItemPriveInterval(isCur, str, priceList[index])
    if isCur then
      self.ui.obj_Current:SetParent(rowItem.transform)
      self.ui.obj_Current.anchoredPosition = Vector2.zero
      self.ui.obj_Current:SetAsFirstSibling()
    end
  end
  self.ui.scrollRect.verticalNormalizedPosition = 1 - (curIndex - 1) / (#intervalList - 1)
end

function UINQuickPurchaseLogicPreview:OnDelete()
  base.OnDelete(self)
end

return UINQuickPurchaseLogicPreview

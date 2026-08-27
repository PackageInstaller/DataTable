local base = UIBaseNode
local UINCardSetCardItem = class("UINCardSetCardItem", UIBaseNode)
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UINCardSetCardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCardSetCardItem:InitCSCardItem(cardSetCtrl, cardSetData, cardData, cardBaseItemPool)
  self.cardSetCtrl = cardSetCtrl
  self.cardSetData = cardSetData
  self.cardData = cardData
  self._cardBaseItemDic = {}
  local cardCfgDic = cardData:GetCardCfgDic()
  for effectId = 0, CardSetEnum.eCardTive.max - 1 do
    if cardCfgDic[effectId] ~= nil then
      local cardBaseItem = cardBaseItemPool:GetOne()
      cardBaseItem:InitCSCardBaseItem(cardSetCtrl, cardSetData, cardData, effectId, self)
      cardBaseItem.transform:SetParent(self.transform)
      self._cardBaseItemDic[effectId] = cardBaseItem
    end
  end
  self:RefreshCardSetCardItem()
end

function UINCardSetCardItem:RefreshCardSetCardItem()
  self:RefeshIsSelectedCardItem()
  self:RefreshIsNewCard()
  self:UpdBanCardSetCardItem()
end

function UINCardSetCardItem:RefeshIsSelectedCardItem()
  local isSelect = self.cardSetData:GetIsSelectedCard(self.cardData)
  self.ui.obj_SelectedDown:SetActive(isSelect)
  for k, baseItem in pairs(self._cardBaseItemDic) do
    baseItem:RefeshIsSelectedCardBaseItem(isSelect)
  end
end

function UINCardSetCardItem:UpdBanCardSetCardItem()
  for k, baseItem in pairs(self._cardBaseItemDic) do
    baseItem:UpdCardStBaseItemBan()
  end
end

function UINCardSetCardItem:RefreshIsNewCard()
  local isNew = self.cardData:GetCardSetCardIsNew()
  self.ui.obj_New:SetActive(isNew)
end

function UINCardSetCardItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetCardItem

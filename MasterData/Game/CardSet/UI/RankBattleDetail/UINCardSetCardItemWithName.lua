local base = require("Game.CardSet.UI.BattleResult.UINCardSetBaseCardItem")
local UINCardSetCardItemWithName = class("UINCardSetCardItemWithName", base)

function UINCardSetCardItemWithName:OnInit()
  base.OnInit(self)
end

function UINCardSetCardItemWithName:InitCardSetCardItemWithName(cardData, resloader, longPressFunc, pressUpFunc)
  base.InitCardSetBaseCardItem(self, cardData, resloader, longPressFunc, pressUpFunc)
  self.ui.tex_CardName.text = cardData:GetCardSetCardName()
  self.ui.tex_CardType.text = cardData:GetCardSetCardTypeName()
end

function UINCardSetCardItemWithName:OnDelete()
  base.OnDelete(self)
end

return UINCardSetCardItemWithName

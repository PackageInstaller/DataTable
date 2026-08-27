local base = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectItemBase")
local UINRfCardSetSelectFacItem = class("UINRfCardSetSelectFacItem", base)
local UINRfCardFacSmall = require("Game.Reinforce.UI.FactorCard.UINRfCardFacSmall")

function UINRfCardSetSelectFacItem:OnInit()
  base.OnInit(self)
  self.cardFacSmall = UINRfCardFacSmall.New()
  self.cardFacSmall:Init(self.ui.uINRfCardFacSmall)
end

function UINRfCardSetSelectFacItem:InitRfCardSetSelectFacItem(cardData, resloader, isSelect, parWin, selectIndex, isFmt)
  base.InitRfCardSetSelectItemBase(self, cardData, resloader, isSelect, parWin, selectIndex)
  self.cardFacSmall:InitRfCardFacSmall(cardData, resloader, isFmt)
  self.cardFacSmall:SetRfCardFacSmallClickFunc(self.onClickRootCallback)
end

function UINRfCardSetSelectFacItem:RefreshRfCardSetSelectFacItem()
  self.cardFacSmall:InitRfCardFacSmall(self.cardData, self.resloader)
end

function UINRfCardSetSelectFacItem:SetIsDefaultFmt(bool)
  self.isDefaultFmt = bool
end

function UINRfCardSetSelectFacItem:OnClickDetails()
  if self.isCheck then
    return
  end
  base.OnClickDetails(self)
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    win:InitRfCardDetailFac(self.cardData, self.isDefaultFmt)
    UIUtil.PopFromBackStackByWinId(UIWindowTypeID.UIReinforceCardDetailFac)
    self.parWin:SetDetailWin(self, win)
    win:SetBkClose()
    local trans = win.transform
    trans.offsetMin = Vector2.New(self.ui.offsetX, self.ui.offsetY)
    trans.offsetMax = Vector2.zero
  end)
end

function UINRfCardSetSelectFacItem:OnDelete()
end

return UINRfCardSetSelectFacItem

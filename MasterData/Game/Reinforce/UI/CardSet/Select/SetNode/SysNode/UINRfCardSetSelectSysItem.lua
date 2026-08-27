local base = require("Game.Reinforce.UI.CardSet.Select.SetNode.SysNode.UINRfCardSetSelectItemBase")
local UINRfCardSetSelectSysItem = class("UINRfCardSetSelectSysItem", base)
local UINRfCardSysSmall = require("Game.Reinforce.UI.SystemCard.UINRfCardSysSmall")

function UINRfCardSetSelectSysItem:OnInit()
  base.OnInit(self)
  self.cardSysSmall = UINRfCardSysSmall.New()
  self.cardSysSmall:Init(self.ui.uINRfCardSysSmall)
end

function UINRfCardSetSelectSysItem:InitRfCardSetSelectFacItem(cardData, resloader, isSelect, parWin, selectIndex)
  base.InitRfCardSetSelectItemBase(self, cardData, resloader, isSelect, parWin, selectIndex)
  self.cardSysSmall:InitRfCardSysSmall(cardData, resloader)
  self.cardSysSmall:SetRfCardSysSmallClickFunc(self.onClickRootCallback)
end

function UINRfCardSetSelectSysItem:RefreshRfCardSetSelectSysItem()
  self.cardSysSmall:InitRfCardSysSmall(self.cardData, self.resloader)
end

function UINRfCardSetSelectSysItem:OnClickDetails()
  if self.isCheck then
    return
  end
  base.OnClickDetails(self)
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailSys, function(win)
    if win == nil then
      return
    end
    win:InitReinforceCardDetailSys(self.cardData)
    UIUtil.PopFromBackStackByWinId(UIWindowTypeID.UIReinforceCardDetailSys)
    self.parWin:SetDetailWin(self, win)
    win:SetBkClose()
    local trans = win.transform
    trans.offsetMin = Vector2.New(self.ui.offsetX, self.ui.offsetY)
    trans.offsetMax = Vector2.zero
  end)
end

function UINRfCardSetSelectSysItem:OnDelete()
end

return UINRfCardSetSelectSysItem

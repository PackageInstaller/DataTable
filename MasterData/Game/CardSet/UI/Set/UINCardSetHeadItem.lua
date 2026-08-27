local UINCardSetHeadItem = class("UINCardSetHeadItem", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UINCardSetHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCardSetHeadItem:InitCardSetHeadItem(cardSetCtrl, eCardType)
  self.cardSetCtrl = cardSetCtrl
  self.eCardType = eCardType
  self:SetCardSetHeadItemType(eCardType)
  self:SetCardSetHeadItemCurNum(eCardType)
end

function UINCardSetHeadItem:RefreshCardHead()
  self:SetCardSetHeadItemType(self.eCardType)
  self:SetCardSetHeadItemCurNum(self.eCardType)
end

function UINCardSetHeadItem:SetCardSetHeadItemType(eCardType)
  self.ui.img_Pic:SetIndex(eCardType - 1)
end

function UINCardSetHeadItem:SetCardSetHeadItemCurNum(eCardType)
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local haveNum = cardSetData:GetCardSetCardNum4Type(eCardType)
  local curSelectNum = cardSetData:GetCardSetSelectCardNum4Type(eCardType)
  if 0 < curSelectNum then
    self.ui.img_Bottom.color = self.ui.color_orange
    self.ui.img_DotFrame.color = Color.white
  else
    self.ui.img_Bottom.color = self.ui.color_black
    self.ui.img_DotFrame.color = Color.New(1, 1, 1, 0.5)
  end
  self.ui.tex_Num.text = tostring(curSelectNum) .. "/" .. tostring(haveNum)
end

function UINCardSetHeadItem:PlayHeadItemTween(index)
  self.gameObject.transform:DOComplete()
  self.gameObject.transform:DOScale(Vector3.New(0, 0, 0), 0.4):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):SetDelay(0.2 + index * 0.05)
end

function UINCardSetHeadItem:OnDelete()
  base.OnDelete(self)
end

return UINCardSetHeadItem

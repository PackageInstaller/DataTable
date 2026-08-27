local UINCSRightTagItem = class("UINCSRightTagItem", UIBaseNode)
local base = UIBaseNode
local cs_Ease = CS.DG.Tweening.Ease

function UINCSRightTagItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCSRightTagItem:InitCSRightTagItem(cardSetCtrl, eCardType)
  self.cardSetCtrl = cardSetCtrl
  self.eCardType = eCardType
  self:RefreshCSRightTag()
end

function UINCSRightTagItem:RefreshCSRightTag()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local usedNum = cardSetData:GetCardSetSelectCardNum4Type(self.eCardType)
  local useLimitNum = cardSetData:GetCardSetCardHUseLimitNum4Type(self.eCardType)
  local curUseNum = cardSetData:GetCardSetSelectCardNum4Type(self.eCardType)
  local typeName = cardSetData:GetCardSetCardHName4Type(self.eCardType)
  self.ui.tex_CNName.text = typeName
  self.ui.tex_ENName:SetIndex(self.eCardType - 1)
  local existNum = 0 < curUseNum
  self.ui.img_Bottom:SetIndex(existNum and 1 or 0)
  self.ui.tex_Num:SetIndex(existNum and 1 or 0, tostring(usedNum), tostring(useLimitNum))
  self.ui.img_TagBg.color = self.ui.color_tagBg[existNum and 2 or 1]
end

function UINCSRightTagItem:PlayInitTween(index)
  self.gameObject.transform:DOComplete()
  self.gameObject.transform:DOLocalMoveX(180, 0.3):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):SetDelay(0.3 + index * 0.05)
  self.ui.canvas_tagItem:DOComplete()
  self.ui.canvas_tagItem:DOFade(0, 0.3):From():SetEase(cs_Ease.OutQuart):SetLink(self.gameObject):SetDelay(0.3 + index * 0.05)
end

function UINCSRightTagItem:ShowTopCSRightTagItem(isShow)
  self.ui.top:SetActive(isShow)
end

function UINCSRightTagItem:OnDelete()
  base.OnDelete(self)
end

return UINCSRightTagItem

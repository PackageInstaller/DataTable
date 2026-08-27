local UINCSRightDetailInfoListItem = class("UINCSRightDetailInfoListItem", UIBaseNode)
local base = UIBaseNode
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")

function UINCSRightDetailInfoListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINCSRightDetailInfoListItem:InitCSRDLItemWithCardData(cardData, resloader)
  local cardType = cardData:GetCardSetCardType()
  local iconRes = cardData:GetCardSetCardIcon()
  self.ui.tex_TpyeName.text = cardData:GetCardSetCardName()
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("CardIcon", iconRes, resloader)
  self.ui.tex_Des.text = cardData:GetCardSetCardDes()
  if cardType ~= 4 then
    self.ui.tex_TypeTitleName:SetIndex(cardType - 1)
    self.ui.img_Bg.color = self.ui.color_normal
  else
    local cardTive = cardData:GetCardSetCardTive()
    if cardTive == CardSetEnum.eCardTive.postive then
      self.ui.tex_TypeTitleName:SetIndex(3)
      self.ui.img_Bg.color = self.ui.color_positive
    elseif cardTive == CardSetEnum.eCardTive.negative then
      self.ui.tex_TypeTitleName:SetIndex(4)
      self.ui.img_Bg.color = self.ui.color_negative
    else
      self.ui.tex_TypeTitleName:SetIndex(5)
      self.ui.img_Bg.color = self.ui.color_normal
    end
  end
  self.ui.tex_Word:SetIndex(cardType - 1)
  self.ui.img_Quality.color = cardData:GetCardStQualityColor()
  self.ui.obj_Selected:SetActive(false)
end

function UINCSRightDetailInfoListItem:SetCSRightDetailInfoListItemSelected()
  self.ui.obj_Selected:SetActive(true)
end

function UINCSRightDetailInfoListItem:OnDelete()
  base.OnDelete(self)
end

return UINCSRightDetailInfoListItem

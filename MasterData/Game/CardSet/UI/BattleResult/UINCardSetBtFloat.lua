local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINCardSetBtFloat = class("UINCardSetBtFloat", base)
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility

function UINCardSetBtFloat:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
end

function UINCardSetBtFloat:InitCardSetBtFloat(transform, cardData, resloader)
  self:FloatTo(transform, HAType.left, VAType.up)
  self.ui.tex_Des.text = cardData:GetCardSetCardDes()
  self.ui.tex_Name.text = cardData:GetCardSetCardName()
  local cardEffect = cardData:GetCardSetCardTive()
  local hasEffect = 0 < cardEffect
  if hasEffect then
    self.ui.tex_TypeTitleName:SetIndex(cardEffect - 1)
    self.ui.img_TypeBg.color = self.ui.color_Type[cardEffect]
  else
    self.ui.tex_TypeTitleName.text.text = cardData:GetCardSetCardTypeName()
    self.ui.img_TypeBg.color = self.ui.color_Env
  end
  local iconRes = cardData:GetCardSetCardIcon()
  self.ui.img_Pic.sprite = AtlasUtil.GetSpriteFromAtlas("CardIcon", iconRes, resloader)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
end

function UINCardSetBtFloat:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UINCardSetBtFloat:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  base.OnHide(self)
end

function UINCardSetBtFloat:OnDelete()
  base.OnDelete(self)
end

return UINCardSetBtFloat

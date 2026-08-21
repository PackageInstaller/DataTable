_class("UIConditionItem", UICustomWidget)
UIConditionItem = UIConditionItem
local ATLAS_NAME = "UIStage.spriteatlas"
local BG_NAME = "map_guanqia_tiao"

function UIConditionItem:OnShow()
  self._imgStar = self:GetGameObject("imgStar")
  self._grayImgStar = self:GetGameObject("imgGrayStar")
  self._txt = self:GetUIComponent("RollingText", "txt")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._bgImage = self:GetUIComponent("Image", "bg")
end

function UIConditionItem:Flush(v, index)
  self._title.text = index
  self._txt:RefreshText(v.content)
  self._imgStar.gameObject:SetActive(v.satisfy)
  self._grayImgStar.gameObject:SetActive(not v.satisfy)
end

function UIConditionItem:RefreshBg(atlas, index)
  local spriteName = BG_NAME .. index
  local sprite = atlas:GetSprite(spriteName)
  if sprite then
    self._bgImage.sprite = sprite
  end
end

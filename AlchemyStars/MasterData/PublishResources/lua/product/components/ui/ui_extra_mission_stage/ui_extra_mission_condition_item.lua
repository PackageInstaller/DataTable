_class("UIExtraMissionStageConditionItem", UICustomWidget)
UIExtraMissionStageConditionItem = UIExtraMissionStageConditionItem
local ATLAS_NAME = "UIExtraMissionStage.spriteatlas"
local BG_NAME = "map_guanqia_tiao"

function UIExtraMissionStageConditionItem:OnShow()
  self._imgStar = self:GetGameObject("imgStar")
  self._grayImgStar = self:GetGameObject("imgGrayStar")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._bgImage = self:GetUIComponent("Image", "bg")
end

function UIExtraMissionStageConditionItem:Init(index, id, desc, pass)
  self._title.text = index
  self._txt.text = desc
  self._imgStar.gameObject:SetActive(pass)
  self._grayImgStar.gameObject:SetActive(not pass)
  local atlas = self:GetAsset(ATLAS_NAME, LoadType.SpriteAtlas)
  if atlas then
    self:RefreshBg(atlas, index)
  end
end

function UIExtraMissionStageConditionItem:RefreshBg(atlas, index)
  local spriteName = BG_NAME .. index
  local sprite = atlas:GetSprite(spriteName)
  if sprite then
    self._bgImage.sprite = sprite
  end
end

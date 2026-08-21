_class("UISeasonConditionItem", UICustomWidget)
UISeasonConditionItem = UISeasonConditionItem
local ATLAS_NAME = "UIStage.spriteatlas"
local BG_NAME = "map_guanqia_tiao"

function UISeasonConditionItem:OnShow()
  self._imgStar = self:GetGameObject("imgStar")
  self._grayImgStar = self:GetGameObject("imgGrayStar")
  self._txt = self:GetUIComponent("RollingText", "txt")
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._bgImage = self:GetUIComponent("Image", "bg")
  self._anim = self:GetUIComponent("Animation", "Base")
  self._rootGo = self:GetGameObject("root")
end

function UISeasonConditionItem:Flush(v, index)
  self._index = index
  self._title.text = index
  self._txt:RefreshText(v.content)
  self._imgStar.gameObject:SetActive(v.satisfy)
  self._grayImgStar.gameObject:SetActive(not v.satisfy)
end

function UISeasonConditionItem:PlayAnim(totalDelay)
  local curAnimDelay = 0
  if totalDelay then
    curAnimDelay = totalDelay
  end
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
    self._animTimer = nil
  end
  self._animTimer = GameGlobal.Timer():AddEvent(curAnimDelay, function()
    self:_PlayInAnim()
  end)
end

function UISeasonConditionItem:RefreshBg(atlas, index)
  local spriteName = BG_NAME .. index
  local sprite = atlas:GetSprite(spriteName)
  if sprite then
    self._bgImage.sprite = sprite
  end
end

function UISeasonConditionItem:SetWaitAnim()
  if self._rootGo then
    self._rootGo:SetActive(false)
  end
end

function UISeasonConditionItem:_PlayInAnim()
  if self._anim then
    self._anim:Play("uieff_UISeasonConditionItem_in")
    if self._rootGo then
      self._rootGo:SetActive(true)
    end
  end
end

function UISeasonConditionItem:OnHide()
  if self._animTimer then
    GameGlobal.Timer():CancelEvent(self._animTimer)
    self._animTimer = nil
  end
end

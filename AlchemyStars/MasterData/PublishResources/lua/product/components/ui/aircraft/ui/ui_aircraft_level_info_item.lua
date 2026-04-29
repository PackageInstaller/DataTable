_class("UIAircraftLevelInfoItem", UICustomWidget)
UIAircraftLevelInfoItem = UIAircraftLevelInfoItem

function UIAircraftLevelInfoItem:OnShow(uiParams)
  self._titleOnly = self:GetGameObject("titleOnly")
  self._single = self:GetGameObject("single")
  self._double = self:GetGameObject("double")
  self._title = self:GetUIComponent("RollingText", "title")
  self._title1 = self:GetUIComponent("RollingText", "title1")
  self._title2 = self:GetUIComponent("RollingText", "title2")
  self._singleText = self:GetUIComponent("UILocalizationText", "singleText")
  self._from = self:GetUIComponent("UILocalizationText", "from")
  self._to = self:GetUIComponent("UILocalizationText", "to")
  self._arrow = self:GetUIComponent("Image", "arrow")
  local atlas = self:GetAsset("UIAircraftLevel.spriteatlas", LoadType.SpriteAtlas)
  self._levelDownArrow = atlas:GetSprite("wind_shengjiang_jiantou1")
  self._levelUpArrow = atlas:GetSprite("wind_shengjiang_jiantou2")
  self._levelUpColor = Color(250, 90, 47)
  self._levelDownColor = Color(22, 171, 255)
end

function UIAircraftLevelInfoItem:OnHide()
end

function UIAircraftLevelInfoItem:SetData(title, isLevelUp, first, second)
  self._titleOnly:SetActive(false)
  self._single:SetActive(false)
  self._double:SetActive(false)
  if second then
    self._double:SetActive(true)
    self._title2:RefreshText(title)
    self._from:SetText(first)
    self._to:SetText(second)
    if isLevelUp then
      self._to:CrossFadeColor(self._levelUpColor, 0, true, false)
      self._arrow.sprite = self._levelUpArrow
    else
      self._to:CrossFadeColor(self._levelDownColor, 0, true, false)
      self._arrow.sprite = self._levelDownArrow
    end
  elseif first then
    self._single:SetActive(true)
    self._title1:RefreshText(title)
    self._singleText:SetText(first)
    if isLevelUp then
      self._singleText:CrossFadeColor(self._levelUpColor, 0, true, false)
    else
      self._singleText:CrossFadeColor(self._levelDownColor, 0, true, false)
    end
  else
    self._titleOnly:SetActive(true)
    self._title:RefreshText(title)
  end
end

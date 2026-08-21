_class("UIAircraftDecorateTabChildItem", UICustomWidget)
UIAircraftDecorateTabChildItem = UIAircraftDecorateTabChildItem

function UIAircraftDecorateTabChildItem:OnShow(uiParams)
  self._atlas = self:GetAsset("UIAircraftDecorate.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.UIAircraftDecorateSmallTabClick, self._OnUIAircraftDecorateSmallTabClick)
end

function UIAircraftDecorateTabChildItem:SetData(index, tabIndex, name, sprite, callback)
  self:_GetComponents()
  self._index = index
  self._tabIndex = tabIndex
  self._name = name
  self._sprite = sprite
  self._callback = callback
  self:_OnValue()
end

function UIAircraftDecorateTabChildItem:_GetComponents()
  self._text = self:GetUIComponent("UILocalizationText", "Text")
  self._icon = self:GetUIComponent("Image", "Image")
  self._select = self:GetGameObject("Select")
end

function UIAircraftDecorateTabChildItem:_OnValue()
  self._text:SetText(StringTable.Get(self._name))
  self._icon.sprite = self._sprite
end

function UIAircraftDecorateTabChildItem:BGOnClick()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundSwitch)
  if self._callback then
    self._callback(self._tabIndex)
  end
end

function UIAircraftDecorateTabChildItem:_OnUIAircraftDecorateSmallTabClick(tabIndex)
  self._select:SetActive(tabIndex == self._tabIndex)
end

function UIAircraftDecorateTabChildItem:OnHide()
end

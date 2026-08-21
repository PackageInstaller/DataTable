_class("UIActivityN29DetectivePieceItem", UICustomWidget)
UIActivityN29DetectivePieceItem = UIActivityN29DetectivePieceItem

function UIActivityN29DetectivePieceItem:OnShow(uiParams)
  self._delay = 0.05
  self:_GetComponent()
end

function UIActivityN29DetectivePieceItem:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._info = self:GetUIComponent("UILocalizationText", "info")
end

function UIActivityN29DetectivePieceItem:SetData(data, index)
  self._data = data
  self._icon:LoadImage(self._data.Icon)
  self._name:SetText(StringTable.Get(self._data.Name))
  self._info:SetText(StringTable.Get(self._data.Info))
  self:_SetAnimation(self._delay * (index - 1))
end

function UIActivityN29DetectivePieceItem:_SetAnimation(delay)
  UIWidgetHelper.PlayAnimationInSequence(self, "anim", "anim", "uieff_UIN29DetectivePieceItem_in", delay, 300, nil)
end

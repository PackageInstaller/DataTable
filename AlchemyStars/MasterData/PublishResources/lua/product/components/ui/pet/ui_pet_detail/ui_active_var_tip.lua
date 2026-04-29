_class("UIActiveVarTip", UICustomWidget)
UIActiveVarTip = UIActiveVarTip

function UIActiveVarTip:OnShow()
end

function UIActiveVarTip:OnHide()
end

function UIActiveVarTip:BgOnClick()
  if not self._pos then
    self._pos = self:GetUIComponent("RectTransform", "Bg")
  end
  self:ShowDialog("UIActiveVarInfo", self._pos.position)
end

_class("UIMapSubItem", UICustomWidget)
UIMapSubItem = UIMapSubItem

function UIMapSubItem:OnShow()
  self._imgMapSub = self:GetUIComponent("RawImageLoader", "imgMapSub")
end

function UIMapSubItem:OnHide()
  if self._imgMapSub then
    self._imgMapSub:DestoryLastImage()
    self._imgMapSub = nil
  end
end

function UIMapSubItem:Flush(idx, map)
  self._imgMapSub:LoadImage(map)
end

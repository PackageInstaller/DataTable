_class("UIActivityN16ActionPointDetail", UIController)
UIActivityN16ActionPointDetail = UIActivityN16ActionPointDetail

function UIActivityN16ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN16ActionPointDetail:OnShow(uiParams)
end

function UIActivityN16ActionPointDetail:OnHide()
end

function UIActivityN16ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

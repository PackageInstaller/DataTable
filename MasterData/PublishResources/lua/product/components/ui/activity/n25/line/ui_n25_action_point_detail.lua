_class("UIActivityN25ActionPointDetail", UIController)
UIActivityN25ActionPointDetail = UIActivityN25ActionPointDetail

function UIActivityN25ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN25ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIActivityN25ActionPointDetail:OnHide()
end

function UIActivityN25ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

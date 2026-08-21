_class("UIActivityN20ActionPointDetail", UIController)
UIActivityN20ActionPointDetail = UIActivityN20ActionPointDetail

function UIActivityN20ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN20ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIActivityN20ActionPointDetail:OnHide()
end

function UIActivityN20ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

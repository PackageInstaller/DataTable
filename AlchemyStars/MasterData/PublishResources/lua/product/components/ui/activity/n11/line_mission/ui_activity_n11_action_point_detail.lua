_class("UIActivityN11ActionPointDetail", UIController)
UIActivityN11ActionPointDetail = UIActivityN11ActionPointDetail

function UIActivityN11ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN11ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIActivityN11ActionPointDetail:OnHide()
end

function UIActivityN11ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

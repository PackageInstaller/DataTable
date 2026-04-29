_class("UIActivityN9ActionPointDetail", UIController)
UIActivityN9ActionPointDetail = UIActivityN9ActionPointDetail

function UIActivityN9ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN9ActionPointDetail:OnShow(uiParams)
end

function UIActivityN9ActionPointDetail:OnHide()
end

function UIActivityN9ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

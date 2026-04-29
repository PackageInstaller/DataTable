_class("UIActivityN23ActionPointDetail", UIController)
UIActivityN23ActionPointDetail = UIActivityN23ActionPointDetail

function UIActivityN23ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN23ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIActivityN23ActionPointDetail:OnHide()
end

function UIActivityN23ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

_class("UIN18ActionPointDetail", UIController)
UIN18ActionPointDetail = UIN18ActionPointDetail

function UIN18ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIN18ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIN18ActionPointDetail:OnHide()
end

function UIN18ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

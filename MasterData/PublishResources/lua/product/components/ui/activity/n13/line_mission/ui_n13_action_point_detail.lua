_class("UIN13ActionPointDetail", UIController)
UIN13ActionPointDetail = UIN13ActionPointDetail

function UIN13ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIN13ActionPointDetail:OnShow(uiParams)
end

function UIN13ActionPointDetail:OnHide()
end

function UIN13ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

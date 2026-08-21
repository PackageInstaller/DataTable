_class("UIActivityN22ActionPointDetail", UIController)
UIActivityN22ActionPointDetail = UIActivityN22ActionPointDetail

function UIActivityN22ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN22ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIActivityN22ActionPointDetail:OnHide()
end

function UIActivityN22ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

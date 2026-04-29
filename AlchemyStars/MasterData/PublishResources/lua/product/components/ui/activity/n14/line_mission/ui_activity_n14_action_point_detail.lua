_class("UIActivityN14ActionPointDetail", UIController)
UIActivityN14ActionPointDetail = UIActivityN14ActionPointDetail

function UIActivityN14ActionPointDetail:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN14ActionPointDetail:OnShow(uiParams)
  self:_SetIcon("_icon", uiParams[1])
end

function UIActivityN14ActionPointDetail:OnHide()
end

function UIActivityN14ActionPointDetail:CloseBtnOnClick(go)
  self:CloseDialog()
end

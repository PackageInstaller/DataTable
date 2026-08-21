_class("UIHomePhotoInfoGetPathItem", UICustomWidget)
UIHomePhotoInfoGetPathItem = UIHomePhotoInfoGetPathItem

function UIHomePhotoInfoGetPathItem:OnShow(uiParams)
  self.pathTxt = self:GetUIComponent("RollingText", "pathTxt")
  self.color = self:GetUIComponent("Image", "Image")
end

function UIHomePhotoInfoGetPathItem:SetData(txt, color)
  self.pathTxt:RefreshText(txt)
  self.color.color = color
end

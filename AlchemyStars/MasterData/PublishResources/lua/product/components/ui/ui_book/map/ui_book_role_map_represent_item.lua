_class("UIBookRoleMapRepresentItem", UICustomWidget)
UIBookRoleMapRepresentItem = UIBookRoleMapRepresentItem

function UIBookRoleMapRepresentItem:Constructor()
end

function UIBookRoleMapRepresentItem:OnShow()
  self:_GetComponents()
end

function UIBookRoleMapRepresentItem:_GetComponents()
  self._icon = self:GetUIComponent("RawImageLoader", "Icon")
end

function UIBookRoleMapRepresentItem:SetData(petID, pic, callback)
  self._petID = petID
  self._pic = pic
  self._callback = callback
  self:_InitComponents()
end

function UIBookRoleMapRepresentItem:_InitComponents()
  self._icon:LoadImage(self._pic)
end

function UIBookRoleMapRepresentItem:IconOnClick()
  if self._callback then
    self._callback(self._petID)
  end
end

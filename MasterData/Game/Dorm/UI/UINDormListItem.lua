local UINDormListItem = class("UINDormListItem", UIBaseNode)

function UINDormListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.roomItem, self, self.OnListItemClicked)
end

function UINDormListItem:InitDormListItem(id, name, unlock, isSelf, action)
  self.unlock = unlock or false
  isSelf = isSelf or false
  self.id = id
  self.ui.img_UnLock:SetActive(self.unlock)
  self.ui.img_Lock:SetActive(not self.unlock)
  if self.unlock then
    self.ui.tex_RoomName.text.color = Color.white
    self.ui.tex_RoomName:SetIndex(0, name)
  else
    self.ui.tex_RoomName.text.color = self.ui.color_roomLock
    self.ui.tex_RoomName:SetIndex(1)
  end
  self.ui.img_Glow:SetActive(isSelf)
  self.clickAction = action
end

function UINDormListItem:OnListItemClicked()
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function UINDormListItem:OnDelete()
end

return UINDormListItem

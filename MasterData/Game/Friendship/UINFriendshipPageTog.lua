local UINFriendshipPageTog = class("UINFriendshipPageTog", UIBaseNode)
local base = UIBaseNode
local FriendshipEnum = require("Game.Friendship.FriendshipEnum")

function UINFriendshipPageTog:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddValueChangedListener(self.ui.toggle, self, self.OnPageChange)
end

function UINFriendshipPageTog:InitAchivTypeToggle(index, isOn, onChangedEvent)
  self.index = index
  self.onChangedEvent = onChangedEvent
  self.ui.toggle.isOn = isOn
  self.ui.img_Icon:SetIndex(index)
  self.ui.img_SelIcon:SetIndex(index)
  if index == FriendshipEnum.togTypes.PersonalInfo then
    self.ui.obj_img_Line:SetActive(false)
  end
end

function UINFriendshipPageTog:OnPageChange(bool)
  if self.onChangedEvent ~= nil and bool then
    self.onChangedEvent(self.index)
  end
  if bool then
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.img_SelIcon.gameObject:SetActive(true)
  else
    self.ui.img_Icon.gameObject:SetActive(true)
    self.ui.img_SelIcon.gameObject:SetActive(false)
  end
end

function UINFriendshipPageTog:OnDelete()
  base.OnDelete(self)
end

return UINFriendshipPageTog

local UINWhiteDayAlbumPageItem = class("UINWhiteDayAlbumPageItem", UIBaseNode)
local base = UIBaseNode

function UINWhiteDayAlbumPageItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWhiteDayAlbumPageItem:SetIsSelected(bool)
  if bool then
    self.ui.img_Page:SetIndex(1)
  else
    self.ui.img_Page:SetIndex(0)
  end
end

function UINWhiteDayAlbumPageItem:OnDelete()
  base.OnDelete(self)
end

return UINWhiteDayAlbumPageItem

local UINBuffItem = class("UINBuffItem", UIBaseNode)
local base = UIBaseNode

function UINBuffItem:ctor()
end

function UINBuffItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBuffItem:InitBuffItem(buffData)
  self.ui.img_icon.sprite = buffData:GetEpBuffIcon()
end

function UINBuffItem:OnDelete()
  base.OnDelete(self)
end

return UINBuffItem

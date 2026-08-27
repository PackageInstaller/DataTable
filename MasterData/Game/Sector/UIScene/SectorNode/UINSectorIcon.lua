local base = UIBaseNode
local UINSectorIcon = class("UINSectorIcon", base)

function UINSectorIcon:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINSectorIcon:InitSectorIcon(iconName, resloader)
  self.ui.img_icon.enabled = false
  resloader:LoadABAssetAsync(PathConsts:GetSeceneIconPicPath(iconName), function(texture)
    if IsNull(self.transform) then
      return
    end
    self.ui.img_icon.texture = texture
    self.ui.img_icon.enabled = true
  end)
end

function UINSectorIcon:OnDelete()
  base.OnDelete(self)
end

return UINSectorIcon

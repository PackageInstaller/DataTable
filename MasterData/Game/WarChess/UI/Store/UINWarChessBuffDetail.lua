local UINWarChessBuffDetail = class("UINWarChessBuffDetail", UIBaseNode)
local base = UIBaseNode

function UINWarChessBuffDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessBuffDetail:InitEpBuffDetail(dynEpBuffData)
  local buffIcon = dynEpBuffData:GetWCBuffIcon()
  if not string.IsNullOrEmpty(buffIcon) then
    self.ui.img_Icon.sprite = CRH:GetSprite(buffIcon, CommonAtlasType.ExplorationIcon)
  end
  self.ui.tex_Name.text = dynEpBuffData:GetWCBuffName()
  self.ui.tex_Desc.text = dynEpBuffData:GetWCBuffDes()
end

function UINWarChessBuffDetail:OnDelete()
  base.OnDelete(self)
end

return UINWarChessBuffDetail

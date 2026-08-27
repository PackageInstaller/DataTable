local UINEpBuffDetail = class("UINEpBuffDetail", UIBaseNode)
local base = UIBaseNode

function UINEpBuffDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEpBuffDetail:InitEpBuffDetail(dynEpBuffData)
  self.ui.img_Icon.sprite = dynEpBuffData:GetEpBuffIcon()
  self.ui.tex_Name.text = dynEpBuffData:GetEpBuffName()
  self.ui.tex_Desc.text = dynEpBuffData:GetEpBuffDescribe()
end

function UINEpBuffDetail:OnDelete()
  base.OnDelete(self)
end

return UINEpBuffDetail

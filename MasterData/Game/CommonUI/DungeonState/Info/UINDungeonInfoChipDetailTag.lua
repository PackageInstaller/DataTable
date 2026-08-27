local UINDungeonInfoChipDetailTag = class("UINDungeonInfoChipDetailTag", UIBaseNode)
local base = UIBaseNode

function UINDungeonInfoChipDetailTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINDungeonInfoChipDetailTag:InitTagItem(tagConfig, color)
  self.ui.tex_Tag.text = LanguageUtil.GetLocaleText(tagConfig.tag_name)
  self.ui.img_tagItem.color = color
end

function UINDungeonInfoChipDetailTag:OnDelete()
  base.OnDelete(self)
end

return UINDungeonInfoChipDetailTag

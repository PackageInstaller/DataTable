local base = UIBaseNode
local UINRfCdTagItem = class("UINRfCdTagItem", base)

function UINRfCdTagItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINRfCdTagItem:InitRfCdTagItem(tagId)
  local cfg = ConfigData.reinforce_card_label[tagId]
  self.ui.tex_TagName.text = LanguageUtil.GetLocaleText(cfg.name)
end

function UINRfCdTagItem:OnDelete()
  base.OnDelete(self)
end

return UINRfCdTagItem

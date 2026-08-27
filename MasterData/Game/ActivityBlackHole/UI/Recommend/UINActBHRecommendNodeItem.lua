local UINActBHRecommendNodeItem = class("UINActBHRecommendNodeItem", UIBaseNode)
local base = UIBaseNode

function UINActBHRecommendNodeItem:OnInit()
  base.OnInit(self)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActBHRecommendNodeItem:InitBHRecommendNodeItem(cfg)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.tag_des)
end

function UINActBHRecommendNodeItem:OnDelete()
  base.OnDelete(self)
end

return UINActBHRecommendNodeItem

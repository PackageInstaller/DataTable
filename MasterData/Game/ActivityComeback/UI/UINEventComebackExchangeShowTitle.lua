local UINEventComebackExchangeShowTitle = class("UINEventComebackExchangeShowTitle", UIBaseNode)
local base = UINEventComebackExchangeShowTitle

function UINEventComebackExchangeShowTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEventComebackExchangeShowTitle:InitExchangeShowTitle(texIndex)
  self.ui.tex_GroupTitle:SetIndex(texIndex)
  self.ui.title.color = self.ui.color_tileBg[texIndex + 1]
  self.ui.tex_Tips.gameObject:SetActive(false)
end

function UINEventComebackExchangeShowTitle:SetNextPoolTip(poolName)
  self.ui.tex_Tips.gameObject:SetActive(true)
  self.ui.tex_Tips:SetIndex(0, poolName)
end

return UINEventComebackExchangeShowTitle

local UINWarChessMainTop_PressPanelEffectItem = {}
local base = UIBaseNode
local UINWarChessMainTop_PressPanelEffectItem = class("UINWarChessMainTop_PressPanelEffectItem", UIBaseNode)

function UINWarChessMainTop_PressPanelEffectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINWarChessMainTop_PressPanelEffectItem:RefreshWCPressEffectItem(stressCfg)
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(stressCfg.describe)
end

function UINWarChessMainTop_PressPanelEffectItem:OnDelete()
  base.OnDelete(self)
end

return UINWarChessMainTop_PressPanelEffectItem

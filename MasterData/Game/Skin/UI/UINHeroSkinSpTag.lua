local UINHeroSkinSpTag = class("UINHeroSkinSpTag", UIBaseNode)
local base = UIBaseNode

function UINHeroSkinSpTag:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroSkinSpTag:InitSkinSpTag(tagId)
  self.ui.text.text = LanguageUtil.GetLocaleText(ConfigData:GetTipTag(TipTag.skinTag, tagId))
end

return UINHeroSkinSpTag

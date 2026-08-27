local UINFmtCampFetterSkillItem = class("UINFmtCampFetterSkillItem", UIBaseNode)
local base = UIBaseNode

function UINFmtCampFetterSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINFmtCampFetterSkillItem:InitFetterSkillItem(campFetterCfg, isfirst, resloader)
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, campFetterCfg.icon, resloader)
  self.ui.img_Line:SetActive(not isfirst)
end

function UINFmtCampFetterSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINFmtCampFetterSkillItem

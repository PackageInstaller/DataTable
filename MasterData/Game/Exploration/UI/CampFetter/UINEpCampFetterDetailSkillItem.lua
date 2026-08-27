local UINEpCampFetterDetailSkillItem = class("UINEpCampFetterDetailSkillItem", UIBaseNode)
local base = UIBaseNode

function UINEpCampFetterDetailSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEpCampFetterDetailSkillItem:InitDetailSkillItem(cfg, resloader)
  self.ui.img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, cfg.icon, resloader)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.name)
  self.ui.tex_Detail.text = LanguageUtil.GetLocaleText(cfg.text)
  if cfg.is_show_active ~= 0 then
    self.ui.tex_Attri:SetIndex(1)
    self.ui.img_attri.color = self.ui.color_orange
  else
    self.ui.tex_Attri:SetIndex(0)
    self.ui.img_attri.color = Color.black
  end
end

function UINEpCampFetterDetailSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINEpCampFetterDetailSkillItem

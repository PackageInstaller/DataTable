local UINEpCampFetterSkillItem = class("UINEpCampFetterSkillItem", UIBaseNode)
local base = UIBaseNode

function UINEpCampFetterSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEpCampFetterSkillItem:InitEpCampFetterSkillItem(camp_ConnectCfg, isFirst, resLoader)
  self.ui.image_Deliver:SetActive(not isFirst)
  self.ui.img_EffIcon.sprite = AtlasUtil.GetSpriteFromAtlas(UIAtlasConsts.Atlas_CampFetterIcon, camp_ConnectCfg.icon, resLoader)
  if camp_ConnectCfg.is_show_active ~= 0 then
    self.ui.img_EffIcon.color = self.ui.color_activeSkill
  else
    self.ui.img_EffIcon.color = Color.white
  end
end

function UINEpCampFetterSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINEpCampFetterSkillItem

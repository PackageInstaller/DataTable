local UINHeroEnterOverViewSkillitem = class("UINHeroEnterOverViewSkillitem", UIBaseNode)
local base = UIBaseNode

function UINHeroEnterOverViewSkillitem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINHeroEnterOverViewSkillitem:InitLifeSkill(skillCfg, resloader)
  self.ui.img_SkillPic.texture = resloader:LoadABAsset(PathConsts:GetSkillIconPath(skillCfg:GetIcon()))
  self.ui.tex_SkillLevel.text = tostring(skillCfg.level)
end

function UINHeroEnterOverViewSkillitem:OnDelete()
  base.OnDelete(self)
end

return UINHeroEnterOverViewSkillitem

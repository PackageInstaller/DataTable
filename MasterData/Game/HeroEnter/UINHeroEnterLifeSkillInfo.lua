local UINHeroEnterLifeSkillInfo = class("UINHeroEnterLifeSkillInfo", UIBaseNode)
local base = UIBaseNode

function UINHeroEnterLifeSkillInfo:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:SetNewOneActive(false)
end

function UINHeroEnterLifeSkillInfo:SetNewOneActive(bool)
  self.ui.image:SetActive(bool)
  self.ui.tex_NewNum.gameObject:SetActive(bool)
  self.ui.new_SkillItem.gameObject:SetActive(bool)
end

function UINHeroEnterLifeSkillInfo:InitLifeSkill(skillCfg, newSkillCfg, resloader)
  self:SetNewOneActive(true)
  if newSkillCfg == nil then
    self.ui.new_SkillItem.gameObject:SetActive(false)
    self.ui.tex_NewNum.text = ConfigData:GetTipContent(TipContent.HeroEnter_notHaveLifeSkill)
  else
    self.ui.new_SkillItem.gameObject:SetActive(true)
    self.ui.tex_NewNum.text = LanguageUtil.GetLocaleText(newSkillCfg.lifeSkillCfg[newSkillCfg.level].name)
    self.ui.img_new.texture = resloader:LoadABAsset(PathConsts:GetSkillIconPath(newSkillCfg:GetIcon()))
    self.ui.tex_newSkillLevel.text = tostring(newSkillCfg.level)
  end
  if skillCfg == nil then
    self.ui.old_SkillItem.gameObject:SetActive(false)
    self.ui.tex_OldNum.text = ConfigData:GetTipContent(TipContent.HeroEnter_notHaveLifeSkill)
  else
    self.ui.old_SkillItem.gameObject:SetActive(true)
    self.ui.tex_OldNum.text = LanguageUtil.GetLocaleText(skillCfg.lifeSkillCfg[skillCfg.level].name)
    self.ui.img_old.texture = resloader:LoadABAsset(PathConsts:GetSkillIconPath(skillCfg:GetIcon()))
    self.ui.tex_oldSkillLevel.text = tostring(skillCfg.level)
  end
end

function UINHeroEnterLifeSkillInfo:OnDelete()
  base.OnDelete(self)
end

return UINHeroEnterLifeSkillInfo

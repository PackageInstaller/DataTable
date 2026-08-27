local UINFairySkillDownItem = class("UINFairySkillDownItem", UIBaseNode)
local base = UIBaseNode
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")

function UINFairySkillDownItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillIcon = UINFairySkillItem.New()
  self.skillIcon:Init(self.ui.uINFairySkillItem)
end

function UINFairySkillDownItem:InitFairySkillDownItem(fairySkillData, resloader)
  self.fairySkillData = fairySkillData
  self.resloader = resloader
  self:RefreshUIInfo()
end

function UINFairySkillDownItem:RefreshUIInfo()
  self.skillIcon:InitFairySkillItem(self.fairySkillData, self.resloader)
  self.ui.tex_SkillName.text = self.fairySkillData:GetFairySkillName()
  self.ui.tex_Des.text = LanguageUtil.GetLocaleText(self.fairySkillData:GetFairySkillSimpleDesc())
  self.type = self.fairySkillData:GetFairySkillType()
  if self.type == nil or self.type == HeroSkillUpgradeEnum.SkillType.undefined then
    self.ui.img_type.color = self.ui.color_typeArry[4]
    self.ui.tex_Type:SetIndex(4)
  else
    self.ui.img_type.color = self.ui.color_typeArry[self.type]
    local index = self.type - 1
    self.ui.tex_Type:SetIndex(index)
  end
end

function UINFairySkillDownItem:OnDelete()
end

return UINFairySkillDownItem

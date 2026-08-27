local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINFairySkillUpgradeItem = class("UINFairySkillUpgradeItem", base)
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")

function UINFairySkillUpgradeItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillIcon = UINFairySkillItem.New()
  self.skillIcon:Init(self.ui.uINElfSkillItem)
end

function UINFairySkillUpgradeItem:InitFairySkillUpgradeItem(fairySkillData, resloader)
  self.fairySkillData = fairySkillData
  self.resloader = resloader
  self.ui.obj_base:SetActive(true)
  self.ui.obj_notGet:SetActive(false)
  self:RefreshUIInfo()
end

function UINFairySkillUpgradeItem:InitFairySkillUpgradeItemEmpty(index)
  self.ui.obj_base:SetActive(false)
  self.ui.obj_notGet:SetActive(true)
  self.ui.tex_noGetTip:SetIndex(index)
end

function UINFairySkillUpgradeItem:RefreshUIInfo()
  self.skillIcon:InitFairySkillItem(self.fairySkillData, self.resloader)
  self.ui.tex_Name.text = self.fairySkillData:GetFairySkillName()
  self.ui.tex_Descr.text = LanguageUtil.GetLocaleText(self.fairySkillData:GetFairySkillDesc())
  local skillCD = self.fairySkillData:GetFairySkillCD()
  if skillCD == 0 then
    self.ui.obj_skillCD:SetActive(false)
  else
    self.ui.obj_skillCD:SetActive(true)
    self.ui.tex_skillCD:SetIndex(0, GetPreciseDecimalStr(skillCD, 1))
  end
  self.type = self.fairySkillData:GetFairySkillType()
  if self.type == nil or self.type == HeroSkillUpgradeEnum.SkillType.undefined then
    self.ui.img_type.color = self.ui.color_typeArry[4]
    self.ui.tex_Type:SetIndex(4)
    self.ui.tex_Tppe_En:SetIndex(4)
  else
    self.ui.img_type.color = self.ui.color_typeArry[self.type]
    local index = self.type - 1
    self.ui.tex_Type:SetIndex(index)
    self.ui.tex_Tppe_En:SetIndex(index)
  end
  self.ui.obj_New:SetActive(false)
end

function UINFairySkillUpgradeItem:SetObjSelected(bool)
  self.ui.obj_Selected:SetActive(bool)
end

function UINFairySkillUpgradeItem:SetNewOpen()
  self.ui.obj_New:SetActive(true)
end

function UINFairySkillUpgradeItem:OnDelete()
  base.OnDelete(self)
end

return UINFairySkillUpgradeItem

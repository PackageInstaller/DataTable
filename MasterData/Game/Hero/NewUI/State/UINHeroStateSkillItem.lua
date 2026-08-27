local UINHeroStateSkillItem = class("UINHeroStateSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")

function UINHeroStateSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.obj_skillItem)
end

function UINHeroStateSkillItem:InitSkillItem(skillData, resloader)
  self.skillItem:InitBaseSkillItem(skillData, resloader)
  if skillData:GetIsUnlock() then
    self.ui.tex_SkillName:SetIndex(1, skillData:GetName())
    if skillData:IsFullLevel() then
      self.ui.tex_SkillLevel:SetIndex(1)
    else
      self.ui.tex_SkillLevel:SetIndex(0, tostring(skillData.level))
    end
  else
    self.ui.tex_SkillName:SetIndex(0)
    self.ui.tex_SkillLevel:SetIndex(0, "0")
  end
end

function UINHeroStateSkillItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroStateSkillItem

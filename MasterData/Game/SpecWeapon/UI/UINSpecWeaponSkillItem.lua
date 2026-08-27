local UINSpecWeaponSkillItem = class("UINSpecWeaponSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")

function UINSpecWeaponSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_info, self, self.OnClickItem)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.uINSkillItem)
end

function UINSpecWeaponSkillItem:InitSpecWeaponSkilDes(skillData, des, resloader, callback)
  self.skillItem:InitBaseSkillItem(skillData, resloader)
  self.ui.tex_SkillName.text = skillData:GetName()
  self.ui.tex_Desc.text = des
  self._callback = callback
end

function UINSpecWeaponSkillItem:OnClickItem()
  if self._callback ~= nil then
    self._callback()
  end
end

return UINSpecWeaponSkillItem

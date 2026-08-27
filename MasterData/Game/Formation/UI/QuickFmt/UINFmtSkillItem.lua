local UINFmtSkillItem = class("UINFmtSkillItem", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UINFmtSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.btn_Icon.onPressDown:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btn_Icon.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
  self.baseSkillItem = UINBaseSkillItem.New()
  self.baseSkillItem:Init(self.ui.uINSkillItem)
  self.oriColor = self.ui.img_skillLevel.color
end

function UINFmtSkillItem:InitFmtSkillItem(skillData, resloader, clickEvent, longPressFunc, pressUpFunc, overriodColor)
  self.skillData = skillData
  self.clickEvent = clickEvent
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.baseSkillItem:InitBaseSkillItem(skillData, resloader)
  if skillData:IsFullLevel() then
    self.ui.tex_SkillLevel:SetIndex(1)
  else
    self.ui.tex_SkillLevel:SetIndex(0, tostring(skillData.level))
  end
  if overriodColor ~= nil then
    self.ui.img_skillLevel.color = overriodColor
  else
    self.ui.img_skillLevel.color = self.oriColor
  end
  self.unlock = skillData:GetIsUnlock()
  if self.unlock then
    self.ui.tex_SkillName:SetIndex(1, skillData:GetName())
  else
    self.ui.tex_SkillName:SetIndex(0)
  end
end

function UINFmtSkillItem:FmtShowSkillAdapter(adapterType)
  self.ui.img_SpecIcon.gameObject:SetActive(self.unlock and 0 < adapterType)
  self.baseSkillItem:SetBanSkillActive(self.unlock and adapterType == ExplorationEnum.eSkillAdapterType.Ban)
end

function UINFmtSkillItem:__OnSkillLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self, self.skillData)
  end
end

function UINFmtSkillItem:__OnSkillPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
end

return UINFmtSkillItem

local UINDungeonInfoHeroDetailSkill = class("UINDungeonInfoHeroDetailSkill", UIBaseNode)
local base = UIBaseNode
local UINBaseSkillItem = require("Game.CommonUI.Item.UINBaseSkillItem")

function UINDungeonInfoHeroDetailSkill:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItem = UINBaseSkillItem.New()
  self.skillItem:Init(self.ui.obj_skillItem)
  self.ui.btn_press.onPressDown:AddListener(BindCallback(self, self.__OnSkillLongPress))
  self.ui.btn_press.onPressUp:AddListener(BindCallback(self, self.__OnSkillPressUp))
end

function UINDungeonInfoHeroDetailSkill:InitDungeonSkillItem(dynBattleSkill, resloader, longPressFunc, pressUpFunc)
  self.skillItem:InitBaseSkillItem(dynBattleSkill, resloader)
  self.skillData = dynBattleSkill
  self.longPressFunc = longPressFunc
  self.pressUpFunc = pressUpFunc
  self.__isUnlock = dynBattleSkill:GetIsUnlock()
  if self.__isUnlock then
    self.ui.tex_SkillName:SetIndex(0, dynBattleSkill:GetName())
    if dynBattleSkill:GetIsFullLevel() then
      self.ui.tex_SkillLevel:SetIndex(1)
    else
      self.ui.tex_SkillLevel:SetIndex(0, tostring(dynBattleSkill.level))
    end
  else
    self.ui.tex_SkillName:SetIndex(1)
    self.ui.tex_SkillLevel:SetIndex(0, "0")
  end
  if self.ui.img_TDIcon ~= nil then
    self.ui.img_TDIcon.gameObject:SetActive(false)
  end
  self.skillItem:SetBanSkillActive(self.__isUnlock and dynBattleSkill:IsSpecialBanSkill())
end

function UINDungeonInfoHeroDetailSkill:ShowAsTdSkill()
  if not self.__isUnlock then
    return
  end
  self.ui.img_TDIcon.gameObject:SetActive(true)
end

function UINDungeonInfoHeroDetailSkill:__OnSkillLongPress()
  if self.longPressFunc ~= nil then
    self.longPressFunc(self, self.skillData)
  end
end

function UINDungeonInfoHeroDetailSkill:__OnSkillPressUp()
  if self.pressUpFunc ~= nil then
    self.pressUpFunc()
  end
end

function UINDungeonInfoHeroDetailSkill:SetSkillClickAction(action)
  self.skillClickFunc = action
end

function UINDungeonInfoHeroDetailSkill:__OnSkillClick()
  if self.skillClickFunc ~= nil then
    self.skillClickFunc(self.skillData)
  end
end

function UINDungeonInfoHeroDetailSkill:OnDelete()
  base.OnDelete(self)
end

return UINDungeonInfoHeroDetailSkill

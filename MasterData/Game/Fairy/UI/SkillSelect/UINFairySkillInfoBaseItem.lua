local base = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local UINFairySkillInfoBaseItem = class("UINFairySkillInfoBaseItem", base)
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")
local HeroSkillUpgradeEnum = require("Game.Hero.NewUI.UpgradeSkill.HeroSkillUpgradeEnum")

function UINFairySkillInfoBaseItem:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_skillUpgradeItem, self, self.OnClickBottom)
end

function UINFairySkillInfoBaseItem:InitFairySkillInfoBaseItem(fairySkillData, resloader, checkSelectCallback, selectCallback, normalSelected)
  base.InitFairySkillUpgradeItem(self, fairySkillData, resloader)
  self.checkSelectCallback = checkSelectCallback
  self.selectCallback = selectCallback
  self.isSelected = not normalSelected
  self:SetSelected()
end

function UINFairySkillInfoBaseItem:SetSelected()
  self.isSelected = not self.isSelected
  self:SetObjSelected(self.isSelected)
end

function UINFairySkillInfoBaseItem:OnClickBottom()
  if self.selectCallback then
    local canClick = true
    if self.checkSelectCallback then
      canClick = self.checkSelectCallback(self.fairySkillData, self.isSelected)
    end
    if canClick then
      self.selectCallback(self.fairySkillData, self.isSelected)
      self:SetSelected()
    end
  end
end

function UINFairySkillInfoBaseItem:OnDelete()
  base.OnDelete(self)
end

return UINFairySkillInfoBaseItem

local UINFairyNoticeSkillItem = class("UINFairyNoticeSkillItem", UIBaseNode)
local base = UIBaseNode
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")

function UINFairyNoticeSkillItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.fairySkillItem = UINFairySkillItem.New()
  self.fairySkillItem:Init(self.ui.uINElfSkillItem)
end

function UINFairyNoticeSkillItem:InitFairyNoticeSkillItem(fairySkillData, isNewSkill, resloader)
  self.fairySkillItem:InitFairyQualityItem(fairySkillData, resloader)
  self.ui.newSkill:SetActive(isNewSkill)
end

function UINFairyNoticeSkillItem:OnDelete()
  self.fairySkillItem:Delete()
end

return UINFairyNoticeSkillItem

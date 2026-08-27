local UINFairyNoticeSkillReset = class("UINFairyNoticeSkillReset", UIBaseNode)
local base = UIBaseNode
local UINFairySkillItem = require("Game.Fairy.UI.UINFairySkillItem")

function UINFairyNoticeSkillReset:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.skillItemPool = UIItemPool.New(UINFairySkillItem, self.ui.uINElfSkillItem, false)
end

function UINFairyNoticeSkillReset:InitSkillReset(fairyData, resloader)
  self.resloader = resloader
  local nowMaxSkillNum = fairyData:GetMaxSkillNum()
  for i = 1, nowMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillItem(fairyData:GetFairySkillBySlotIndex(i), self.resloader)
  end
end

function UINFairyNoticeSkillReset:OnDelete()
  self.skillItemPool:DeleteAll()
end

return UINFairyNoticeSkillReset

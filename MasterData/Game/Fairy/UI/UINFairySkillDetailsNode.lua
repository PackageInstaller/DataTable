local UINFairySkillDetailsNode = class("UINFairySkillDetailsNode", UIBaseNode)
local base = UIBaseNode
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")

function UINFairySkillDetailsNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, function()
    self:Hide()
    UIUtil.ReShowTopStatus()
  end)
  self.skillItemPool = UIItemPool.New(UINFairySkillUpgradeItem, self.ui.obj_fairySkill, false)
end

function UINFairySkillDetailsNode:InitUINFairySkillDetailsNode(fairyData, resloader)
  self.resloader = resloader
  self:Show()
  self.skillItemPool:HideAll()
  local nowMaxSkillNum = fairyData:GetMaxSkillNum()
  local ultMaxSkillNum = fairyData:GetMaxStateSkillNum()
  for i = 1, nowMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillUpgradeItem(fairyData:GetFairySkillBySlotIndex(i), self.resloader)
  end
  for i = nowMaxSkillNum + 1, ultMaxSkillNum do
    local skillItem = self.skillItemPool:GetOne(true)
    skillItem:InitFairySkillUpgradeItemEmpty(i - 2)
  end
end

function UINFairySkillDetailsNode:OnDelete()
  base.OnDelete(self)
end

return UINFairySkillDetailsNode

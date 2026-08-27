local UIFairySkillDetails = class("UIFairySkillDetails", UIBaseWindow)
local base = UIBaseWindow
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local UINFairySkillDetailsDown = require("Game.Fairy.UI.SkillDetails.UINFairySkillDetailsDown")
local cs_ResLoader = CS.ResLoader

function UIFairySkillDetails:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, function()
    UIManager:DeleteWindow(UIWindowTypeID.FairySkillDetails)
  end)
  self.skillItemPool = UIItemPool.New(UINFairySkillUpgradeItem, self.ui.obj_fairySkill, false)
  self.resloader = cs_ResLoader.Create()
  self.downNode = UINFairySkillDetailsDown.New()
  self.downNode:Init(self.ui.obj_down)
end

function UIFairySkillDetails:InitFairySkillDetailsNode(fairyData)
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
  self.downNode:InitFairySkillDetailsDown(fairyData, self.resloader)
end

function UIFairySkillDetails:OnDelete()
  base.OnDelete(self)
  self.downNode:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIFairySkillDetails

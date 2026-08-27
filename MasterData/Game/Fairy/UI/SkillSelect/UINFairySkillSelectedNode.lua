local UINFairySkillSelectedNode = class("UINFairySkillSelectedNode", UIBaseNode)
local base = UIBaseNode
local UINFairySkillSelectedItem = require("Game.Fairy.UI.SkillSelect.UINFairySkillSelectedItem")
local UINFairySkillUpgradeItem = require("Game.Fairy.UI.UINFairySkillUpgradeItem")
local UINFairyRightConsumeItem = require("Game.Fairy.UI.Right.UINFairyRightConsumeItem")

function UINFairySkillSelectedNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnSelectedNodeClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, function()
    UIUtil.OnClickBackByUiTab(self)
  end)
  self._checkSelectCallback = BindCallback(self, self.CheckCanClickItem)
  self._selectCallback = BindCallback(self, self.ClickSkillItem)
  self.skillItemPool = UIItemPool.New(UINFairySkillSelectedItem, self.ui.itemGroup, false)
  self.consumeCostItem1 = UINFairyRightConsumeItem.New()
  self.consumeCostItem1:Init(self.ui.obj_cost1)
  self.consumeCostItem2 = UINFairyRightConsumeItem.New()
  self.consumeCostItem2:Init(self.ui.obj_cost2)
end

function UINFairySkillSelectedNode:InitUINFairySkillSelectedNode(fairyDataList, resloader, skillUpgradeNode, confirmFunc, uiMain)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):SetTopStatusVisible(false):PushTopStatusDataToBackStack(true)
  self.resloader = resloader
  self.skillItemPool:HideAll()
  self.skillUpgradeNode = skillUpgradeNode
  for i, data in pairs(fairyDataList) do
    local item = self.skillItemPool:GetOne(true)
    item:InitFairySkillSelectedItem(data, self.resloader, self._checkSelectCallback, self._selectCallback, skillUpgradeNode)
  end
  local nowNum, maxNum = self.skillUpgradeNode:GetNowSelectNum()
  self.ui.tex_Num:SetIndex(0, tostring(nowNum), tostring(maxNum))
  self.confirmFunc = confirmFunc
  self.uiMain = uiMain
  self:RefreshSelectedNodeUI()
end

function UINFairySkillSelectedNode:RefreshSelectedNodeUI()
  self.ui.tex_Confirm.text = self.uiMain:GetUpgradeStateTex()
  local costItem1, costItem2 = self.uiMain:GetConsumeCostItem()
  self.consumeCostItem1:InitFairyRightConsumeItem(costItem1.itemId, costItem1.consumeNum, costItem1.clickFunc)
  if costItem2 then
    self.consumeCostItem2:Show()
    self.consumeCostItem2:InitFairyRightConsumeItem(costItem2.itemId, costItem2.consumeNum, costItem2.clickFunc)
  else
    self.consumeCostItem2:Hide()
  end
end

function UINFairySkillSelectedNode:ClickSkillItem(skillData, isSelected)
  self.skillUpgradeNode:ClickSkillItem(skillData, isSelected)
  local nowNum, maxNum = self.skillUpgradeNode:GetNowSelectNum()
  self.ui.tex_Num:SetIndex(0, tostring(nowNum), tostring(maxNum))
end

function UINFairySkillSelectedNode:CheckCanClickItem(skillData, isSelected)
  return self.skillUpgradeNode:CheckCanClickItem(skillData, isSelected)
end

function UINFairySkillSelectedNode:OnSelectedNodeClose()
  if self.confirmFunc and self.confirmFunc() then
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UINFairySkillSelectedNode:OnDelete()
  self.skillItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINFairySkillSelectedNode

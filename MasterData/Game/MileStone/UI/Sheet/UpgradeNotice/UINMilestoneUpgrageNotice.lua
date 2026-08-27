local base = UIBaseNode
local UINMilestoneUpgrageNotice = class("UINMilestoneUpgrageNotice", base)
local UINMilestoneUpExpNode = require("Game.MileStone.UI.Sheet.UpgradeNotice.UINMilestoneUpExpNode")
local UINMilestoneUpStageNode = require("Game.MileStone.UI.Sheet.UpgradeNotice.UINMilestoneUpStageNode")
local PlayMode = {exp = 1, stage = 2}

function UINMilestoneUpgrageNotice:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Background, self, self.__OnClickBg)
  self.expNode = UINMilestoneUpExpNode.New()
  self.expNode:Init(self.ui.go_stageEXPUp)
  self.stageNode = UINMilestoneUpStageNode.New()
  self.stageNode:Init(self.ui.go_stageLvlUp)
end

function UINMilestoneUpgrageNotice:InitMilestoneUpgrageNotice(resloader)
  self.resloader = resloader
end

function UINMilestoneUpgrageNotice:ShowMlstModuleExpChange(msData, msDimensionData, oldProcess)
  self.expNode:Show()
  self.stageNode:Hide()
  local msModuleId = msDimensionData:GetMlstDimensionId()
  local newProcess = msDimensionData:GetMlstDimensionScoreProgress()
  local stageId = msDimensionData:GetMlstDimensionStage()
  self.playMode = PlayMode.exp
  self.expNode:InitMilestoneUpExpNode(msData, msModuleId)
  self.expNode:PlayMilestoneUpgrage(stageId, oldProcess, newProcess)
  self.ui.go_particle:SetActive(false)
  UIUtil.HideTopStatus()
end

function UINMilestoneUpgrageNotice:ShowStageUp(msDimensionData)
  self.expNode:Hide()
  self.stageNode:Show()
  self.stageNode:InitMilestoneUpStageNode(msDimensionData, self.resloader)
  self.playMode = PlayMode.stage
  self.ui.go_particle:SetActive(false)
  UIUtil.HideTopStatus()
end

function UINMilestoneUpgrageNotice:__OnClickBg()
  self:Hide()
  self.ui.go_particle:SetActive(true)
  UIUtil.ReShowTopStatus()
end

function UINMilestoneUpgrageNotice:OnHide()
  self.expNode:Hide()
  self.stageNode:Hide()
end

function UINMilestoneUpgrageNotice:OnDelete()
  self.expNode:Delete()
  self.stageNode:Delete()
  base.OnDelete(self)
end

return UINMilestoneUpgrageNotice

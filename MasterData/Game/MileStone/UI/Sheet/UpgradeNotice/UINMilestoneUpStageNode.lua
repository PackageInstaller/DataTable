local base = UIBaseNode
local UINMilestoneUpStageNode = class("UINMilestoneUpStageNode", base)
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")

function UINMilestoneUpStageNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINMilestoneUpStageNode:InitMilestoneUpStageNode(msdData, resloader)
  local stage = msdData:GetMlstDimensionStage()
  self.ui.Tex_Stage.text = MilestoneUtil.GetSPSStageId2EngChar(stage)
  self.ui.Img_Icon.sprite = AtlasUtil.GetSpriteFromAtlas("Milestone", msdData:GetMlstDimensionIcon(), resloader)
  self.ui.Tex_TitleName.text = msdData:GetMlstDimensionName()
end

function UINMilestoneUpStageNode:OnDelete()
  base.OnDelete(self)
end

return UINMilestoneUpStageNode

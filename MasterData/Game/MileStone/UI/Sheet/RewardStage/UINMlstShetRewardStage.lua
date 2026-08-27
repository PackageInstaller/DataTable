local UINMlstShetRewardStage = {}
local base = UIBaseNode
local UINMlstShetRewardStage = class("UINMlstShetRewardStage", base)
local UINMlstShetRewardStageItem = require("Game.MileStone.UI.Sheet.RewardStage.UINMlstShetRewardStageItem")

function UINMlstShetRewardStage:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_bg, self, self._OnClickClose)
  self.stageItemPool = UIItemPool.New(UINMlstShetRewardStageItem, self.ui.item, false)
end

function UINMlstShetRewardStage:InitMlstShetRewardStage(bandData)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.Hide):PushTopStatusDataToBackStack()
  local stageMax = bandData:GetMlstBandStageMax()
  self.stageItemPool:HideAll()
  for i = 1, stageMax do
    local item = self.stageItemPool:GetOne()
    item:InitMlstShetRewardStageItem(i, bandData)
  end
end

function UINMlstShetRewardStage:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINMlstShetRewardStage:OnDelete()
  base.OnDelete(self)
end

return UINMlstShetRewardStage

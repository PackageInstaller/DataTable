local UINDrawLotteryTaskWindowItemGroupDoing = class("UINDrawLotteryTaskWindowItemGroupDoing", UIBaseNode)
local UINDrawLotteryTaskWindowItem = require("Game.EventDrawLottery.UI.Task.UINDrawLotteryTaskItem")
local base = UIBaseNode

function UINDrawLotteryTaskWindowItemGroupDoing:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.taskWindowItem = UINDrawLotteryTaskWindowItem.New()
  self.taskWindowItem:Init(self.ui.obj_taskItem)
  self.taskWindowItem2 = UINDrawLotteryTaskWindowItem.New()
  self.taskWindowItem2:Init(self.ui.obj_taskItem1)
end

function UINDrawLotteryTaskWindowItemGroupDoing:InitDrawLotteryTaskWindowItemGroupDoing(actData)
  self.actData = actData
  self.groupNum = self.actData:GetDrawLotteryGroupNum()
  self:RefreshTaskItemIsDoing()
end

function UINDrawLotteryTaskWindowItemGroupDoing:RefreshTaskItemIsDoing()
  for i = 1, self.groupNum do
    local realData = self.actData:GetDrawLotteryNowTaskStage(i)
    local stageId = self.actData:GetStageIdByTaskData(realData)
    if i == 1 then
      self.taskWindowItem:InitDrawLotteryTaskItem(self.actData, realData, stageId)
    else
      self.taskWindowItem2:InitDrawLotteryTaskItem(self.actData, realData, stageId)
    end
  end
end

function UINDrawLotteryTaskWindowItemGroupDoing:OnDelete()
end

return UINDrawLotteryTaskWindowItemGroupDoing

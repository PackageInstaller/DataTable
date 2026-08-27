local base = require("Game.EventDrawLottery.UI.Task.UINDrawLotteryTaskItem")
local UINDrawLotteryTaskWindowItem = class("UINDrawLotteryTaskWindowItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")

function UINDrawLotteryTaskWindowItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.OnClickReceive)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINDrawLotteryTaskWindowItem:RefreshBtnUI()
  local isPicked = self.taskInfo.state == proto_object_QuestState.QuestStateExpired or self.taskInfo.state == proto_object_QuestState.QuestStateCompleted
  self.ui.obj_Clear.gameObject:SetActive(isPicked)
  local isComplect = self.taskInfo:CheckComplete()
  self.ui.btn_Receive.gameObject:SetActive(isComplect and not isPicked)
end

function UINDrawLotteryTaskWindowItem:OnDelete()
  base.OnDelete(self)
end

return UINDrawLotteryTaskWindowItem

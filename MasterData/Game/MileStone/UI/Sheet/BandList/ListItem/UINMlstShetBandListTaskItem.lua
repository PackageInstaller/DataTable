local base = UIBaseNode
local UINMlstShetBandListTaskItem = class("UINMlstShetBandListTaskItem", base)
local MilestoneUtil = require("Game.MileStone.MilestoneUtil")

function UINMlstShetBandListTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self._OnClickCompleteTask)
end

function UINMlstShetBandListTaskItem:InitMlstShetBandListTaskItem(taskData, scoreItemId, pickRewardFunc)
  self._pickRewardFunc = pickRewardFunc
  self._taskData = taskData
  self.ui.canvas_taskItem.alpha = 1
  self.ui.obj_Receive:SetActive(false)
  self.ui.tex_Name.text = taskData:GetTaskName()
  local schedule, aim = taskData:GetTaskProcess()
  self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(aim))
  self.ui.tex_Des.text = taskData:GetTaskFirstStepIntro()
  local isPickedReward = taskData:IsPickedTaskReward()
  if isPickedReward then
    self.ui.obj_State:SetActive(true)
    self.ui.tex_State:SetIndex(0)
    self.ui.canvas_taskItem.alpha = 0.5
  elseif taskData:CheckComplete() then
    self.ui.obj_State:SetActive(false)
    self.ui.obj_Receive:SetActive(true)
  else
    self.ui.obj_State:SetActive(true)
    self.ui.tex_State:SetIndex(1)
  end
  local rewardIds, rewardNums = taskData:GetTaskCfgRewards()
  local score = MilestoneUtil.GetMlstTaskScore(taskData, scoreItemId)
  self.ui.tex_Point:SetIndex(0, tostring(score))
end

function UINMlstShetBandListTaskItem:_OnClickCompleteTask()
  if self._pickRewardFunc ~= nil then
    self._pickRewardFunc(self._taskData)
  end
end

function UINMlstShetBandListTaskItem:OnDelete()
  base.OnDelete(self)
end

return UINMlstShetBandListTaskItem

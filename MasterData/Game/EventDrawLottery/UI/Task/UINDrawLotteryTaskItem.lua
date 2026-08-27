local UINDrawLotteryTaskItem = class("UINDrawLotteryTaskItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")

function UINDrawLotteryTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Jump, self, self.OnClickBtnJump)
  UIUtil.AddButtonListener(self.ui.btn_Receive, self, self.OnClickReceive)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.uINBaseItemWithReceived, false)
end

function UINDrawLotteryTaskItem:InitDrawLotteryTaskItem(actData, taskInfo, taskIndex)
  self.actData = actData
  self.taskInfo = taskInfo
  self.taskIndex = taskIndex
  local isFinish = taskInfo.state == proto_object_QuestState.QuestStateCompleted
  self.rewardPool:HideAll()
  for i, v in ipairs(taskInfo.stcData.rewardIds) do
    local item = self.rewardPool:GetOne(true)
    local itemCfg = ConfigData.item[v]
    local num = taskInfo.stcData.rewardNums[i]
    item:InitItemWithCount(itemCfg, num, nil, isFinish)
  end
  self:UpdateUI()
end

function UINDrawLotteryTaskItem:UpdateUI()
  self:RefreshNormalUI()
  self:RefreshBtnUI()
end

function UINDrawLotteryTaskItem:RefreshNormalUI()
  self.ui.tex_Num.text = string.format("%02d", self.taskIndex)
  self.ui.tex_TaskIntro.text = LanguageUtil.GetLocaleText(self.taskInfo.stcData.task_intro)
  local schedule, aim = self.taskInfo:GetTaskProcess()
  local correctionNum = self.actData:GetCorrectionNum(self.taskInfo)
  schedule = schedule - correctionNum
  aim = aim - correctionNum
  self.ui.tex_Progress.text = tostring(schedule) .. "/" .. tostring(aim)
  local progress = schedule / aim
  progress = progress < 1 and progress or 1
  self.ui.bar.value = progress
end

function UINDrawLotteryTaskItem:RefreshBtnUI()
  local isPicked = self.taskInfo.state == proto_object_QuestState.QuestStateExpired or self.taskInfo.state == proto_object_QuestState.QuestStateCompleted
  self.ui.obj_Clear:SetActive(isPicked)
  if not IsNull(self.ui.obj_infoGroup) then
    self.ui.obj_infoGroup:SetActive(not isPicked)
  end
  local isComplect = self.taskInfo:CheckComplete()
  local isCanjump = self.taskInfo.stcData.jump_id ~= nil and self.taskInfo.stcData.jump_id > 0
  self.ui.btn_Jump.gameObject:SetActive(not isComplect and not isPicked and isCanjump)
  self.ui.btn_Receive.gameObject:SetActive(isComplect and not isPicked)
end

function UINDrawLotteryTaskItem:OnClickBtnJump()
  if self.taskInfo.stcData.jump_id ~= nil and self.taskInfo.stcData.jump_id > 0 then
    JumpManager:Jump(self.taskInfo.stcData.jump_id, nil, nil, self.taskInfo.stcData.jumpArgs)
  end
end

function UINDrawLotteryTaskItem:OnClickReceive()
  local ids, nums = self.taskInfo:GetTaskCfgRewards()
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(ids, nums)
  if self.actData then
    local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    actFrameNet:CS_Activity_Quest_Commit(self.actData:GetActFrameId(), self.taskInfo.id, function()
      if IsNull(self.transform) then
        return
      end
      local rewardDic = {}
      for i, id in ipairs(ids) do
        rewardDic[id] = nums[i]
      end
      UIUtil.ShowCommonReward(rewardDic, crTransDic)
    end)
  else
    local taskCtr = ControllerManager:GetController(ControllerTypeId.Task)
    taskCtr:SendCommitQuestReward(self.taskInfo)
  end
end

function UINDrawLotteryTaskItem:OnDelete()
end

return UINDrawLotteryTaskItem

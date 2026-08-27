local UINActivityStarUpTask = class("UINActivityStarUpTask", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")

function UINActivityStarUpTask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.OnClickGet)
  UIUtil.AddButtonListener(self.ui.btn_Goto, self, self.OnClickGoto)
  self.ui.rewardItem:SetActive(false)
  self.rewardPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
end

function UINActivityStarUpTask:InitItem(activityInfo, taskInfo)
  self.activityInfo = activityInfo
  self.taskInfo = taskInfo
  local isFinish = taskInfo.state == proto_object_QuestState.QuestStateCompleted
  self.rewardPool:HideAll()
  for i, v in ipairs(taskInfo.stcData.rewardIds) do
    local item = self.rewardPool:GetOne(true)
    local itemCfg = ConfigData.item[v]
    local num = taskInfo.stcData.rewardNums[i]
    item:InitItemWithCount(itemCfg, num, nil, isFinish)
  end
  self:__SetTaskTextFunc(self.ui.tex_TaskIntro, isFinish, taskInfo)
  self:UpdateUI()
end

function UINActivityStarUpTask:__SetTaskTextFunc(textItemInfo, isFinish, taskInfo)
  textItemInfo:SetIndex(isFinish and 0 or 1, LanguageUtil.GetLocaleText(taskInfo.stcData.name))
end

function UINActivityStarUpTask:UpdateUI()
  if self.taskInfo.state == proto_object_QuestState.QuestStateCompleted then
    self.ui.img_Buttom:SetIndex(2)
  elseif self.taskInfo:CheckComplete() then
    self.ui.img_Buttom:SetIndex(1)
  else
    self.ui.img_Buttom:SetIndex(0)
  end
  self.ui.obj_Unfinish:SetActive(false)
  self.ui.obj_Completed:SetActive(false)
  self.ui.btn_Get.gameObject:SetActive(false)
  self.ui.btn_Goto.gameObject:SetActive(false)
  local isPicked = self.taskInfo.state == proto_object_QuestState.QuestStateExpired or self.taskInfo.state == proto_object_QuestState.QuestStateCompleted
  local isComplect = self.taskInfo:CheckComplete()
  local isCanjump = self.taskInfo.stcData.jump_id ~= nil and 0 < self.taskInfo.stcData.jump_id
  self.ui.btn_Goto.gameObject:SetActive(not isComplect and not isPicked and isCanjump)
  self.ui.obj_Unfinish.gameObject:SetActive(not isComplect and not isPicked and not isCanjump)
  self.ui.btn_Get.gameObject:SetActive(isComplect and not isPicked)
  self.ui.obj_Completed:SetActive(isPicked)
  local schedule, aim = self.taskInfo:GetTaskProcess()
  self.ui.tex_Progress.text = tostring(schedule) .. "/" .. tostring(aim)
  local progress = schedule / aim
  progress = progress < 1 and progress or 1
  self.barWidth = self.ui.bar.rectTransform.rect.width
  local vec = self.ui.img_Fill.rectTransform.sizeDelta
  vec.x = self.barWidth * progress
  self.ui.img_Fill.rectTransform.sizeDelta = vec
  for i, v in ipairs(self.rewardPool.listItem) do
    v:SetPickedUIActive(isFinish)
  end
end

function UINActivityStarUpTask:OnClickGoto()
  if self.taskInfo.stcData.jump_id ~= nil and self.taskInfo.stcData.jump_id > 0 then
    JumpManager:Jump(self.taskInfo.stcData.jump_id, nil, nil, self.taskInfo.stcData.jumpArgs)
  end
end

function UINActivityStarUpTask:OnClickGet()
  local ids, nums = self.taskInfo:GetTaskCfgRewards()
  local crTransDic = PlayerDataCenter:CalCrItemTransDic(ids, nums)
  if self.activityInfo then
    local actFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    actFrameNet:CS_Activity_Quest_Commit(self.activityInfo:GetActivityFrameId(), self.taskInfo.id, function()
      self.activityInfo:UpdateStarUpRedddot()
      if IsNull(self.transform) or not self._showCommonReward then
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
    taskCtr:SendCommitQuestReward(self.taskInfo, self._showCommonReward)
  end
end

function UINActivityStarUpTask:SetActLimitTaskShowCommonReward()
  self._showCommonReward = true
end

function UINActivityStarUpTask:UpdActLimitTaskIsNew(isNew)
  self.ui.obj_New:SetActive(isNew)
end

function UINActivityStarUpTask:OnDelete()
  base.OnDelete(self)
end

return UINActivityStarUpTask

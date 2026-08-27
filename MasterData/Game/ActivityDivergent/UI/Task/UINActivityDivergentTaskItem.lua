local UINActivityDivergentTaskItem = class("UINActivityDivergentTaskItem", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")

function UINActivityDivergentTaskItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_GetNewTask, self, self.__OnClickGetNewDivergentTask)
  UIUtil.AddButtonListener(self.ui.btn_Refresh, self, self.__OnClickExchangeDivergentTask)
  UIUtil.AddButtonListener(self.ui.btn_jump, self, self.__OnClickDivergentTask)
end

function UINActivityDivergentTaskItem:InitDivergentTaskItem(divergentData, taskData, clickGetNewTaskFunc, clickExchangeTaskFunc, needAnim)
  local delayTime = 0
  if needAnim then
    delayTime = 0.175
    self.ui.ani_taskitem:Play("UI_AnotherHero_RefreshTaskItem")
  end
  TimerManager:StopTimer(self.animTimer)
  self.animTimer = TimerManager:StartTimer(delayTime, function()
    self._divergentData = divergentData
    self._taskData = taskData
    self._clickGetNewTaskFunc = clickGetNewTaskFunc
    self._clickExchangeTaskFunc = clickExchangeTaskFunc
    if taskData == nil then
      self.ui.obj_HasTaskItem:SetActive(false)
      self.ui.obj_NewTaskItem:SetActive(true)
      return
    else
      self.ui.obj_HasTaskItem:SetActive(true)
      self.ui.obj_NewTaskItem:SetActive(false)
    end
    self._divergentTaskCfg = divergentData:GetDivergentTaskGroupCfg(taskData.id)
    local mainColor = self.ui.color_TaskLevel[self._divergentTaskCfg.task_rank]
    self.ui.img_RewardIcon.color = mainColor
    self.ui.img_DownLine.color = mainColor
    self.ui.img_TaskState.color = taskData:CheckComplete() and mainColor or self.ui.color_DefaultTaskState
    self.ui.tex_Des.text = LanguageUtil.GetLocaleText(taskData.stcData.task_intro)
    self.ui.tex_TaskState:SetIndex(taskData:CheckComplete() and 1 or 0)
    local taskTokenId = divergentData:GetDivergentTokenId()
    local rewardIds, rewardNums = taskData:GetTaskCfgRewards()
    for index, rewardId in ipairs(rewardIds) do
      if rewardId == taskTokenId then
        local rewardNum = rewardNums[index]
        self.ui.tex_RewardNum:SetIndex(0, tostring(rewardNum))
        break
      end
    end
    self.ui.tex_Progress:SetIndex(0, tostring(taskData.schedule), tostring(taskData.aim))
  end, nil, true)
end

function UINActivityDivergentTaskItem:__OnClickGetNewDivergentTask()
  if self._taskData ~= nil then
    return
  end
  if self._clickGetNewTaskFunc ~= nil then
    self._clickGetNewTaskFunc()
  end
end

function UINActivityDivergentTaskItem:__OnClickExchangeDivergentTask()
  if self._taskData == nil then
    return
  end
  if self._clickExchangeTaskFunc ~= nil then
    self._clickExchangeTaskFunc(self._taskData)
  end
end

function UINActivityDivergentTaskItem:__OnClickDivergentTask()
  if not self._taskData:CheckComplete() then
    self:__OnClickDivergentTaskJump()
    return
  end
  self:__OnClickGetDivergentReward()
end

function UINActivityDivergentTaskItem:__OnClickDivergentTaskJump()
  if self._taskData.stcData.jump_id ~= nil and self._taskData.stcData.jump_id > 0 then
    JumpManager:Jump(self._taskData.stcData.jump_id, nil, nil, self._taskData.stcData.jumpArgs)
  end
end

function UINActivityDivergentTaskItem:__OnClickGetDivergentReward()
  local divergentCtrl = ControllerManager:GetController(ControllerTypeId.ActivityDivergent)
  if divergentCtrl == nil then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Commit(self._divergentData:GetActFrameId(), self._taskData.id)
end

return UINActivityDivergentTaskItem

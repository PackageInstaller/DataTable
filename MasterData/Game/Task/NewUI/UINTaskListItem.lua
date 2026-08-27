local UINTaskListItem = class("UINTaskListItem", UIBaseNode)
local base = UIBaseNode
local TaskEnum = require("Game.Task.TaskEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local JumpManager = require("Game.Jump.JumpManager")

function UINTaskListItem:OnInit()
  self.ctrl = ControllerManager:GetController(ControllerTypeId.Task)
  self.taskState = nil
  self.state = nil
  self.taskCfg = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ItemClick, self, self.OnClickBtn)
  self.poolRewardItem = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
end

function UINTaskListItem:InitTaskItem(taskData, typeId)
  self.taskData = taskData
  self.typeId = typeId
  if taskData.isPicked then
    self.state = TaskEnum.eTaskState.Picked
  elseif taskData:CheckComplete() then
    self.state = TaskEnum.eTaskState.Completed
  else
    self.state = TaskEnum.eTaskState.InProgress
  end
  self.taskCfg = taskData.stcData
  self:RefreshUI()
  self:RefreshRewards(self.state == TaskEnum.eTaskState.Picked)
end

function UINTaskListItem:RefreshUI()
  self.ui.btn_ItemClick.enabled = true
  local unlock = true
  if self.taskCfg.open_condition ~= nil and self.taskCfg.open_condition > 0 then
    unlock = FunctionUnlockMgr:ValidateUnlock(self.taskCfg.open_condition)
  end
  if unlock then
    self.ui.img_state:SetIndex(self.state - 1)
    self.ui.tex_State:SetIndex(self.state - 1)
    self.ui.obj_stepArrow:SetActive(self.state == TaskEnum.eTaskState.Completed)
    self.ui.obj_lock:SetActive(false)
    self.ui.obj_state:SetActive(true)
  else
    self.ui.img_state:SetIndex(0)
    self.ui.tex_State:SetIndex(0)
    self.ui.obj_stepArrow:SetActive(false)
    self.ui.obj_lock:SetActive(true)
    self.ui.obj_state:SetActive(false)
    local msg
    local sysOpenCfg = ConfigData.system_open[self.taskCfg.open_condition]
    if table.count(sysOpenCfg.pre_condition) == 1 and sysOpenCfg.pre_condition[1] == 3 then
      self.ui.obj_lockTextSub:SetActive(true)
      local sectorStageCfg = ConfigData.sector_stage[sysOpenCfg.pre_para1[1]]
      msg = ConfigData:GetSectorInfoMsg(sectorStageCfg.sector, sectorStageCfg.num, sectorStageCfg.difficulty)
    else
      self.ui.obj_lockTextSub:SetActive(false)
      msg = FunctionUnlockMgr:GetFuncUnlockDecription(self.taskCfg.open_condition)
    end
    self.ui.tex_lock.text = msg
  end
  if not unlock then
    self.ui.obj_isOver:SetActive(false)
  elseif self.state == TaskEnum.eTaskState.InProgress then
    self.ui.obj_isOver:SetActive(false)
  elseif self.state == TaskEnum.eTaskState.Completed then
    self.ui.obj_isOver:SetActive(false)
  elseif self.state == TaskEnum.eTaskState.Picked then
    self.ui.obj_isOver:SetActive(true)
    self.ui.btn_ItemClick.enabled = false
  else
    error("can't figure the task state=" .. self.taskData.state)
    return
  end
  local stepCfg = self.taskData:GetStepCfg()
  if stepCfg == nil then
    error("can't read stepCfg id=" .. self.taskData.stepIdx)
  end
  local schedule = unlock and self.taskData.schedule or 0
  self.ui.tex_TaskIntro.text = self.taskData:GetTaskFirstStepIntro()
  local sizeDelta = self.ui.img_bar.sizeDelta
  if self.state == TaskEnum.eTaskState.Picked then
    self.ui.img_Fill.sizeDelta = sizeDelta
    self.ui.tex_Progress:SetIndex(1)
  else
    self.ui.img_Fill.sizeDelta = Vector2.New(schedule / self.taskData.aim * sizeDelta.x, sizeDelta.y)
    if schedule < self.taskData.aim then
      self.ui.tex_Progress:SetIndex(0, tostring(schedule), tostring(self.taskData.aim))
    else
      self.ui.tex_Progress:SetIndex(1)
    end
  end
  if not IsNull(self.ui.obj_img_Activity) then
    local bindActFrameId = self.taskData:GetBindActFramId()
    self.ui.obj_img_Activity:SetActive(bindActFrameId ~= nil)
    if bindActFrameId ~= nil then
      local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
      local activityFrameData = activityFrameCtrl:GetActivityFrameData(bindActFrameId)
      if activityFrameData == nil then
        error("activityFrameData not exist")
      end
      self.ui.tex_ActName.text = activityFrameData:GetActivityFrameName()
      self.ui.img_bottom:SetIndex(1)
    else
      self.ui.img_bottom:SetIndex(0)
    end
  end
end

function UINTaskListItem:RefreshRewards(isPick)
  self.poolRewardItem:HideAll()
  for index, id in ipairs(self.taskCfg.rewardIds) do
    local itemCfg = ConfigData.item[id]
    if itemCfg.type == eItemType.BattlePassPoint then
      local battlePassData = PlayerDataCenter.battlepassData:GetMainBattlePass()
      if battlePassData == nil then
        goto lbl_35
      end
    end
    local num = self.taskCfg.rewardNums[index]
    local ItemWithCount = self.poolRewardItem:GetOne()
    ItemWithCount:InitItemWithCount(itemCfg, num, nil, isPick)
    ::lbl_35::
  end
end

function UINTaskListItem:OnClickBtn()
  if self.state == TaskEnum.eTaskState.InProgress then
    local jumpId = self.taskCfg.jump_id
    local jumpArgs = self.taskCfg.jumpArgs
    if jumpId ~= nil and 0 < jumpId then
      JumpManager:Jump(jumpId, function(jumpCallback)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  elseif self.state == TaskEnum.eTaskState.Completed then
    self.state = TaskEnum.eTaskState.Picked
    local taskWindow = UIManager:GetWindow(UIWindowTypeID.Task)
    if taskWindow ~= nil and self.poolRewardItem.listItem[1] ~= nil then
      taskWindow:RecordTaskRewardItemPos(self.poolRewardItem.listItem[1].transform.position)
    end
    self.ctrl:SendCommitQuestReward(self.taskData, nil, function()
      if taskWindow ~= nil then
        taskWindow:ChangeBtnReceiveAll(self.typeId)
      end
    end)
  else
    return
  end
end

function UINTaskListItem:OnDelete()
  base.OnDelete(self)
end

return UINTaskListItem

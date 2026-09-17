local this = class("moduleNoviceTask", G_UIModuleBase)
local _noviceTaskGroupTpl = L_GameTpl:getNoviceTaskGroupTpl()
local SwitchNoviceTaskGroupDirection = {TURN_LEFT = 1, TURN_RIGHT = 2}

function this.bind()
  return {
    txt_noviceTaskGroupTitle = "",
    txt_NoviceTaskGroupDesc = "",
    go_btnNoviceTaskGroupTitleLeft = true,
    go_btnNoviceTaskGroupTitleRight = true,
    alphaBtnNoviceTaskGroupTitleRight = 1,
    txt_groupProgressLeft = "",
    txt_groupProgressRight = "",
    txt_rewardTitle = L_Lang:get(L_WordsTpl:getValue("ui_novicetask_progress_reward")),
    enable_rewardScrollView = false,
    noviceTaskGroupRewardList = {
      moduleName = "pages/ActivityTask/cellStatusRewardItem"
    },
    active_canReceiveGroupRewardPart = false,
    active_canNotReceiveGroupRewardPart = false,
    active_canFinishCondition = false,
    txt_finishCondition = "",
    text_receiveGroupReward = L_Lang:get(L_WordsTpl:getValue("ui_novice_task_receive_all")),
    noviceTaskList_mobile = {
      moduleName = "pages/activityTask/cellNoviceTaskItem"
    },
    noviceTaskList_pc = {
      moduleName = "pages/activityTask/cellNoviceTaskItem"
    },
    text_canNotReceiveGroupRewardPart = ""
  }
end

function this.methods()
  return {
    onclick_btnNoviceTaskGroupTitleLeft = function(self)
      if not self._isListReady or self._isRewardPageOpenWait then
        return
      end
      self:switchNoviceTaskGroup(SwitchNoviceTaskGroupDirection.TURN_LEFT)
    end,
    onclick_btnNoviceTaskGroupTitleRight = function(self)
      if not self._isListReady or self._isRewardPageOpenWait then
        return
      end
      if L_NoviceTaskStore:getTaskGroupIfFinishedById(self.data.currentTaskGroupId) then
        self:switchNoviceTaskGroup(SwitchNoviceTaskGroupDirection.TURN_RIGHT)
      else
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_novicetask_lock"))
      end
    end,
    noviceTaskList_mobile = {
      onClick_receiveNoviceTaskReward = function(self, cellNoviceTaskItem)
        if not self._isListReady or self._isRewardPageOpenWait then
          return
        end
        self:onClickReceive(cellNoviceTaskItem)
      end,
      onClick_goto = function(self, bind)
        if not self._isListReady or self._isRewardPageOpenWait then
          return
        end
        L_JumpMgr:jumpTo(bind.systemJump)
      end
    },
    noviceTaskList_pc = {
      onClick_receiveNoviceTaskReward = function(self, cellNoviceTaskItem)
        if not self._isListReady or self._isRewardPageOpenWait then
          return
        end
        self:onClickReceive(cellNoviceTaskItem)
      end,
      onClick_goto = function(self, bind)
        if not self._isListReady or self._isRewardPageOpenWait then
          return
        end
        L_JumpMgr:jumpTo(bind.systemJump)
      end
    },
    onclick_btn_canReceiveGroupReward = function(self)
      if not self._isListReady or self._isRewardPageOpenWait then
        return
      end
      L_NoviceTaskStore:req_noviceTaskFinishGroup(self.data.currentTaskGroupId, function(rspData, errorCode)
        local rewards = rspData.rewards
        if errorCode == L_Const.errorCode.ErrCodeSucc and not table.isEmpty(rewards) then
          L_RewardManager:showPage(rewards, rspData.src)
          self._waitForRewardClose_groupReward = true
        end
      end)
    end,
    onclick_btn_canFinishCondition = function(self)
    end
  }
end

function this:open()
  self.inReward = false
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
end

function this:close()
  L_TimerManager:clearTimer(self)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_closePage, self)
end

function this:switchNoviceTaskGroup(switchDirection)
  if switchDirection == SwitchNoviceTaskGroupDirection.TURN_LEFT then
    self.data.currentTaskGroupId = self.data.currentTaskGroupId - 1
    self.bindComponents.ani_descPart:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_descPart:Play("anim_NT_change_left")
    else
      self.bindComponents.ani_descPart:Play("anim_NT_change_left_mobile")
    end
  else
    self.data.currentTaskGroupId = self.data.currentTaskGroupId + 1
    self.bindComponents.ani_descPart:Stop()
    if L_DeviceTpl:getIsPc() then
      self.bindComponents.ani_descPart:Play("anim_NT_change_right")
    else
      self.bindComponents.ani_descPart:Play("anim_NT_change_right_mobile")
    end
  end
  self:refreshNoviceTaskAllImmediately(true)
  self:playListCellInVFX(0.13)
  self.parent.bindComponents.ani_pageNoviceTask:Stop()
  if L_DeviceTpl:getIsPc() then
    self.parent.bindComponents.ani_pageNoviceTask:Play("anim_NT_change")
  else
    self.parent.bindComponents.ani_pageNoviceTask:Play("anim_NT_change_mobile")
  end
end

function this:refreshModule()
  self.data = {}
  self.data.currTypeTaskId = 1
  self.data.currentTaskGroupId = L_NoviceTaskStore:getMaxUnlockedTaskGroupId(self.data.currTypeTaskId)
  self.data.maxTaskGroupId = L_NoviceTaskStore:getMaxTaskGroupId(self.data.currTypeTaskId)
  self:refreshNoviceTaskAllImmediately()
  self:playListCellInVFX(0.2)
  self.bindComponents.ani_descPart:Stop()
  if L_DeviceTpl:getIsPc() then
    self.bindComponents.ani_descPart:Play("anim_NT_change_right")
  else
    self.bindComponents.ani_descPart:Play("anim_NT_change_right_mobile")
  end
  self.parent.bindComponents.ani_pageNoviceTask:Stop()
  if L_DeviceTpl:getIsPc() then
    self.parent.bindComponents.ani_pageNoviceTask:Play("anim_NT_in")
  else
    self.parent.bindComponents.ani_pageNoviceTask:Play("anim_NT_in_mobile")
  end
end

function this:refreshNoviceTaskAllImmediately(isFromLeftRightChange)
  self:refreshNoviceTaskGroupContent(isFromLeftRightChange)
  self:refreshNoviceTaskContent()
end

function this:onEvent_nextTaskGroupUnlocked()
  self:switchNoviceTaskGroup(SwitchNoviceTaskGroupDirection.TURN_RIGHT)
end

function this:refreshNoviceTaskGroupContent(isFromLeftRightChange)
  local delayRefreshTitleNameTime = isFromLeftRightChange and 0.066 or 0
  L_TimerManager:newOrResetTimer(self, "VFX_delayRefreshTitleName", function()
    self.bind.txt_noviceTaskGroupTitle = _noviceTaskGroupTpl:getTaskGroupTiltleById(self.data.currentTaskGroupId)
  end, delayRefreshTitleNameTime)
  self.bind.txt_NoviceTaskGroupDesc = _noviceTaskGroupTpl:getTaskGroupTitleDescById(self.data.currentTaskGroupId)
  self.bind.go_btnNoviceTaskGroupTitleLeft = true
  self.bind.go_btnNoviceTaskGroupTitleRight = true
  if self.data.currentTaskGroupId == 1 then
    self.bind.go_btnNoviceTaskGroupTitleLeft = false
  elseif self.data.currentTaskGroupId == self.data.maxTaskGroupId then
    self.bind.go_btnNoviceTaskGroupTitleRight = false
  end
  local isTaskGroupComplete = L_NoviceTaskStore:checkIfTargetTaskGroupCompleteByGroupId(self.data.currentTaskGroupId)
  self.bind.active_canReceiveGroupRewardPart = isTaskGroupComplete and L_NoviceTaskStore:getTaskGroupIfFinishedById(self.data.currentTaskGroupId) == false
  self.bind.active_canNotReceiveGroupRewardPart = not isTaskGroupComplete or L_NoviceTaskStore:getTaskGroupIfFinishedById(self.data.currentTaskGroupId) == true
  if L_NoviceTaskStore:getTaskGroupIfFinishedById(self.data.currentTaskGroupId) then
    self.bind.text_canNotReceiveGroupRewardPart = L_WordsTpl:getValue("ui_novicetask_alreadyreceived")
  end
  if not isTaskGroupComplete then
    self.bind.text_canNotReceiveGroupRewardPart = L_WordsTpl:getValue("ui_novice_task_receive")
  end
  self.bind.alphaBtnNoviceTaskGroupTitleRight = L_NoviceTaskStore:getTaskGroupIfFinishedById(self.data.currentTaskGroupId) == false and 0.5 or 1
  self.bind.txt_groupProgressLeft = tostring(L_NoviceTaskStore:getTaskGroupProgressById(self.data.currentTaskGroupId))
  self.bind.txt_groupProgressRight = tostring(L_NoviceTaskStore:getTaskGroupMaxProgressById(self.data.currentTaskGroupId))
  local base_data = {}
  self.bind.noviceTaskGroupRewardList:clear()
  for i, v in ipairs(_noviceTaskGroupTpl:getTaskGroupRewardById(self.data.currentTaskGroupId)) do
    table.insert(base_data, {
      itemId = v[2],
      itemType = v[1],
      itemNum = v[3]
    })
  end
  self.bind.noviceTaskGroupRewardList:insert_array(base_data)
  self.bind.enable_rewardScrollView = 3 < #base_data and true or false
  self.content = self.content or self.bindComponents.scrollView_reward.content
  if self.bind.enable_rewardScrollView then
    self.bindComponents.scrollView_reward.horizontalNormalizedPosition = 0
  else
    local anchoredPosition = self.content.anchoredPosition
    anchoredPosition.x = 0
    self.content.anchoredPosition = anchoredPosition
  end
end

function this:refreshNoviceTaskContent()
  local taskInfosDic = L_NoviceTaskStore:getTaskInfosDic() or {}
  local taskInfos = taskInfosDic[self.data.currentTaskGroupId] or {}
  local temp = {}
  for i, taskInfo in ipairs(taskInfos) do
    table.insert(temp, {
      currentTaskGroupId = self.data.currentTaskGroupId,
      taskId = taskInfo.task_id
    })
  end
  if L_DeviceTpl:getIsMobile() then
    self.bind.noviceTaskList_mobile:clear()
    self.bind.noviceTaskList_mobile:insert_array(temp)
  elseif L_DeviceTpl:getIsPc() then
    self.bind.noviceTaskList_pc:clear()
    self.bind.noviceTaskList_pc:insert_array(temp)
  end
end

function this:onClickReceive(cellNoviceTaskItem)
  if self.inReward then
    return
  end
  self.inReward = true
  L_NoviceTaskStore:req_noviceTaskFinish(cellNoviceTaskItem, function(rspData, errorCode)
    local rewards = rspData.rewards
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if not table.isEmpty(rewards) then
        self._isRewardPageOpenWait = true
        L_TimerManager:newOrResetTimer(self, "VFX_delayShowPageReward", function()
          self._isRewardPageOpenWait = false
          self._waitForRewardClose = true
          L_RewardManager:showPage(rewards, rspData.src)
        end, 0.73)
      end
      cellNoviceTaskItem:onClick()
    end
  end)
end

function this:onEvent_closePage(pageName)
  if pageName == "pageReward" then
    self.inReward = false
    self:playListRefreshVFX()
  end
end

function this:playListRefreshVFX()
  if self._waitForRewardClose then
    self:refreshNoviceTaskAllImmediately()
    self._waitForRewardClose = false
  end
  if self._waitForRewardClose_groupReward then
    if self.data.currentTaskGroupId < L_NoviceTaskStore:getMaxTaskGroupId(self.data.currTypeTaskId) then
      self:switchNoviceTaskGroup(SwitchNoviceTaskGroupDirection.TURN_RIGHT)
      self:playListCellInVFX(0)
      self._waitForRewardClose_groupReward = false
      L_FlyMsgManager:showNormalMsgByKey("notice_novicetask_unlock", {
        [0] = _noviceTaskGroupTpl:getTaskGroupTiltleById(self.data.currentTaskGroupId)
      })
    else
      self:refreshNoviceTaskAllImmediately()
    end
  end
end

function this:playListCellInVFX(delayTime, intervalTime)
  intervalTime = intervalTime or 0.1
  if L_DeviceTpl:getIsPc() then
    for i, v in pairs(self.modules.noviceTaskList_pc) do
      local cell = v
      cell:playCellOutVFX()
      L_TimerManager:stopTimer(self, string.format("VFX_showNoviceTaskContentCell_%d", i))
    end
  elseif L_DeviceTpl:getIsMobile() then
    for i, v in pairs(self.modules.noviceTaskList_mobile) do
      local cell = v
      cell:playCellOutVFX()
      L_TimerManager:stopTimer(self, string.format("VFX_showNoviceTaskContentCell_%d", i))
    end
  end
  self._isListReady = false
  local taskCount = 0
  taskCount = L_DeviceTpl:getIsPc() and #self.modules.noviceTaskList_pc or taskCount
  taskCount = L_DeviceTpl:getIsMobile() and #self.modules.noviceTaskList_mobile or taskCount
  L_TimerManager:newOrResetTimer(self, "VFX_showNoviceTaskContent", function()
    if L_DeviceTpl:getIsPc() then
      for i, v in pairs(self.modules.noviceTaskList_pc) do
        L_TimerManager:newOrResetTimer(self, string.format("VFX_showNoviceTaskContentCell_%d", i), function()
          local cell = v
          cell:playCellInVFX(function()
            if i == taskCount then
              self._isListReady = true
            end
          end)
        end, intervalTime * (i - 1))
      end
    elseif L_DeviceTpl:getIsMobile() then
      for i, v in pairs(self.modules.noviceTaskList_mobile) do
        L_TimerManager:newOrResetTimer(self, string.format("VFX_showNoviceTaskContentCell_%d", i), function()
          local cell = v
          cell:playCellInVFX(function()
            if i == taskCount then
              self._isListReady = true
            end
          end)
        end, intervalTime * (i - 1))
      end
    end
  end, delayTime)
end

return this

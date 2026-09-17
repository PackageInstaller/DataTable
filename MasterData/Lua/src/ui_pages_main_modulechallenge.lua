local this = class("moduleChallenge", G_UIModuleBase)
local Color_NotLose = C_Color(1, 1, 1, 1)
local Color_Lose = C_Color(1, 1, 1, 0.2)
local SelectId_StatusIcon = {
  [C_EChallengeState.Running] = 1,
  [C_EChallengeState.Fail] = 2,
  [C_EChallengeState.Success] = 3,
  Temporary = 4
}

function this.bind()
  return {
    go_challengeContent = false,
    go_timeLimitChallenge = false,
    list_timeLimitChallenge = {
      moduleName = "pages/main/cellChallenge"
    },
    go_temporaryChallenge = false,
    list_temporaryChallenge = {
      moduleName = "pages/main/cellChallenge"
    },
    go_btnRestart = false,
    go_countdown = false,
    go_countdownStart = false,
    go_countdownRunning = false,
    txt_startCountdown = nil,
    txt_countdown = nil,
    go_completed = false,
    isOn_success = false,
    go_moduleCountDown = false
  }
end

function this.methods()
  return {
    onClick_restartChallenge = function(self)
      local data_tip = {
        txtTitle = L_WordsTpl:getValue("notice_challenge_again_title"),
        txtContent = L_WordsTpl:getValue("notice_challenge_again"),
        confirmCallback = function()
          self:stopChallenge()
        end
      }
      L_GameUtil.showCommonTip(data_tip)
    end
  }
end

function this:open()
  self._lastGroupStatus = C_EChallengeState.None
  self._syncChallengeDataHandler = handler(self, self.onEvent_syncChallengeData)
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:show()
  self:refreshContent()
  L_ShortCutManager:registerShortCut("pageMainCity", C_InputManager_KeyType.ETriggerPlayableInteraction, function()
    AzurWorld.ChallengeMgr:TriggerPlayableInteractionAction()
  end)
  L_ShortCutManager:registerShortCut("pageMainCity", C_InputManager_KeyType.EExitPlayableInteraction, function()
    AzurWorld.ChallengeMgr:ExitPlayableInteractionAction()
  end)
end

function this:refreshContent()
  local showData = AzurWorld.ChallengeMgr:GetShowChallengeData()
  local dataList = showData.allDataList
  local groupData = showData.groupData
  print("状态", groupData.state, "type", groupData.type)
  if groupData.state == C_EChallengeState.None then
    if self._lastGroupStatus ~= C_EChallengeState.None then
      self.bindComponents.ani_chanllengeContent:Stop()
      self.bindComponents.ani_chanllengeContent:Play("anim_challenge_chanllengeContent_out")
      L_TimerManager:newOrResetTimer(self, "VFX_chanllengeContentOut", function()
        self:clearData()
      end, 0.5)
    else
      self:clearData()
    end
    self._lastGroupStatus = C_EChallengeState.None
    return
  end
  local dataCount = dataList.Count
  local tmp_timeLimit, tmp_temporary = {}, {}, {}
  for i = 0, dataCount - 1 do
    local data = dataList[i]
    if data.type == C_EChallengeType.TimeLimited then
      table.insert(tmp_timeLimit, {
        type = data.type,
        state = data.state,
        txt_content = data.content,
        color_txtContent = data.state == C_EChallengeState.Fail and Color_Lose or Color_NotLose,
        selectId_statusIcon = SelectId_StatusIcon[data.state] or 1
      })
    elseif data.type == C_EChallengeType.Temporary then
      table.insert(tmp_temporary, {
        type = data.type,
        state = data.state,
        txt_content = data.content,
        color_txtContent = Color_NotLose,
        selectId_statusIcon = SelectId_StatusIcon.Temporary,
        needShowInVFX = groupData.state == C_EChallengeState.Running and data.state == C_EChallengeState.Start,
        delayRefreshCallback = function()
          self:refreshContent()
        end
      })
    end
  end
  local hasTimeLimitData = not table.isEmpty(tmp_timeLimit)
  local hasTemporaryData = not table.isEmpty(tmp_temporary)
  self.bind.go_temporaryChallenge = hasTemporaryData
  self.bind.go_timeLimitChallenge = hasTimeLimitData
  self.bind.go_challengeContent = hasTimeLimitData or hasTemporaryData
  self:refreshList("list_timeLimitChallenge", tmp_timeLimit)
  self:refreshList("list_temporaryChallenge", tmp_temporary)
  self.bind.go_btnRestart = groupData.stopCallbackAction ~= nil
  if groupData.state ~= self._lastGroupStatus then
    self:onStateChange(groupData.state, groupData)
  end
  local isTimeLimitChallenge = 0 < groupData.limitTime or groupData.type == C_EChallengeGroupType.MountChallenge
  if isTimeLimitChallenge then
    if groupData.state == C_EChallengeState.Start then
      self.bind.go_countdown = true
      self.bind.go_countdownStart = true
      self.bind.go_countdownRunning = false
      self.bind.txt_startCountdown = L_WordsTpl:getValue("notice_moduleChallenge", {
        [0] = groupData.limitTime
      })
      L_TimerManager:newOrResetTimer(self, "VFX_startIn", function()
        self.bindComponents.ani_start:Stop()
        self.bindComponents.ani_start:Play("anim_challenge_start_out")
        L_TimerManager:newOrResetTimer(self, "VFX_startOut", function()
          self.bind.go_countdownStart = false
        end, 0.567)
        self.bind.go_countdownRunning = true
      end, 5)
    elseif groupData.state == C_EChallengeState.Running and not self.bind.go_countdown then
      self.bind.go_countdown = true
      self.bind.go_countdownRunning = true
      self.bind.go_countdownStart = false
    end
    if groupData.type == C_EChallengeGroupType.MountChallenge then
      local leftTime = groupData.currentTime
      if leftTime > groupData.endWarningTime then
        self.bind.txt_countdown = string.format("<color=#ffffff>%s<size=18px>s</size></color>", leftTime)
      else
        self.bind.txt_countdown = string.format("<color=#ff6d6d>%s<size=18px>s</size></color>", leftTime)
      end
      if leftTime <= 0 then
        self:countdownOutVFX()
      end
    else
      local endTime = groupData.startTime + groupData.limitTime
      
      local function timeTick()
        local nowTime = L_TimeUtil.getServerTime()
        local leftTime = endTime - nowTime
        self.bind.txt_countdown = string.format("<color = #ffffff>%s<size = 18px>s</size></color>", leftTime)
        if leftTime <= 0 then
          L_TimerManager:stopTimer(self, "countdown")
          self:countdownOutVFX()
        end
      end
      
      L_TimerManager:newOrResetTimer(self, "countdown", timeTick, 0.5, -1)
      timeTick()
    end
  end
  local needShowCompleted = self._lastGroupStatus == C_EChallengeState.Running and groupData.state == C_EChallengeState.Success or groupData.state == C_EChallengeState.Fail
  self.bind.isOn_success = groupData.state == C_EChallengeState.Success
  self.bind.go_completed = needShowCompleted
  if needShowCompleted then
    self:countdownOutVFX()
    if groupData.type == C_EChallengeGroupType.MountChallenge or groupData.type == C_EChallengeGroupType.PlayableWumiPhoto then
      C_AudioManager.Play(self.bind.isOn_success and "Play_SFX_System_MountChallenge_Win" or "Play_SFX_System_MountChallenge_Loose")
    else
      C_AudioManager.Play(self.bind.isOn_success and "Play_SFX_System_Dungeon_Info_Win" or "Play_SFX_System_Dungeon_Info_Loose")
    end
    L_TimerManager:newOrResetTimer(self, "completedVFX", function()
      if self.bind.isOn_success then
        self.bindComponents.ani_success:Stop()
        self.bindComponents.ani_success:Play("anim_challenge_success_out")
      else
        self.bindComponents.ani_failure:Stop()
        self.bindComponents.ani_failure:Play("anim_challenge_failure_out")
      end
    end, 3.6)
    L_TimerManager:newOrResetTimer(self, "completed", function()
      AzurWorld.ChallengeMgr:Dispatch(C_EChallengeEvent.SyncChallengeData)
    end, 4)
  end
  self._lastGroupStatus = groupData.state
end

function this:onStateChange(new_state, groupData)
  if new_state == C_EChallengeState.Start then
    self.bindComponents.ani_chanllengeContent:Play("anim_challenge_chanllengeContent_in")
    if groupData.type == C_EChallengeGroupType.MountChallenge then
      self.bind.go_moduleCountDown = true
      self.bindComponents.countDownAnim:Play("anim_petbattle_countdown")
      L_AudioUtil.playSound("Play_SFX_System_MountChallenge_Begin")
    elseif groupData.type == C_EChallengeGroupType.PlayableWumiPhoto then
      self.bind.go_moduleCountDown = true
      self.bindComponents.countDownAnim:Play("anim_petbattle_countdown", 0, 0.75)
      L_AudioUtil.playSound("Play_SFX_System_HUD_General_Start")
    elseif groupData.type == C_EChallengeGroupType.JengaChallenge then
      AzurWorld.ChallengeMgr:SwitchMainPlayableInputMap()
    end
    L_TimerManager:newOrResetTimer(self, "countDownAnim", function()
      self.bind.go_moduleCountDown = false
    end, 5)
  end
end

function this:stopChallenge()
  AzurWorld.ChallengeMgr:StopChallenge()
  self:countdownOutVFX()
end

function this:refreshList(listName, dataList)
  local list = self.modules[listName]
  if #dataList == #list then
    for i, v in pairs(list) do
      v:refreshView(dataList[i])
    end
  else
    local isPlayingOutVFX = false
    if listName == "list_temporaryChallenge" then
      for i, v in pairs(list) do
        isPlayingOutVFX = v._playingOut
        if isPlayingOutVFX then
          break
        end
      end
    end
    if not isPlayingOutVFX then
      self.bind[listName]:clear()
    else
      for i = #dataList, 1 do
        for _, v in pairs(list) do
          if v.bind.txt_content == dataList[i].txt_content then
            dataList[i] = nil
          end
        end
      end
    end
    self.bind[listName]:insert_array(dataList)
  end
end

function this:clearData()
  self.bind.go_timeLimitChallenge = false
  self.bind.go_temporaryChallenge = false
  self.bind.go_countdown = false
  self.bind.go_completed = false
  self.bind.go_btnRestart = false
  self.bind.list_timeLimitChallenge:clear()
  self.bind.list_temporaryChallenge:clear()
  self.bind.go_challengeContent = false
  L_TimerManager:clearTimer(self)
end

function this:onEvent_syncChallengeData()
  self:refreshContent()
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

function this:countdownOutVFX()
  if self.bind.go_countdown then
    self.bindComponents.ani_running:Stop()
    self.bindComponents.ani_running:Play("anim_challenge_running_out")
    L_TimerManager:newOrResetTimer(self, "VFX_runningOut", function()
      self.bind.go_countdown = false
    end, 0.267)
  end
end

return this

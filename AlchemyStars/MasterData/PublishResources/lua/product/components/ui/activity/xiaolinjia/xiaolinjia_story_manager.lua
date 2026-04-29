_class("XiaoLinJiaStoryManager", Object)
XiaoLinJiaStoryManager = XiaoLinJiaStoryManager

function XiaoLinJiaStoryManager:Constructor(storyName, uiController)
  self.sessionID = 1
  self.dialogList = {}
  self.isPlayingSession = false
  self.curIsQuestion = false
  self.curQuestionIndex = 0
  self.curPlayerSelectIndex = 0
  self.curRunTime = 0
  self.curShowStopTime = 0
  self.canJumpToNextSession = false
  self.uiController = uiController
  self.isAuto = false
  self.isEnd = false
  self.hasShowedResult = false
  local storyCfg = Cfg[storyName]
  if not storyCfg then
    Log.exception("剧情配置不存在", storyCfg)
  end
  for _, v in pairs(storyCfg({})) do
    self.dialogList[v.ID] = v
  end
  self.doneStartSessionMap = {}
  self.doneEndSessionMap = {}
  self.sessionLength = #self.dialogList
end

function XiaoLinJiaStoryManager:GetDialogList()
  return self.dialogList
end

function XiaoLinJiaStoryManager:GetFirstMissionData()
  return self.dialogList[1]
end

function XiaoLinJiaStoryManager:GetCurSessionID()
  return self.sessionID
end

function XiaoLinJiaStoryManager:GetCurSessionData()
  return self.curSessionData
end

function XiaoLinJiaStoryManager:GetCurSessionIsQuestion()
  return self.curIsQuestion
end

function XiaoLinJiaStoryManager:GetCurQuestionIndex()
  return self.curQuestionIndex
end

function XiaoLinJiaStoryManager:SetCurPlayerSelectIndex(index)
  self.curPlayerSelectIndex = index
end

function XiaoLinJiaStoryManager:StartSession()
  if self.doneStartSessionMap[self.sessionID] then
    return
  end
  local curSession = self.dialogList[self.sessionID]
  if curSession.Topic then
    self.curIsQuestion = true
    self.curQuestionIndex = self.curQuestionIndex + 1
    self.curSessionData[1] = curSession
  else
    self.curIsQuestion = false
    self.curSessionData = {}
    local longSpeekContent = ""
    if curSession.Continuous then
      local tempSessionID = self.sessionID
      while self.dialogList[tempSessionID].Continuous do
        table.insert(self.curSessionData, self.dialogList[tempSessionID])
        local content = self.dialogList[tempSessionID].Content
        if string.len(content) > string.len(longSpeekContent) then
          longSpeekContent = content
        end
        tempSessionID = tempSessionID + 1
      end
      self.sessionID = tempSessionID - 1
    else
      self.curSessionData[1] = curSession
      longSpeekContent = self.curSessionData[1].Content
    end
    self.curShowStopTime = self.curRunTime + self:GetkeepWaitTime(longSpeekContent)
    self.isPlayingSession = true
  end
  self.uiController:OnSessionStart()
  self.doneStartSessionMap[self.sessionID] = true
end

function XiaoLinJiaStoryManager:GetkeepWaitTime(str)
  local len = string.len(str)
  if 10 < len then
    local time = (len - 10) * 0.03
    return 0.5 + time
  else
    return 0.5
  end
end

function XiaoLinJiaStoryManager:SetAuto(flag)
  self.isAuto = flag
end

function XiaoLinJiaStoryManager:GetAuto()
  return self.isAuto
end

function XiaoLinJiaStoryManager:Update(deltaTimeMS)
  if self.isEnd then
    return
  end
  self.curRunTime = self.curRunTime + deltaTimeMS / 1000
  if not self.isPlayingSession then
    return
  end
  if self.curIsQuestion then
    return
  end
  if self.isAuto then
    if self.curRunTime > self.curShowStopTime then
      self.curShowStopTime = 99999
      self:EndSession()
    end
  elseif self.curRunTime > self.curShowStopTime then
    self.canJumpToNextSession = true
  end
end

function XiaoLinJiaStoryManager:TouchScreenAndJumpToNextSession()
  if self.canJumpToNextSession then
    self:EndSession()
    self.canJumpToNextSession = false
  end
end

function XiaoLinJiaStoryManager:TouchQuestionResultPanelAndJumpToNextSession()
  self.canJumpToNextSession = true
  if self.canJumpToNextSession then
    self:EndSession()
    self.canJumpToNextSession = false
  end
end

function XiaoLinJiaStoryManager:EndSession(jumpID)
  self.isPlayingSession = false
  self.curShowStopTime = 99999
  if self.curSessionData[1].CheckResult == 1 and not self.hasShowedResult then
    self.uiController:ShowClosingPanel()
    self.hasShowedResult = true
    return
  end
  if self.curIsQuestion then
    local optionsJump = self.curSessionData[1].OptionsJump
    self.sessionID = optionsJump[self.curPlayerSelectIndex]
  else
    jumpID = jumpID or self.curSessionData[1].Jump
    if jumpID then
      self.sessionID = jumpID
    else
      self.sessionID = self.sessionID + 1
    end
  end
  if self.doneEndSessionMap[self.sessionID] then
    return
  end
  self.doneEndSessionMap[self.sessionID] = true
  GameGlobal.UIStateManager():Lock("XiaoLinJiaStoryManager_EndSession")
  self.endTask = GameGlobal.TaskManager():StartTask(function(TT)
    self.uiController:OnSessionEnd(TT)
    GameGlobal.UIStateManager():UnLock("XiaoLinJiaStoryManager_EndSession")
    if self.sessionID <= self.sessionLength then
      self:StartSession()
    else
      self.isEnd = true
      self.uiController:OnExit()
    end
  end)
end

function XiaoLinJiaStoryManager:GetCanJumpSession()
  local tmpSession = self.sessionID
  while tmpSession ~= self.sessionLength and not self.dialogList[tmpSession].CheckResult and not self.dialogList[tmpSession].Options do
    tmpSession = tmpSession + 1
  end
  if tmpSession == self.sessionID then
    return false
  end
  return true
end

function XiaoLinJiaStoryManager:JumpSession()
  local tmpSession = self.sessionID
  while tmpSession ~= self.sessionLength and not self.dialogList[tmpSession].CheckResult and not self.dialogList[tmpSession].Options do
    tmpSession = tmpSession + 1
  end
  if tmpSession == self.sessionID then
    return
  end
  self.canJumpToNextSession = false
  self:EndSession(tmpSession)
end

function XiaoLinJiaStoryManager:IsPlayingSession()
end

function XiaoLinJiaStoryManager:ForceEnd()
  self.isEnd = true
end

function XiaoLinJiaStoryManager:OnDispose()
  self.isEnd = true
  if self.endTask then
    GameGlobal.TaskManager():KillTask(self.endTask)
    GameGlobal.UIStateManager():UnLock("XiaoLinJiaStoryManager_EndSession")
    self.endTask = nil
  end
end

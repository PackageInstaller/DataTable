local AvgStoryManager, Super = System.NewClass("AvgStoryManager", Manager)
AvgStoryManager.isIgnoreStory = false

function AvgStoryManager:ctor()
  Super.ctor(self)
  self.callBackId = 0
  self.allDialogTagMap = {}
  self.storyEndCallback = {}
  self.storyTailCallback = {}
  self.storyRealPlayCallback = {}
  self.tlPlayerList = {}
  self.tempDialogMap = {}
  self._commentId = nil
  self._loopingStoryId = nil
  self._loopStopped = nil
end

function AvgStoryManager:Awake(binder)
  Super.Awake(self)
  self.binder = binder
  EventMgr.Instance.StartStory:RegisterEvent(System.fn(self, self.StartStoryById))
  EventMgr.Instance.SkipDialog:RegisterEvent(System.fn(self, self.SkipDialog))
  EventMgr.Instance.StopStory:RegisterEvent(System.fn(self, self.StopStory))
  EventMgr.Instance.OnStoryEnd:RegisterEvent(System.fn(self, self.OnStoryEnd))
  EventMgr.Instance.OnStoryTail:RegisterEvent(System.fn(self, self.OnStoryTail))
  EventMgr.Instance.OnStoryRealStart:RegisterEvent(System.fn(self, self.OnStoryRealStart))
  if (ApplicationUtils.is_debug_mode() or Utils.__get_mode_from_debug_file()) and ApplicationUtils.__IsEditor then
    CommonDefine.BackCommandBlacklist[Urls.AvgDialogPanelNew] = false
  end
end

function AvgStoryManager:Reset()
  self.storyEndCallback = {}
  self.storyTailCallback = {}
  self.storyRealPlayCallback = {}
  self._loopingStoryId = nil
  self._loopStopped = nil
  UIManager.Instance:CloseByUrl(Urls.AvgDialogPanelNew)
end

function AvgStoryManager:ResetAvgCfg()
  for key, _ in pairs(package.loaded) do
    if string.startswith(key, "Config") then
      package.loaded[key] = nil
    end
  end
  DT.AvgDialog = nil
  DT.AvgBg = nil
  DT.AvgRole = nil
end

function AvgStoryManager:StartStory(id)
  local cfg = DT.AvgDialog[id]
  local storyId = cfg and cfg.ID
  if storyId then
    self:StartStoryById(storyId)
  end
  return storyId
end

function AvgStoryManager:GetDelayTime(storyId, chatId)
  chatId = chatId or 1
  local info = self:GetDialogInfo(storyId, chatId)
  local Sequence = info and info.Sequence or ""
  local delayPattern = "DelayShow%((.-)%)"
  local delay = string.match(Sequence, delayPattern)
  do return tonumber end
  return tonumber, delay
end

function AvgStoryManager:StartPlayTimeline(storyId, chatId, delayTime)
  self.binder:BindTimer(delayTime, 0, nil, function()
    AvgStoryManager.Instance:WaitStoryFinish(storyId, function()
      if #self.tlPlayerList > 0 then
        EventMgr.Instance.StopEntranceAniEvent:Dispatch()
        if bg.battleRender then
          self:ClearTLPlayerList()
          bg.battleRender:PopPerformQueue("Check_AVG_Timeline")
        else
          Logger.Warn("avg播Timeline异常中断，可能是跳过剧情了, storyId : %s", storyId)
        end
      end
    end)
  end)
  local info = self:GetDialogInfo(storyId, chatId)
  if nil == info or not info.TimelineParam then
    return
  end
  self:PlayTimelineByEntityCfgId(storyId, chatId)
end

function AvgStoryManager:PlayTimelineByEntityCfgId(storyId, chatId)
  local info = self:GetDialogInfo(storyId, chatId)
  if nil == info or not info.TimelineParam then
    return
  end
  for i = 1, #info.TimelineParam, 3 do
    local roleType = tonumber(info.TimelineParam[i])
    local cfgId = tonumber(info.TimelineParam[i + 1])
    local timelinePath = info.TimelineParam[i + 2]
    
    local function onEndAVGTL()
    end
    
    if 0 ~= roleType and bg.battleScene and bg.battleScene.roleList then
      local entity
      for _, role in ipairs(bg.battleScene.roleList) do
        for _, awaker in ipairs(role.awakerList or {}) do
          if awaker.tid == cfgId and awaker.role.roleType == roleType then
            entity = awaker
            break
          end
        end
      end
      if entity then
        local tempTLPlayer = BattleAwakerTimelinePlayer(entity)
        tempTLPlayer:SetLoadResSync(true)
        tempTLPlayer:PlayTimeline(timelinePath, 1, 0, onEndAVGTL)
        table.insert(self.tlPlayerList, tempTLPlayer)
      end
    else
      local tempTLPlayer = MSceneTimelinePlayer()
      tempTLPlayer:SetLoadResSync(true)
      tempTLPlayer:PlayTimeline(timelinePath, 0, onEndAVGTL)
      table.insert(self.tlPlayerList, tempTLPlayer)
    end
  end
end

function AvgStoryManager:ClearTLPlayerList()
  for _, tempTlplayer in ipairs(self.tlPlayerList) do
    tempTlplayer:Stop()
    tempTlplayer:Dispose()
  end
  self.tlPlayerList = {}
end

function AvgStoryManager:SetSkipPlot(stageId)
  self.SkipPlot = true
  MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.SkipPlotStageId, stageId)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function AvgStoryManager:ClearSkipPlot()
  self.SkipPlot = nil
  MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.SkipPlotStageId, 0)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function AvgStoryManager:IsSkipPlot()
  if bg.IsInBattle() then
    local battleTid = bg.battleData and bg.battleData.battleTid or 0
    local isBattleSkipPlot = BattleCfgUtils.GetSkipPlot(battleTid)
    if isBattleSkipPlot then
      return true
    end
    local isBattleMustPlayPlot = BattleCfgUtils.GetIsMustPlayPlot(battleTid)
    if isBattleMustPlayPlot then
      return false
    end
  end
  local stageId = WorldStageManager.Instance:GetCurStageId()
  if stageId and StageCfgUtils.GetSkipPlot(stageId) then
    return true
  end
  if self.SkipPlot == nil then
    local skipPlotStageId = MobileFileDataManager.Instance:GetPlayerFileValue(CommonDefine.LocalSaveKey.SkipPlotStageId)
    if nil == skipPlotStageId then
      self.SkipPlot = false
    else
      self.SkipPlot = 0 ~= skipPlotStageId
    end
  end
  if UIManager.Instance:GetWindow(Urls.DbgBattlePanel) then
    self.SkipPlot = false
  end
  return self.SkipPlot
end

function AvgStoryManager:ClearSkipPlot()
  self.SkipPlot = nil
  MobileFileDataManager.Instance:SetPlayerFileValue(CommonDefine.LocalSaveKey.SkipPlotStageId, 0)
  MobileFileDataManager.Instance:OnSavePlayerFileInfo()
end

function AvgStoryManager:IncreaseCallbackId()
  self.callBackId = self.callBackId + 1
  return self.callBackId
end

function AvgStoryManager:PlayStoryOnce(storyId, callback, tailCallback, options)
  local isPlayed = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG_ONCE, storyId)
  if isPlayed then
    if tailCallback then
      tailCallback()
    end
    if callback then
      callback()
    end
    return
  end
  ClientDataUtils.SetData(cd.ClientDataMainKey.AVG_ONCE, storyId, cd.NumberTrue)
  self:StartStoryById(storyId, nil, callback, tailCallback, options)
end

function AvgStoryManager:StartStoryById(storyId, chatId, callback, tailCallback, options)
  ArtCollectionController.Instance:CollecAvgTrigger(storyId)
  if options and options.isLoop then
    self._loopingStoryId = storyId
    self._loopStopped = nil
    local originalCallback = callback
    
    function callback(...)
      if originalCallback then
        originalCallback(...)
      end
      if self._loopStopped then
        self._loopStopped = nil
        self._loopingStoryId = nil
        self:SetCommentId(nil)
        return
      end
      self:StartStoryById(storyId, nil, originalCallback, tailCallback, options)
      local commentListPanel = UIManager.Instance:GetWindow(Urls.CommentListView)
      if commentListPanel and commentListPanel.ui and commentListPanel.ui.uiNode then
        commentListPanel.ui.uiNode.transform:SetAsLastSibling()
      end
    end
  end
  local callbackId = self:IncreaseCallbackId()
  self.storyEndCallback[callbackId] = {storyId, callback}
  self.storyTailCallback[callbackId] = {storyId, tailCallback}
  chatId = chatId or self:GetStartChatId(storyId)
  if not self:IsValid(storyId, chatId) then
    TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
      EventMgr.Instance.OnStoryEnd:Dispatch(storyId)
    end)
    return callbackId
  end
  local isBubbleDialog = self:IsAvgBubble(storyId, chatId)
  if isBubbleDialog then
    if not self:IsSkipPlot() then
      UIManager.Instance:Reopen(Urls.AvgBubblePanel, storyId, chatId)
    end
  else
    self:SaveRecoverStoryId(storyId)
    EventMgr.Instance.OnStoryStart:Dispatch(storyId)
    local loginPvStoryId = DT.GetConstant("LoginScreenPV")
    if self:IsSkipPlot() and loginPvStoryId ~= storyId then
      EventMgr.Instance.OnStoryEnd:Dispatch(storyId)
    else
      if AvgStoryManager.isIgnoreStory and CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor then
        TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
          EventMgr.Instance.OnStoryEnd:Dispatch(storyId)
        end)
        return
      end
      local delayTime = self:GetDelayTime(storyId, chatId)
      if delayTime then
        self.binder:BindTimer(delayTime, 0, nil, function()
          UIManager.Instance:Reopen(Urls.AvgDialogPanelNew, storyId, chatId, options)
          EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.EnterAvg, storyId)
        end)
      else
        UIManager.Instance:Reopen(Urls.AvgDialogPanelNew, storyId, chatId, options)
        EventMgr.Instance.GameEvent:Dispatch(CommonDefine.GameEvent.EnterAvg, storyId)
      end
      self:StartPlayTimeline(storyId, chatId, delayTime)
    end
  end
  return callbackId
end

function AvgStoryManager:ClearCallback(callbackId)
  self.storyEndCallback[callbackId] = nil
  self.storyTailCallback[callbackId] = nil
  self.storyRealPlayCallback[callbackId] = nil
end

function AvgStoryManager:WaitStoryStart(storyId, callback)
  local callbackId = self:IncreaseCallbackId()
  local avgDialogPanel = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
  if avgDialogPanel:GetIsRealPlay(storyId) then
    callback()
  else
    self.storyRealPlayCallback[callbackId] = {storyId, callback}
  end
  return callbackId
end

function AvgStoryManager:WaitStoryFinish(storyId, callback, priority)
  local callbackId = self:IncreaseCallbackId()
  if not self:IsPlaying() then
    callback()
    return callbackId
  end
  self.storyEndCallback[callbackId] = {
    storyId,
    callback,
    priority or 0
  }
  return callbackId
end

function AvgStoryManager:OnStoryRealStart(storyId)
  for callbackId, info in pairs(table.clone(self.storyRealPlayCallback)) do
    if info[1] == storyId then
      self.storyEndCallback[callbackId] = nil
      if info[2] then
        info[2]()
      end
    end
  end
end

function AvgStoryManager:SaveRecoverStoryId(storyId)
  if not DataCenter.playerData.DRole then
    return
  end
  local saveKey = CommonDefine.LocalSaveKey.RecoverStoryId
  MobileFileDataManager.Instance:SetPlayerFileValue(saveKey, storyId, true)
end

function AvgStoryManager:GetRecoverStoryId()
  do return MobileFileDataManager.Instance.GetPlayerFileValue, MobileFileDataManager.Instance end
  return MobileFileDataManager.Instance.GetPlayerFileValue, MobileFileDataManager.Instance, CommonDefine.LocalSaveKey.RecoverStoryId
end

function AvgStoryManager:IsAvgBubble(storyId, chatId)
  local dialogInfo = self:GetDialogInfo(storyId, chatId or self:GetStartChatId(storyId))
  local dialogType = dialogInfo and dialogInfo.DialogType
  return dialogType == CommonDefine.AvgDialogType.AvgBubble
end

function AvgStoryManager:IsPlaying()
  local avgPanel = UIManager.Instance:GetWindow(Urls.AvgDialogPanelNew)
  if avgPanel then
    return avgPanel.isPlaying
  end
end

function AvgStoryManager:IsValid(storyId, chatId)
  local dialogInfo = self:GetDialogInfo(storyId, chatId)
  return nil ~= dialogInfo
end

function AvgStoryManager:GetStartChatId(_)
  return 1
end

function AvgStoryManager:GetTagIndexMap(storyId)
  local dialogList = self:GetDialogInfoList(storyId)
  local map = self.allDialogTagMap[storyId]
  if not map then
    map = {}
    for chatIndex, dialogInfo in ipairs(dialogList) do
      if dialogInfo.ChatID then
        map[dialogInfo.ChatID] = chatIndex
      end
    end
    self.allDialogTagMap[storyId] = map
  end
  return map
end

function AvgStoryManager:GetChatIndexesByTags(storyId, tags)
  if not tags then
    return
  end
  local tagIndexMap = self:GetTagIndexMap(storyId)
  local chatIds = {}
  for _, tag in ipairs(tags) do
    local chatId = tagIndexMap[tag]
    if chatId then
      table.insert(chatIds, chatId)
    end
  end
  return chatIds
end

function AvgStoryManager:GetOptionChain(storyId)
  local dialogList = self:GetDialogInfoList(storyId)
  local optionChain = {}
  for chatId, chatInfo in pairs(dialogList or {}) do
    local optionChatIds = self:GetChatIndexesByTags(storyId, chatInfo.NextChatID) or {
      chatId + 1
    }
    local firstNextDialogInfo = self:GetDialogInfo(storyId, optionChatIds[1]) or {}
    if #optionChatIds > 1 or firstNextDialogInfo.DialogType == CommonDefine.AvgDialogType.OptionDialog then
      for _, optionId in ipairs(optionChatIds) do
        local chain = {}
        optionChain[optionId] = chain
        local curChatId = optionId
        local dialogInfo = dialogList[curChatId]
        while dialogInfo and (not dialogInfo.NextChatID or not (#dialogInfo.NextChatID > 1)) do
          local nextChatIds = self:GetChatIndexesByTags(dialogInfo.NextChatID)
          curChatId = nextChatIds and nextChatIds[1] or curChatId + 1
          table.insert(chain, curChatId)
          dialogInfo = dialogList[curChatId]
        end
      end
    end
  end
  return optionChain
end

function AvgStoryManager:StopStory()
  self:StopAvgBubble()
  if not self:IsPlaying() then
    return
  end
  local playerData = DataCenter.playerData.DRole
  if not playerData or playerData.name ~= "default" then
    AudioManager.Instance:PostSoundEvent("AVG_EXIT_AUDIO_UNICTRL")
  end
  EventMgr.Instance.ToHideStory:Dispatch()
end

function AvgStoryManager:StopAvgBubble()
  UIManager.Instance:CloseByUrl(Urls.AvgBubblePanel)
end

function AvgStoryManager:OnStoryEnd(storyId)
  self:SaveRecoverStoryId(nil)
  UIAudioManager.Instance:ResumePanelMusic()
  local callBackInfoList = {}
  for callbackId, endCallback in pairs(table.clone(self.storyEndCallback)) do
    local _storyId, _callback, _priority = endCallback[1], endCallback[2], endCallback[3] or 0
    if not _storyId or _storyId == storyId then
      self.storyEndCallback[callbackId] = nil
      table.insert(callBackInfoList, {priority = _priority, callback = _callback})
    end
  end
  table.sort(callBackInfoList, function(a, b)
    return a.priority > b.priority
  end)
  for _, info in ipairs(callBackInfoList) do
    if info.callback then
      info.callback()
    end
  end
end

function AvgStoryManager:OnStoryTail(storyId)
  for callbackId, info in pairs(table.clone(self.storyTailCallback)) do
    local _storyId, _callback = table.unpack(info)
    if _storyId == storyId then
      self.storyTailCallback[callbackId] = nil
      if _callback then
        _callback()
      end
    end
  end
end

function AvgStoryManager:SkipDialog()
  self:StopStory()
end

function AvgStoryManager:RegisterTempDialog(storyId, dialogCfg)
  self.tempDialogMap[storyId] = dialogCfg
end

function AvgStoryManager:UnregisterTempDialog(storyId)
  self.tempDialogMap[storyId] = nil
end

function AvgStoryManager:GetDialogInfoList(storyId)
  local dialogCfg = self.tempDialogMap[storyId] or DT.AvgDialog[storyId]
  assert(dialogCfg, "storyId: " .. storyId .. " not found")
  return dialogCfg.data_list
end

function AvgStoryManager:GetDialogInfo(storyId, chatId)
  local dialogInfoList = self:GetDialogInfoList(storyId)
  return dialogInfoList[chatId]
end

function AvgStoryManager:GetReadyVideoUrl(storyId, chatId)
  local dialogInfoList = self:GetDialogInfoList(storyId)
  local chatIdList = {}
  for tempChatId, _ in pairs(dialogInfoList or {}) do
    table.insert(chatIdList, tempChatId)
  end
  table.sort(chatIdList)
  local videoPattern = "%((.-%.mp4)"
  for i, nextChatId in ipairs(chatIdList) do
    if chatId < nextChatId then
      local dialogInfo = self:GetDialogInfo(storyId, nextChatId)
      local cmdStr = dialogInfo and dialogInfo.Sequence or ""
      local videoUrl = string.match(cmdStr, videoPattern)
      if videoUrl then
        return videoUrl
      end
      local bgIdStr = dialogInfo.BgID and dialogInfo.BgID[1] or ""
      if string.contains(bgIdStr, ".mp4") then
        return bgIdStr
      end
    end
  end
end

function AvgStoryManager:SetCommentId(commentId)
  self._commentId = commentId
end

function AvgStoryManager:GetCommentId()
  return self._commentId
end

function AvgStoryManager:IsLooping()
  return self._loopingStoryId ~= nil
end

function AvgStoryManager:StopLoop()
  if self._loopingStoryId then
    self._loopStopped = true
  end
end

function AvgStoryManager:OnDestroy()
  Super.OnDestroy(self)
end

return AvgStoryManager

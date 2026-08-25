local typeof = _ENV.typeof
local Camp1 = bc.BattleCamp.Camp1
local Camp2 = bc.BattleCamp.Camp2
local T_Z1VideoController = typeof(CS.Z1VideoController)
local List = CS.System.Collections.Generic.List
local GameObjectList = List(CS.UnityEngine.GameObject)
local AMPlayer = CS.AMTimeline.AMPlayer
AMPlayer.DisableSceneTrans = false
local BattleAwakerTimelinePlayer, Super = System.NewClass("BattleAwakerTimelinePlayer", TimelinePlayer)

function BattleAwakerTimelinePlayer:ctor(awaker)
  Super.ctor(self, awaker.rootNode)
  self.awaker = awaker
  self.timelineConfig = TimelineConfig()
end

function BattleAwakerTimelinePlayer:PlayTimeline(assetPath, gameSpeed, looping, onComplete, onEvent, abortSignal, onStarted, firstUid, nextBeHitUid)
  self.timelineConfig:Reset()
  self.extraFinishCB = nil
  self.isBattleSkillTimeline = false
  self.timelineConfig.assetPath = assetPath
  self.timelineConfig.direction = TimelineConfig.GetAwakerDirection(self.awaker)
  self.timelineConfig.looping = looping or 0
  
  function self.timelineConfig.onComplete()
    self.timeout = 0
    self:OnTimelineComplete()
    self:_ResetZ1VideoControllerAutoPlay()
    if self.extraFinishCB then
      self.extraFinishCB()
    end
    self:SpinShadowReset()
    if onComplete then
      onComplete()
    end
  end
  
  self.timelineConfig.abortSignal = abortSignal
  self.timelineConfig.aceTarget = bg.battleScene:GetSfxAttachmentPoint(self.awaker.role.camp)
  self.timelineConfig.playbackSpeed = gameSpeed or 1.0
  self.firstUid = firstUid
  self.nextBeHitUid = nextBeHitUid
  self.timelineHitTargets = nil
  self.timelineConfig.targets = self:GetEnemiesTargets(firstUid, nextBeHitUid)
  self.timelineConfig.onEvent = onEvent
  self.timelineConfig.seekTime = self.seekTime or 0
  self.timelineConfig.centerPosition = self.awaker:GetSkillCastPosition()
  self.timelineConfig.controlChildrenTargetIndex = bg.battleRender.recordMgr:GetControlChildrenIndex()
  
  function self.timelineConfig.onStarted()
    self:_InitEffectLightCompBySetting()
    if onStarted then
      onStarted()
    end
  end
  
  self.seekTime = 0
  print("========播放技能文件===========", assetPath)
  self:Play(self.timelineConfig)
  return self
end

function BattleAwakerTimelinePlayer:GetEnemiesSlashTargets(firstUid, nextBeHitUid)
  local enemyCamp = self.awaker.role.camp == Camp1 and Camp2 or Camp1
  local roleList = bg.battleScene:GetRoleListByCamp(enemyCamp)
  local targetList = {}
  local recordMgr = bg and bg.battleRender and bg.battleRender.recordMgr
  local beHitUidSet = {}
  local beHitUidOrder = {}
  if recordMgr and recordMgr.curPlayRecordList then
    for _, record in ipairs(recordMgr.curPlayRecordList) do
      if record then
        if record.eventId == BattleRenderEvent.ChangeRoleFsmState and record.data and record.data.newState == bc.AwakerFsmState.BeHit and record.data.uid then
          local uid = record.data.uid
          if not beHitUidSet[uid] then
            beHitUidSet[uid] = true
            table.insert(beHitUidOrder, uid)
          end
        end
        if record.eventId == BattleRenderEvent.BeHit and record.data and record.data.beHitConfig and record.data.beHitConfig.destRoleUid then
          local uid = record.data.beHitConfig.destRoleUid
          if not beHitUidSet[uid] then
            beHitUidSet[uid] = true
            table.insert(beHitUidOrder, uid)
          end
        end
      end
    end
  end
  if #beHitUidOrder > 0 then
    local uidToAwaker = {}
    for i = 1, #roleList do
      if not roleList[i]:IsHidden() then
        local awakerList = roleList[i]:GetAwakerList()
        if awakerList then
          for j = 1, #awakerList do
            local a = awakerList[j]
            if a and not a.dead and beHitUidSet[a.uid] then
              uidToAwaker[a.uid] = a
            end
          end
        end
      end
    end
    local orderedUids = {}
    if nil ~= firstUid and beHitUidSet[firstUid] then
      table.insert(orderedUids, firstUid)
    end
    for _, uid in ipairs(beHitUidOrder) do
      if uid ~= firstUid and beHitUidSet[uid] then
        table.insert(orderedUids, uid)
      end
    end
    for _, uid in ipairs(orderedUids) do
      local a = uidToAwaker[uid]
      if a then
        table.insert(targetList, a)
      end
    end
    self.timelineHitTargets = targetList
    return targetList
  end
  local isFindFirstUid = false
  if nil ~= firstUid then
    for i = 1, #roleList do
      if not roleList[i]:IsHidden() then
        local awakerList = roleList[i]:GetAwakerList()
        if awakerList then
          for j = 1, #awakerList do
            local a = awakerList[j]
            if a and not a.dead and a.uid == firstUid then
              isFindFirstUid = true
              table.insert(targetList, a)
              break
            end
          end
        end
      end
      if isFindFirstUid then
        break
      end
    end
  end
  if not isFindFirstUid and nil ~= nextBeHitUid then
    for i = 1, #roleList do
      if not roleList[i]:IsHidden() then
        local awakerList = roleList[i]:GetAwakerList()
        if awakerList then
          for j = 1, #awakerList do
            local a = awakerList[j]
            if a and not a.dead and a.uid == nextBeHitUid then
              table.insert(targetList, a)
              break
            end
          end
        end
      end
      if #targetList > 0 then
        break
      end
    end
  end
  self.timelineHitTargets = targetList
  return targetList
end

function BattleAwakerTimelinePlayer:GetTimelineSlashTargets(targetIndex)
  if not self.timelineHitTargets then
    self:GetEnemiesSlashTargets(self.firstUid, self.nextBeHitUid)
  end
  local idx = (targetIndex or 0) + 1
  local target = self.timelineHitTargets and self.timelineHitTargets[idx] or nil
  return target
end

function BattleAwakerTimelinePlayer:AddBindings()
  local bindings = self.awaker:GetBindings()
  for name, go in pairs(bindings) do
    self:AddBindingGameObject(name, go)
  end
end

function BattleAwakerTimelinePlayer:Stop()
  self.timeout = 0
  self:StopTimeoutTimer()
  Super.Stop(self)
end

function BattleAwakerTimelinePlayer:Dispose()
  self:StopTimeoutTimer()
  Super.Dispose(self)
  self.timelineVideoGos = nil
end

function BattleAwakerTimelinePlayer:SetTimeout(timeout)
  self.timeout = timeout
  self:StartTimeoutTimer()
end

function BattleAwakerTimelinePlayer:SpinShadowReset()
  if self.spinShadowReset then
    if self.spinShadowResetTimer then
      bg.battleRender:UnperformWithDelay(self.spinShadowResetTimer)
      self.spinShadowResetTimer = nil
    end
    CS.UnityEngine.Shader.SetGlobalFloat("AllAlpha", 0.6)
    self.spinShadowResetTimer = bg.battleRender:PerformWithDelay(0.01, function()
      CS.UnityEngine.Shader.SetGlobalFloat("AllAlpha", 0.6)
    end, self)
    self.spinShadowReset = false
  end
end

function BattleAwakerTimelinePlayer:OnTimelineComplete()
  self:StopTimeoutTimer()
end

function BattleAwakerTimelinePlayer:StartTimeoutTimer()
end

function BattleAwakerTimelinePlayer:StopTimeoutTimer()
  if self.timeoutTimer then
    TimerManager.Instance:StopTimer(self.timeoutTimer)
    self.timeoutTimer = nil
  end
end

function BattleAwakerTimelinePlayer:MoveToCenter(duration, onMovetoCenterFinished)
  if self.amPlayer then
    self.amPlayer.onMovetoCenterFinished = onMovetoCenterFinished
    self.amPlayer:MoveToCenter(duration)
  end
end

function BattleAwakerTimelinePlayer:GetEnemiesTargets(firstUid, nextBeHitUid)
  local enemyCamp = self.awaker.role.camp == Camp1 and Camp2 or Camp1
  local roleList = bg.battleScene:GetRoleListByCamp(enemyCamp)
  local targetList = {}
  local isFindFirstUid = false
  for i = 1, #roleList do
    if roleList[i]:IsHidden() then
    else
      local awakerList = roleList[i]:GetAwakerList()
      if awakerList then
        for j = 1, #awakerList do
          if not awakerList[j].dead then
            if awakerList[j].uid == firstUid then
              isFindFirstUid = true
              table.insert(targetList, 1, awakerList[j])
            else
              table.insert(targetList, awakerList[j])
            end
          end
        end
      end
    end
  end
  if not isFindFirstUid and nextBeHitUid then
    for i, awaker in ipairs(targetList) do
      if awaker.uid == nextBeHitUid then
        targetList[i], targetList[1] = targetList[1], targetList[i]
        break
      end
    end
  end
  self.timelineTargets = targetList
  local targets = GameObjectList()
  for _, target in ipairs(targetList) do
    local bindGo = target.rootNode
    if bindGo then
      targets:Add(bindGo)
    end
  end
  return targets
end

function BattleAwakerTimelinePlayer:GetTimelineTargets(targetIndex)
  local idx = (targetIndex or 0) + 1
  local target = self.timelineTargets and self.timelineTargets[idx] or nil
  return target
end

function BattleAwakerTimelinePlayer:OnTLEvent(eventId, eventParam, eventParam1)
  Super.OnTLEvent(self, eventId, eventParam)
  if eventId == rc.TimeLineEvent.SceneTransEvent then
    if AMPlayer.DisableSceneTrans then
      return
    end
    if bg.battleScene then
      self.extraFinishCB = bg.battleScene:EnterDimensionScene(eventParam)
    end
  elseif eventId == rc.TimeLineEvent.SceneControlEvent then
    if AMPlayer.DisableSceneTrans then
      return
    end
    if bg.battleScene then
      self.extraFinishCB = bg.battleScene:ChangeBattleScene(eventParam, eventParam1)
    end
  elseif eventId == rc.TimeLineEvent.ShowBattleScene then
    if bg.battleScene then
      bg.battleScene:ShowScene(true)
    end
  elseif eventId == rc.TimeLineEvent.HideBattleScene then
    if bg.battleScene then
      bg.battleScene:ShowScene(false)
    end
  elseif eventId == rc.TimeLineEvent.ShowDimensionVideo then
    if bg.battleScene then
      bg.battleScene:ShowDimensionVideo(true)
    end
  elseif eventId == rc.TimeLineEvent.HideDimensionVideo then
    if bg.battleScene then
      bg.battleScene:ShowDimensionVideo(false)
    end
  elseif eventId == rc.TimeLineEvent.StateUIVisibleEvent then
    self:BattleHideStateUI(eventParam, eventParam1)
  elseif eventId == rc.TimeLineEvent.SetAllAlpha then
    self:ResetAllAlpha()
  end
end

function BattleAwakerTimelinePlayer:ResetAllAlpha()
  self.spinShadowReset = true
end

function BattleAwakerTimelinePlayer:BattleHideStateUI(hideBlood, hideIntention)
  local bBloodVisible = "false" == hideBlood and true or false
  local bIntentionVisible = "false" == hideIntention and true or false
  local curTlPlayer = self.awaker
  local curPlayerCamp = curTlPlayer and curTlPlayer.role.camp or Camp2
  if curPlayerCamp == Camp1 then
    if not bg.battleScene then
      return
    end
    local roleList = bg.battleScene.roleList or {}
    for _, role in ipairs(roleList) do
      if role.camp == curPlayerCamp then
        if 1 == #role.awakerList then
          if role.statusUI then
            role.statusUI:SetActiveWithIntention(bBloodVisible)
          end
        else
          for _, awaker in ipairs(role.awakerList) do
            if awaker ~= curTlPlayer then
              local canShow = awaker.rootNode.activeSelf
              if role.statusUI then
                role.statusUI:SetActiveWithIntention(canShow)
              end
              break
            end
          end
        end
      end
    end
  elseif curTlPlayer.role and curTlPlayer.role.statusUI then
    curTlPlayer.role.statusUI:SetBloodActive(bBloodVisible)
    curTlPlayer.role.statusUI:SetIntentionActive(bIntentionVisible)
  end
end

function BattleAwakerTimelinePlayer:_InitEffectLightCompBySetting()
  if not self.amPlayer then
    return
  end
  local amObjects = self.amPlayer:GetAMObjects()
  for i = 0, amObjects.Count - 1 do
    local amObject = amObjects[i]
    if amObject.gameObject and amObject.resPath and #amObject.resPath > 0 then
      SettingManager:ResetParticleSystemLights(amObject.gameObject)
    end
    if amObject.gameObject and string.find(amObject.gameObject.name, "TimelineVideo") then
      self.timelineVideoGos = self.timelineVideoGos or {}
      table.insert(self.timelineVideoGos, amObject.gameObject)
    end
  end
end

function BattleAwakerTimelinePlayer:_ResetZ1VideoControllerAutoPlay()
  if self.timelineVideoGos then
    for _, v in pairs(self.timelineVideoGos) do
      if not IsNil(v) then
        local comp = v:GetComponent(T_Z1VideoController)
        if comp then
          comp.isAuto = false
        end
      end
    end
    table.clear(self.timelineVideoGos)
  end
end

return BattleAwakerTimelinePlayer

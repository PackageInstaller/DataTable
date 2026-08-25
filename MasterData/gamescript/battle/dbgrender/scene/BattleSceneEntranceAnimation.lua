local List = CS.System.Collections.Generic.List
local GameObjectList = List(CS.UnityEngine.GameObject)
local BattleSceneEntranceAnimation = System.NewClass("BattleSceneEntranceAnimation")

function BattleSceneEntranceAnimation.GetAnimationPath()
  local timelinePath, awaker = BattleSceneEntranceAnimation.GetAwakerTimelinePath()
  if timelinePath then
    return timelinePath, awaker
  end
  if bg.isPVP then
    return nil
  end
  return CommonRes.TimelinePrepared.Common_In_Battle, awaker
end

function BattleSceneEntranceAnimation.GetAwakerTimelinePath()
  local battleTid = bg.battleScene.battleId
  local battleCfg = DT.BattleConfig[battleTid]
  local timelinePath = battleCfg.StartTimeline
  local awaker
  if timelinePath and string.find(timelinePath, "TimelineRoot/Skill/") then
    awaker = BattleSceneEntranceAnimation.GetTimelineAwaker(timelinePath)
  end
  return timelinePath, awaker
end

function BattleSceneEntranceAnimation.GetTimelineAwaker(timelinePath)
  if timelinePath and string.find(timelinePath, "TimelineRoot/Skill/") then
    local roleDataModelMap = bg.battleDataCenter.roleDataModelMap
    for k, v in pairs(roleDataModelMap) do
      if v.configData then
        local animationConfig = AwakerDataUtils.GetAwakerAnimationConfig(v.roleType, v.tid)
        local spineName = PathStrUtils.GetBaseName(animationConfig.spineName)
        local timelineData = DT.TimelineEventData[spineName]
        if not (timelineData and timelineData.MarchIn) or timelineData.MarchIn.file ~= timelinePath then
        else
          local awaker = bg.battleScene:GetAwakerByUid(v.uid)
          if awaker then
            return awaker
          end
        end
      end
    end
  end
end

function BattleSceneEntranceAnimation:ctor()
end

function BattleSceneEntranceAnimation:GetFriendAwakers(awaker)
  if not awaker then
    return
  end
  local awakers
  local roleList = bg.battleScene:GetRoleListByCamp(awaker.role.camp)
  for i = 1, #roleList do
    local awakerList = roleList[i]:GetAwakerList()
    if awakerList then
      for j = 1, #awakerList do
        if awaker ~= awakerList[j] then
          awakers = awakers or {}
          table.insert(awakers, awakerList[j])
        end
      end
    end
  end
  return awakers
end

function BattleSceneEntranceAnimation:GetFriendTargets(awaker)
  if not awaker then
    return
  end
  local roleList = bg.battleScene:GetRoleListByCamp(awaker.role.camp)
  local targets = GameObjectList()
  for i = 1, #roleList do
    local awakerList = roleList[i]:GetAwakerList()
    if awakerList then
      for j = 1, #awakerList do
        if awaker ~= awakerList[j] then
          targets:Add(awakerList[j].rootNode)
        end
      end
    end
  end
  return targets
end

function BattleSceneEntranceAnimation:GetTimelineDura(timelinePath)
  if not timelinePath then
    return 0
  end
  local defaultDura = 3
  local pathes = string.split(timelinePath, "/")
  local fileNameEx = pathes[#pathes]
  local fileName = string.replace(fileNameEx, ".prefab", "", true)
  local pattern = "(.-)_(%a+)$"
  local base, action = string.match(fileName, pattern)
  local timelineCfg = bg.DT.TimelineEventData[base]
  if timelineCfg and timelineCfg[action] then
    return timelineCfg[action].duration
  end
  return defaultDura
end

function BattleSceneEntranceAnimation:StartAnimation(callback)
  local startAnimationTag = "StartAnimation"
  local stageComp = WorldStageManager.Instance:GetCurStageComp()
  if stageComp and stageComp.map then
    stageComp.map:Hide()
  end
  local animationPath, awaker = BattleSceneEntranceAnimation.GetAnimationPath()
  local timelineDura = self:GetTimelineDura(animationPath)
  local direction = 0
  self.animationPath = animationPath
  if awaker then
    self.player = awaker.rootNode
    direction = TimelineConfig.GetAwakerDirection(awaker)
    awaker:StopTimeline()
  else
    self.tempPlayer = CS.UnityEngine.GameObject("BattleSceneEntranceAnimation")
    self.player = self.tempPlayer
  end
  
  local function onStarted()
    self:HidewBlackScreenGo()
    self:PlayMonsterArrivedSound()
  end
  
  local isRunCompleteCb = false
  local isPlayIdle = false
  
  local function onComplete()
    if isRunCompleteCb then
      return
    end
    isRunCompleteCb = true
    if self.isDestroyed then
      return
    end
    if awaker and bg.battleScene then
      bg.battleScene:BattleHideEnemy(false)
      bg.battleScene:BattleHideFriend(false)
      bg.battleScene:SetCurTimelinePlayer(nil)
    end
    if self.timelinePlayer then
      self.timelinePlayer:Stop()
    end
    if not isPlayIdle and awaker then
      isPlayIdle = true
      awaker:TryPlayIdle()
    end
    self:UpdateRootHpAndRootIntentionPosition()
    local targets = self:GetFriendAwakers(awaker)
    if targets then
      for i = 1, #targets do
        targets[i]:TryPlayIdle()
      end
    end
    if callback then
      callback()
    end
    bg.battleRender:PopPerformQueue(startAnimationTag)
  end
  
  local function timelineFunc()
    self:ShowBlackScreenGo()
    self.timelinePlayer = TimelinePlayer(self.player)
    local timelineConfig = TimelineConfig()
    timelineConfig.assetPath = self.animationPath
    timelineConfig.direction = direction
    timelineConfig.onStarted = onStarted
    timelineConfig.onComplete = onComplete
    timelineConfig.useSmoothTime = bg.isPVP
    timelineConfig.targets = self:GetFriendTargets(awaker)
    local delayTime = 0.01
    if bg.isReplay then
      delayTime = 1
    end
    self._schedulerId = bg.battleRender:PerformWithDelay(delayTime, function()
      self._schedulerId = nil
      if awaker then
        awaker:StopTimeline()
        if bg.battleScene then
          bg.battleScene:SetCurTimelinePlayer(awaker)
        end
      end
      if self.timelinePlayer then
        self.timelinePlayer:Play(timelineConfig)
      end
      bg.battleRender:PerformWithDelay(timelineDura + 3, function()
        onComplete()
      end, self)
    end, self)
  end
  
  if WorldRecoveryManager.Instance:IsRecovery() == false then
    local isBlock = true
    bg.battleRender:Push2Queue_RunInThisFrameData(function()
      local tid = bg.battleRender.battleTid
      EventMgr.Instance.GuideBattleEvent:Dispatch(CommonDefine.GuideBattle.Begin, {tid})
    end, "Check_AVG_Timeline", isBlock)
  end
  bg.battleRender:Push2Queue_RunInThisFrameData(function()
    if not animationPath then
      onStarted()
      onComplete()
      return
    end
    if bg.isPVP then
      timelineFunc()
    elseif self.SkipEntranceAni.value then
      onStarted()
      onComplete()
    elseif self.StopEntranceAni == nil then
      timelineFunc()
    else
      self.binder:BindToRaw(function(_, finish, _)
        if finish then
          onStarted()
          onComplete()
        end
      end, function()
        return self.StopEntranceAni.value and self.StoryEnd.value
      end)
    end
  end, startAnimationTag)
end

function BattleSceneEntranceAnimation:OnStopEntranceAni()
  self.StopEntranceAni = Vue.ref(true)
end

function BattleSceneEntranceAnimation:OnStoryEnd()
  self.StoryEnd.value = true
end

function BattleSceneEntranceAnimation:OnSkipEntranceAni()
  self.SkipEntranceAni.value = true
end

function BattleSceneEntranceAnimation:Awake()
  self.binder = Vue.newBinder(self)
  self.binder:BindEvent(EventMgr.Instance.OnStoryEnd, System.fn(self, self.OnStoryEnd))
  self.binder:BindEvent(EventMgr.Instance.StopEntranceAniEvent, System.fn(self, self.OnStopEntranceAni))
  self.binder:BindEvent(EventMgr.Instance.SkipEntranceAniEvent, System.fn(self, self.OnSkipEntranceAni))
  self.StoryEnd = Vue.ref(false)
  self.SkipEntranceAni = Vue.ref(false)
end

function BattleSceneEntranceAnimation:Dispose()
  self.binder:teardown()
  if self._schedulerId then
    bg.battleRender:UnperformWithDelay(self._schedulerId)
    self._schedulerId = nil
  end
  if bg.battleScene and bg.battleScene.curTimelinePlayer then
    bg.battleScene:BattleHideEnemy(false)
    bg.battleScene:BattleHideFriend(false)
    bg.battleScene:SetCurTimelinePlayer(nil)
  end
  self.isDestroyed = true
  if self.timelinePlayer then
    local timelinePlayer = self.timelinePlayer
    self.timelinePlayer = nil
    timelinePlayer:Stop()
  end
  if self.tempPlayer then
    CS.UnityEngine.GameObject.Destroy(self.tempPlayer)
    self.tempPlayer = nil
  end
  if self.animationPath then
    self.animationPath = nil
  end
  if self.blackScreenGo then
    CS.UnityEngine.GameObject.Destroy(self.blackScreenGo)
    self.blackScreenGo = nil
  end
  ResLoadMgr.UnloadAssetByTarget(self)
end

function BattleSceneEntranceAnimation:PlayMonsterArrivedSound()
  local battleScene = bg.battleScene
  local roleList = battleScene and battleScene.roleList or nil
  if not roleList then
    return
  end
  for k, v in pairs(roleList) do
    local awakerList = v.awakerList
    for k1, v1 in pairs(awakerList) do
      if v1.isMonster then
        v1:PlayMonsterArriveAudio(0)
      end
    end
  end
end

function BattleSceneEntranceAnimation:UpdateRootHpAndRootIntentionPosition()
  local battleScene = bg.battleScene
  if battleScene then
    battleScene:UpdateRootHpAndRootIntentionPosition()
  end
end

function BattleSceneEntranceAnimation:ShowBlackScreenGo()
  BattlePerformanceUtil.ShowBlackScreenGo()
end

function BattleSceneEntranceAnimation:HidewBlackScreenGo()
  if bg.GetIsDelayHideBlack() and bg.battleRender then
    bg.SetIsDelayHideBlack(false)
    bg.battleRender:PerformWithDelay(0.5, function()
      BattlePerformanceUtil.CloseBlackScreenGo()
    end)
    return
  end
  BattlePerformanceUtil.CloseBlackScreenGo()
end

return BattleSceneEntranceAnimation

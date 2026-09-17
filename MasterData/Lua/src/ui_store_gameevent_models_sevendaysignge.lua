local this = class("sevenDaySignGE", L_GameEventStore.baseGameEventCls)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
local C_NetManager = CS.Azur.Gameplay.Core.Net.NetManager

function this:ctor(eventId, type, data)
  this.super.ctor(self, eventId, type, data)
  self:listenCallFunc()
  self.logicDeltaTime = 0
  L_TimerManager:newOrResetTimer(self, "delayAutoOpenPageActivitySevenDaySign", function()
    self:OnTimerDelayAutoOpenPageActivitySevenDaySign()
  end, 1, -1)
end

function this:listenCallFunc()
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.onSystemUnlock, self)
  L_GameStore:listenCallFunc(L_GameStore.event.enterGame, self.onEnterGame, self)
  self:registerConditionGroup()
end

function this:dispose()
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_GameStore:unListenCallFunc(L_GameStore.event.enterGame, self.onEnterGame, self)
  self:unregisterConditionGroup()
  self:resetCachedOpenFlag()
  L_TimerManager:clearTimer(self)
end

function this:registerConditionGroup()
  local gameEventTpl = _GameEventTpl:getTplById(self.id)
  if gameEventTpl == nil then
    return
  end
  local conditionGroup = _GameEventTpl:getCondition(gameEventTpl)
  if conditionGroup == nil then
    return
  end
  self.unlockConditionGroupNode = L_ConditionManager:registGroup("sevenDaySignGEUnlockConditionGroup", conditionGroup, self.onConditionUnlock, self)
end

function this:unregisterConditionGroup()
  L_ConditionManager:unRegist(self.unlockConditionGroupNode, "sevenDaySignGEUnlockConditionGroup")
end

function this:initData()
  self.data = self.data
  self.data.count = 0
  self.data.lastSignTime = nil
  self.data.rewardCount = 0
  self.hasSyncEventData = false
  self:resetCachedOpenFlag()
end

function this:populate(protoData)
  local data = protoData.daily_sign
  self.data.count = data.count or self.data.count
  self.data.lastSignTime = data.time or self.data.lastSignTime
  self.data.rewardCount = data.reward_count or self.data.rewardCount
  self.hasSyncEventData = true
  self:onPopulateGameEventDataTryAutoOpenPage()
end

function this:req_activityDailySign(callback)
  local signDay = self.data.count
  if signDay > self.data.rewardCount then
    if signDay == 2 then
      L_GameUtil.LogClientADEvent("retention_d2")
    elseif signDay == 7 then
      L_GameUtil.LogClientADEvent("retention_d7")
    end
  end
  L_Net:sendMessage(MsgGenCode.CSProtoActivityDailySign, {
    u32 = self.id
  }, function(rsp_data, errorCode)
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      return
    end
    if callback then
      callback(rsp_data)
    end
  end)
end

function this:sortActivityDailySignReward(rsp_data, clientSortRwdList)
  if table.isEmpty(rsp_data) or table.isEmpty(rsp_data.rewards) then
    return
  end
  rsp_data.rewards = L_DataUtil.parseRewardConfig(rsp_data.rewards, true, true, nil, true)
end

function this:resetCachedOpenFlag()
  self.cachedDelayTryFlag = false
  self.cachedOpenFlagOfNotEnterGame = false
  self.cachedOpenFlagOfLoadingWorld = false
  self.cachedOpenFlagOfNotInMainCityUI = false
  self.cachedOpenFlagOfInBattle = false
  self.cachedOpenFlagOfErrorWorldProxy = false
  self.cachedOpenFlagOfInPlayable = false
  self.cachedOpenFlagOfInGuide = false
  self.cachedOpenFlagOfRestoreUI = false
  self.cachedOpenFlagOfPage = false
  self.cachedOpenFlagOfStory = false
  self.cachedOpenFlagOfCameraBusy = false
  self.cachedOpenFlagOfPriorityQueueNotEmpty = false
end

function this:onSystemUnlock(systemId, isOpen)
  if systemId ~= L_SystemConst.enum.gameAct then
    return
  end
  if isOpen == false then
    return
  end
  self.cachedDelayTryFlag = true
end

function this:onEnterGame()
  self.cachedDelayTryFlag = true
end

function this:onPopulateGameEventDataTryAutoOpenPage()
  self.cachedDelayTryFlag = true
end

function this:onConditionUnlock()
  self.cachedDelayTryFlag = true
end

function this:tryAutoOpenPageActivitySevenDaySign(logSource)
  C_MJLog.LogInfo(logSource, C_ELogModule.Home)
  if self:checkIfCanReceiveReward() == false then
    return
  end
  if AzurWorld.ActivityManager:OnGetIsCloseAutomaticPushWindowState() == true then
    return
  end
  C_MJLog.LogInfo("[签到活动自动打开] 有未领取奖励，尝试打开活动界面", C_ELogModule.Home)
  if not L_GameStore:isEntered() or C_NetManager.GameConnectStatus ~= C_EGameConnectStatus.InGame then
    self.cachedOpenFlagOfNotEnterGame = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，游戏没进去", C_ELogModule.Home)
    return
  end
  if self:checkIfIsLoadingWorldScene() then
    self.cachedOpenFlagOfLoadingWorld = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，加载场景中", C_ELogModule.Home)
    return
  end
  if L_UI:currentPage(L_UI.groupKeys.stack) ~= "pageMainCity" and L_UI:currentPage(L_UI.groupKeys.stack) ~= "pageActivityNDaySign" then
    self.cachedOpenFlagOfNotInMainCityUI = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，非主界面", C_ELogModule.Home)
    return
  end
  if C_BattleManager.IsInBattle(C_EntityManager.MainPlayer) then
    self.cachedOpenFlagOfInBattle = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，战斗中", C_ELogModule.Home)
    return
  end
  if AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.World and AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.Home and AzurWorld.proxyCenter.curProxy.proxyType ~= C_EWorldType.HomeDorm then
    self.cachedOpenFlagOfErrorWorldProxy = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，场景非大世界或家园", C_ELogModule.Home)
    return
  end
  if AzurWorld.PlayableUnitMgr.runningPlayableIds.Count > 0 then
    self.cachedOpenFlagOfInPlayable = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，playable玩法中", C_ELogModule.Home)
    return
  end
  if L_GuideManager:isGuideOnRunning() then
    self.cachedOpenFlagOfInGuide = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，引导中", C_ELogModule.Home)
    return
  end
  if c_UIRestore.HasRestoreUI() then
    self.cachedOpenFlagOfRestoreUI = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，有需要还原的UI", C_ELogModule.Home)
    return
  end
  if L_UI:getPageStatus("pageDungeonEntrustEntrance") == L_UI.pageStatus.opening then
    self.cachedOpenFlagOfPage = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，委托界面开启时不打开", C_ELogModule.Home)
    return
  end
  if AzurWorld.StoryMgr.IsPlaying then
    self.cachedOpenFlagOfStory = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发外部限制，剧情播放时不打开", C_ELogModule.Home)
    return
  end
  if C_MonthCardStore.GetHasMonthCard() and not C_MonthCardStore.GetHasOpenedMonthCardPage() then
    self.cachedOpenFlagOfStory = true
    C_MJLog.LogInfo("[签到活动自动打开] 触发月卡限制，剧情播放时不打开", C_ELogModule.Home)
    return
  end
  if C_CameraManager.IsCameraBusy() then
    self.cachedOpenFlagOfCameraBusy = true
    C_MJLog.LogInfo("[签到活动自动打开] 相机被其他业务占用 暂时不打开", C_ELogModule.Home)
    return
  end
  if not C_UIMgr.CheckPriorityQueueClean() then
    self.cachedOpenFlagOfPriorityQueueNotEmpty = true
    C_MJLog.LogInfo("[签到活动自动打开] 弹窗队列里还有窗口未弹出，不能打开", C_ELogModule.Home)
    return
  end
  local keyString = self:getLastSignTimeStampkey()
  local timeNow = L_TimeUtil.getServerTime()
  C_PlayerPrefsUtility.SetInt(keyString, timeNow)
  if L_UI:getPage("pageActivityNDaySign") == nil then
    C_MJLog.LogInfo("[签到活动自动打开] 自动打开检测成功，准备开启界面", C_ELogModule.Home)
    L_UI:open("pageActivityNDaySign", {
      gameEventType = L_Const.ActivityType.AT_DAILY_SIGN
    })
  end
  if AzurWorld.popperPartyMgr:HasWorldShowKickNotify() then
    AzurWorld.popperPartyMgr:ShowKickTip()
  end
  self:resetCachedOpenFlag()
end

function this:OnTimerDelayAutoOpenPageActivitySevenDaySign()
  if self.cachedDelayTryFlag == false and self.cachedOpenFlagOfNotEnterGame == false and self.cachedOpenFlagOfLoadingWorld == false and self.cachedOpenFlagOfNotInMainCityUI == false and self.cachedOpenFlagOfInBattle == false and self.cachedOpenFlagOfErrorWorldProxy == false and self.cachedOpenFlagOfInPlayable == false and self.cachedOpenFlagOfInGuide == false and self.cachedOpenFlagOfRestoreUI == false and self.cachedOpenFlagOfPage == false and AzurWorld.popperPartyMgr:HasWorldShowKickNotify() == false and self.cachedOpenFlagOfStory == false and self.cachedOpenFlagOfCameraBusy == false and self.cachedOpenFlagOfPriorityQueueNotEmpty == false then
    self.logicDeltaTime = 0
    return
  end
  self.logicDeltaTime = self.logicDeltaTime + 1
  if self.logicDeltaTime <= 3 then
    return
  end
  self:tryAutoOpenPageActivitySevenDaySign()
  self.cachedDelayTryFlag = false
  self.logicDeltaTime = 0
end

function this:checkIfDeltaTimeOverOneDay()
  local timeNow = L_TimeUtil.getServerTime()
  local keyString = self:getLastSignTimeStampkey()
  local lastOpenTime = C_PlayerPrefsUtility.GetInt(keyString)
  return not L_TimeUtil.isSameDay(timeNow, lastOpenTime)
end

function this:checkIfCanReceiveReward()
  if not self.data:isShow() or not self.hasSyncEventData then
    return false
  end
  if self.data.rewardCount >= self.data.count then
    return false
  end
  return true
end

function this:checkRedDot()
  return self.data.count > self.data.rewardCount
end

function this:checkIfIsLoadingWorldScene()
  return C_WorldSource.isLoadReady == false or C_GameFlow.inLoading
end

function this:getLastSignTimeStampkey()
  return string.format("sevenDaySignAutoOpen_%d_%d", self.id, L_PlayerStore:getPlayerId() or -1)
end

function this:getData()
  return self.data
end

return this

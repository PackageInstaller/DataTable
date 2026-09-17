local this = class("moduleMainCityBtnFunc", G_UIModuleBase)
local _systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()
local _enemyTpl = L_GameTpl:getEnemyTpl()

function this.bind()
  return {
    go_btnExitDungeon = false,
    go_btnOpenMenu = true,
    go_btnControllerRoulette = false,
    go_home = true,
    go_exitHome = false,
    go_exitHomeDorm = false,
    go_topRight = true,
    go_topLeft = true
  }
end

function this.methods()
  return {
    onClick_gameAct = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.gameAct)
    end,
    onClick_activity = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.activation)
    end,
    onClick_gacha = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.gacha)
    end,
    onClick_hero = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.hero)
    end,
    onClick_pet = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.pet)
    end,
    onClick_btnHome = function(self)
      C_HomeUtil.SwitchInOutHome()
    end,
    onClick_btnExitHome = function()
      C_HomeUtil.SwitchInOutHome()
    end,
    onClick_btnExitDorm = function()
      C_HomeUtil.SwitchInOutHome()
    end,
    onClick_noviceTask = function(self)
      if AzurWorld.JourneyMgr:AllRewardAndBottomRewardComplete() then
        return
      end
      L_UI:open("pageStarJourney")
    end,
    onClick_menu = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.mainMenu)
    end,
    onClick_exitDungeon = function(self)
      if L_WorldManager:getCurModule() == L_Const.worldModule.rogue then
        L_UI:open("pageRogueMap")
      else
        AzurWorld.DungeonMgr:ExitDungeon(true)
      end
    end,
    onClick_tutorial = function(self)
      L_UI:open("pageTutorial")
    end,
    onClick_task = function(self)
      L_SystemBreakManager:jumpTo(L_SystemConst.enum.task)
    end,
    onClick_battlePass = function(self)
      if not C_IntegrateMgr.SystemUnlockModule:CheckAndTip(L_SystemConst.enum.battlePass) then
        return
      end
      L_UI:open("pageBattlePassMain")
    end,
    onClick_entrustTask = function(self)
      L_UI:open("pageDungeonEntrustEntrance")
    end
  }
end

function this:open()
  self.systemUnlockHandleId = C_IntegrateMgr.SystemUnlockModule:listenCallFunc(C_IntegrateMgr.SystemUnlockModule.updateSystem, self.onEvent_updateSystem, self)
  L_NoviceTaskStore:listenCallFunc(L_NoviceTaskStore.event.refreshNoviceTask, self.onEvent_refreshNoviceTask, self)
  self._onCutWorldComplete = handler(self, self.onEvent_switchSceneEnd)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_BattleManager:addListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
  L_BattleManager:addListener(L_BattleManager.event.exitBattle, self.onEvent_exitBattle, self)
  self._onBattlePassFullSyncHandle = handler(self, self.onBattlePassFullSync)
  C_BattlePassStoreEvent.instance:Listen(C_EBattlePassStoreEvent.FullInfoSync, self._onBattlePassFullSyncHandle)
  self._onControlSchemeChangeHandle = handler(self, self.onControlSchemeChange)
  C_ExternalManager.AddEvent(C_EExternalEventType.ControlSchemeChange, self._onControlSchemeChangeHandle)
  self.onEvent_journeyTaskUpdate = handler(self, self.onJourneyTaskUpdate)
  AzurWorld.JourneyMgr:RegisterEvent(C_EJourneyEvent.UpdateJourneyTaskServerData, self.onEvent_journeyTaskUpdate)
  self.lockedSystem = self.lockedSystem or {
    [L_SystemConst.enum.activation] = {},
    [L_SystemConst.enum.gameAct] = {},
    [L_SystemConst.enum.mainMenu] = {},
    [L_SystemConst.enum.tutorial] = {},
    [L_SystemConst.enum.home] = {},
    [L_SystemConst.enum.journeyTask] = {},
    [L_SystemConst.enum.battlePass] = {},
    [L_SystemConst.enum.entrustTask] = {},
    [L_SystemConst.enum.gacha] = {}
  }
  self:checkIsInDungeon()
  self:checkIsInHome()
  self:checkControllerRoulette()
  self:initRedDot()
  self:initSystem()
  self:bindPcKey()
end

function this:show()
  if self.reddotMap == nil then
    return
  end
  if AzurWorld.RedDotMgr and self.bindComponents.gameActDot then
    AzurWorld.RedDotMgr:BindRedDotRenderer("GameAct", self.bindComponents.gameActDot.gameObject)
    AzurWorld.RedDotMgr:MarkDirty("GameAct")
  end
  for key, go in pairs(self.reddotMap) do
    L_ReddotManager:setDirty(key, true)
  end
end

function this:checkIsInDungeon()
  local isInDungeon = AzurWorld.DungeonMgr:CheckIsDungeonScene()
  self.bind.go_btnExitDungeon = isInDungeon
  self.bind.go_btnOpenMenu = not isInDungeon
  self.lockedSystem[L_SystemConst.enum.mainMenu].inDungeon = isInDungeon or nil
  self.bind.go_topLeft = not isInDungeon
  self.bind.go_topRight = not isInDungeon
end

function this:checkIsInHome()
  local isInHome = C_HomeUtil.IsInHome()
  self.bind.go_home = not isInHome
  self.bind.go_exitHome = isInHome
  self:checkInHomeDorm()
end

function this:initSystem()
  self.specialSystemId = self.specialSystemId or {
    L_SystemConst.enum.journeyTask,
    L_SystemConst.enum.battlePass,
    L_SystemConst.enum.activation,
    L_SystemConst.enum.gameAct,
    L_SystemConst.enum.entrustTask,
    L_SystemConst.enum.gacha
  }
  self.bossBattleLockSystem = self.bossBattleLockSystem or {
    L_SystemConst.enum.activation,
    L_SystemConst.enum.gameAct,
    L_SystemConst.enum.entrustTask,
    L_SystemConst.enum.battlePass,
    L_SystemConst.enum.gacha
  }
  if not self.cacheSpecialSystemCheck then
    self.cacheIsSpecialSystem = {}
    for _, systemId in pairs(self.specialSystemId) do
      self.cacheIsSpecialSystem[systemId] = true
    end
  end
  local allSystem = {
    [L_SystemConst.enum.hero] = {
      self.bindComponents.transHero
    },
    [L_SystemConst.enum.pet] = {
      self.bindComponents.transPet
    },
    [L_SystemConst.enum.activation] = {
      self.bindComponents.transActivity
    },
    [L_SystemConst.enum.gameAct] = {
      self.bindComponents.transGameAct
    },
    [L_SystemConst.enum.gacha] = {
      self.bindComponents.transGacha
    },
    [L_SystemConst.enum.mainMenu] = {
      self.bindComponents.transMenu
    },
    [L_SystemConst.enum.tutorial] = {
      self.bindComponents.transBtnTutorial
    },
    [L_SystemConst.enum.home] = {
      self.bindComponents.transBtnHome
    },
    [L_SystemConst.enum.battlePass] = {
      self.bindComponents.transBattlePass
    },
    [L_SystemConst.enum.entrustTask] = {
      self.bindComponents.transEntrustTask
    }
  }
  for i, v in pairs(allSystem) do
    for _, rectTrans in pairs(v) do
      rectTrans.gameObject:ActiveTrans(false)
    end
  end
  if self.systemToTrans then
    self:destroyAllLocker()
  end
  self.systemToTrans = AzurWorld.DungeonMgr:CheckIsInTeaching() and {
    [L_SystemConst.enum.hero] = {
      self.bindComponents.transHero
    },
    [L_SystemConst.enum.pet] = {
      self.bindComponents.transPet
    }
  } or allSystem
  for systemId, v in pairs(self.systemToTrans) do
    local isUnlocked = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(systemId)
    local tpl = _systemUnlockTpl:getTplById(systemId)
    local shouldShow = tpl and _systemUnlockTpl:getButtonShow(tpl)
    if self:isSystemLockedByAny(systemId) then
    elseif isUnlocked or shouldShow then
      for _, rectTrans in pairs(v) do
        rectTrans.gameObject:ActiveTrans(true)
      end
    else
      v.locker = v.locker or C_IntegrateMgr.SystemUnlockModule:TryGenerateLocker(systemId)
      if v.locker then
        self:refreshSystem(systemId, false)
        v.locker:setCallback(self.refreshSystem, self, self.gameObject)
      end
    end
  end
  for _, systemId in pairs(self.specialSystemId) do
    self:refreshSpecialSystem(systemId)
  end
  self:updateTopRightFrameSize()
  self:onJourneyTaskUpdate()
end

function this:isSystemLockedByAny(systemId)
  local t = self.lockedSystem[systemId]
  return t and next(t)
end

function this:initRedDot()
  self.reddotMap = {
    [L_ReddotManager.DotDef.Activity] = self.bindComponents.activityDot,
    [L_ReddotManager.DotDef.Hero] = self.bindComponents.heroDot,
    [L_ReddotManager.DotDef.Pet] = self.bindComponents.petDot,
    [L_ReddotManager.DotDef.Menu] = self.bindComponents.menuDot,
    [L_ReddotManager.DotDef.JourneyTask] = self.bindComponents.noviceTaskDot,
    [L_ReddotManager.DotDef.JourneyTaskNew] = self.bindComponents.noviceNewTaskDot,
    [L_ReddotManager.DotDef.BattlePassLua] = self.bindComponents.battlePassDot,
    [L_ReddotManager.DotDef.Gacha] = self.bindComponents.gachaDot,
    [L_ReddotManager.DotDef.EntrustTaskEnter] = self.bindComponents.entrustTaskDot
  }
  for key, go in pairs(self.reddotMap) do
    L_ReddotManager:registerReddot(go, key)
  end
end

function this:bindPcKey()
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.gameAct, L_Const.AnchorType.Center, self.bindComponents.transKeyActivityMain, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.OpenGacha, L_Const.AnchorType.Center, self.bindComponents.transKeyGacha, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openBattlePass, L_Const.AnchorType.Center, self.bindComponents.transKeyBattlePass, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.OpenEntrustTask, L_Const.AnchorType.Center, self.bindComponents.transKeyEntrustTask, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openActivity, L_Const.AnchorType.Center, self.bindComponents.transKeyActivity, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openPet, L_Const.AnchorType.Center, self.bindComponents.transKeyPet, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openHero, L_Const.AnchorType.Center, self.bindComponents.transKeyHero, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.tutorial, L_Const.AnchorType.Center, self.bindComponents.transKeyTutorial, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openHome, L_Const.AnchorType.Center, self.bindComponents.transKeyHome, L_Vector3.new(0, 0, 0))
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openNoviceTask, L_Const.AnchorType.Center, self.bindComponents.transKeyNoviceTask, L_Vector3.new(0, 0, 0))
  if AzurWorld.DungeonMgr:CheckIsDungeonScene() then
    L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openMenu, L_Const.AnchorType.Bottom, self.bindComponents.transExitDungeon)
  else
    L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openMenu, L_Const.AnchorType.Center, self.bindComponents.transKeyMenu, L_Vector3.new(0, 0, 0))
  end
  L_ShortCutManager:addShortKeyFlag(self, L_Const.settingType.openTask, L_Const.AnchorType.Center, self.bindComponents.transKeyTask, L_Vector3.new(0, 0, 0))
end

function this:onEvent_updateSystem(systemId)
  self:refreshSpecialSystem(systemId)
end

function this:onEventJourneyTaskAllExecuteOver(type, argList)
  self:refreshSpecialSystem(L_SystemConst.enum.journeyTask)
end

function this:onBattlePassFullSync()
  self:refreshSpecialSystem(L_SystemConst.enum.battlePass)
end

function this:onEvent_refreshNoviceTask()
end

function this:onEvent_switchSceneEnd()
  self:checkIsInDungeon()
  self:checkIsInHome()
  self:checkControllerRoulette()
  self:initSystem()
end

function this:close()
  self:destroyAllLocker()
  L_ShortCutManager:clearShortKeyFlag(self)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_NoviceTaskStore:unListenCallFunc(L_NoviceTaskStore.event.refreshNoviceTask, self.onEvent_refreshNoviceTask, self)
  C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_BattleManager:removeListener(L_BattleManager.event.battleStart, self.onEvent_battleStart, self)
  L_BattleManager:removeListener(L_BattleManager.event.exitBattle, self.onEvent_exitBattle, self)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.ControlSchemeChange, self._onControlSchemeChangeHandle)
  self._onControlSchemeChangeHandle = nil
  if self.onEvent_journeyTaskUpdate ~= nil then
    AzurWorld.JourneyMgr:UnregisterEvent(C_EJourneyEvent.UpdateJourneyTaskServerData, self.onEvent_journeyTaskUpdate)
  end
  if self._onBattlePassFullSyncHandle ~= nil then
    C_BattlePassStoreEvent.instance:Cancel(C_EBattlePassStoreEvent.FullInfoSync, self._onBattlePassFullSyncHandle)
    self._onBattlePassFullSyncHandle = nil
  end
  local reddotMap = self.reddotMap or {}
  for key, go in pairs(reddotMap) do
    L_ReddotManager:unregisterReddot(go, key)
  end
end

function this:destroyAllLocker()
  for _, v in pairs(self.systemToTrans) do
    local locker = v.locker
    if locker then
      C_IntegrateMgr.SystemUnlockModule:RemoveLocker(locker)
    end
  end
end

function this:refreshSystem(systemId, isUnlock)
  local node = self.systemToTrans and self.systemToTrans[systemId]
  if not node then
    return
  end
  local locker = node.locker
  for _, v in ipairs(node) do
    local isNeedShow = not self:isSystemLockedByAny(systemId) and (not locker or locker:tryShowOrHide(v, isUnlock))
    if isNeedShow then
      local lock = v:Find("lock")
      local unlock = v:Find("unlock")
      if lock then
        lock.gameObject:ActiveTrans(not isUnlock)
      end
      if unlock then
        unlock.gameObject:ActiveTrans(isUnlock)
      end
    end
  end
  if isUnlock and self.cacheIsSpecialSystem and self.cacheIsSpecialSystem[systemId] then
    self:refreshSpecialSystem(systemId)
  end
  self:updateTopRightFrameSize()
end

function this:refreshBossBattleButtons()
  for _, k in pairs(self.bossBattleLockSystem) do
    self:refreshSystem(k, true)
  end
end

function this:checkIfShowOnBossBattle()
  return not self._hasBoss
end

function this:checkIfShowNoviceTaskBtn()
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.journeyTask) then
    if L_NoviceTaskStore:checkIfAllTaskCompletedAndAllRewardReceived() then
      return false
    end
    return true
  end
  return false
end

function this:checkIfShowBattlePassBtn()
  return C_BattlePassStore.CheckShowBattlePass()
end

function this:refreshSpecialSystem(systemId)
  self.systemId2Trans = self.systemId2Trans or {
    [L_SystemConst.enum.journeyTask] = self.bindComponents.transNoviceTask,
    [L_SystemConst.enum.battlePass] = self.bindComponents.transBattlePass,
    [L_SystemConst.enum.activation] = self.bindComponents.transActivity,
    [L_SystemConst.enum.gameAct] = self.bindComponents.transGameAct,
    [L_SystemConst.enum.entrustTask] = self.bindComponents.transEntrustTask,
    [L_SystemConst.enum.gacha] = self.bindComponents.transGacha
  }
  self.systemId2CheckFunc = self.systemId2CheckFunc or {
    [L_SystemConst.enum.journeyTask] = "checkIfShowNoviceTaskBtn",
    [L_SystemConst.enum.battlePass] = "checkIfShowBattlePassBtn",
    [L_SystemConst.enum.activation] = "checkIfShowOnBossBattle",
    [L_SystemConst.enum.gameAct] = "checkIfShowOnBossBattle",
    [L_SystemConst.enum.entrustTask] = "checkIfShowOnBossBattle",
    [L_SystemConst.enum.gacha] = "checkIfShowOnBossBattle"
  }
  if not self.systemId2Trans[systemId] then
    return
  end
  local show = C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(systemId) and self[self.systemId2CheckFunc[systemId]](self) and not AzurWorld.DungeonMgr:CheckIsInTeaching() and not self:isSystemLockedByAny(systemId)
  self.systemId2Trans[systemId].gameObject:ActiveTrans(show)
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

function this:onEvent_battleStart()
  if not L_BattleDataManager:getShowBossHpNode() then
    return
  end
  local hasBoss = C_BattleManager.IsInBossBattle()
  if not hasBoss then
    return
  end
  self._hasBoss = true
  for _, k in ipairs(self.bossBattleLockSystem) do
    self.lockedSystem[k].inBossBattle = true
  end
  self:refreshBossBattleButtons()
  self._hasBoss = nil
end

function this:onEvent_exitBattle()
  for _, k in ipairs(self.bossBattleLockSystem) do
    self.lockedSystem[k].inBossBattle = nil
  end
  self:refreshBossBattleButtons()
end

function this:checkInHomeDorm()
  local worldCity = C_TDWorldCityTable.GetData(AzurWorld.Instance.CurWorldId)
  local isInHomeDorm = worldCity.WorldType == C_EWorldType.HomeDorm or nil
  self.lockedSystem[L_SystemConst.enum.tutorial].inDorm = isInHomeDorm
  self.lockedSystem[L_SystemConst.enum.home].inDorm = isInHomeDorm
  if L_DeviceTpl:getIsMobile() then
    self.bind.go_exitHomeDorm = isInHomeDorm == true
  end
  if isInHomeDorm then
    self.bind.go_topLeft = false
  end
end

function this:checkControllerRoulette()
  local curModule = L_WorldManager:getCurModule()
  self.bind.go_btnControllerRoulette = C_InputManager.IsEnableGamePad and table.containsValue(L_Const.validModulesRoulette, curModule)
end

function this:onControlSchemeChange()
  self:checkControllerRoulette()
end

function this:updateTopRightFrameSize()
  local rectFrame = self.bindComponents.rect_topRightFrame
  if rectFrame then
    local cellShortKeyRoulette = self.bindComponents.transShortKeyRoulette
    local topRightSystems = {
      self.bindComponents.transActivityMain,
      self.bindComponents.transBattlePass,
      self.bindComponents.transGacha,
      self.bindComponents.transEntrustTask,
      self.bindComponents.transActivity,
      self.bindComponents.transPet,
      self.bindComponents.transHero
    }
    local pos_left = cellShortKeyRoulette.anchoredPosition.x
    local pos_right = -1
    for _, sys in ipairs(topRightSystems) do
      if sys and sys.gameObject.activeInHierarchy then
        pos_right = math.max(pos_right, sys.anchoredPosition.x)
      end
    end
    local width = math.max(100, pos_right - pos_left)
    rectFrame:SetSizeWithCurrentAnchors(0, width)
  end
end

function this:onJourneyTaskUpdate()
  if AzurWorld.JourneyMgr:AllRewardAndBottomRewardComplete() then
    self.bindComponents.transNoviceTask.gameObject:SetActive(false)
  end
end

return this

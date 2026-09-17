local manager = class("guide.guideManager")
local tag = "guide"
manager:importPartialClass(require("modules.guide.guideManager_parser"))
manager:importPartialClass(require("modules.guide.guideManager_checker"))
manager:importPartialClass(require("modules.guide.guideManager_extension"))
local guideGroupTpl = L_GameTpl:getGuideGroupTpl()
local guideTpl = L_GameTpl:getGuideTpl()
local isShowSkip = L_GameTpl:getGameConstTpl():getData("GUIDE_UI_SKIP_BUTTON_DISPLAY", L_Const.GameTplType.bool)

function manager:ctor()
  self._event = require("core.event").new()
  
  function self._updateHandler()
    self:update()
  end
  
  self._bavTreeData = {}
  self._guideWorldPauseOwners = {}
  self._isGuideWorldPaused = false
  self._guideStatus = {}
  self._guideFinishedCallback = {}
  self._localGuideIdCache = {}
  self.isNotForceCastSkill = false
  self.guideTpl = {}
  self.isActive = true
  self.isDebugActive = false
  self.blockStatus = false
  self.guideBlockUis = L_GameTpl:getGameConstTpl():getData("GUIDE_UI_BLACKLIST", L_Const.GameTplType.list_string)
  self.behaviorWaitCache = {}
  self.restartCache = {}
  self.isDetectSkill = false
  self.checkRangeInterval = 10
  self.checkRangeCount = 0
  self.pageActivityNDaySignOpened = false
  self.jumpToFuncStatus = true
  self.transferToFuncStatus = true
  self.curCheckHeroPageModuleName = ""
  self.cacheJourneyTaskRewards = {}
  self.cacheJourneyTaskCompletes = {}
  self.cacheDungeonFirstWin = {}
  self.guideJsonConfigs = {}
end

function manager:onUIShowed(pageName)
  self:updateBlockStatus(pageName, true)
  if pageName == "pageMainCity" then
    if c_UIRestore.IsRestoring() then
      return
    end
    self:tryTriggerGuideByParams()
  end
end

function manager:onUIClosed(pageName)
  if pageName == "pageActivityNDaySign" then
    self.pageActivityNDaySignOpened = true
  end
  self:updateBlockStatus(pageName, false)
  if pageName == "loading" then
    self:tryTriggerGuideByParams()
  end
end

function manager:initialize()
  self:stopAllGuide(true)
  self:addEventListener()
  self:enableUpdate()
end

function manager:addEventListener()
  self.inputActionHandle = self.inputActionHandle or handler(self, self.onEventInputActionHandle)
  C_ExternalManager.AddEvent(C_EExternalEventType.TriggerInputAction, self.inputActionHandle)
  L_UI:addListener(L_UI.pageEvent.showed, self.onUIShowed, self)
  L_UI:addListener(L_UI.pageEvent.closed, self.onUIClosed, self)
  self.guideHandle = self.guideHandle or handler(self, self.startGuideHandle)
  C_ExternalManager.AddEvent(C_EExternalEventType.TriggerGuideById, self.guideHandle)
  L_UI:addListener(L_UI.pageEvent.opened, self.dealUIGuide, self)
  L_UI:addListener(L_UI.pageEvent.firstOpen, self.dealUIGuideFirstOpen, self)
  self.onEvent_systemUnlock = handler(self, self.onSystemUnlock)
  C_SystemUnlockEvent.instance:Listen(C_ESystemUnlockEvent.SystemUnlockGuideEvent, self.onEvent_systemUnlock)
  self._onCutWorldComplete = handler(self, self.onSwitchSceneEnd)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  L_PlayerStore:listenCallFunc(L_PlayerStore.event.playerLevelUp, self.onPlayerLevelUp, self)
  self.onEvent_homeBuildSync = handler(self, self.onHomeBuildingSync)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildSync, self.onEvent_homeBuildSync)
  self.onEvent_homeLevelBaseSync = handler(self, self.onHomeLevelBaseSync)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeLevelBaseSync, self.onEvent_homeLevelBaseSync)
  self.onEvent_homeBuildProductGuideSync = handler(self, self.onHomeBuildProductGuide)
  C_HomeStoreEvent.instance:Listen(C_EHomeStoreEvent.HomeBuildProductGuide, self.onEvent_homeBuildProductGuideSync)
  self.onEvent_journeyTaskReward = handler(self, self.onJourneyTaskReward)
  AzurWorld.JourneyMgr:RegisterEvent(C_EJourneyEvent.UpdateJourneyTaskRewarding, self.onEvent_journeyTaskReward)
  self.onEvent_journeyTaskComplete = handler(self, self.onJourneyTaskComplete)
  AzurWorld.JourneyMgr:RegisterEvent(C_EJourneyEvent.UpdateJourneyTaskCompleted, self.onEvent_journeyTaskComplete)
  L_TechnologyStore:listenCallFunc(L_TechnologyStore.event.refresh, self.onTechnologyRefresh, self)
  self.onEvent_OnSceneLoadStart = handler(self, self.onSceneLoadStart)
  C_WorldEvent.instance:Listen(C_EWorldEvent.OnSceneLoadStart, self.onEvent_OnSceneLoadStart)
  self.onEvent_FullReconnected = handler(self, self.onReconnected)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  self.onEvent_OnReconnecting = handler(self, self.onReconnecting)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.Reconnecting, self.onEvent_OnReconnecting)
  self.onEvent_OnSimpleReconnected = handler(self, self.onSimpleReconnected)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.SimpleReconnected, self.onEvent_OnSimpleReconnected)
  self.onEvent_OnInGame = handler(self, self.onInGame)
  L_Net:RegisterGameConnectEvent(C_EGameConnectStatus.InGame, self.onEvent_OnInGame)
  self._onEvent_storyStartHandle = self._onEvent_storyStartHandle or handler(self, self._onEvent_storyStart)
  self._onEvent_storyEndHandle = self._onEvent_storyEndHandle or handler(self, self._onEvent_storyEnd)
  C_StoryEvent.instance:Listen(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
  C_StoryEvent.instance:Listen(C_EStoryEvent.StoryEnd, self._onEvent_storyEndHandle)
  self.onEvent_HeroAllDead = self.onEvent_HeroAllDead or handler(self, self.onHeroAllDead)
  AzurWorld.playerMgr:RegisterEvent(C_EPlayerEvent.EFormationAllDead, self.onEvent_HeroAllDead)
  self.onEvent_CollectionToolRefresh = self.onEvent_CollectionToolRefresh or handler(self, self.onCollectionToolRefresh)
  C_CollectionToolStoreEvent.instance:Listen(C_ECollectionToolStoreEvent.CollectStatusChange, self.onEvent_CollectionToolRefresh)
  self.onEvent_DungeonFirstWin = self.onEvent_DungeonFirstWin or handler(self, self.onDungeonFirstWin)
  C_DungeonEntrustEvent.instance:Listen(C_EDungeonEntrustEvents.DungeonFirstWin, self.onEvent_DungeonFirstWin)
  L_HeroManager:addListener(L_HeroManager.event.curModuleChanged, self.onHeroPageCurModuleChanged, self)
  L_ProductStore:listenCallFunc(L_ProductStore.event.productFinishGuide, self.onProductFinishGuide, self)
  L_PetManager:addListener(L_PetManager.event.petBoxHaveCanMutationPetGuide, self.onPetBoxHaveCanMutationPetGuide, self)
  self.syncMountServDataHandle = self.syncMountServDataHandle or handler(self, self.satietyValueRefresh)
  AzurWorld.mountMgr:RegisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self.syncMountServDataHandle)
  L_ShopStore:listenCallFunc(L_ShopStore.event.onOpenShopPage, self.onPageShopOpened, self)
  self.onHeroAnimChangedEnterHandle = self.onHeroAnimChangedEnterHandle or handler(self, self.onHeroAnimChangedEnter)
  C_GuideEvent.instance:Listen(C_EGuideEvents.HeroAnimStateChangedEnter, self.onHeroAnimChangedEnterHandle)
  self.onSwitchPetPageHandle = self.onSwitchPetPageHandle or handler(self, self.onSwitchPetPage)
  C_ExternalManager.AddEvent(C_EExternalEventType.SwitchPetPage, self.onSwitchPetPageHandle)
  self.quickItemBarShowHandle = self.quickItemBarShowHandle or handler(self, self.onQuickItemBarShow)
  C_ExternalManager.AddEvent(C_EExternalEventType.QuickItemBarShow, self.quickItemBarShowHandle)
  self.onEvent_CVStateChanged = self.onEvent_CVStateChanged or handler(self, self.onScenarioCVStateChanged)
  AzurWorld.scenarioManager:RegisterEvent(C_EScenarioEvent.CVStateChanged, self.onEvent_CVStateChanged)
  self.onEvent_CVStaminaChanged = self.onEvent_CVStaminaChanged or handler(self, self.onScenarioCVStaminaChanged)
  AzurWorld.scenarioManager:RegisterEvent(C_EScenarioEvent.CVStaminaChanged, self.onEvent_CVStaminaChanged)
  self.onEvent_CVTrainReadyPreChoose = self.onEvent_CVTrainReadyPreChoose or handler(self, self.onScenarioCVTrainReadyPreChoose)
  AzurWorld.scenarioManager:RegisterEvent(C_EScenarioEvent.CVTrainReadyPreChoose, self.onEvent_CVTrainReadyPreChoose)
end

function manager:onScenarioCVStateChanged()
  local stateValue = AzurWorld.scenarioManager.StateMachine.curStateType.value__
  C_MJLog.LogInfo(string.format("onScenarioCVStateChanged stateValue: %s", stateValue), C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.cvStateChanged,
        param = stateValue
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onScenarioCVStaminaChanged()
  local stamina = AzurWorld.scenarioManager.RuntimeData.Stamina
  C_MJLog.LogInfo(string.format("onScenarioCVStaminaChanged stamina: %s", stamina), C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.cvStaminaChanged,
        param = stamina
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onScenarioCVTrainReadyPreChoose(_, varList)
  local trainingData = varList:GetObject(0)
  local isBondTrain = trainingData:IsBondTrain() and 1 or 0
  C_MJLog.LogInfo(string.format("onScenarioCVTrainReadyPreChoose isBondTrain: %s", isBondTrain), C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.cvTrainReadyBondTrain,
        param = isBondTrain
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onPetBoxHaveCanMutationPetGuide()
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.petBoxHaveCanMutationPet,
        param = 0
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onQuickItemBarShow()
  C_MJLog.LogInfo("onQuickItemBarShow", C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.onQuickItemBarShow,
        param = 0
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onProductFinishGuide(buildGroupId, sendProductList)
  for i = 1, #sendProductList do
    local list = {}
    table.insert(list, buildGroupId)
    table.insert(list, sendProductList[i])
    local collectionParams = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.homeBuildProduct,
          param = list
        }
      }
    }
    self:tryTriggerGuideByParams(collectionParams)
  end
end

function manager:onPageShopOpened(pageId)
  C_MJLog.LogInfo(string.format("ShopPageOpened  %s", pageId), C_ELogModule.Guide)
  C_MJLog.LogInfo(string.format("ShopPageOpened  %s", pageId), C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.openShopPage,
        param = pageId
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onSwitchPetPage(args)
  C_MJLog.LogInfo(string.format("ShopSwitchPetPage  %s", args.objIndex), C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.switchPetPage,
        param = args.objIndex
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onHeroAnimChangedEnter(_, varList)
end

function manager:satietyValueRefresh(_, par)
  C_MJLog.LogInfo("饱食度刷新", C_ELogModule.Guide)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.satietyValueChanged,
        param = 0
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onHeroPageCurModuleChanged(changedInfo)
  C_MJLog.LogInfo("HeroPageCurModuleChanged changedInfo: moduleName-> " .. changedInfo.moduleName .. " status-> " .. tostring(changedInfo.status), C_ELogModule.Guide)
  if changedInfo.status then
    self.curCheckHeroPageModuleName = changedInfo.moduleName
  elseif self.curCheckHeroPageModuleName == changedInfo.moduleName then
    self.curCheckHeroPageModuleName = ""
  end
end

function manager:onHeroAllDead()
  self:stopAllGuide(true)
end

function manager:onCollectionToolRefresh(_, varList)
  local isCollection = varList:GetBool(0)
  local toolTypeId = varList:GetInt(1)
  if isCollection then
    local collectionParams = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.collection,
          param = tostring(toolTypeId)
        }
      }
    }
    self:tryTriggerGuideByParams(collectionParams)
  end
end

function manager:onDungeonFirstWin(_, varList)
  local dungeonId = varList:GetUint(0)
  local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
  local tpl = _dungeonEntrustTpl:getTplByDungeonId(dungeonId)
  local id = _dungeonEntrustTpl:getId(tpl)
  self.cacheDungeonFirstWin[id] = true
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.dungeonFirstWin,
        param = id
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:_onEvent_storyStart()
  self:stopAllGuide()
end

function manager:_onEvent_storyEnd()
  self:restartAllGuide()
end

function manager:onReconnected()
  C_MJLog.LogInfo("GuideManager onReconnected", C_ELogModule.Guide)
  self.inSimpleReconnecting = false
  self:stopAllGuide(true)
  Timer.once(0.1, function()
    self:restartAllGuide()
    self:tryTriggerGuideByParams()
  end)
end

function manager:onSimpleReconnected()
  C_MJLog.LogInfo("GuideManager onSimpleReconnected", C_ELogModule.Guide)
  self.inSimpleReconnecting = false
end

function manager:onReconnecting()
  C_MJLog.LogInfo("GuideManager onReconnecting", C_ELogModule.Guide)
  self.inSimpleReconnecting = true
end

function manager:onInGame()
  C_MJLog.LogInfo("GuideManager onInGame", C_ELogModule.Guide)
  self.inSimpleReconnecting = false
end

function manager:onFormationRefresh(fType)
  if fType == L_FormationConst.FormationType.world then
    self:tryTriggerGuideByParams()
  end
end

function manager:onSceneLoadStart()
  self._ESyncFormationServerDataHandler = handler(self, self.onFormationRefresh)
  AzurWorld.formationMgr:RegisterEvent(C_EFormationEvent.ESyncFormationServerData, self._ESyncFormationServerDataHandler)
end

function manager:onPlayerLevelUp()
  self:tryTriggerGuideByParams()
end

function manager:onTechnologyRefresh()
  self:tryTriggerGuideByParams()
end

function manager:onSwitchSceneEnd()
  local sceneId = AzurWorldInstance.CurWorldId
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.switchScene,
        param = tostring(sceneId)
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onSystemUnlock(_, args)
  local systemId = args:GetInt(0)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.funcUnlock,
        param = tostring(systemId)
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onHomeBuildingSync()
  self:tryTriggerGuideByParams()
end

function manager:onHomeLevelBaseSync(_, args)
  local lv = args:GetUint(1)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.homeLvUpgrade,
        param = lv
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onHomeBuildProductGuide(_, args)
  local groupId = args:GetInt(0)
  local productId = args:GetUint(1)
  local list = {}
  table.insert(list, groupId)
  table.insert(list, productId)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.homeBuildProduct,
        param = list
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:onJourneyTaskReward(_, args)
  local count = args:GetInt(0)
  for i = 1, count do
    local journeyTaskId = args:GetInt(i)
    self.cacheJourneyTaskRewards[journeyTaskId] = true
    local params = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.journeyTaskRewarding,
          param = journeyTaskId
        }
      }
    }
    self:tryTriggerGuideByParams(params)
  end
end

function manager:onJourneyTaskComplete(_, args)
  local count = args:GetInt(0)
  for i = 1, count do
    local journeyTaskId = args:GetInt(i)
    self.cacheJourneyTaskCompletes[journeyTaskId] = true
    local params = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.journeyTaskComplete,
          param = journeyTaskId
        }
      }
    }
    self:tryTriggerGuideByParams(params)
  end
end

function manager:dealUIGuideFirstOpen(pageName)
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.firstOpenPage,
        param = pageName
      }
    }
  }
  self:tryTriggerGuideByParams(params)
end

function manager:dealUIGuide(pageName)
  if table.containsValue(self.guideBlockUis, pageName) then
    return
  end
  if c_UIRestore.IsRestoring() then
    return
  end
  local params = {
    guideParams = {
      {
        type = L_Const.triggerGuideType.uiOpen,
        param = pageName
      }
    }
  }
  self:tryTriggerGuideByParams(params)
  local page = L_UI:getPage(pageName)
  if page ~= nil and page.options and page.options.buildingGuid then
    local serverData = L_HomeStore:getHomeBuildingByGuid(page.options.buildingGuid)
    local homeBuildingTpl = L_GameTpl:getHomeBuildingTpl()
    local tpl_building = homeBuildingTpl:getTplById(serverData.build_id)
    local groupId = homeBuildingTpl:getGroupId(tpl_building)
    local buildParams = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.buildType,
          param = tostring(groupId)
        }
      }
    }
    self:tryTriggerGuideByParams(buildParams)
  end
  if pageName == "pageActivityScenarioMain" then
    local scenarioParams = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.scenarioEndlessOpen,
          param = 0
        },
        {
          type = L_Const.triggerGuideType.scenarioEndBookEnabled,
          param = 0
        }
      }
    }
    self:tryTriggerGuideByParams(scenarioParams)
  end
end

function manager:triggerGuideByParams(params)
  params = params or table.empty
  CS.UnityEngine.Profiling.Profiler.BeginSample("guide triggerGuideByParams parseGuideParams")
  local guidGroupIds = self:parseGuideParams(params)
  CS.UnityEngine.Profiling.Profiler.EndSample()
  if not guidGroupIds then
    return
  end
  CS.UnityEngine.Profiling.Profiler.BeginSample("guide triggerGuideByParams start guide")
  for _, groupId in ipairs(guidGroupIds) do
    self:startGuide(groupId)
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function manager:tryTriggerGuideByParams(params)
  if params and params.callBack ~= nil then
    self:triggerGuideByParams(params)
    return
  end
  if not self.tempParseParmas then
    self.tempParseParmas = {
      hasGlobal = false,
      paramMap = {}
    }
  end
  if params and params.guideParams and #params.guideParams > 0 then
    for _, p in ipairs(params.guideParams) do
      if p.type then
        local typeKey = p.type
        local paramKey = p.param
        if type(paramKey) == "table" then
          C_MJLog.LogDebug("[GuideManager tryTriggerGuideByParams] type: " .. tostring(typeKey) .. " paramKey: " .. table.concat(paramKey, "#"), C_ELogModule.Guide)
        else
          C_MJLog.LogDebug("[GuideManager tryTriggerGuideByParams] type: " .. tostring(typeKey) .. " paramKey: " .. tostring(paramKey), C_ELogModule.Guide)
        end
        local typeMap = self.tempParseParmas.paramMap[typeKey]
        if not typeMap then
          typeMap = {}
          self.tempParseParmas.paramMap[typeKey] = typeMap
        end
        typeMap[paramKey] = true
      end
    end
  else
    self.tempParseParmas.hasGlobal = true
  end
  self.triggerGuideDirtySign = true
end

function manager:startGuideHandle(param)
  CS.UnityEngine.Profiling.Profiler.BeginSample("guide startGuideHandle")
  if param.guideId then
    self._guideFinishedCallback[param.guideId] = param.callBack
    local isGuideContitionSatisfy = false
    local isGuideNeedCb = false
    isGuideContitionSatisfy, isGuideNeedCb = self:checkConditionsByGuideId(param.guideId)
    if not isGuideContitionSatisfy then
      C_MJLog.LogInfo("@guide guide condition not satisfied, actively trigger callback function" .. tostring(param.guideId), C_ELogModule.Guide)
      if param.callBack ~= nil then
        param.callBack()
      end
      return
    end
    local ignoreGuideClosed = false
    local tpl = guideGroupTpl:getTplById(param.guideId)
    if tpl ~= nil then
      local triggerSourceId = guideGroupTpl:getTriggerSource(tpl)
      ignoreGuideClosed = triggerSourceId == 1 or triggerSourceId == 3
    end
    self:startGuide(param.guideId, ignoreGuideClosed)
    C_MJLog.LogInfo("C# guide event start guideId: " .. param.guideId, C_ELogModule.Guide)
  end
  if param.guideParams then
    local temp = {
      callBack = param.callBack,
      guideParams = {}
    }
    for i = 0, param.guideParams.Count - 1 do
      table.insert(temp.guideParams, param.guideParams[i])
      C_MJLog.LogInfo("C# guide event start type: " .. param.guideParams[i].type .. " param: " .. param.guideParams[i].param, C_ELogModule.Guide)
    end
    self:tryTriggerGuideByParams(temp)
  end
  CS.UnityEngine.Profiling.Profiler.EndSample()
end

function manager:updateBlockStatus(pageName, bShow)
  self.blockStatus = self:isBlockPageOpened(pageName, bShow)
end

function manager:getTpl()
  if table.isEmpty(self.guideTpl) then
    self.guideTpl = L_GameTpl:getGuideGroupTpl()
  end
  return self.guideTpl
end

function manager:setGuideStatus(guideType, isRunning)
  self._guideStatus[guideType] = isRunning
  C_MJLog.LogInfo("setGuideStatus:" .. tostring(isRunning), C_ELogModule.Guide)
end

function manager:getAllGuideStatus()
  for _, v in pairs(self._guideStatus) do
    if v == true then
      return true
    end
  end
  return false
end

function manager:setGuideDebug(isDebugActive)
  if not isDebugActive and self:isGuideOnRunning(self.debugGuideId) then
    return
  end
  self.isDebugActive = isDebugActive
end

function manager:isOnDebugMode()
  return self.isDebugActive
end

function manager:forceEndGuide(guideId)
  self:endGuide(guideId)
end

function manager:clearAllControl()
  L_GuideManager:internalSendEvent(G_GuideClasses.GuideEvent.GuideControlMouse, {key = "guideClick", isShow = false})
  C_InputManager.DisableHighLevelControl()
  C_ScreenTouch.SetEnabled(true)
  L_UI:setTempTopGuideMask(false)
  self:setForceNotCastSkill(false)
  C_UIMgr.ResumePriorityQueue()
  self:changeTransferToFuncStatus(true)
  self:changeJumpToFuncStatus(true)
  self:clearWorldPause("clearAllControl")
end

function manager:getInputName(keyText)
  local guideIconTpl = L_GameTpl:getGuideIconTpl()
  local tpl = guideIconTpl:getTplByKeyCode(keyText)
  local keyShow = keyText
  if tpl ~= nil and not string.isEmpty(guideIconTpl:getDisName(tpl)) then
    keyShow = guideIconTpl:getDisName(tpl)
  else
    C_MJLog.LogInfo("guide input name cfg is not configured, check guideIconTpl, " .. tostring(keyText), C_ELogModule.Guide)
  end
  return keyShow
end

function manager:restartAllGuide()
  for _, guideId in ipairs(self.restartCache) do
    self:startGuide(guideId)
  end
  self.restartCache = {}
end

function manager:dispose()
  L_GuideManager:stopAllGuide(true)
  self:disableUpdate()
  self._bavTreeData = {}
  self._guideWorldPauseOwners = {}
  self._isGuideWorldPaused = false
  self._guideStatus = {}
  self._guideFinishedCallback = {}
  self._localGuideIdCache = {}
  self.restartCache = {}
  self.isNotForceCastSkill = false
  self.pageActivityNDaySignOpened = false
  self.jumpToFuncStatus = true
  self.transferToFuncStatus = true
  self.inSimpleReconnecting = false
  self.curCheckHeroPageModuleName = ""
  self.guideJsonConfigs = {}
  self.cacheJourneyTaskRewards = {}
  self.cacheJourneyTaskCompletes = {}
  self.cacheDungeonFirstWin = {}
  L_UI:removeListener(L_UI.pageEvent.showed, self.onUIShowed, self)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onUIClosed, self)
  if self.inputActionHandle ~= nil then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.TriggerInputAction, self.inputActionHandle)
  end
  if self.guideHandle ~= nil then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.TriggerGuideById, self.guideHandle)
  end
  L_UI:removeListener(L_UI.pageEvent.opened, self.dealUIGuide, self)
  L_UI:removeListener(L_UI.pageEvent.firstOpen, self.dealUIGuideFirstOpen, self)
  C_IntegrateMgr.SystemUnlockModule:unListenCallFunc(self.systemUnlockHandleId)
  L_PlayerStore:unListenCallFunc(L_PlayerStore.event.playerLevelUp, self.onPlayerLevelUp, self)
  if self.onEvent_homeBuildSync ~= nil then
    C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildSync, self.onEvent_homeBuildSync)
  end
  if self.onEvent_homeLevelBaseSync ~= nil then
    C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeLevelBaseSync, self.onEvent_homeLevelBaseSync)
  end
  if self.onEvent_homeBuildProductGuideSync ~= nil then
    C_HomeStoreEvent.instance:Cancel(C_EHomeStoreEvent.HomeBuildProductGuide, self.onEvent_homeBuildProductGuideSync)
  end
  if self.onEvent_journeyTaskReward ~= nil then
    AzurWorld.JourneyMgr:UnregisterEvent(C_EJourneyEvent.UpdateJourneyTaskRewarding, self.onEvent_journeyTaskReward)
  end
  if self.onEvent_journeyTaskComplete ~= nil then
    AzurWorld.JourneyMgr:UnregisterEvent(C_EJourneyEvent.UpdateJourneyTaskCompleted, self.onEvent_journeyTaskComplete)
  end
  L_TechnologyStore:unListenCallFunc(L_TechnologyStore.event.refresh, self.onTechnologyRefresh, self)
  if self.onEvent_OnSceneLoadStart ~= nil then
    C_WorldEvent.instance:Cancel(C_EWorldEvent.OnSceneLoadStart, self.onEvent_OnSceneLoadStart)
  end
  if self.onEvent_FullReconnected ~= nil then
    L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.FullReconnected, self.onEvent_FullReconnected)
  end
  if self.onEvent_OnSimpleReconnected ~= nil then
    L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.SimpleReconnected, self.onEvent_OnSimpleReconnected)
  end
  if self.onEvent_OnReconnecting ~= nil then
    L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.Reconnecting, self.onEvent_OnReconnecting)
  end
  if self.onEvent_OnInGame ~= nil then
    L_Net:UnregisterGameConnectEvent(C_EGameConnectStatus.InGame, self.onEvent_OnInGame)
  end
  if self._onEvent_storyStartHandle ~= nil then
    C_StoryEvent.instance:Cancel(C_EStoryEvent.StoryStart, self._onEvent_storyStartHandle)
  end
  if self._onEvent_storyEndHandle ~= nil then
    C_StoryEvent.instance:Cancel(C_EStoryEvent.StoryEnd, self._onEvent_storyEndHandle)
  end
  if self.onEvent_HeroAllDead ~= nil then
    AzurWorld.playerMgr:UnregisterEvent(C_EPlayerEvent.EFormationAllDead, self.onEvent_HeroAllDead)
  end
  if self._onCutWorldComplete ~= nil then
    C_GameFlow.flowEvent:Cancel(C_EGameFlowEvent.CutWorldComplete, self._onCutWorldComplete)
  end
  if self.onEvent_CollectionToolRefresh ~= nil then
    C_CollectionToolStoreEvent.instance:Cancel(C_ECollectionToolStoreEvent.CollectStatusChange, self.onEvent_CollectionToolRefresh)
  end
  if self.onEvent_DungeonFirstWin ~= nil then
    C_DungeonEntrustEvent.instance:Cancel(C_EDungeonEntrustEvents.DungeonFirstWin, self.onEvent_DungeonFirstWin)
  end
  if self.onHeroAnimChangedEnterHandle ~= nil then
    C_GuideEvent.instance:Cancel(C_EGuideEvents.HeroAnimStateChangedEnter, self.onHeroAnimChangedEnterHandle)
  end
  L_HeroManager:removeListener(L_HeroManager.event.curModuleChanged, self.onHeroPageCurModuleChanged, self)
  L_ProductStore:unListenCallFunc(L_ProductStore.event.productFinishGuide, self.onProductFinishGuide, self)
  L_PetManager:removeListener(L_PetManager.event.petBoxHaveCanMutationPetGuide, self.onPetBoxHaveCanMutationPetGuide, self)
  AzurWorld.mountMgr:UnregisterEvent(C_EMountEvent.ESyncMountRouletteServerData, self.syncMountServDataHandle)
  L_ShopStore:unListenCallFunc(L_ShopStore.event.onOpenShopPage, self.onPageShopOpened, self)
  C_ExternalManager.RemoveEvent(C_EExternalEventType.SwitchPetPage, self.onSwitchPetPageHandle)
  if self.quickItemBarShowHandle ~= nil then
    C_ExternalManager.RemoveEvent(C_EExternalEventType.QuickItemBarShow, self.quickItemBarShowHandle)
  end
  if self.onEvent_CVStateChanged ~= nil then
    AzurWorld.scenarioManager:UnregisterEvent(C_EScenarioEvent.CVStateChanged, self.onEvent_CVStateChanged)
  end
  if self.onEvent_CVStaminaChanged ~= nil then
    AzurWorld.scenarioManager:UnregisterEvent(C_EScenarioEvent.CVStaminaChanged, self.onEvent_CVStaminaChanged)
  end
  if self.onEvent_CVTrainReadyPreChoose ~= nil then
    AzurWorld.scenarioManager:UnregisterEvent(C_EScenarioEvent.CVTrainReadyPreChoose, self.onEvent_CVTrainReadyPreChoose)
  end
end

function manager:startGuide(guideId, ignoreGuideClosed)
  if not self:checkCanRunGuide(guideId, ignoreGuideClosed) then
    self:setGuideDebug(false)
    return
  end
  local config = self:getTpl():getTplById(guideId)
  if not self:getTpl():getIsWorking(config) then
    self:setGuideDebug(false)
    return
  end
  if config then
    local isInBattle = C_BattleManager.IsInBattle(C_EntityManager.MainPlayer)
    if self:getTpl():getIsBattle(config) and not isInBattle then
      C_MJLog.LogInfo(string.format("id: %d仅在战斗中触发", guideId), C_ELogModule.Guide)
      self:setGuideDebug(false)
      return
    end
    if self:getTpl():getIsNoBattle(config) and isInBattle then
      C_MJLog.LogInfo(string.format("id: %d仅在非战斗中触发", guideId), C_ELogModule.Guide)
      self:setGuideDebug(false)
      return
    end
    local path = L_Config:getPathByHash(config.bavTreePath)
    if not string.isEmpty(path) then
      local jsonHandle = self.guideJsonConfigs[path]
      if jsonHandle == nil then
        jsonHandle = C_LuaUtility.LoadRawTextSync(path)
        self.guideJsonConfigs[path] = jsonHandle
      end
      if not string.isEmpty(jsonHandle) then
        local isReplacingGuide = self:dealPriority(guideId)
        C_MJLog.LogInfo("start guide guideId:" .. guideId, C_ELogModule.Guide)
        L_UI:setGlobleMask("guide", false)
        local bevTree = L_BevTree:generateBevTree()
        bevTree:initialize(jsonHandle, {guideId = guideId})
        bevTree.jsonPath = path
        self._bavTreeData[guideId] = bevTree
        if table.count(self._bavTreeData) == 1 and not isReplacingGuide then
          self:OnGuideNumFromZeroToOne()
        end
        self:dealGuideInBattle(guideId)
      end
    end
  end
end

function manager:checkCanRunGuide(guideId, ignoreGuideClosed)
  if guideId == nil then
    return false
  end
  if self._bavTreeData[guideId] then
    return false
  end
  if not self:checkCommonCanRunGuide(ignoreGuideClosed) then
    return false
  end
  if self:checkGuideType(guideId) then
    return false
  end
  if not self:triggerScene(guideId) then
    return false
  end
  if not self:isPlayableSatisfy(guideId) then
    return false
  end
  self:updateBlockStatus()
  if self.blockStatus then
    if L_LoadingManager:isLoading() then
      table.insert(self.behaviorWaitCache, {guideId = guideId})
    end
    return false
  end
  local tpl = guideGroupTpl:getTplById(guideId)
  if not self:isOnDebugMode() and L_GuideStore:isGuideComplete(guideId) and guideGroupTpl:getIsRepeat(tpl) == false then
    if self._guideFinishedCallback[guideId] then
      self._guideFinishedCallback[guideId]()
    end
    self._guideFinishedCallback[guideId] = nil
    return false
  end
  return true
end

function manager:checkCommonCanRunGuide(ignoreGuideClosed)
  if self:checkFormationHp() then
    return false
  end
  if AzurWorld.StoryMgr.IsPlaying then
    return false
  end
  if C_CameraManager.IsCurrentCamera(C_ECameraType.UltimateSkill) then
    return false
  end
  if not self:canStartGuide() and not ignoreGuideClosed then
    return false
  end
  return true
end

function manager:checkPauseBehaviorTreeRunning()
  if AzurWorld.StoryMgr.IsPlaying then
    return true
  end
  if C_CameraManager.IsCurrentCamera(C_ECameraType.UltimateSkill) then
    return true
  end
  return false
end

function manager:checkFormationHp()
  if C_KiBoDuelLuaWrapper:IsInKiBoDuel() then
    return false
  end
  local heroDic = L_PlayerManager:getAllHeroCsEntity()
  for i, v in pairs(heroDic) do
    if not C_EntityManager.IsEntityDead(v.data.entityId) and C_MyFloatUtility.GetFloat(v.data.aliveProperty.hp) > 0 then
      return false
    end
  end
  return true
end

function manager:checkGuideType(guideId)
  local tpl = guideGroupTpl:getTplById(guideId)
  local guideType = guideGroupTpl:getGuideType(tpl)
  local curPriority = guideGroupTpl:getGuidePriority(tpl)
  for runningGuideId, _ in pairs(self._bavTreeData) do
    local runningTpl = guideGroupTpl:getTplById(runningGuideId)
    local runningGuideType = guideGroupTpl:getGuideType(runningTpl)
    if runningGuideType == guideType then
      local canBeInterrupted = guideGroupTpl:getIsBreak(runningTpl)
      local runningPriority = guideGroupTpl:getGuidePriority(runningTpl)
      if not canBeInterrupted and curPriority <= runningPriority then
        return true
      end
    end
  end
  return false
end

function manager:dealPriority(guideId)
  local tpl = guideGroupTpl:getTplById(guideId)
  local guideType = guideGroupTpl:getGuideType(tpl)
  local curPriority = guideGroupTpl:getGuidePriority(tpl)
  local interruptedGuideIds = {}
  local runningGuideCount = table.count(self._bavTreeData)
  for runningGuideId, _ in pairs(self._bavTreeData) do
    local runningTpl = guideGroupTpl:getTplById(runningGuideId)
    local runningGuideType = guideGroupTpl:getGuideType(runningTpl)
    if runningGuideType == guideType then
      local canBeInterrupted = guideGroupTpl:getIsBreak(runningTpl)
      local runningPriority = guideGroupTpl:getGuidePriority(runningTpl)
      if canBeInterrupted or curPriority > runningPriority then
        table.insert(interruptedGuideIds, runningGuideId)
      end
    end
  end
  table.sort(interruptedGuideIds)
  local isReplacingGuide = 0 < #interruptedGuideIds and #interruptedGuideIds == runningGuideCount
  for _, interruptedGuideId in ipairs(interruptedGuideIds) do
    L_GuideStore:updateGuideData(interruptedGuideId, 0)
    self:endGuideTree(interruptedGuideId, true, isReplacingGuide)
    self:saveInterruptedGuide(interruptedGuideId)
  end
  return isReplacingGuide
end

function manager:saveInterruptedGuide(guideId)
  L_GuideStore:req_updateGuideData(guideId, 0, function(success)
    if success then
      self:saveMutualGuides(guideId)
      C_MJLog.LogInfo(string.format("[GuideInterrupt] save success guideId=%s step=0", tostring(guideId)), C_ELogModule.Guide)
    else
      C_MJLog.LogError(string.format("[GuideInterrupt] save failed guideId=%s step=0", tostring(guideId)), C_ELogModule.Guide)
    end
  end)
end

function manager:dealGuideInBattle(guideId)
  local isInBattle = C_BattleManager.IsInBattle(C_EntityManager.MainPlayer)
  local tpl = guideGroupTpl:getTplById(guideId)
  local isBattleGuide = tpl and guideGroupTpl:getIsBattleGuide(tpl) ~= 0
  self:setWorldPause(isInBattle and isBattleGuide, guideId)
end

function manager:isBlockPageOpened(pName, bShow)
  for _, pageName in pairs(self.guideBlockUis) do
    local page = L_UI:getPage(pageName)
    if pageName == pName and bShow then
      return true
    end
    if page then
      return true
    end
  end
  return false
end

function manager:enableUpdate()
  C_UpdateSource.AddUpdateEventHandler(self._updateHandler, "guideManager.update")
end

function manager:disableUpdate()
  C_UpdateSource.RemoveUpdateEventHandler(self._updateHandler)
end

function manager:update()
  if not string.isEmpty(self.curCheckHeroPageModuleName) then
    local param = {
      guideParams = {
        {
          type = L_Const.triggerGuideType.heroPageCurModuleChanged,
          param = self.curCheckHeroPageModuleName
        }
      }
    }
    self:tryTriggerGuideByParams(param)
    self.curCheckHeroPageModuleName = ""
  end
  if self:checkPauseBehaviorTreeRunning() then
    return
  end
  if not self:isOnDebugMode() then
    self:delayTriggerGuide()
  end
  self:checkWaitCache()
  local timeScale = C_Time.deltaTime
  for _, tree in pairs(self._bavTreeData) do
    if tree then
      tree:onUpdate(timeScale)
    end
  end
  if table.count(self._bavTreeData) > 0 then
    if not L_UI:checkPageOpen("pageGuideSkip") then
      L_UI:open("pageGuideSkip")
    else
      self:internalSendEvent(G_GuideClasses.GuideEvent.GuideRefresh)
    end
  elseif L_UI:checkPageOpen("pageGuideSkip") then
    L_UI:close("pageGuideSkip")
  end
  if self.checkRangeCount < self.checkRangeInterval then
    self.checkRangeCount = self.checkRangeCount + 1
  else
    self.checkRangeCount = 0
    self.isCloseToSpecial = self:checkRangeEntities()
  end
end

function manager:delayTriggerGuide()
  if not self.triggerGuideDirtySign or #self.restartCache > 0 then
    return
  end
  CS.UnityEngine.Profiling.Profiler.BeginSample("guide triggerGuideByParams check")
  local canRunGuide = self:checkCommonCanRunGuide()
  CS.UnityEngine.Profiling.Profiler.EndSample()
  if canRunGuide then
    local pending = self.tempParseParmas
    if not pending then
      self:triggerGuideByParams()
    else
      local mergedGuideParams = {}
      local paramMap = pending.paramMap or {}
      for typeKey, paramSet in pairs(paramMap) do
        for paramKey, _ in pairs(paramSet) do
          table.insert(mergedGuideParams, {type = typeKey, param = paramKey})
        end
      end
      if 0 < #mergedGuideParams then
        self:triggerGuideByParams({guideParams = mergedGuideParams})
      elseif pending.hasGlobal then
        self:triggerGuideByParams()
      else
        self:triggerGuideByParams()
      end
    end
  end
  self.tempParseParmas = nil
  self.triggerGuideDirtySign = false
end

function manager:checkWaitCache()
  if not self.blockStatus and #self.behaviorWaitCache > 0 then
    for _, treeData in ipairs(self.behaviorWaitCache) do
      if self._bavTreeData[treeData.guideId] then
        printf(treeData.guideId .. " 已经加载过了")
      else
        self:startGuide(treeData.guideId)
      end
    end
    self.behaviorWaitCache = {}
  end
end

function manager:internalSendEvent(eventName, ...)
  self._event:send(eventName, ...)
end

function manager:addListener(eventName, func, register, obj, priority)
  self._event:register(eventName, func, register, obj, priority)
end

function manager:removeListener(eventName, func)
  self._event:unRegister(eventName, func)
end

function manager:endGuideTree(guideId, isSkipTrigger, isReplacingGuide)
  local preGuideData = self._bavTreeData[guideId]
  if preGuideData then
    preGuideData:onDestroy()
    self._bavTreeData[guideId] = nil
    if table.count(self._bavTreeData) == 0 and not isReplacingGuide then
      self:OnGuideNumFromOneToZero()
    end
    if self._guideFinishedCallback[guideId] then
      self._guideFinishedCallback[guideId]()
    end
    self._guideFinishedCallback[guideId] = nil
    self._localGuideIdCache[guideId] = true
    self:onEndSendEvent(guideId)
    C_MJLog.LogInfo("结束了了行为树：" .. tostring(guideId), C_ELogModule.Guide)
    if guideId == 20007 then
      C_InputManager.SetCameraFollowMouse(false)
    end
    if not isSkipTrigger then
      if not self.isDebugActive then
        self:tryTriggerGuideByParams()
      end
      self:setGuideDebug(false)
    end
  end
  if guideId ~= nil then
    self:setWorldPause(false, guideId)
  end
end

function manager:isLocalGuideCompleted(guideId)
  return self._localGuideIdCache[guideId] == true
end

function manager:endGuide(guideId, isSkipTrigger)
  self:endGuideTree(guideId, isSkipTrigger)
  if guideId == nil then
    self:clearWorldPause("endGuideWithoutId")
  end
end

function manager:onEndSendEvent(guideId)
  self:internalSendEvent(G_GuideClasses.GuideEvent.GuideEnd, guideId)
  local args = CS.Lens.Gameplay.Modules.BigWorld.CommonIntDriveArgs()
  args.intVal = guideId
  C_DriveManager.DispatchDrive(C_EExternalDrive.DoGuideEnd, args)
end

function manager:isBattleGuideRunning()
  local tpl
  for guideId, tree in pairs(self._bavTreeData) do
    tpl = guideGroupTpl:getTplById(guideId)
    local isBattleGuide = guideGroupTpl:getIsBattleGuide(tpl)
    if isBattleGuide ~= 0 then
      return true
    end
  end
  return false
end

function manager:isGuideOnRunning(guideId)
  if guideId then
    return self._bavTreeData[guideId] ~= nil
  end
  return table.count(self._bavTreeData) > 0
end

function manager:getCurrentGuide()
  local res = {}
  for _, tree in pairs(self._bavTreeData) do
    table.insert(res, tree)
  end
  return res
end

function manager:saveStepId(guideId, step, isSkipTrigger)
  L_GuideStore:req_updateGuideData(guideId, step, function(success)
    if success then
      if step == 0 then
        self:saveMutualGuides(guideId)
        self:endGuide(guideId, isSkipTrigger)
      end
      C_MJLog.LogInfo(tostring(guideId) .. " 保存了步骤id:" .. step, C_ELogModule.Guide)
    end
  end)
end

function manager:saveMutualGuides(id)
  local groupTpl = guideGroupTpl:getTplById(id)
  if groupTpl then
    local mutualIds = guideGroupTpl:getMutualExclusion(groupTpl)
    if #mutualIds == 0 then
      return
    end
    for k, mutualId in ipairs(mutualIds) do
      if not L_GuideStore:isGuideComplete(mutualId, true) then
        local ids = {}
        local tpls = guideTpl:getGroup(mutualId)
        for _, tpl in ipairs(tpls) do
          table.insert(ids, guideTpl:getId(tpl))
        end
        table.insert(ids, 0)
        Timer.once(0.5 * k, function()
          self:saveMutualSteps(mutualId, ids)
        end, self)
      end
    end
  end
end

function manager:saveMutualSteps(guideId, steps)
  if #steps == 0 then
    return
  end
  local step = steps[1]
  table.remove(steps, 1)
  L_GuideStore:req_updateGuideData(guideId, step, function(success)
    if success then
      self:saveMutualSteps(guideId, steps)
      C_MJLog.LogInfo("互斥引导 " .. tostring(guideId) .. " 保存了步骤id:" .. step, C_ELogModule.Guide)
    end
  end)
end

function manager:getGuideBevData()
  return self._bavTreeData
end

function manager:getRunningGuideIds()
  local res = {}
  for k, _ in pairs(self._bavTreeData) do
    table.insert(res, k)
  end
  return res
end

function manager:getIsDetectSkill()
  return self.isDetectSkill
end

function manager:setIsDetectSkill(isDetect)
  self.isDetectSkill = isDetect
end

function manager:clear()
  self.guideActive = false
end

function manager:setForceNotCastSkill(isActive)
  self.isNotForceCastSkill = isActive
end

function manager:OnGuideNumFromZeroToOne()
  self:changeJumpToFuncStatus(false)
  self:changeTransferToFuncStatus(false)
  C_UIMgr.PausePriorityQueue()
end

function manager:OnGuideNumFromOneToZero()
  self:changeJumpToFuncStatus(true)
  self:changeTransferToFuncStatus(true)
  C_UIMgr.ResumePriorityQueue()
end

function manager:changeJumpToFuncStatus(status)
  if self.jumpToFuncStatus == status then
    return
  end
  self.jumpToFuncStatus = status
  L_JumpMgr:lockJump(not self.jumpToFuncStatus, "notice_guide_ban_jump")
end

function manager:changeTransferToFuncStatus(status)
  if self.transferToFuncStatus == status then
    return
  end
  self.transferToFuncStatus = status
end

function manager:checkIsDisableMapTransfer()
  if self.transferToFuncStatus == false then
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_guide_ban_transmit"))
    return true
  end
  return false
end

function manager:getIsNotForceCastSkill()
  return self.isNotForceCastSkill
end

function manager:debugGuideCondition(conditionId, param)
  local params = {
    guideParams = {
      {type = conditionId, param = param}
    }
  }
  local guidGroupIds = self:parseGuideParams(params)
  if not guidGroupIds then
    return
  end
  for _, groupId in ipairs(guidGroupIds) do
    C_MJLog.LogInfo("@guide 筛选出的引导组：" .. tostring(groupId), C_ELogModule.Guide)
  end
end

function manager:debugGuide(guideId)
  if guideId == nil then
    return
  end
  self.debugGuideId = guideId
  self:setGuideDebug(true)
  self:testGuide(guideId)
end

function manager:debugCSGuide(guideId, guideType, guideParams)
  local dataWrap = {}
  if guideId ~= 0 then
    dataWrap = {guideId = guideId}
  else
    dataWrap = {
      guideParams = {
        {type = guideType, param = guideParams}
      }
    }
  end
  self:startGuideHandle(dataWrap)
end

function manager:testGuide(guideId)
  local isGuideContitionSatisfy = false
  local isGuideNeedCb = false
  isGuideContitionSatisfy, isGuideNeedCb = self:checkConditionsByGuideId(guideId)
  C_MJLog.LogInfo("@guide Check if the guiding configuration conditions are met.：" .. tostring(isGuideContitionSatisfy), C_ELogModule.Guide)
  C_MJLog.LogInfo("@guide Whether the conditions for guiding code handwriting are met.：" .. tostring(self:checkCanRunGuide(guideId)), C_ELogModule.Guide)
  local config = self:getTpl():getTplById(guideId)
  if config then
    local path = L_Config:getPathByHash(config.bavTreePath)
    if not string.isEmpty(path) then
      local jsonHandle = C_LuaUtility.LoadRawTextSync(path)
      if not string.isEmpty(jsonHandle) then
        C_MJLog.LogInfo("开始引导 guideId:" .. guideId)
        local bevTree = L_BevTree:generateBevTree()
        bevTree:initialize(jsonHandle, {guideId = guideId})
        bevTree.jsonPath = path
        self._bavTreeData[guideId] = bevTree
        if table.count(self._bavTreeData) == 1 then
          self:OnGuideNumFromZeroToOne()
        end
        self:dealGuideInBattle(guideId)
      end
    end
  else
    C_MJLog.LogInfo("@guide No configuration file was found.", C_ELogModule.Guide)
  end
end

function manager:canStartGuide()
  return self.guideActive
end

function manager:setGmGuideState(state)
  self._tempGuideState = state
end

function manager:getGmGuideState()
  return self._tempGuideState
end

function manager:setGuideActive(isActive)
  local function rspCb()
    L_PlayerStore:getPlayerBaseInfo().skip_guide = isActive and 0 or 1
    
    self.guideActive = isActive
    C_MJLog.LogInfo("guide 引导状态修改" .. tostring(self.guideActive), C_ELogModule.Guide)
    if isActive then
      L_GuideManager:startAllGuide()
    else
      L_GuideManager:stopAllGuide()
    end
  end
  
  L_PlayerStore:req_skipGuide(isActive and 0 or 1, rspCb)
end

function manager:startAllGuide()
  local active = L_PlayerStore:getPlayerBaseInfo().skip_guide
  self.guideActive = active == nil or tonumber(active) == 0
end

function manager:stopAllGuide(isClearAll)
  C_MJLog.LogInfo("stop all guide" .. tostring(isClearAll), C_ELogModule.Guide)
  for guideId, tree in pairs(self._bavTreeData) do
    if tree then
      tree:onReset()
    end
    if guideId == 30015 then
      self:saveStepId(30015, 0)
    end
    if not isClearAll and guideId ~= 30015 then
      table.insert(self.restartCache, guideId)
    end
  end
  self:clearAllControl()
  self._bavTreeData = {}
  self._guideStatus = {}
  self.isDetectSkill = false
  self.isNotForceCastSkill = false
  self.checkRangeCount = 0
end

return manager

-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/CoreBattleFlow.lua

module("logic.battle.battleflow.CoreBattleFlow", package.seeall)

local CoreBattleFlow = class("CoreBattleFlow", IBattleFlowHandler)

function CoreBattleFlow:ctor()
	self._compList = {}
	self._workingWork = false

	self:_registerComponents()
	self:_notifyComponents(BattleFunctionName.onInit)
	self:handleInit()
end

function CoreBattleFlow:setSpeed(speed)
	BattleTime.timeScale = speed

	self:_notifyComponents(BattleFunctionName.onUpdateTimeScale)

	local scene = SceneMgr.instance:getScene(SceneType.Battle)

	scene.stage:setPlaySpeed(speed)
	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleSpeedUpdate)
end

function CoreBattleFlow:enter(battleFieldInfo)
	self.assistantSystemMgr:startAssistantSystems()
	self.model:setBattleFieldInfo(battleFieldInfo)
	self.model:setMode(battleFieldInfo.mode)
	self.model:setPhase(BattleEnum.Phase.READY)
	self:_notifyComponents(BattleFunctionName.onStart)
	self:handleEnterBattle()

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = self.model:isReconnectMode() and self:_createReconnectEnterFlow() or self:_createNormalEnterFlow()

	work:addChild(sequence)
	work:start(self)
end

function CoreBattleFlow:restart(restartType)
	if BattleLog.enableLog then
		BattleLog.log("CoreBattleFlow::restart start!")
	end

	local work = self:_createWork()

	work:setDoneCaller(self._onRestartFinish, self)

	local isRealEnd = self.model:getResultMO():isRealEnd()
	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(self:isShowBlackLoading()))
	sequence:addChild(WorkBattleSetupRestart.New())
	sequence:addChild(WorkBattleRequestStartBattle.New(isRealEnd, restartType))
	work:addChild(sequence)
	work:start(self)
end

function CoreBattleFlow:exit()
	local work = self:_createWork()

	work:setDoneCaller(self._onExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(self:createBeforeEndBattleWork())
	sequence:addChild(WorkGameEndReport.New())
	sequence:addChild(self:createCalculateWork())
	sequence:addChild(WorkBeforeExitBattle.New(self:isShowBlackLoading()))
	sequence:addChild(self:createExitBattleWork())
	sequence:addChild(self:createAfterExitBattleWork())
	work:addChild(sequence)
	work:start(self)
end

function CoreBattleFlow:forceExit()
	self:_destroyWork()
	self:_processBeforeExit()
	self:_processExitFinish()
end

function CoreBattleFlow:_createNormalEnterFlow()
	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(self:isShowBlackLoading()))
	sequence:addChild(WorkEnableLoadingOptimize.New())
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkBattleExitCurrentScene.New())
	sequence:addChild(WorkBattleLoadScene.New())
	sequence:addChild(WorkInterval.New(0.1))

	local loadParallel = FlowParallel.New()

	loadParallel:addChild(WorkLoadResource.New())
	loadParallel:addChild(WorkPreloadResource.New())
	sequence:addChild(loadParallel)
	sequence:addChild(WorkTriggerResourceLoaded.New())
	sequence:addChild(WorkTriggerEnterDone.New())
	sequence:addChild(WorkWaitBasicViewsOpen.New())
	sequence:addChild(WorkExecuteInitCommands.New())
	sequence:addChild(WorkBattlePrepareCameraEffect.New())
	sequence:addChild(WorkInterval.New(0.1))
	sequence:addChild(WorkDisableLoadingOptimize.New())
	sequence:addChild(WorkBattlePlayBossAnimation.New())
	sequence:addChild(WorkHideLoading.New())
	sequence:addChild(WorkTriggerBeforeCampAdjustmentGuide.New())
	sequence:addChild(WorkInterval.New(0.17))
	sequence:addChild(WorkWaitBeforeCampAdjustmentGuide.New())
	sequence:addChild(WorkBattleWinCondition.New())
	sequence:addChild(WorkBattleStartCameraEffect.New())
	sequence:addChild(WorkCampAdjustment.New())
	sequence:addChild(WorkPauseCmdExecuter.New())
	sequence:addChild(WorkPreviewTargetCameraEffect.New())
	sequence:addChild(WorkBackupCalculate.New())
	sequence:addChild(self:createBeforeStartBattleWork())
	sequence:addChild(WorkGameStartReport.New())
	sequence:addChild(WorkResumeCmdExecuter.New())
	sequence:addChild(WorkTriggerStart.New())

	return sequence
end

function CoreBattleFlow:_createReconnectEnterFlow()
	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(self:isShowBlackLoading()))
	sequence:addChild(WorkEnableLoadingOptimize.New())
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkBattleExitCurrentScene.New())
	sequence:addChild(WorkBattleLoadScene.New())
	sequence:addChild(WorkInterval.New(0.1))

	local loadParallel = FlowParallel.New()

	loadParallel:addChild(WorkLoadResource.New())
	loadParallel:addChild(WorkPreloadResource.New())
	sequence:addChild(loadParallel)
	sequence:addChild(WorkTriggerResourceLoaded.New())
	sequence:addChild(WorkTriggerEnterDone.New())
	sequence:addChild(WorkWaitBasicViewsOpen.New())
	sequence:addChild(WorkExecuteInitCommands.New())
	sequence:addChild(WorkReconnectSetup.New())
	sequence:addChild(WorkInterval.New(0.1))
	sequence:addChild(WorkDisableLoadingOptimize.New())
	sequence:addChild(WorkHideLoading.New())
	sequence:addChild(WorkBackupCalculate.New())
	sequence:addChild(WorkReconnectStarter.New())
	sequence:addChild(WorkTriggerStart.New())

	return sequence
end

function CoreBattleFlow:_registerComponents()
	self.netAgent = BattleAgent.instance

	self:_addComponent("model", BattleModel)
	self:_addComponent("settingModel", BattleSettingModel)
	self:_addComponent("settingMgr", BattleSettingMgr)
	self:_addComponent("infoCollector", BattleInfoCollector)
	self:_addComponent("assistantSystemMgr", BattleAssistantSystemMgr)
	self:_addComponent("boardMgr", BattleCheckerBoardMgr)
	self:_addComponent("cameraMgr", BattleCameraMgr)
	self:_addComponent("pathArrow", BattlePathArrow)
	self:_addComponent("resMgr", BattleResourceMgr)
	self:_addComponent("preloadMgr", BattleResourcePreloadMgr)
	self:_addComponent("unitMgr", BattleUnitMgr)
	self:_addComponent("boardModel", BattleBoardModel)
	self:_addComponent("pathFinder", BattlePathFinder)
	self:_addComponent("sharedPathFinder", BattlePathFinder)
	self:_addComponent("cmdExecuter", BattleCmdExecuter)
	self:_addComponent("unitOperator", BattleUnitOperator)
	self:_addComponent("releaseSkillAgent", BattleReleaseSkillAgent)
	self:_addComponent("campOperator", BattleCampOperator)
	self:_addComponent("netEventMgr", BattleNetEventMgr)
	self:_addComponent("viewMgr", BattleViewMgr)
	self:_addComponent("campPlayer", BattleCampPlayer)
	self:_addComponent("localLogic", BattleLocalLogic)
	self:_addComponent("roundReport", BattleCompRoundReport)
	self:_addComponent("forecastDrawing", BattleCompForecastDrawing)
	self:_addComponent("snipingDrawing", BattleCompSnipingDrawing)
	self:_addComponent("dangerArea", BattleDangerArea)
	self:_addComponent("scenePickerHandler", BattleScenePickerHandler)
	self:_addComponent("campAdjustment", BattleCampAdjustment)
	self:_addComponent("haloLinks", BattleCompHaloLinks)
	self:_addComponent("forecastMgr", BattleForecastMgr)
	self:_addComponent("aiForecastMgr", BattleAiForecastMgr)
	self:_addComponent("additionalTerrainMgr", BattleAdditionalTerrainMgr)
	self:_addComponent("pianoTerrainMgr", BattlePianoTerrainMgr)
	self:_addComponent("loopAnimSynMgr", BattleLoopAnimSynMgr)
	self:_addComponent("plotPerformanceMgr", BattlePlotPerformanceMgr)
	self:_addComponent("sceneGameObjectMgr", BattleSceneGameObjectMgr)
	self:_addComponent("effectPlayer", BattleCompEffectPlayer)
	self:_addComponent("undoMgr", BattleCompUndoMgr)
end

function CoreBattleFlow:_onEnterFinish(result)
	if result ~= WorkResult.Succeed then
		if BattleLog.enableError then
			BattleLog.error("CoreBattleFlow::enter failed,result:", result)
		end

		return
	end

	self:_processEnterFinish()

	local snapshotInfo = BattleSnapshotInfo:createInstance()

	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleStart, snapshotInfo)
	snapshotInfo:returnSelf()
end

function CoreBattleFlow:_onExitFinish(result)
	local snapshotInfo = BattleSnapshotInfo:createInstance()

	self:_processExitFinish()
	BattleDispatcher:dispatchEvent(BattleEventType.OnBattleExitFinish, snapshotInfo)
	snapshotInfo:returnSelf()
end

function CoreBattleFlow:_onRestartFinish(result)
	if BattleLog.enableLog then
		BattleLog.log("CoreBattleFlow::restart finish!")
	end
end

function CoreBattleFlow:_processBeforeExit()
	self:_notifyComponents(BattleFunctionName.onPreClear)
end

function CoreBattleFlow:_processExitFinish()
	self:_clearForExit()
	self:handleExitBattleFinish()
	self.resMgr:clearCacheResources()
	BattleMgr.instance:internalExitFinish()
end

function CoreBattleFlow:_processEnterFinish()
	return
end

function CoreBattleFlow:_clearForExit(isRestart)
	self:_notifyComponents(BattleFunctionName.onClear, isRestart)
	self.assistantSystemMgr:clearAfterExit()
end

function CoreBattleFlow:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function CoreBattleFlow:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function CoreBattleFlow:_notifyComponents(functionName, ...)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component, ...)
		end
	end
end

function CoreBattleFlow:_addComponent(compName, compClass)
	local compInst = compClass.New()

	self[compName] = compInst
	compInst.flow = self

	table.insert(self._compList, compInst)
end

function CoreBattleFlow:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

function CoreBattleFlow:internal_BeforeExit()
	self:_processBeforeExit()
end

function CoreBattleFlow:internal_ClearForExit(isRestart)
	self:_clearForExit(isRestart)
end

function CoreBattleFlow:internal_NotifyComponent(functionName)
	self:_notifyComponents(functionName)
end

function CoreBattleFlow:leaveScene()
	self:_notifyComponents(SceneFunctionName.onLeaveScene)
	ScenePickerViewFacade.instance:close(BattleConst.DefaultStateKey)
	BattleCalculateMgr.instance:hidePerform()
	SkillPerformanceAssistant:hideUIProperties()
	SkillPerformanceAssistant:hideSceneObjectRoot()
end

function CoreBattleFlow:returnScene()
	self:_notifyComponents(SceneFunctionName.onReturnScene)
	ScenePickerViewFacade.instance:open(BattleConst.DefaultStateKey)
	BattleCalculateMgr.instance:showPerform()

	local isRealEnd = self.model:getResultMO():isRealEnd()

	if not isRealEnd then
		SkillPerformanceAssistant:showUIProperties()
		SkillPerformanceAssistant:showSceneObjectRoot()
	end
end

function CoreBattleFlow:onReturnSceneFinished()
	self:_notifyComponents(SceneFunctionName.onReturnSceneFinished)
end

return CoreBattleFlow

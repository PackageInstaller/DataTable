-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/BattleMgr.lua

module("logic.battle.BattleMgr", package.seeall)

local BattleMgr = class("BattleMgr")

function BattleMgr:ctor()
	self._battleFlowCaches = {}
	self._activeBattleFlow = false
end

function BattleMgr:enter(originalInfo, battleFlowClass, mode)
	if BattleLog.enableLog then
		BattleLog.logServer(string.format("BattleMgr:enter battle = {%s}, data = %s", OOPUtil.getClassName(battleFlowClass), originalInfo))
	end

	self:_setActiveBattleFlow(battleFlowClass or DefaultBattleFlow)

	local battleFieldInfo = self._activeBattleFlow:buildBattleFieldInfo(originalInfo)

	battleFieldInfo.mode = mode or BattleEnum.Mode.NORMAL

	self._activeBattleFlow:enter(battleFieldInfo)
end

function BattleMgr:enterWithClientInfo(battleFieldInfo)
	self:_setActiveBattleFlow(ClientPreviewBattleFlow)
	self._activeBattleFlow:enter(battleFieldInfo, BattleEnum.Mode.NORMAL)
end

function BattleMgr:userRequestRestart(restartType)
	if not self._activeBattleFlow:isSupportRestart() then
		local dialog = Dialog.showMessage(lang("tip_reinvestigation"), lang("tip_fight_not_investigate"))

		dialog:setViewRootType(ViewRootType.Popup)

		return
	end

	self._activeBattleFlow:userRequestRestart(restartType)
end

function BattleMgr:exit()
	self._activeBattleFlow:exit()
end

function BattleMgr:forceExit()
	if self._activeBattleFlow then
		self._activeBattleFlow:forceExit()
	end
end

function BattleMgr:isInBattle()
	return self._activeBattleFlow and true or false
end

function BattleMgr:getActiveBattleFlow()
	return self._activeBattleFlow
end

function BattleMgr:internalExitFinish()
	self:_clearActiveBattleFlow()
end

function BattleMgr:internalPause(isPause)
	local cmdExecuter = self:getCmdExecuter()

	cmdExecuter:setPause(isPause)
end

function BattleMgr:getResourceMgr()
	return self._activeBattleFlow.resMgr
end

function BattleMgr:getUnitMgr()
	return self._activeBattleFlow.unitMgr
end

function BattleMgr:getForecastMgr()
	return self._activeBattleFlow.forecastMgr
end

function BattleMgr:getModel()
	return self._activeBattleFlow.model
end

function BattleMgr:getSettingModel()
	return self._activeBattleFlow.settingModel
end

function BattleMgr:getBoardModel()
	return self._activeBattleFlow.boardModel
end

function BattleMgr:getBoardMgr()
	return self._activeBattleFlow.boardMgr
end

function BattleMgr:getDangerArea()
	return self._activeBattleFlow.dangerArea
end

function BattleMgr:getPathFinder()
	return self._activeBattleFlow.pathFinder
end

function BattleMgr:getSharedPathFinder()
	return self._activeBattleFlow.sharedPathFinder
end

function BattleMgr:getCmdExecuter()
	return self._activeBattleFlow.cmdExecuter
end

function BattleMgr:getPathArrow()
	return self._activeBattleFlow.pathArrow
end

function BattleMgr:getCampAdjustment()
	return self._activeBattleFlow.campAdjustment
end

function BattleMgr:getNetAgent()
	return self._activeBattleFlow.netAgent
end

function BattleMgr:getNetEventMgr()
	return self._activeBattleFlow.netEventMgr
end

function BattleMgr:getLocalLogic()
	return self._activeBattleFlow.localLogic
end

function BattleMgr:getServerSimulation()
	return self._activeBattleFlow.serverSimulation
end

function BattleMgr:getInfoCollector()
	return self._activeBattleFlow.infoCollector
end

function BattleMgr:getCapterMgr()
	return self._activeBattleFlow.battleCapture
end

function BattleMgr:getUnitOperator()
	return self._activeBattleFlow.unitOperator
end

function BattleMgr:getReleaseSkillAgent()
	return self._activeBattleFlow.releaseSkillAgent
end

function BattleMgr:getCampOperator()
	return self._activeBattleFlow.campOperator
end

function BattleMgr:getMultiPlayerNetStateMgr()
	return self._activeBattleFlow.multiPlayerNetStateMgr
end

function BattleMgr:getAdditionalTerrainMgr()
	return self._activeBattleFlow.additionalTerrainMgr
end

function BattleMgr:getPianoTerrainMgr()
	return self._activeBattleFlow.pianoTerrainMgr
end

function BattleMgr:getWinCondition()
	return self._activeBattleFlow.winCondition
end

function BattleMgr:getScenePicker()
	return self._activeBattleFlow.scenePickerHandler
end

function BattleMgr:getCameraMgr()
	return self._activeBattleFlow.cameraMgr
end

function BattleMgr:getSnipingDrawing()
	return self._activeBattleFlow.snipingDrawing
end

function BattleMgr:getEffectPlayer()
	return self._activeBattleFlow.effectPlayer
end

function BattleMgr:getUndoMgr()
	return self._activeBattleFlow.undoMgr
end

function BattleMgr:getPlotPerformanceMgr()
	return self._activeBattleFlow.plotPerformanceMgr
end

function BattleMgr:getSceneGameObjectMgr()
	return self._activeBattleFlow.sceneGameObjectMgr
end

function BattleMgr:_setActiveBattleFlow(battleFlowClass)
	local battleFlow = self._battleFlowCaches[battleFlowClass]

	if not battleFlow then
		battleFlow = battleFlowClass.New()
		self._battleFlowCaches[battleFlowClass] = battleFlow
	end

	self._activeBattleFlow = battleFlow
end

function BattleMgr:_clearActiveBattleFlow()
	self._activeBattleFlow = false
end

BattleMgr.instance = BattleMgr.New()

return BattleMgr

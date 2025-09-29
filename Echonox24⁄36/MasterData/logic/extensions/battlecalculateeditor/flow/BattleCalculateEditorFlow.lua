-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/flow/BattleCalculateEditorFlow.lua

module("logic.extensions.battlecalculateeditor.flow.BattleCalculateEditorFlow", package.seeall)

local M = class("BattleCalculateEditorFlow", CoreBattleFlow)

function M:buildBattleFieldInfo(battleInfoNO)
	return {}
end

function M:enter(battleFieldInfo)
	self:_notifyComponents(BattleFunctionName.onStart)
	self:handleEnterBattle()

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = self:_createNormalEnterFlow()

	work:addChild(sequence)
	work:start(self)
end

function M:_registerComponents()
	self.netAgent = BattleAgent.instance

	self:_addComponent("model", BattleCalculateEditorModel)
	self:_addComponent("cameraMgr", BattleCameraMgr)
	self:_addComponent("resMgr", BattleCalculateEditorResourceMgr)
	self:_addComponent("viewMgr", BattleCalculateEditorViewMgr)
	self:_addComponent("sceneGameObjectMgr", BattleSceneGameObjectMgr)
end

function M:_createNormalEnterFlow()
	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(self:isShowBlackLoading()))
	sequence:addChild(WorkEnableLoadingOptimize.New())
	sequence:addChild(WorkInterval.New(0.2))
	sequence:addChild(WorkBattleExitCurrentScene.New())
	sequence:addChild(WorkBattleCalculateEditorLoadScene.New())
	sequence:addChild(WorkLoadResource.New())
	sequence:addChild(WorkTriggerResourceLoaded.New())
	sequence:addChild(WorkInterval.New(0.1))
	sequence:addChild(WorkDisableLoadingOptimize.New())
	sequence:addChild(WorkHideLoading.New())
	sequence:addChild(WorkInterval.New(0.17))

	return sequence
end

function M:exit()
	local work = self:_createWork()

	work:setDoneCaller(self._processExitFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkBeforeExitBattle.New())
	sequence:addChild(self:createExitBattleWork())
	work:addChild(sequence)
	work:start(self)
end

function M:_clearForExit(isRestart)
	self:_notifyComponents(BattleFunctionName.onClear, isRestart)
end

function M:_onEnterFinish(result)
	self:_processEnterFinish()
end

function M:createExitBattleWork()
	return WorkBattleExitScene.New()
end

function M:handleExitBattleFinish()
	SceneFace.instance:enterRoomScene(true, true)
	ViewMgr.instance:open(ViewName.MainUIView)
	ViewMgr.instance:open(ViewName.HackToolView)
end

return M

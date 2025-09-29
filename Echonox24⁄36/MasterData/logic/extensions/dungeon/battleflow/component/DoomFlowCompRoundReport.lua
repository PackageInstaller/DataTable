-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/component/DoomFlowCompRoundReport.lua

module("logic.extensions.dungeon.battleflow.component.DoomFlowCompRoundReport", package.seeall)

local DoomFlowCompRoundReport = class("DoomFlowCompRoundReport", BattleCompRoundReport)

function DoomFlowCompRoundReport:onStart()
	DoomFlowCompRoundReport.super.onStart(self)

	self._model = self.flow.model or false
	self._unitMgr = self.flow.unitMgr or false
	self._doomLogic = self.flow.doomLogic or false
	self._localLogic = self.flow.localLogic or false
	self._timelineTask = TimelineTask.New()
	self._randomType = 0

	BattleDispatcher:addEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
	GlobalDispatcher:addEventListener(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, self._onEnterOrExitBttleVsScene, self)
end

function DoomFlowCompRoundReport:onClear()
	DoomFlowCompRoundReport.super.onClear(self)
	self._forecastComp:clear()

	self._forecastComp = false
	self._model = false
	self._unitMgr = false
	self._doomLogic = false
	self._localLogic = false

	self._timelineTask:clear()

	self._randomType = 0

	BattleDispatcher:removeEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
	GlobalDispatcher:removeEventListener(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, self._onEnterOrExitBttleVsScene, self)
end

function DoomFlowCompRoundReport:onResourceLoaded()
	local resMgr = BattleMgr.instance:getResourceMgr()
	local forecastGo = resMgr:getInst(BattleResourceName.DoomForecastTitle)

	self._forecastComp = DoomEventBroadcastComp.New(forecastGo)
end

function DoomFlowCompRoundReport:playPlayerStartedReport(campId, callback, callbackSelf)
	if self._model:getOperateCampId() ~= campId then
		Handler:executeCallback(callback, callbackSelf)

		return
	end

	self._randomType = math.random() > 0.5 and 1 or 2

	self._timelineTask:addFinishListener(callback, callbackSelf)
	self._timelineTask:addTask(0, self._tFocusCamera, self)
	self._timelineTask:addTask(BattleConst.DelayZeroPointFive, self._tShowRandomNotify, self)
	self._timelineTask:addTask(BattleConst.DelayThree)
	self._timelineTask:start(self._randomType)
end

function DoomFlowCompRoundReport:playPlayerEndedReport(campId, callback, callbackSelf)
	if self._model:getOperateCampId() ~= campId then
		Handler:executeCallback(callback, callbackSelf)

		return
	end

	local randomType = 3

	self._timelineTask:addFinishListener(callback, callbackSelf)
	self._timelineTask:addTask(0, self._tFocusCamera, self)
	self._timelineTask:addTask(BattleConst.DelayZeroPointFive, self._tShowRandomNotify, self)
	self._timelineTask:addTask(BattleConst.DelayThree)
	self._timelineTask:start(randomType)
end

function DoomFlowCompRoundReport:_tFocusCamera()
	local unit = self._unitMgr:getUnit(self._doomLogic:getSourceEntityId())
	local x, y, z = BattleUnitUtil.getUnitDiffFocusPos(unit)

	BattleCameraUtil.doFollowPosition(x, y, z, BattleConst.DelayZeroPointFive)
end

function DoomFlowCompRoundReport:_tShowRandomNotify(randomType)
	self._forecastComp:showNotify(self._doomLogic, randomType)

	local unit = self._unitMgr:getUnit(self._doomLogic:getSourceEntityId())

	if randomType == 3 then
		unit.effectPlayer:playEffect(10057)
	else
		unit.effectPlayer:playEffect(10056)
	end
end

function DoomFlowCompRoundReport:_onEnterOrExitBttleVsScene(_, isEnter)
	if not isEnter then
		self._forecastComp:setVisible(not isEnter)
	end
end

function DoomFlowCompRoundReport:initializeNotifyView()
	local selectedTargetIndex = self._doomLogic:getSelectedTargetIndex()

	if selectedTargetIndex then
		if self._localLogic:isOperateCamp() then
			self._randomType = math.random() > 0.5 and 1 or 2
		else
			self._randomType = 3
		end

		self._forecastComp:showNotify(self._doomLogic, self._randomType)
	end
end

function DoomFlowCompRoundReport:_onBattleStart()
	self:initializeNotifyView()
end

return DoomFlowCompRoundReport

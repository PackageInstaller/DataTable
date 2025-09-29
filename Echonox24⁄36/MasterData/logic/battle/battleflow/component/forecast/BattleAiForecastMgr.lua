-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/BattleAiForecastMgr.lua

module("logic.battle.battleflow.component.forecast.BattleAiForecastMgr", package.seeall)

local BattleAiForecastMgr = class("BattleAiForecastMgr", IBattleFlowComp)
local kBaseAiForecastKey = "base_ai_forecast_key"

function BattleAiForecastMgr:onInit()
	self._requestingQueue = Queue.create()
	self._forecastCaches = {}
	self._activeForecastResult = false
end

function BattleAiForecastMgr:onStart()
	self:_setEvent(true)

	self._forecastDrawing = self.flow.forecastDrawing or false

	self:clearCaches()
	self._requestingQueue:clear()
end

function BattleAiForecastMgr:onClear()
	self:_setEvent(false)

	self._forecastDrawing = false

	self:clearCaches()
	self._requestingQueue:clear()
end

function BattleAiForecastMgr:activeBaseForecastResult()
	self:setActiveForecastResult(kBaseAiForecastKey)
end

function BattleAiForecastMgr:pushRequestAiForecast(forecastKey)
	local forecastResult = self._forecastCaches[forecastKey]

	if forecastResult then
		return forecastResult
	end

	forecastResult = BattleAiForecastResult:createInstance()
	self._forecastCaches[forecastKey] = forecastResult

	self._requestingQueue:enqueue(forecastKey)

	return forecastResult
end

function BattleAiForecastMgr:setActiveForecastResult(forecastKey)
	self._activeForecastResult = self._forecastCaches[forecastKey]

	self._forecastDrawing:updateAiForecast()
end

function BattleAiForecastMgr:getActiveForecastResult()
	return self._activeForecastResult
end

function BattleAiForecastMgr:clearCaches()
	BattleTableUtil.clearReusableTable(self._forecastCaches)
end

function BattleAiForecastMgr:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_AI_FORECAST_PUSH, self._onAiForecastPush, self)
		BattleDispatcher:addEventListener(BattleEventType.OnOperateNextUnit, self._onOperateNextUnit, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_AI_FORECAST_PUSH, self._onAiForecastPush, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnOperateNextUnit, self._onOperateNextUnit, self)
	end
end

function BattleAiForecastMgr:_requestBaseAiForecast()
	self:pushRequestAiForecast(kBaseAiForecastKey)
	BattleAgent.instance:sendForecastAiRequest()
end

function BattleAiForecastMgr:_onOperateNextUnit()
	self:clearCaches()
	self:_requestBaseAiForecast()
	self:activeBaseForecastResult()
end

function BattleAiForecastMgr:_onAiForecastPush(evt, msg)
	local forecastKey = self._requestingQueue:dequeue()
	local forecastResult = self._forecastCaches[forecastKey]

	if forecastResult and msg then
		forecastResult:initFromAiForecastNOList(msg.forecastAis)

		if forecastResult == self._activeForecastResult then
			BattleDispatcher:dispatchEvent(BattleEventType.OnAiForecastResultUpdate, forcastResult)
		end
	end
end

return BattleAiForecastMgr

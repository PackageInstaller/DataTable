local FogNightmareAutoPlayData = class("FogNightmareAutoPlayData")

function FogNightmareAutoPlayData:ctor()
	self._cmdManager = require("app.view.module.fogNightmare.model.struct.execute.FogNightmareCmdManager").new()
	self._visualPlayer = nil
	self._timeInterval = 0.5
end

function FogNightmareAutoPlayData:initData()
	self:stopAutoPlay()
	self._cmdManager:clearAllCmd()

	self._timeInterval = 0.5
	self._visualPlayer = nil
	self._lowHpNum = 6
	self._isAutoPlaying = false
	self._waiterParam = nil
	self._isAutoSkip = false
	self._forceOpen = false
end

function FogNightmareAutoPlayData:setForceOpenAuto(arg_3_1)
	self._forceOpen = arg_3_1
end

function FogNightmareAutoPlayData:isForceOpenAuto()
	return self._forceOpen
end

function FogNightmareAutoPlayData:setVisualPlayer(arg_5_1)
	self._visualPlayer = arg_5_1
end

function FogNightmareAutoPlayData:setAutoInterval(arg_6_1)
	self._timeInterval = arg_6_1
end

function FogNightmareAutoPlayData:getAutoInterval()
	return self._timeInterval
end

function FogNightmareAutoPlayData:setWaiterParam(arg_8_1)
	self._waiterParam = arg_8_1
end

function FogNightmareAutoPlayData:getWaiterParam()
	return self._waiterParam
end

function FogNightmareAutoPlayData:checkCurCmdId(arg_10_1, arg_10_2)
	local var_10_0 = false
	local var_10_1 = self._cmdManager:getCurCmd()

	if var_10_1 then
		var_10_0 = var_10_1:getId() == arg_10_1
	end

	if not var_10_0 and arg_10_2 then
		self._cmdManager:clearAllCmd()
	end

	return var_10_0
end

function FogNightmareAutoPlayData:doAndCheckNextCmd()
	local var_11_0 = self._cmdManager:popCmd()

	if var_11_0 then
		return var_11_0:execute()
	end

	return false
end

function FogNightmareAutoPlayData:prepareAutoPlay(arg_12_1)
	self._cmdManager:clearAllCmd()
	self._visualPlayer:startThinking()

	return handler(self, self._autoPlay)
end

function FogNightmareAutoPlayData:setLowHpNum(arg_13_1)
	self._lowHpNum = arg_13_1
end

function FogNightmareAutoPlayData:getLowHpNum()
	return self._lowHpNum
end

function FogNightmareAutoPlayData:stopAutoPlay(arg_15_1)
	if self._isAutoPlaying then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_FOG_NIGHTMARE_AUTO_PLAY_STOP, false, arg_15_1)
	end

	self:setLowHpNum(6)

	self._isAutoPlaying = false
	self._isAutoSkip = false

	if self._visualPlayer then
		self._visualPlayer:stopThinking()
	end
end

function FogNightmareAutoPlayData:_autoPlay()
	self._isAutoPlaying = true

	if not self:_checkTime() then
		self:stopAutoPlay(g.core.lang:get(500257))

		return
	end

	self:_doCmd()

	local var_16_0 = self._cmdManager:getCurCmd()

	while var_16_0 and var_16_0:isQuickTrigger() do
		self:_doCmd()

		if var_16_0 == self._cmdManager:getCurCmd() or not self._isAutoPlaying then
			break
		end

		var_16_0 = self._cmdManager:getCurCmd()
	end
end

function FogNightmareAutoPlayData:_doCmd()
	local var_17_0 = self._cmdManager:getCurCmd() or self._cmdManager:popCmd()

	if not var_17_0 then
		self:stopAutoPlay()

		return
	end

	var_17_0:execute()

	if var_17_0:isFinish() then
		var_17_0:onInactive()
		self._cmdManager:popCmd()
	end
end

function FogNightmareAutoPlayData:_checkTime()
	return g.core.common.ServerTime:getTime() <= g.core.model.User.fogNightmareData:getEndTime()
end

function FogNightmareAutoPlayData:getCmdManager()
	return self._cmdManager
end

function FogNightmareAutoPlayData:isAutoPlay()
	return self._isAutoPlaying
end

function FogNightmareAutoPlayData:setAutoSkipEnable(arg_21_1)
	self._isAutoSkip = arg_21_1
end

function FogNightmareAutoPlayData:isAutoSkipEnable()
	return self._isAutoSkip
end

return FogNightmareAutoPlayData

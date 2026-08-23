local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.config.mystery_stage_info
local MysteryStageData = class("MysteryStageData")

function MysteryStageData:ctor(arg_1_1)
	self._stageId = arg_1_1
	self._isExist = true
	self._isPassed = false
	self._lastKillTime = 0
	self._lockTime = 0
	self._stageCfg = var_0_1.get(arg_1_1)
end

function MysteryStageData:updateServerInfo(arg_2_1)
	if arg_2_1.last_kill_time then
		self._lastKillTime = arg_2_1.last_kill_time
	end

	if arg_2_1.lock_time then
		self._lockTime = arg_2_1.lock_time
	end
end

function MysteryStageData:setPassed()
	self._isPassed = true
end

function MysteryStageData:getPassed()
	return self._isPassed
end

function MysteryStageData:isMonsterLockTime()
	if var_0_0:getTime() < self._lockTime then
		return true
	else
		return false
	end
end

function MysteryStageData:getStageLockTime()
	return self._lockTime
end

function MysteryStageData:setLastKillTime(arg_7_1)
	self._lastKillTime = math.max(0, arg_7_1)
end

function MysteryStageData:getStageLastKillTime()
	return self._lastKillTime
end

function MysteryStageData:isMonsterExist()
	if var_0_0:getTime() > self._lastKillTime + self._stageCfg.reborn_time then
		return true
	else
		return false
	end
end

function MysteryStageData:getStageCfg()
	return self._stageCfg
end

function MysteryStageData:getDropAwards()
	return (g.core.common.Drops:getGoodsArray(self._stageCfg.drop_reward))
end

return MysteryStageData

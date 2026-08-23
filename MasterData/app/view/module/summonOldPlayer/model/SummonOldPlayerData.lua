local SummonOldPlayerData = class("SummonOldPlayerData")

function SummonOldPlayerData:ctor()
	self:initData()
end

function SummonOldPlayerData:initData()
	self._createdSvrData = nil
	self._isNeedChangeNewSvr = nil
	self._rechargeAmount = 0
	self._isSubscribe = false
	self._isOldPlayer = false
	self._inheritServerId = 0
	self._activityData = nil
end

function SummonOldPlayerData:onRedPointInfo(arg_3_1)
	self._activityData = arg_3_1.activity
	self._isOldPlayer = arg_3_1.is_old_player
	self._inheritServerId = arg_3_1.inherit_server_id or 0
end

function SummonOldPlayerData:onS2CGetInfo(arg_4_1)
	self._rechargeAmount = arg_4_1.recharge_amount
	self._isSubscribe = arg_4_1.is_subscribe
	self._isOldPlayer = arg_4_1.is_old_player
	self._inheritServerId = arg_4_1.inherit_server_id
end

function SummonOldPlayerData:getRechargeAmount()
	return self._rechargeAmount
end

function SummonOldPlayerData:isSubscribe()
	return self._isSubscribe
end

function SummonOldPlayerData:getInheritServerId()
	return self._inheritServerId
end

function SummonOldPlayerData:setLoginNewSvr()
	self._isNeedChangeNewSvr = true
end

function SummonOldPlayerData:getLoginNewSvrData()
	return self._isNeedChangeNewSvr
end

function SummonOldPlayerData:isShowDoor()
	if not self._activityData then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUMMON_OLD_PLAYER) then
		return false
	end

	local var_10_0 = g.core.model.User:getLevel()

	if var_10_0 < self._activityData.min_level or var_10_0 > self._activityData.max_level then
		return false
	end

	local var_10_1 = g.core.common.ServerTime:getTime()

	if var_10_1 < self._activityData.start_time or var_10_1 > self._activityData.end_time then
		return false
	end

	return self._isOldPlayer
end

function SummonOldPlayerData:getActivityCloseTime()
	return self._activityData.end_time
end

return SummonOldPlayerData

local var_0_0 = g.core.const.ConstMgr.SevenDaysConst.RECEIVE_STATE
local var_0_1 = g.core.const.ConstMgr.SevenDaysConst.ACT_VALUE
local var_0_2 = g.core.common.Goods
local var_0_3 = g.core.model.User.resourceData
local var_0_4 = g.core.config.sevendays_points_reward_info
local SevenDaysIntegralAwardStruct = class("SevenDaysIntegralAwardStruct")

function SevenDaysIntegralAwardStruct:ctor(arg_1_1)
	self._info = arg_1_1
	self._preScore = 0
	self._nextScore = arg_1_1.score
	self._received = false

	self:_initPreNextScore()
end

function SevenDaysIntegralAwardStruct:_initPreNextScore()
	local var_2_0 = var_0_4.fetch(self._info.id - 1)

	if var_2_0 and var_2_0.type == self._info.type then
		self._preScore = var_2_0.score
	end

	local var_2_1 = var_0_4.fetch(self._info.id + 1)

	if var_2_1 and var_2_1.type == self._info.type then
		self._nextScore = var_2_1.score
	end
end

function SevenDaysIntegralAwardStruct:getInfo()
	return self._info
end

function SevenDaysIntegralAwardStruct:getCurIntegral(arg_4_1)
	return var_0_3:getResourceById((arg_4_1 == var_0_1.PHASE_2 or nil) and var_0_2.RESOURCE.TYPE_COURAGE_2)
end

function SevenDaysIntegralAwardStruct:getReceiveState()
	if self._received then
		return var_0_0.RECEIVED
	elseif self:getCurIntegral(self._info.type) < self._info.score then
		return var_0_0.NOT_ACHIEVED
	else
		return var_0_0.CAN_RECEIVE
	end
end

function SevenDaysIntegralAwardStruct:setReceived(arg_6_1)
	self._received = arg_6_1
end

function SevenDaysIntegralAwardStruct:getProgressRelativePre()
	return self:_getProgress(self._preScore, self._info.score)
end

function SevenDaysIntegralAwardStruct:getProgressRelativeNext()
	return self:_getProgress(self._info.score, self._nextScore)
end

function SevenDaysIntegralAwardStruct:_getProgress(arg_9_1, arg_9_2)
	if arg_9_2 - arg_9_1 <= 0 then
		return 100
	else
		return math.max(0, self:getCurIntegral(self._info.type) - arg_9_1) / (arg_9_2 - arg_9_1) * 100
	end
end

return SevenDaysIntegralAwardStruct

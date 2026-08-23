local ActivityGetStaminaConst = require("app.view.module.activity.const.ActivityGetStaminaConst")
local var_0_1 = ActivityGetStaminaConst.RECEIVE_STATE
local var_0_2 = g.core.common.ServerTime
local var_0_3 = g.core.config.time_event_info
local var_0_4 = g.core.config.get_stamina_info
local var_0_5 = g.core.common.GlobalFunc
local var_0_6 = g.core.common.Goods
local ActivityGetStaminaData = class("ActivityGetStaminaData")

function ActivityGetStaminaData:ctor()
	self:initData()
end

function ActivityGetStaminaData:initData()
	self._timeEventList = {}
	self._receivedIdList = {}

	self:_initTimeEventList()
end

function ActivityGetStaminaData:_initTimeEventList()
	for iter_3_0, iter_3_1 in var_0_3:ipairs() do
		if iter_3_1.id == ActivityGetStaminaConst.TIME_EVENT_INFO_ID then
			table.insert(self._timeEventList, iter_3_1)
		end
	end
end

function ActivityGetStaminaData:getTimeEventList()
	if #self._timeEventList > 1 then
		table.sort(self._timeEventList, self:_getSortRuleByTime())
	end

	return self._timeEventList
end

function ActivityGetStaminaData:_getSortRule()
	return function(arg_6_0, arg_6_1)
		local var_6_0 = self:getReceivedState(arg_6_0)
		local var_6_1 = self:getReceivedState(arg_6_1)

		if var_6_0 == var_6_1 then
			return arg_6_0.open_time < arg_6_1.open_time
		else
			return var_6_0 < var_6_1
		end
	end
end

function ActivityGetStaminaData:_getSortRuleByTime()
	return function(arg_8_0, arg_8_1)
		return arg_8_0.open_time < arg_8_1.open_time
	end
end

function ActivityGetStaminaData:getTimeEventInfo(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._timeEventList) do
		if iter_9_1.num == arg_9_1 then
			return iter_9_1
		end
	end
end

function ActivityGetStaminaData:getStaminaInfo(arg_10_1)
	return var_0_4.fetch(arg_10_1)
end

function ActivityGetStaminaData:getId(arg_11_1)
	return arg_11_1.num
end

function ActivityGetStaminaData:getReceivedState(arg_12_1)
	if self:isReceived((self:getId(arg_12_1))) then
		return var_0_1.RECEIVED
	end

	local var_12_0 = var_0_2:secondsFromToday()

	if var_12_0 < arg_12_1.open_time then
		return var_0_1.NOT_RECEIVED
	elseif var_12_0 > arg_12_1.end_time then
		return var_0_1.CAN_RETROACTIVE
	else
		return var_0_1.CAN_RECEIVE
	end
end

function ActivityGetStaminaData:isReceived(arg_13_1)
	return checkbool((table.indexof(self._receivedIdList, arg_13_1)))
end

function ActivityGetStaminaData:isOverflowIfGet(arg_14_1)
	return (var_0_5.isOverflowIfAdd({
		type = var_0_6.TYPE_RESOURCE,
		value = var_0_6.RESOURCE.TYPE_STAMINA
	}, self:getStaminaInfo(arg_14_1).stamina))
end

function ActivityGetStaminaData:isEnoughMoneyRetroactive(arg_15_1)
	return g.core.model.User:getFreeGold() >= self:getStaminaInfo(arg_15_1).supplement_cost
end

function ActivityGetStaminaData:isExistStaminaGet()
	for iter_16_0, iter_16_1 in ipairs(self._timeEventList) do
		if self:getReceivedState(iter_16_1) == var_0_1.CAN_RECEIVE then
			return true
		end
	end
end

function ActivityGetStaminaData:onRcvGetStaminaInfo(arg_17_1)
	self._receivedIdList = arg_17_1.ids or {}
end

function ActivityGetStaminaData:onRcvGetStaminaGet(arg_18_1)
	if arg_18_1.id then
		table.insert(self._receivedIdList, arg_18_1.id)
	end
end

return ActivityGetStaminaData

local var_0_0 = g.core.const.ConstMgr.SevenDaysConst
local var_0_1 = g.core.const.ConstMgr.SevenDaysConst.RECEIVE_STATE
local var_0_2 = g.core.config.sevendays_task_info
local var_0_3 = "reward_type_"
local var_0_4 = "reward_value_"
local var_0_5 = "reward_size_"
local SevenDaysTaskStruct = class("SevenDaysTaskStruct")

function SevenDaysTaskStruct:ctor(arg_1_1)
	self._info = arg_1_1
	self._progress = 0
	self._reverse = arg_1_1.target == var_0_0.TARGET_ARENA_RANKING
	self._received = false
	self._awardList = {}

	self:_initAwardList()
end

function SevenDaysTaskStruct:_initAwardList()
	local var_2_0 = 1

	while var_0_2.hasKey(var_0_3 .. 1) do
		if self._info[var_0_3 .. 1] > 0 then
			table.insert(self._awardList, {
				type = self._info[var_0_3 .. 1],
				value = self._info[var_0_4 .. var_2_0],
				size = self._info[var_0_5 .. var_2_0]
			})
		end

		var_2_0 = var_2_0 + 1
	end
end

function SevenDaysTaskStruct:getInfo()
	return self._info
end

function SevenDaysTaskStruct:setReceived(arg_4_1)
	self._received = arg_4_1

	if arg_4_1 then
		self:setProgress()
	end
end

function SevenDaysTaskStruct:isReceived()
	return self._received
end

function SevenDaysTaskStruct:getProgress()
	return self._progress
end

function SevenDaysTaskStruct:setProgress(arg_7_1)
	arg_7_1 = self._received and self._info.target_value or arg_7_1 or 0
	self._progress = arg_7_1
end

function SevenDaysTaskStruct:getReceiveState()
	if self._received then
		return var_0_1.RECEIVED
	elseif not self:isUnlocked() then
		return var_0_1.LOCKED
	else
		local var_8_0 = self._progress

		if self._reverse then
			if not math.uint64_equal(var_8_0, 0) and math.uint64_lt(var_8_0, self._info.target_value, true) then
				return var_0_1.CAN_RECEIVE
			end
		elseif not math.uint64_lt(var_8_0, self._info.target_value) then
			return var_0_1.CAN_RECEIVE
		end

		return var_0_1.NOT_ACHIEVED
	end
end

function SevenDaysTaskStruct:getAwardList()
	return self._awardList
end

function SevenDaysTaskStruct:isUnlocked()
	return g.view.entrance.ModuleGotoProxy:getModuleStateByRouteId(self._info.route_id)
end

return SevenDaysTaskStruct

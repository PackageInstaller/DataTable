local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local PeakArenaGroupStruct = class("PeakArenaGroupStruct")

function PeakArenaGroupStruct:ctor(arg_1_1)
	self._id = arg_1_1
	self._name = arg_1_1 < var_0_0.FINAL_GROUP_ID and g.core.lang:get(307010 + arg_1_1 - 1) or "Final"
	self._userId2DArr = {}

	for iter_1_0 = 1, var_0_0.PEAK_STAGE_ROUND do
		self._userId2DArr[iter_1_0] = {}
	end
end

function PeakArenaGroupStruct:updateData(arg_2_1)
	for iter_2_0 = 1, var_0_0.PEAK_STAGE_ROUND do
		local var_2_0 = iter_2_0 - 1

		if self._id == var_0_0.FINAL_GROUP_ID then
			var_2_0 = var_2_0 + var_0_0.PEAK_STAGE_ROUND - 1
			self._userId2DArr[iter_2_0] = clone(arg_2_1[var_2_0] or {})
		else
			local var_2_1 = arg_2_1[var_2_0] or {}
			local var_2_2 = self:getUserNumWithRound(iter_2_0)
			local var_2_3 = {}

			for iter_2_1 = 1, var_2_2 do
				table.insert(var_2_3, var_2_1[var_2_2 * (self._id - 1) + iter_2_1] or 0)
			end

			self._userId2DArr[iter_2_0] = var_2_3
		end
	end
end

function PeakArenaGroupStruct:getName()
	return self._name
end

function PeakArenaGroupStruct:getUserIdWithRoundUserIdx(arg_4_1, arg_4_2)
	return self._userId2DArr[arg_4_1][arg_4_2] or 0
end

function PeakArenaGroupStruct:getUserIdArrWithRound(arg_5_1)
	return self._userId2DArr[arg_5_1]
end

function PeakArenaGroupStruct:getValidUserIdArr()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs((self:getUserIdArrWithRound(1))) do
		if iter_6_1 and iter_6_1 > 0 then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function PeakArenaGroupStruct:getUserMatchState(arg_7_1, arg_7_2)
	local var_7_0 = self:getUserIdWithRoundUserIdx(arg_7_1, arg_7_2)

	if var_7_0 == 0 then
		return var_0_0.UserMatchState.EMPTY
	elseif arg_7_1 == var_0_0.PEAK_STAGE_ROUND then
		return var_0_0.UserMatchState.VICTORY
	else
		local var_7_1 = self:getUserIdWithRoundUserIdx(arg_7_1 + 1, (math.ceil(arg_7_2 / 2)))

		if var_7_1 == 0 then
			return var_0_0.UserMatchState.WAITING_GAME_BEGIN
		elseif var_7_1 == var_7_0 then
			return var_0_0.UserMatchState.VICTORY
		else
			return var_0_0.UserMatchState.DEFEAT
		end
	end
end

function PeakArenaGroupStruct:isEmpty()
	if #self._userId2DArr[1] == 0 then
		return true
	else
		for iter_8_0, iter_8_1 in pairs(self._userId2DArr[1]) do
			if iter_8_1 and iter_8_1 > 0 then
				return false
			end
		end

		return true
	end
end

function PeakArenaGroupStruct:getUserIdArrSortByRank()
	local var_9_0 = {}

	for iter_9_0 = var_0_0.PEAK_STAGE_ROUND, 1, -1 do
		if iter_9_0 == var_0_0.PEAK_STAGE_ROUND then
			table.insert(var_9_0, (self:getUserIdWithRoundUserIdx(iter_9_0, 1)))
		else
			for iter_9_1, iter_9_2 in ipairs((self:getUserIdArrWithRound(iter_9_0))) do
				if self:getUserMatchState(iter_9_0, iter_9_1) == var_0_0.UserMatchState.DEFEAT then
					table.insert(var_9_0, iter_9_2)
				end
			end
		end
	end

	return var_9_0
end

function PeakArenaGroupStruct:getWinnerUserId(arg_10_1, arg_10_2)
	local var_10_0 = self:getUserMatchState(arg_10_1, arg_10_2)

	if var_10_0 == var_0_0.UserMatchState.VICTORY then
		return self:getUserIdWithRoundUserIdx(arg_10_1, arg_10_2)
	elseif var_10_0 == var_0_0.UserMatchState.DEFEAT then
		return self:getUserIdWithRoundUserIdx(arg_10_1, (arg_10_2 % 2 == 0 or nil) and arg_10_2 - 1)
	else
		return 0
	end
end

function PeakArenaGroupStruct:getUserNumWithRound(arg_11_1)
	return var_0_0.FIRST_ROUND_USER_NUM / math.pow(2, arg_11_1 - 1)
end

return PeakArenaGroupStruct

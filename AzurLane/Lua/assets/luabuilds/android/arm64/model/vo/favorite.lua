class = var_0_10000

local var_0_0 = "Favorite"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.STATE_AWARD = 1
var_0_1.STATE_WAIT = 2
var_0_1.STATE_LOCK = 3
var_0_1.STATE_FETCHED = 4

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_0.configId
	arg_1_0.star = arg_1_1.star

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.storeup_data_template
end

function var_0_1.getStarCount(arg_3_0, arg_3_1)
	local var_3_0 = 0

	pairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0:getConfig("char_list")) do
		if arg_3_1[iter_3_1] then
			var_3_0 = var_3_0 + arg_3_1[iter_3_1].star
		end
	end

	return var_3_0
end

function var_0_1.getNextAwardIndex(arg_4_0, arg_4_1)
	local var_4_0 = 1

	if arg_4_1[arg_4_0.id] then
		var_4_0 = arg_4_1[arg_4_0.id] + 1
	end

	return var_4_0
end

function var_0_1.isFetchAll(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_1[arg_5_0.id] then
		var_5_0 = 0
	end

	return var_5_0 >= #arg_5_0:getConfig("level")
end

function var_0_1.canGetRes(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getNextAwardIndex(arg_6_2)
	local var_6_1 = arg_6_0:getConfig("award_display")
	local var_6_2 = arg_6_0:getStarCount(arg_6_1)
	local var_6_3 = false

	if var_6_0 <= #var_6_1 then
		var_6_3 = true

		if var_6_2 >= arg_6_0:getConfig("level")[var_6_0] then
			return true
		end
	end

	return false, var_6_3
end

function var_0_1.getState(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2[arg_7_0.id]
	local var_7_1, var_7_2 = arg_7_0:canGetRes(arg_7_1, arg_7_2)
	local var_7_3 = arg_7_0:isFetchAll(arg_7_2)

	if var_7_1 then
		return var_0_1.STATE_AWARD
	elseif var_7_3 then
		return var_0_1.STATE_FETCHED
	else
		local var_7_4

		if not var_7_2 or not var_0_1.STATE_WAIT then
			var_7_4 = var_0_1.STATE_LOCK
		end

		return var_7_4
	end

	return
end

function var_0_1.getAwardState(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0

	if not arg_8_2[arg_8_0.id] then
		var_8_0 = 0
	end

	local var_8_1 = arg_8_0:getConfig("level")
	local var_8_2 = arg_8_0:getConfig("award_display")

	if var_8_1[arg_8_3] <= arg_8_0:getStarCount(arg_8_1) then
		local var_8_3

		if not (var_8_0 < arg_8_3) or (not var_8_2[arg_8_3] or not var_0_1.STATE_AWARD) and not var_0_1.STATE_LOCK then
			var_8_3 = var_0_1.STATE_FETCHED
		end

		return var_8_3
	else
		local var_8_4

		if not var_8_2[arg_8_3] or not var_0_1.STATE_WAIT then
			var_8_4 = var_0_1.STATE_LOCK
		end

		return var_8_4
	end

	return
end

function var_0_1.containShipGroup(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getConfig("award_display")

	_ = var_1_10003

	return var_1_10003.any(var_9_0, function(arg_10_0)
		local var_10_0 = arg_10_0[1]

		DROP_TYPE_SHIP = var_2_10002

		if var_10_0 == var_2_10002 then
			Ship = var_10_0

			local var_10_1 = var_10_0.New({
				configId = arg_10_0[2]
			})

			if var_1.getGroupId(var_10_1) == arg_9_1 then
				return true
			end
		end

		return false
	end)
end

return var_0_1

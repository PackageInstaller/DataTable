class = var_0_10000

local var_0_0 = "AttireFrame"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.STATE_LOCK = 1
var_0_1.STATE_UNLOCKABLE = 2
var_0_1.STATE_UNLOCK = 3

function var_0_1.attireFrameRes(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_0.attireInfo[arg_1_2]

	if arg_1_1 then
		getProxy = var_1_10005
		PlayerProxy = var_1_10007

		local var_1_1 = var_1_10005(var_1_10007)

		var_1_10005 = var_1_10005.getRawData(var_1_1)

		if arg_1_3 then
			HXSet = var_1_10006
			arg_1_3 = not var_1_10006.isHxPropose() or var_1_10005:GetProposeShipId() == var_1_10005.character
		end
	elseif arg_1_3 then
		HXSet = var_1_10005
		arg_1_3 = not var_1_10005.isHxPropose()
	end

	AttireConst = var_1_10005

	if arg_1_2 == var_1_10005.TYPE_ICON_FRAME and var_1_0 == 0 and arg_1_3 then
		pg = var_5

		if var_5.ship_data_template[arg_1_0.icon] then
			ShipGroup = var_6

			if var_6.IsMetaGroup(var_5.group_type) then
				do return "meta_propose" end

				goto label_1_0
			end
		end

		return "propose"
	else
		AttireConst = var_5

		if arg_1_2 == var_5.TYPE_CHAT_FRAME then
			local var_1_2

			if not arg_1_1 or not (var_1_0 .. "_self") then
				var_1_2 = var_1_0 .. "_other"
			end

			return var_1_2
		else
			return var_1_0
		end
	end

	::label_1_0::

	return
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id

	arg_2_0:updateData(arg_2_1)

	return
end

function var_0_1.isNew(arg_3_0)
	return arg_3_0.new == true
end

function var_0_1.clearNew(arg_4_0)
	arg_4_0.new = nil

	return
end

function var_0_1.updateData(arg_5_0, arg_5_1)
	local var_5_0

	if not arg_5_1.end_time and not arg_5_1.time then
		var_5_0 = -1
	end

	arg_5_0.endTime = var_5_0
	arg_5_0.new = arg_5_1.isNew

	return
end

function var_0_1.getState(arg_6_0)
	local var_6_0 = var_0_1.STATE_LOCK

	if arg_6_0:isOwned() then
		var_6_0 = var_0_1.STATE_UNLOCK
	elseif not var_2 and arg_6_0:canUnlock() then
		var_6_0 = var_0_1.STATE_UNLOCKABLE
	end

	return var_6_0
end

function var_0_1.canUnlock(arg_7_0)
	return false
end

function var_0_1.isOwned(arg_8_0)
	return arg_8_0.endTime >= 0 and not arg_8_0:isExpired()
end

function var_0_1.isExpired(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.TimeMgr.GetInstance()
	local var_9_1 = var_1.GetServerTime(var_9_0)
	local var_9_2

	if arg_9_0:expiredType() then
		var_9_2 = var_9_1 >= arg_9_0:getExpiredTime()
	end

	return var_9_2
end

function var_0_1.getExpiredTime(arg_10_0)
	if arg_10_0:expiredType() then
		return arg_10_0.endTime
	end

	assert = var_1

	var_1(false)

	return
end

function var_0_1.updateEndTime(arg_11_0, arg_11_1)
	arg_11_0.endTime = arg_11_1

	return
end

function var_0_1.expiredType(arg_12_0)
	return arg_12_0:getConfig("time_limit_type") == 1
end

function var_0_1.getTimerKey(arg_13_0)
	return arg_13_0:getType() .. "_" .. arg_13_0.id
end

function var_0_1.getType(arg_14_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.bindConfigTable(arg_15_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.getDropType(arg_16_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

return var_0_1

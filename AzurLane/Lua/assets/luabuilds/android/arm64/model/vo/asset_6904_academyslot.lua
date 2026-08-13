class = var_0_10000

local var_0_0 = "AcademySlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.STATE_IDLE = "STATE_IDLE"
var_0_1.STATE_IN_CLASS = "STATE_IN_CLASS"
var_0_1.STATE_CLASS_OVER = "STATE_CLASS_OVER"

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.SetSlotData(arg_2_0, arg_2_1)
	arg_2_0._shipVO = arg_2_1.ship
	arg_2_0._attrList = {}
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1.attr_list) do
		arg_2_0._attrList[iter_2_1.attr] = iter_2_1.num
	end

	arg_2_0._timeStamp = arg_2_1.time

	return
end

function var_0_1.GetShip(arg_3_0)
	return arg_3_0._shipVO
end

function var_0_1.GetAttrList(arg_4_0)
	return arg_4_0._attrList
end

function var_0_1.GetDuration(arg_5_0)
	if arg_5_0._timeStamp then
		local var_5_0 = arg_5_0._timeStamp

		pg = var_1_10002

		local var_5_1 = var_1_10002.TimeMgr.GetInstance()

		return var_5_0 - var_2.GetServerTime(var_5_1)
	else
		return nil
	end

	return
end

return var_0_1

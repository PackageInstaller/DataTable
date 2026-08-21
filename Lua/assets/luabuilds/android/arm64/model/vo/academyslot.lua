local var_0_0 = class("AcademySlot", import(".BaseVO"))

var_0_0.STATE_IDLE = "STATE_IDLE"
var_0_0.STATE_IN_CLASS = "STATE_IN_CLASS"
var_0_0.STATE_CLASS_OVER = "STATE_CLASS_OVER"

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.SetSlotData(arg_2_0, arg_2_1)
	arg_2_0._shipVO = arg_2_1.ship
	arg_2_0._attrList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.attr_list) do
		arg_2_0._attrList[iter_2_1.attr] = iter_2_1.num
	end

	arg_2_0._timeStamp = arg_2_1.time

	return
end

function var_0_0.GetShip(arg_3_0)
	return arg_3_0._shipVO
end

function var_0_0.GetAttrList(arg_4_0)
	return arg_4_0._attrList
end

function var_0_0.GetDuration(arg_5_0)
	if arg_5_0._timeStamp then
		return arg_5_0._timeStamp - pg.TimeMgr.GetInstance():GetServerTime()
	else
		return nil
	end

	return
end

return var_0_0

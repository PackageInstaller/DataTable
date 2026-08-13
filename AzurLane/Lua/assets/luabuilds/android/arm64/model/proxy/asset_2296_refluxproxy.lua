class = var_0_10000

local var_0_0 = "RefluxProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0:initData()
	arg_1_0:addListener()

	return
end

function var_0_1.timeCall(arg_2_0)
	local var_2_0 = {}

	ProxyRegister = var_1_10002
	var_2_0[var_1_10002.DayCall] = function(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.setAutoActionForbidden(var_3_0, false)

		local var_3_1 = arg_2_0
		local var_3_2 = var_1.sendNotification

		GAME = var_4

		var_3_2(var_3_1, var_4.REFLUX_REQUEST_DATA)

		return
	end

	return var_2_0
end

function var_0_1.initData(arg_4_0)
	arg_4_0.active = false
	arg_4_0.returnLV = 0
	arg_4_0.returnTimestamp = 0
	arg_4_0.returnShipNum = 0
	arg_4_0.returnLastTimestamp = 0
	arg_4_0.ptNum = 0
	arg_4_0.ptStage = 0
	arg_4_0.signCount = 0
	arg_4_0.signLastTimestamp = 0
	arg_4_0.autoActionForbidden = false

	return
end

function var_0_1.setData(arg_5_0, arg_5_1)
	arg_5_0.active = arg_5_1.active == 1
	arg_5_0.returnLV = arg_5_1.return_lv
	arg_5_0.returnTimestamp = arg_5_1.return_time
	arg_5_0.returnShipNum = arg_5_1.ship_number
	arg_5_0.returnLastTimestamp = arg_5_1.last_offline_time
	arg_5_0.ptNum = arg_5_1.pt
	arg_5_0.ptStage = arg_5_1.pt_stage
	arg_5_0.signCount = arg_5_1.sign_cnt
	arg_5_0.signLastTimestamp = arg_5_1.sign_last_time

	return
end

function var_0_1.addListener(arg_6_0)
	arg_6_0:on(11752, function(arg_7_0)
		local var_7_0 = arg_6_0

		var_1.setData(var_7_0, arg_7_0)

		return
	end)

	return
end

function var_0_1.setSignLastTimestamp(arg_8_0, arg_8_1)
	local var_8_1

	if not arg_8_1 then
		pg = var_1_10003

		local var_8_0 = var_1_10003.TimeMgr.GetInstance()

		var_8_1 = var_3.GetServerTime(var_8_0)
	end

	arg_8_0.signLastTimestamp = var_8_1

	return
end

function var_0_1.addSignCount(arg_9_0)
	arg_9_0.signCount = arg_9_0.signCount + 1

	return
end

function var_0_1.addPtAfterSubTasks(arg_10_0, arg_10_1)
	ipairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_1) do
		local var_10_0 = iter_10_1.id

		pg = var_1_10008
		var_1_10008 = var_1_10008.return_task_template[var_10_0].pt_award
		arg_10_0.ptNum = arg_10_0.ptNum + var_1_10008
	end

	return
end

function var_0_1.addPTStage(arg_11_0)
	arg_11_0.ptStage = arg_11_0.ptStage + 1

	return
end

function var_0_1.isActive(arg_12_0)
	return arg_12_0.active
end

function var_0_1.isCanSign(arg_13_0)
	local var_13_0 = arg_13_0

	if arg_13_0.isActive(var_13_0) and not arg_13_0.autoActionForbidden then
		pg = var_1

		local var_13_1 = var_1.TimeMgr.GetInstance()
		local var_13_2 = arg_13_0.signCount

		pg = var_13_0

		local var_13_3 = #var_13_0.return_sign_template.all
		local var_13_4 = arg_13_0.signLastTimestamp
		local var_13_5 = var_13_1:GetServerTime()
		local var_13_6 = var_13_1:IsSameDay(var_13_5, var_13_4)

		if var_13_2 < var_13_3 and not var_13_6 then
			return true
		end
	end

	return
end

function var_0_1.isInRefluxTime(arg_14_0)
	if arg_14_0:isActive() then
		pg = var_1

		local var_14_0 = var_1.TimeMgr.GetInstance()

		pg = var_1_10002

		local var_14_1 = #var_1_10002.return_sign_template.all

		if arg_14_0.returnTimestamp + var_14_1 * 0 <= var_14_0:GetServerTime() then
			return false
		else
			return true
		end
	else
		return false
	end

	return
end

function var_0_1.setAutoActionForbidden(arg_15_0, arg_15_1)
	arg_15_0.autoActionForbidden = arg_15_1

	return
end

return var_0_1

local var_0_0 = class("RefluxProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0:initData()
	arg_1_0:addListener()

	return
end

function var_0_0.timeCall(arg_2_0)
	return {
		[ProxyRegister.DayCall] = function(arg_3_0)
			arg_2_0:setAutoActionForbidden(false)
			arg_2_0:sendNotification(GAME.REFLUX_REQUEST_DATA)

			return
		end
	}
end

function var_0_0.initData(arg_4_0)
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

function var_0_0.setData(arg_5_0, arg_5_1)
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

function var_0_0.addListener(arg_6_0)
	arg_6_0:on(11752, function(arg_7_0)
		arg_6_0:setData(arg_7_0)

		return
	end)

	return
end

function var_0_0.setSignLastTimestamp(arg_8_0, arg_8_1)
	arg_8_0.signLastTimestamp = arg_8_1 or pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.addSignCount(arg_9_0)
	arg_9_0.signCount = arg_9_0.signCount + 1

	return
end

function var_0_0.addPtAfterSubTasks(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		arg_10_0.ptNum = arg_10_0.ptNum + pg.return_task_template[iter_10_1.id].pt_award
	end

	return
end

function var_0_0.addPTStage(arg_11_0)
	arg_11_0.ptStage = arg_11_0.ptStage + 1

	return
end

function var_0_0.isActive(arg_12_0)
	return arg_12_0.active
end

function var_0_0.isCanSign(arg_13_0)
	if arg_13_0:isActive() and not arg_13_0.autoActionForbidden then
		local var_13_0 = pg.TimeMgr.GetInstance()

		if arg_13_0.signCount < #pg.return_sign_template.all and not var_13_0:IsSameDay(var_13_0:GetServerTime(), arg_13_0.signLastTimestamp) then
			return true
		end
	end

	return
end

function var_0_0.isInRefluxTime(arg_14_0)
	if arg_14_0:isActive() then
		if arg_14_0.returnTimestamp + #pg.return_sign_template.all * 0 <= pg.TimeMgr.GetInstance():GetServerTime() then
			return false
		else
			return true
		end
	else
		return false
	end

	return
end

function var_0_0.setAutoActionForbidden(arg_15_0, arg_15_1)
	arg_15_0.autoActionForbidden = arg_15_1

	return
end

return var_0_0

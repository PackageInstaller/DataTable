local var_0_0 = class("IslandDeviceShipOrderBtn", import(".IslandDeviceBaseBtn"))

var_0_0.STATES = {
	WAITING = 3,
	FINISHED = 1,
	RUNNING = 2
}

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0.statesTF = arg_1_0.unlockTF:Find("states")

	setText(arg_1_0.statesTF:Find("finished/Text"), i18n("island_freight_btn_receive"))
	setText(arg_1_0.statesTF:Find("waiting"), i18n("island_freight_btn_idle"))

	arg_1_0.timeTxt = arg_1_0.statesTF:Find("running/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.FlushDataUI(arg_2_0)
	local var_2_0, var_2_1 = arg_2_0:GetState()

	setActive(arg_2_0.statesTF:Find("finished"), var_2_0 == var_0_0.STATES.FINISHED)
	setActive(arg_2_0.statesTF:Find("running"), var_2_0 == var_0_0.STATES.RUNNING)
	setActive(arg_2_0.statesTF:Find("waiting"), var_2_0 == var_0_0.STATES.WAITING)

	local var_2_2 = arg_2_0.statesTF:GetComponent(typeof(Animation))

	if var_2_0 == var_0_0.STATES.FINISHED then
		var_2_2:Play("IslandDeviceUI_shipoderfinished_")
	elseif var_2_0 == var_0_0.STATES.RUNNING then
		var_2_2:Play("IslandDeviceUI_shipoderrunning_")
	elseif var_2_0 == var_0_0.STATES.WAITING then
		var_2_2:Play("IslandDeviceUI_shipoderwaiting_")
	else
		var_2_2:Stop()
	end

	arg_2_0:RemoveTimer()

	if var_2_0 == var_0_0.STATES.RUNNING then
		arg_2_0:AddTimer(var_2_1)
	end

	return
end

function var_0_0.AddTimer(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetEndTime()

	arg_3_0.timer = Timer.New(function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = var_3_0 - pg.TimeMgr.GetInstance():GetServerTime()

		arg_3_0.timeTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_4_0)

		if var_4_0 <= 0 then
			arg_3_0:RemoveTimer()
			arg_3_0:FlushDataUI()
		end

		return
	end, 1, -1)

	arg_3_0.timer.func()
	arg_3_0.timer:Start()

	return
end

function var_0_0.RemoveTimer(arg_5_0)
	if arg_5_0.timer then
		arg_5_0.timer:Stop()

		arg_5_0.timer = nil
	end

	return
end

function var_0_0.GetState(arg_6_0)
	local var_6_9000
	local var_6_0 = getProxy(IslandProxy):GetIsland()
	local var_6_1 = underscore.values(var_6_0.GetOrderAgency(var_6_9000):GetShipSlotList())

	if var_6_0 then
		return var_0_0.STATES.FINISHED, (underscore.detect(var_6_1, function(arg_7_0)
			return arg_7_0:IsFinished()
		end))
	end

	local var_6_2 = underscore.select(var_6_1, function(arg_8_0)
		return arg_8_0:IsSubmited() and not arg_8_0:IsFinished()
	end)

	table.sort(var_6_2, CompareFuncs({
		function(arg_9_0)
			return arg_9_0:GetEndTime()
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))

	if #var_6_2 > 0 then
		return var_0_0.STATES.RUNNING, var_6_2[1]
	end

	return var_0_0.STATES.WAITING, nil
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
	arg_11_0:RemoveTimer()

	return
end

return var_0_0

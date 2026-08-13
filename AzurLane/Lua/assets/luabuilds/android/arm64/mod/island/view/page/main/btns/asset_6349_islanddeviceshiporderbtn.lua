class = var_0_10000

local var_0_0 = "IslandDeviceShipOrderBtn"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandDeviceBaseBtn"))

var_0_1.STATES = {
	WAITING = 3,
	FINISHED = 1,
	RUNNING = 2
}

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	local var_1_0 = arg_1_0.unlockTF

	arg_1_0.statesTF = var_1.Find(var_1_0, "states")
	setText = var_1

	local var_1_1 = arg_1_0.statesTF
	local var_1_2 = var_3.Find(var_1_1, "finished/Text")

	i18n = var_4

	var_1(var_1_2, var_4("island_freight_btn_receive"))

	setText = var_1

	local var_1_3 = arg_1_0.statesTF
	local var_1_4 = var_3.Find(var_1_3, "waiting")

	i18n = var_4

	var_1(var_1_4, var_4("island_freight_btn_idle"))

	local var_1_5 = arg_1_0.statesTF
	local var_1_6 = var_1.Find(var_1_5, "running/Text")
	local var_1_7 = var_1.GetComponent

	typeof = var_4
	Text = var_6
	arg_1_0.timeTxt = var_1_7(var_1_6, var_4(var_6))

	return
end

function var_0_1.FlushDataUI(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1, var_2_2 = arg_2_0.GetState(var_2_0)

	setActive = var_2_0

	local var_2_3 = arg_2_0.statesTF

	var_2_0(var_5.Find(var_2_3, "finished"), var_2_1 == var_0_1.STATES.FINISHED)

	setActive = var_2_0

	local var_2_4 = arg_2_0.statesTF

	var_2_0(var_5.Find(var_2_4, "running"), var_2_1 == var_0_1.STATES.RUNNING)

	setActive = var_2_0

	local var_2_5 = arg_2_0.statesTF

	var_2_0(var_5.Find(var_2_5, "waiting"), var_2_1 == var_0_1.STATES.WAITING)

	local var_2_6 = arg_2_0.statesTF
	local var_2_7 = var_3.GetComponent

	typeof = var_6
	Animation = var_8

	local var_2_8 = var_2_7(var_2_6, var_6(var_8))

	if var_2_1 == var_0_1.STATES.FINISHED then
		var_2_8:Play("IslandDeviceUI_shipoderfinished_")
	elseif var_2_1 == var_0_1.STATES.RUNNING then
		var_2_8:Play("IslandDeviceUI_shipoderrunning_")
	elseif var_2_1 == var_0_1.STATES.WAITING then
		var_2_8:Play("IslandDeviceUI_shipoderwaiting_")
	else
		var_2_8:Stop()
	end

	arg_2_0:RemoveTimer()

	if var_2_1 == var_0_1.STATES.RUNNING then
		arg_2_0:AddTimer(var_2_2)
	end

	return
end

function var_0_1.AddTimer(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetEndTime()

	Timer = var_1_10003
	arg_3_0.timer = var_1_10003.New(function(arg_4_0, arg_4_1, arg_4_2)
		pg = var_2_10003

		local var_4_0 = var_2_10003.TimeMgr.GetInstance()
		local var_4_1 = var_3.GetServerTime(var_4_0)
		local var_4_2 = var_3_0 - var_4_1
		local var_4_3 = arg_3_0.timeTxt

		pg = var_2_10006

		local var_4_4 = var_2_10006.TimeMgr.GetInstance()

		var_4_3.text = var_6.DescCDTime(var_4_4, var_4_2)

		if var_4_2 <= 0 then
			local var_4_5 = arg_3_0

			var_5.RemoveTimer(var_4_5)

			local var_4_6 = arg_3_0

			var_5.FlushDataUI(var_4_6)
		end

		return
	end, 1, -1)

	arg_3_0.timer.func()

	local var_3_1 = arg_3_0.timer

	var_3.Start(var_3_1)

	return
end

function var_0_1.RemoveTimer(arg_5_0)
	if arg_5_0.timer then
		local var_5_0 = arg_5_0.timer

		var_1.Stop(var_5_0)

		arg_5_0.timer = nil
	end

	return
end

function var_0_1.GetState(arg_6_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetIsland(var_6_0)
	local var_6_2 = var_1.GetOrderAgency(var_6_1)

	underscore = var_1_10002

	local var_6_3 = var_1_10002.values(var_6_2:GetShipSlotList())

	underscore = var_6_1

	if var_6_1.detect(var_6_3, function(arg_7_0)
		return arg_7_0:IsFinished()
	end) then
		return var_0_1.STATES.FINISHED, var_3
	end

	underscore = var_4

	local var_6_4 = var_4.select(var_6_3, function(arg_8_0)
		local var_8_0

		if arg_8_0:IsSubmited() then
			var_8_0 = not arg_8_0:IsFinished()
		end

		return var_8_0
	end)

	table = var_5

	local var_6_5 = var_5.sort
	local var_6_6 = var_6_4

	CompareFuncs = var_1_10008

	var_6_5(var_6_6, var_1_10008({
		function(arg_9_0)
			return arg_9_0:GetEndTime()
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))

	if #var_6_4 > 0 then
		return var_0_1.STATES.RUNNING, var_6_4[1]
	end

	return var_0_1.STATES.WAITING, nil
end

function var_0_1.Dispose(arg_11_0)
	var_0_1.super.Dispose(arg_11_0)
	arg_11_0:RemoveTimer()

	return
end

return var_0_1

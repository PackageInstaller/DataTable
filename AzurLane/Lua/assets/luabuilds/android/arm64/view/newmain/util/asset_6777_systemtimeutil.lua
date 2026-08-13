class = var_0_10000

local var_0_0 = var_0_10000("SystemTimeUtil")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.SetUp(arg_2_0, arg_2_1)
	arg_2_0.callback = arg_2_1

	arg_2_0:Flush()

	return
end

function var_0_0.Flush(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerHour(var_3_0) < 12 and "AM" or "PM"

	pg = var_1_10004

	local var_3_2 = var_1_10004.TimeMgr.GetInstance()
	local var_3_3 = var_4.CurrentSTimeDesc(var_3_2, "%M", true)

	if arg_3_0.callback then
		arg_3_0.callback(var_1, var_3_3, var_3_1)
	end

	pg = var_5

	local var_3_4 = var_5.TimeMgr.GetInstance()
	local var_3_5 = var_5.GetServerTime(var_3_4)
	local var_3_6 = arg_3_0:GetSecondsToNextMinute(var_3_5)

	arg_3_0:AddTimer(var_3_6)

	return
end

function var_0_0.GetSecondsToNextMinute(arg_4_0, arg_4_1)
	math = var_1_10002

	if var_1_10002.ceil(arg_4_1 / 60) * 60 - arg_4_1 <= 0 then
		return 60
	end

	return var_3
end

function var_0_0.AddTimer(arg_5_0, arg_5_1)
	arg_5_0:RemoveTimer()

	Timer = var_2
	arg_5_0.timer = var_2.New(function()
		local var_6_0 = arg_5_0

		var_0.Flush(var_6_0)

		return
	end, arg_5_1, 1)

	local var_5_0 = arg_5_0.timer

	var_2.Start(var_5_0)

	return
end

function var_0_0.RemoveTimer(arg_7_0)
	if arg_7_0.timer then
		local var_7_0 = arg_7_0.timer

		var_1.Stop(var_7_0)

		arg_7_0.timer = nil
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveTimer()

	return
end

return var_0_0

pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.BrightnessMgr = var_0_10001("BrightnessMgr")
YSNormalTool = var_2

local var_0_1 = var_2.BrightnessTool

var_1.AutoIntoDarkModeTime = 10
var_1.DarkModeBrightness = 0.1
var_1.BrightnessMode = {
	AUTO_ANDROID = 1,
	MANUAL_ANDROID = 0,
	MANUAL_IOS = 2
}

function var_1.Init(arg_1_0, arg_1_1)
	GlobalClickEventMgr = var_1_10002

	local var_1_0 = var_1_10002.Inst

	var_2.AddPointerDownFunc(var_1_0, function()
		if not arg_1_0.manulStatus then
			return
		end

		local var_2_0 = arg_1_0

		var_0.AwakeForAWhile(var_2_0)

		return
	end)

	arg_1_0.manulStatus = false
	arg_1_0.originalBrightnessValue = 0
	arg_1_0.originalBrightnessMode = 0
	arg_1_0.sleepTimeOutCounter = 0

	arg_1_1()

	return
end

function var_1.AwakeForAWhile(arg_3_0)
	if not arg_3_0:IsPermissionGranted() then
		arg_3_0:ExitManualMode()

		return
	end

	var_0_1.SetBrightnessValue(arg_3_0.originalBrightnessValue)
	arg_3_0:SetDelayTask()

	return
end

function var_1.SetDelayTask(arg_4_0)
	arg_4_0:ClearTask()

	Timer = var_1
	arg_4_0.task = var_1.New(function()
		local var_5_0 = var_0_1.SetBrightnessValue

		math = var_2_10001

		var_5_0(var_2_10001.min(var_0.DarkModeBrightness, arg_4_0.originalBrightnessValue))

		return
	end, var_0.AutoIntoDarkModeTime)

	local var_4_0 = arg_4_0.task

	var_1.Start(var_4_0)

	return
end

function var_1.ClearTask(arg_6_0)
	if not arg_6_0.task then
		return
	end

	local var_6_0 = arg_6_0.task

	var_1.Stop(var_6_0)

	arg_6_0.task = nil

	return
end

function var_1.EnterManualMode(arg_7_0)
	if arg_7_0.manulStatus then
		return
	end

	arg_7_0.originalBrightnessValue = var_0_1.GetBrightnessValue()

	local var_7_0 = var_0_1.SetBrightnessValue

	math = var_1_10003

	var_7_0(var_1_10003.min(var_0.DarkModeBrightness, var_1))

	arg_7_0.manulStatus = true

	return
end

function var_1.ExitManualMode(arg_8_0)
	if not arg_8_0.manulStatus then
		return
	end

	var_0_1.SetBrightnessValue(arg_8_0.originalBrightnessValue)
	arg_8_0:ClearTask()

	arg_8_0.manulStatus = false

	return
end

function var_1.IsPermissionGranted(arg_9_0)
	return var_0_1.CanWriteSetting()
end

function var_1.OpenPermissionSettings(arg_10_0)
	YSNormalTool = var_1_10001

	var_1_10001.OtherTool.OpenAndroidWriteSettings()

	return
end

function var_1.RequestPremission(arg_11_0, arg_11_1)
	arg_11_0:OpenPermissionSettings()

	if arg_11_1 then
		FrameTimer = var_2

		local var_11_0 = var_2.New(function()
			local var_12_0 = arg_11_1
			local var_12_1 = arg_11_0

			var_12_0(var_1.IsPermissionGranted(var_12_1))

			return
		end, 2)

		var_2.Start(var_11_0)
	end

	return
end

function var_1.SetScreenNeverSleep(arg_13_0, arg_13_1)
	tobool = var_1_10002

	if var_1_10002(arg_13_1) then
		if arg_13_0.sleepTimeOutCounter == 0 then
			Screen = var_2
			SleepTimeout = var_3
			var_2.sleepTimeout = var_3.NeverSleep
		end

		arg_13_0.sleepTimeOutCounter = arg_13_0.sleepTimeOutCounter + 1
	else
		arg_13_0.sleepTimeOutCounter = arg_13_0.sleepTimeOutCounter - 1
		assert = var_2

		var_2(arg_13_0.sleepTimeOutCounter >= 0, "InCorrect Call of SetScreenNeverSleep")

		math = var_2
		arg_13_0.sleepTimeOutCounter = var_2.max(0, arg_13_0.sleepTimeOutCounter)

		if arg_13_0.sleepTimeOutCounter == 0 then
			Screen = var_2
			SleepTimeout = var_3
			var_2.sleepTimeout = var_3.SystemSetting
		end
	end

	return
end

return

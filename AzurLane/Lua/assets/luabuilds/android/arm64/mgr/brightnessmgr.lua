pg = pg or {}

local var_0_0 = singletonClass("BrightnessMgr")

pg.BrightnessMgr = var_0_0

local var_0_1 = YSNormalTool.BrightnessTool

var_0_0.AutoIntoDarkModeTime = 10
var_0_0.DarkModeBrightness = 0.1
var_0_0.BrightnessMode = {
	AUTO_ANDROID = 1,
	MANUAL_ANDROID = 0,
	MANUAL_IOS = 2
}

function var_0_0.Init(arg_1_0, arg_1_1)
	GlobalClickEventMgr.Inst:AddPointerDownFunc(function()
		if not arg_1_0.manulStatus then
			return
		end

		arg_1_0:AwakeForAWhile()

		return
	end)

	arg_1_0.manulStatus = false
	arg_1_0.originalBrightnessValue = 0
	arg_1_0.originalBrightnessMode = 0
	arg_1_0.sleepTimeOutCounter = 0

	arg_1_1()

	return
end

function var_0_0.AwakeForAWhile(arg_3_0)
	if not arg_3_0:IsPermissionGranted() then
		arg_3_0:ExitManualMode()

		return
	end

	var_0_1.SetBrightnessValue(arg_3_0.originalBrightnessValue)
	arg_3_0:SetDelayTask()

	return
end

function var_0_0.SetDelayTask(arg_4_0)
	arg_4_0:ClearTask()

	arg_4_0.task = Timer.New(function()
		var_0_1.SetBrightnessValue(math.min(var_0_0.DarkModeBrightness, arg_4_0.originalBrightnessValue))

		return
	end, var_0_0.AutoIntoDarkModeTime)

	arg_4_0.task:Start()

	return
end

function var_0_0.ClearTask(arg_6_0)
	if not arg_6_0.task then
		return
	end

	arg_6_0.task:Stop()

	arg_6_0.task = nil

	return
end

function var_0_0.EnterManualMode(arg_7_0)
	if arg_7_0.manulStatus then
		return
	end

	local var_7_0 = var_0_1.GetBrightnessValue()

	arg_7_0.originalBrightnessValue = var_7_0

	var_0_1.SetBrightnessValue(math.min(var_0_0.DarkModeBrightness, var_7_0))

	arg_7_0.manulStatus = true

	return
end

function var_0_0.ExitManualMode(arg_8_0)
	if not arg_8_0.manulStatus then
		return
	end

	var_0_1.SetBrightnessValue(arg_8_0.originalBrightnessValue)
	arg_8_0:ClearTask()

	arg_8_0.manulStatus = false

	return
end

function var_0_0.IsPermissionGranted(arg_9_0)
	return var_0_1.CanWriteSetting()
end

function var_0_0.OpenPermissionSettings(arg_10_0)
	YSNormalTool.OtherTool.OpenAndroidWriteSettings()

	return
end

function var_0_0.RequestPremission(arg_11_0, arg_11_1)
	arg_11_0:OpenPermissionSettings()

	if arg_11_1 then
		FrameTimer.New(function()
			arg_11_1(arg_11_0:IsPermissionGranted())

			return
		end, 2):Start()
	end

	return
end

function var_0_0.SetScreenNeverSleep(arg_13_0, arg_13_1)
	arg_13_1 = tobool(arg_13_1)

	if arg_13_1 then
		if arg_13_0.sleepTimeOutCounter == 0 then
			Screen.sleepTimeout = SleepTimeout.NeverSleep
		end

		arg_13_0.sleepTimeOutCounter = arg_13_0.sleepTimeOutCounter + 1
	else
		arg_13_0.sleepTimeOutCounter = arg_13_0.sleepTimeOutCounter - 1

		assert(arg_13_0.sleepTimeOutCounter >= 0, "InCorrect Call of SetScreenNeverSleep")

		arg_13_0.sleepTimeOutCounter = math.max(0, arg_13_0.sleepTimeOutCounter)

		if arg_13_0.sleepTimeOutCounter == 0 then
			Screen.sleepTimeout = SleepTimeout.SystemSetting
		end
	end

	return
end

return

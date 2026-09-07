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

function var_0_0:AwakeForAWhile()
	if not self:IsPermissionGranted() then
		self:ExitManualMode()

		return
	end

	var_0_1.SetBrightnessValue(self.originalBrightnessValue)
	self:SetDelayTask()

	return
end

function var_0_0:SetDelayTask()
	self:ClearTask()

	self.task = Timer.New(function()
		var_0_1.SetBrightnessValue(math.min(var_0_0.DarkModeBrightness, self.originalBrightnessValue))

		return
	end, var_0_0.AutoIntoDarkModeTime)

	self.task:Start()

	return
end

function var_0_0:ClearTask()
	if not self.task then
		return
	end

	self.task:Stop()

	self.task = nil

	return
end

function var_0_0:EnterManualMode()
	if self.manulStatus then
		return
	end

	local var_7_0 = var_0_1.GetBrightnessValue()

	self.originalBrightnessValue = var_7_0

	var_0_1.SetBrightnessValue(math.min(var_0_0.DarkModeBrightness, var_7_0))

	self.manulStatus = true

	return
end

function var_0_0:ExitManualMode()
	if not self.manulStatus then
		return
	end

	var_0_1.SetBrightnessValue(self.originalBrightnessValue)
	self:ClearTask()

	self.manulStatus = false

	return
end

function var_0_0.IsPermissionGranted(arg_9_0)
	return var_0_1.CanWriteSetting()
end

function var_0_0.OpenPermissionSettings(arg_10_0)
	YSNormalTool.OtherTool.OpenAndroidWriteSettings()

	return
end

function var_0_0:RequestPremission(arg_11_1)
	self:OpenPermissionSettings()

	if arg_11_1 then
		FrameTimer.New(function()
			arg_11_1(self:IsPermissionGranted())

			return
		end, 2):Start()
	end

	return
end

function var_0_0:SetScreenNeverSleep(arg_13_1)
	arg_13_1 = tobool(arg_13_1)

	if arg_13_1 then
		if self.sleepTimeOutCounter == 0 then
			Screen.sleepTimeout = SleepTimeout.NeverSleep
		end

		self.sleepTimeOutCounter = self.sleepTimeOutCounter + 1
	else
		self.sleepTimeOutCounter = self.sleepTimeOutCounter - 1

		assert(self.sleepTimeOutCounter >= 0, "InCorrect Call of SetScreenNeverSleep")

		self.sleepTimeOutCounter = math.max(0, self.sleepTimeOutCounter)

		if self.sleepTimeOutCounter == 0 then
			Screen.sleepTimeout = SleepTimeout.SystemSetting
		end
	end

	return
end

return

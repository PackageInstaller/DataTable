local var_0_0 = setmetatable
local var_0_1 = UpdateBeat
local var_0_2 = CoUpdateBeat
local var_0_3 = Time

Timer = {}

local var_0_4 = Timer
local var_0_5 = {
	__index = var_0_4
}

local function var_0_6(arg_1_0, arg_1_1)
	return function()
		arg_1_0.running = false
		arg_1_0.timeout = true

		if arg_1_1 then
			arg_1_1()
		end
	end
end

function var_0_4.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_3 = arg_3_3 or false and true
	arg_3_2 = arg_3_2 or 1

	local var_3_0 = {
		func = arg_3_0,
		duration = arg_3_1,
		loop = arg_3_2,
		unscaled = arg_3_3
	}

	var_3_0.id = FuncTimerManager.inst:CreateFuncTimer(var_0_6(var_3_0, arg_3_0), arg_3_1, arg_3_2, false)

	return var_0_0(var_3_0, var_0_5)
end

function var_0_4.Start(arg_4_0)
	arg_4_0.running = true

	FuncTimerManager.inst:StartFuncTimer(arg_4_0.id)
end

function var_0_4.Reset(arg_5_0)
	FuncTimerManager.inst:ResetFuncTimer(arg_5_0.id)
end

function var_0_4.Stop(arg_6_0)
	if arg_6_0.running then
		arg_6_0.running = false
		arg_6_0.timeout = false
	end

	FuncTimerManager.inst:RemoveFuncTimer(arg_6_0.id)
end

function var_0_4.QueryTime(arg_7_0)
	return FuncTimerManager.inst:QueryTotalTime(arg_7_0.id)
end

function var_0_4.Update(arg_8_0)
	if not arg_8_0.running then
		return
	end

	local var_8_0 = arg_8_0.unscaled and var_0_3.unscaledDeltaTime or var_0_3.deltaTime

	arg_8_0.time = arg_8_0.time - var_8_0

	if arg_8_0.time <= 0 then
		arg_8_0.func()

		if arg_8_0.loop > 0 then
			arg_8_0.loop = arg_8_0.loop - 1
			arg_8_0.time = arg_8_0.time + arg_8_0.duration
		end

		if arg_8_0.loop == 0 then
			arg_8_0:Stop()
		elseif arg_8_0.loop < 0 then
			arg_8_0.time = arg_8_0.time + arg_8_0.duration
		end
	end
end

function var_0_4.IsRunning(arg_9_0)
	return arg_9_0.running
end

function var_0_4.HasStarted(arg_10_0)
	return arg_10_0.running ~= nil
end

FrameTimer = {}

local var_0_7 = FrameTimer
local var_0_8 = {
	__index = var_0_7
}

function var_0_7.New(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = var_0_3.frameCount + arg_11_1

	arg_11_2 = arg_11_2 or 1

	return var_0_0({
		running = false,
		func = arg_11_0,
		loop = arg_11_2,
		duration = arg_11_1,
		count = var_11_0,
		scheduler = arg_11_3
	}, var_0_8)
end

function var_0_7.Reset(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.func = arg_12_1
	arg_12_0.duration = arg_12_2
	arg_12_0.loop = arg_12_3
	arg_12_0.count = var_0_3.frameCount + arg_12_2
end

function var_0_7.Start(arg_13_0)
	local var_13_0 = arg_13_0.scheduler or var_0_2

	if not arg_13_0.handle then
		arg_13_0.handle = var_13_0:CreateListener(arg_13_0.Update, arg_13_0)
	end

	var_13_0:AddListener(arg_13_0.handle)

	arg_13_0.running = true
end

function var_0_7.Stop(arg_14_0)
	arg_14_0.running = false

	local var_14_0 = arg_14_0.scheduler or var_0_2

	if arg_14_0.handle then
		var_14_0:RemoveListener(arg_14_0.handle)
	end
end

function var_0_7.Update(arg_15_0)
	if not arg_15_0.running then
		return
	end

	if var_0_3.frameCount >= arg_15_0.count then
		arg_15_0.func()

		if arg_15_0.loop > 0 then
			arg_15_0.loop = arg_15_0.loop - 1
		end

		if arg_15_0.loop == 0 then
			arg_15_0:Stop()
		else
			arg_15_0.count = var_0_3.frameCount + arg_15_0.duration
		end
	end
end

CoTimer = {}

local var_0_9 = CoTimer
local var_0_10 = {
	__index = var_0_9
}

function var_0_9.New(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or 1

	return var_0_0({
		running = false,
		duration = arg_16_1,
		loop = arg_16_2,
		func = arg_16_0,
		time = arg_16_1
	}, var_0_10)
end

function var_0_9.Start(arg_17_0)
	if not arg_17_0.handle then
		arg_17_0.handle = var_0_2:CreateListener(arg_17_0.Update, arg_17_0)
	end

	arg_17_0.running = true

	var_0_2:AddListener(arg_17_0.handle)
end

function var_0_9.Reset(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.duration = arg_18_2
	arg_18_0.loop = arg_18_3 or 1
	arg_18_0.func = arg_18_1
	arg_18_0.time = arg_18_2
end

function var_0_9.Stop(arg_19_0)
	arg_19_0.running = false

	if arg_19_0.handle then
		var_0_2:RemoveListener(arg_19_0.handle)
	end
end

function var_0_9.Update(arg_20_0)
	if not arg_20_0.running then
		return
	end

	if arg_20_0.time <= 0 then
		arg_20_0.func()

		if arg_20_0.loop > 0 then
			arg_20_0.loop = arg_20_0.loop - 1
			arg_20_0.time = arg_20_0.time + arg_20_0.duration
		end

		if arg_20_0.loop == 0 then
			arg_20_0:Stop()
		elseif arg_20_0.loop < 0 then
			arg_20_0.time = arg_20_0.time + arg_20_0.duration
		end
	end

	arg_20_0.time = arg_20_0.time - var_0_3.deltaTime
end

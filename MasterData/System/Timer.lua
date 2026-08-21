local var_0_0 = setmetatable
local var_0_1 = UpdateBeat
local var_0_2 = CoUpdateBeat
local var_0_3 = Time

Timer = {}

local var_0_4 = Timer
local var_0_5 = {
	__index = var_0_4
}

function var_0_4.New(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_3 = arg_1_3 or false and true
	arg_1_2 = arg_1_2 or 1

	return var_0_0({
		running = false,
		func = arg_1_0,
		duration = arg_1_1,
		time = arg_1_1,
		loop = arg_1_2,
		unscaled = arg_1_3
	}, var_0_5)
end

function var_0_4.Start(arg_2_0)
	arg_2_0.running = true

	if not arg_2_0.handle then
		arg_2_0.handle = var_0_1:CreateListener(arg_2_0.Update, arg_2_0)
	end

	var_0_1:AddListener(arg_2_0.handle)
end

function var_0_4.Reset(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.duration = arg_3_2
	arg_3_0.loop = arg_3_3 or 1
	arg_3_0.unscaled = arg_3_4
	arg_3_0.func = arg_3_1
	arg_3_0.time = arg_3_2
end

function var_0_4.Stop(arg_4_0)
	arg_4_0.running = false

	if arg_4_0.handle then
		var_0_1:RemoveListener(arg_4_0.handle)
	end
end

function var_0_4.Update(arg_5_0)
	if not arg_5_0.running then
		return
	end

	local var_5_0 = arg_5_0.unscaled and var_0_3.unscaledDeltaTime or var_0_3.deltaTime

	arg_5_0.time = arg_5_0.time - var_5_0

	if arg_5_0.time <= 0 then
		arg_5_0.func()

		if arg_5_0.loop > 0 then
			arg_5_0.loop = arg_5_0.loop - 1
			arg_5_0.time = arg_5_0.time + arg_5_0.duration
		end

		if arg_5_0.loop == 0 then
			arg_5_0:Stop()
		elseif arg_5_0.loop < 0 then
			arg_5_0.time = arg_5_0.time + arg_5_0.duration
		end
	end
end

FrameTimer = {}

local var_0_6 = FrameTimer
local var_0_7 = {
	__index = var_0_6
}

function var_0_6.New(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_3.frameCount + arg_6_1

	arg_6_2 = arg_6_2 or 1

	return var_0_0({
		running = false,
		func = arg_6_0,
		loop = arg_6_2,
		duration = arg_6_1,
		count = var_6_0
	}, var_0_7)
end

function var_0_6.Reset(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.func = arg_7_1
	arg_7_0.duration = arg_7_2
	arg_7_0.loop = arg_7_3
	arg_7_0.count = var_0_3.frameCount + arg_7_2
end

function var_0_6.Start(arg_8_0)
	if not arg_8_0.handle then
		arg_8_0.handle = var_0_2:CreateListener(arg_8_0.Update, arg_8_0)
	end

	var_0_2:AddListener(arg_8_0.handle)

	arg_8_0.running = true
end

function var_0_6.Stop(arg_9_0)
	arg_9_0.running = false

	if arg_9_0.handle then
		var_0_2:RemoveListener(arg_9_0.handle)
	end
end

function var_0_6.Update(arg_10_0)
	if not arg_10_0.running then
		return
	end

	if var_0_3.frameCount >= arg_10_0.count then
		arg_10_0.func()

		if arg_10_0.loop > 0 then
			arg_10_0.loop = arg_10_0.loop - 1
		end

		if arg_10_0.loop == 0 then
			arg_10_0:Stop()
		else
			arg_10_0.count = var_0_3.frameCount + arg_10_0.duration
		end
	end
end

CoTimer = {}

local var_0_8 = CoTimer
local var_0_9 = {
	__index = var_0_8
}

function var_0_8.New(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2 = arg_11_2 or 1

	return var_0_0({
		running = false,
		duration = arg_11_1,
		loop = arg_11_2,
		func = arg_11_0,
		time = arg_11_1
	}, var_0_9)
end

function var_0_8.Start(arg_12_0)
	if not arg_12_0.handle then
		arg_12_0.handle = var_0_2:CreateListener(arg_12_0.Update, arg_12_0)
	end

	arg_12_0.running = true

	var_0_2:AddListener(arg_12_0.handle)
end

function var_0_8.Reset(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.duration = arg_13_2
	arg_13_0.loop = arg_13_3 or 1
	arg_13_0.func = arg_13_1
	arg_13_0.time = arg_13_2
end

function var_0_8.Stop(arg_14_0)
	arg_14_0.running = false

	if arg_14_0.handle then
		var_0_2:RemoveListener(arg_14_0.handle)
	end
end

function var_0_8.Update(arg_15_0)
	if not arg_15_0.running then
		return
	end

	if arg_15_0.time <= 0 then
		arg_15_0.func()

		if arg_15_0.loop > 0 then
			arg_15_0.loop = arg_15_0.loop - 1
			arg_15_0.time = arg_15_0.time + arg_15_0.duration
		end

		if arg_15_0.loop == 0 then
			arg_15_0:Stop()
		elseif arg_15_0.loop < 0 then
			arg_15_0.time = arg_15_0.time + arg_15_0.duration
		end
	end

	arg_15_0.time = arg_15_0.time - var_0_3.deltaTime
end

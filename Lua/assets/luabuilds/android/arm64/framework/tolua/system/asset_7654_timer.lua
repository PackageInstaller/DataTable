local var_0_0 = setmetatable
local var_0_1 = UpdateBeat
local var_0_2 = CoUpdateBeat
local var_0_3 = Time

Timer = {
	loop = 1,
	running = false,
	time = 0,
	duration = 1,
	scale = false
}

local var_0_4 = {
	__index = Timer
}

function Timer.New(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert(arg_1_1 > 0, "定时器间隔不能小于等于0！：" .. arg_1_1)

	arg_1_3 = arg_1_3 or false
	arg_1_2 = arg_1_2 or 1

	return var_0_0({
		running = false,
		func = arg_1_0,
		duration = arg_1_1,
		time = arg_1_1,
		loop = arg_1_2,
		scale = arg_1_3
	}, var_0_4)
end

function Timer:Start()
	assert(self.running == false, "对已经启动的定时器执行启动！")

	self.running = true
	self.paused = nil
	self.handle = self.handle or var_0_1:CreateListener(self.Update, self)

	var_0_1:AddListener(self.handle)

	return
end

function Timer:Reset(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self.duration = arg_3_2 or self.duration

	assert(self.duration > 0, "定时器间隔不能小于等于0！：" .. self.duration)

	self.loop = arg_3_3 or self.loop
	self.scale = arg_3_4 or self.scale
	self.func = arg_3_1 or self.func
	self.time = arg_3_2 or self.time
	self.running = false
	self.paused = nil

	return
end

function Timer.SetScale(arg_4_0, arg_4_1)
	arg_4_0.scale = arg_4_1

	return
end

function Timer:Stop()
	if not self.running then
		return
	end

	self.running = false
	self.paused = nil
	self.time = 0

	if self.handle then
		var_0_1:RemoveListener(self.handle)
	end

	return
end

function Timer.Pause(arg_6_0)
	arg_6_0.paused = true

	return
end

function Timer.Resume(arg_7_0)
	arg_7_0.paused = nil

	return
end

function Timer:Update()
	if not self.running or self.paused then
		return
	end

	self.time = self.time - ((self.scale or nil) and (var_0_3.deltaTime or var_0_3.unscaledDeltaTime))

	while self.time <= 0 and 0 < 6 do
		self:func()

		if self.loop > 0 then
			self.loop = self.loop - 1
			self.time = self.time + self.duration
		end

		if self.loop == 0 then
			self:Stop()

			return
		elseif self.loop < 0 then
			self.time = self.time + self.duration
		end
	end

	return
end

FrameTimer = {}

local var_0_5 = {
	__index = FrameTimer
}

function FrameTimer.New(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2 = arg_9_2 or 1

	return var_0_0({
		running = false,
		func = arg_9_0,
		loop = arg_9_2,
		duration = arg_9_1,
		count = var_0_3.frameCount + arg_9_1
	}, var_0_5)
end

function FrameTimer.Reset(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.func = arg_10_1
	arg_10_0.duration = arg_10_2
	arg_10_0.loop = arg_10_3
	arg_10_0.count = var_0_3.frameCount + arg_10_2

	return
end

function FrameTimer:Start()
	self.handle = self.handle or var_0_2:CreateListener(self.Update, self)

	var_0_2:AddListener(self.handle)

	self.running = true

	return
end

function FrameTimer:Stop()
	self.running = false

	if self.handle then
		var_0_2:RemoveListener(self.handle)
	end

	return
end

function FrameTimer:Update()
	if not self.running then
		return
	end

	if var_0_3.frameCount >= self.count then
		self.func()

		if self.loop > 0 then
			self.loop = self.loop - 1
		end

		if self.loop == 0 then
			self:Stop()
		else
			self.count = var_0_3.frameCount + self.duration
		end
	end

	return
end

CoTimer = {}

local var_0_6 = {
	__index = CoTimer
}

function CoTimer.New(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or 1

	return var_0_0({
		running = false,
		duration = arg_14_1,
		loop = arg_14_2,
		func = arg_14_0,
		time = arg_14_1
	}, var_0_6)
end

function CoTimer:Start()
	self.handle = self.handle or var_0_2:CreateListener(self.Update, self)
	self.running = true

	var_0_2:AddListener(self.handle)

	return
end

function CoTimer.Reset(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.duration = arg_16_2
	arg_16_0.loop = arg_16_3 or 1
	arg_16_0.func = arg_16_1
	arg_16_0.time = arg_16_2

	return
end

function CoTimer:Stop()
	self.running = false

	if self.handle then
		var_0_2:RemoveListener(self.handle)
	end

	return
end

function CoTimer:Update()
	if not self.running then
		return
	end

	if self.time <= 0 then
		self.func()

		if self.loop > 0 then
			self.loop = self.loop - 1
			self.time = self.time + self.duration
		end

		if self.loop == 0 then
			self:Stop()
		elseif self.loop < 0 then
			self.time = self.time + self.duration
		end
	end

	self.time = self.time - var_0_3.deltaTime

	return
end

return

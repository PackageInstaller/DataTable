local var_0_0 = setmetatable
local var_0_2 = CoUpdateBeat
local var_0_3 = Time

Timer = {}

local var_0_4 = {
	__index = Timer
}

local function var_0_5(arg_1_0, arg_1_1)
	return function()
		arg_1_0.running = false
		arg_1_0.timeout = true

		if arg_1_1 then
			arg_1_1()
		end
	end
end

function Timer.New(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_3 = arg_3_3 or false and true
	arg_3_2 = arg_3_2 or 1

	local var_3_0 = {
		func = arg_3_0,
		duration = arg_3_1,
		loop = arg_3_2,
		unscaled = arg_3_3
	}

	var_3_0.id = FuncTimerManager.inst:CreateFuncTimer(var_0_5(var_3_0, arg_3_0), arg_3_1, arg_3_2, false)

	return var_0_0(var_3_0, var_0_4)
end

function Timer:Start()
	self.running = true

	FuncTimerManager.inst:StartFuncTimer(self.id)
end

function Timer:Reset()
	FuncTimerManager.inst:ResetFuncTimer(self.id)
end

function Timer:Stop()
	if self.running then
		self.running = false
		self.timeout = false
	end

	FuncTimerManager.inst:RemoveFuncTimer(self.id)
end

function Timer:QueryTime()
	return FuncTimerManager.inst:QueryTotalTime(self.id)
end

function Timer:Update()
	if not self.running then
		return
	end

	self.time = self.time - ((self.unscaled or nil) and (var_0_3.unscaledDeltaTime or var_0_3.deltaTime))

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
end

function Timer:IsRunning()
	return self.running
end

function Timer:HasStarted()
	return self.running ~= nil
end

FrameTimer = {}

local var_0_6 = {
	__index = FrameTimer
}

function FrameTimer.New(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_2 = arg_11_2 or 1

	return var_0_0({
		running = false,
		func = arg_11_0,
		loop = arg_11_2,
		duration = arg_11_1,
		count = var_0_3.frameCount + arg_11_1,
		scheduler = arg_11_3
	}, var_0_6)
end

function FrameTimer.Reset(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_0.func = arg_12_1
	arg_12_0.duration = arg_12_2
	arg_12_0.loop = arg_12_3
	arg_12_0.count = var_0_3.frameCount + arg_12_2
end

function FrameTimer:Start()
	local var_13_0 = self.scheduler or var_0_2

	self.handle = self.handle or var_13_0:CreateListener(self.Update, self)

	var_13_0:AddListener(self.handle)

	self.running = true
end

function FrameTimer:Stop()
	self.running = false

	if self.handle then
		(self.scheduler or var_0_2):RemoveListener(self.handle)
	end
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
end

CoTimer = {}

local var_0_7 = {
	__index = CoTimer
}

function CoTimer.New(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or 1

	return var_0_0({
		running = false,
		duration = arg_16_1,
		loop = arg_16_2,
		func = arg_16_0,
		time = arg_16_1
	}, var_0_7)
end

function CoTimer:Start()
	self.handle = self.handle or var_0_2:CreateListener(self.Update, self)
	self.running = true

	var_0_2:AddListener(self.handle)
end

function CoTimer.Reset(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0.duration = arg_18_2
	arg_18_0.loop = arg_18_3 or 1
	arg_18_0.func = arg_18_1
	arg_18_0.time = arg_18_2
end

function CoTimer:Stop()
	self.running = false

	if self.handle then
		var_0_2:RemoveListener(self.handle)
	end
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
end

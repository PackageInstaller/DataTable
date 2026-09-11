local var_0_0 = singletonClass("TimeWheelMgr")

function var_0_0:Ctor(arg_1_1)
	self.tickInterval_ = arg_1_1 or 1
	self.timeWheel_ = {}

	if self.timer_ == nil then
		self.timer_ = Timer.New(handler(self, self.Update), 1, -1)
	end

	self.timer_:Start()
end

function var_0_0:AddTask(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {
		func = arg_2_1,
		next_tick = arg_2_2,
		interval = arg_2_3 or self.tickInterval_
	}

	table.insert(self.timeWheel_, var_2_0)

	return var_2_0
end

function var_0_0:RemoveTask(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.timeWheel_) do
		if iter_3_1 == arg_3_1 then
			table.remove(self.timeWheel_, iter_3_0)

			break
		end
	end
end

function var_0_0:Update()
	local var_4_0 = manager.time:GetServerTime()

	if not var_4_0 then
		return
	end

	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(self.timeWheel_) do
		if var_4_0 >= iter_4_1.next_tick then
			table.insert(var_4_1, iter_4_1)

			iter_4_1.next_tick = var_4_0 + iter_4_1.interval
		end
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_1) do
		iter_4_3.func()
	end
end

function var_0_0:Dispose()
	if self.timer_ ~= nil then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return var_0_0

local var_0_0 = singletonClass("DelayedActionMgr")

function var_0_0:Ctor()
	self:Init()
end

function var_0_0:Init()
	self.schedule = {}
	self.addList = {}

	self:StartSchedule()
end

local function var_0_1()
	return LuaForUtil.NowMilliSec * 0.001
end

local function var_0_2(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1.executeTime = arg_4_2 + arg_4_1.delay

	table.insert(arg_4_0.schedule, arg_4_1)
end

function var_0_0:StartSchedule()
	self:StopSchedule()

	self.scheduler = FrameTimer.New(function()
		self.updateLoopFlag = true

		local var_6_0 = var_0_1()

		for iter_6_0 = #self.schedule, 1, -1 do
			if var_6_0 >= self.schedule[iter_6_0].executeTime then
				self.schedule[iter_6_0].func()
				table.remove(self.schedule, iter_6_0)
			end
		end

		if #self.addList > 0 then
			for iter_6_1, iter_6_2 in ipairs(self.addList) do
				var_0_2(self, iter_6_2, var_6_0)
			end

			self.addList = {}
		end

		self.updateLoopFlag = nil
	end, 1, -1)

	self.scheduler:Start()
end

function var_0_0:StopSchedule()
	if self.scheduler then
		self.scheduler:Stop()

		self.scheduler = nil
	end
end

function var_0_0:Add(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {
		func = arg_8_1,
		delay = arg_8_2
	}

	if arg_8_3 or self.updateLoopFlag then
		table.insert(self.addList, var_8_0)
	else
		var_0_2(self, var_8_0, var_0_1())
	end

	return var_8_0
end

function var_0_0:Dispose()
	self:StopSchedule()

	self.schedule = nil
	self.addList = nil
end

return var_0_0

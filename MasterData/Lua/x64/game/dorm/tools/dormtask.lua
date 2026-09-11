local var_0_0 = class("DormTaskRunner.Task")

function var_0_0:Ctor(arg_1_1)
	self.progress = 0
	self.taskList = {}
	self.taskDataCtx = arg_1_1 or {}
	self.taskDataCtx.task = self
end

function var_0_0:Then(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or {}
	arg_2_2.taskDataCtx = self.taskDataCtx

	table.insert(self.taskList, {
		function(arg_3_0)
			if arg_2_1 then
				arg_2_1(arg_3_0)
			end

			return true, arg_3_0
		end,
		true,
		arg_2_2
	})

	return self
end

function var_0_0:WaitUntil(arg_4_1, arg_4_2, arg_4_3)
	arg_4_3 = arg_4_3 or {}
	arg_4_3.taskDataCtx = self.taskDataCtx

	table.insert(self.taskList, {
		arg_4_1,
		arg_4_2,
		arg_4_3
	})

	return self
end

local function var_0_1(arg_5_0)
	if not arg_5_0.timer.running then
		arg_5_0.timer:Start()
	end

	return arg_5_0.timer.timeout
end

local function var_0_2()
	return true
end

function var_0_0:WaitForSec(arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		return self:WaitUntil(var_0_2, arg_7_2)
	end

	return self:WaitUntil(var_0_1, arg_7_2, {
		timer = self.taskRunner:NewTimer(nil, arg_7_1, false, false)
	})
end

function var_0_0:WaitTask(...)
	return self:WaitAllTask({
		...
	})
end

function var_0_0:WaitAllTask(arg_9_1)
	return self:WaitUntil(function()
		for iter_10_0, iter_10_1 in ipairs(arg_9_1) do
			if not iter_10_1:IsFinished() then
				return false
			end
		end

		return true
	end)
end

function var_0_0:WaitAnyTask(arg_11_1)
	return self:WaitUntil(function()
		for iter_12_0, iter_12_1 in ipairs(arg_11_1) do
			if iter_12_1:IsFinished() then
				return true
			end
		end

		return false
	end)
end

function var_0_0:HandleAnimeLoop(arg_13_1)
	local var_13_0 = {
		continue = false,
		started = false
	}

	DormCharacterActionManager:RegisterAnimeEvent(function(arg_14_0, arg_14_1, ...)
		if var_13_0.started and arg_13_1(arg_14_0, arg_14_1, ...) then
			var_13_0.continue = true

			return true
		end
	end)

	if #self.taskList >= 1 then
		self.taskList[#self.taskList][2] = false
	end

	return self:WaitUntil(function(arg_15_0)
		arg_15_0.started = arg_15_0.started or true

		return arg_15_0.continue
	end, false, var_13_0)
end

function var_0_0:Start(arg_16_1)
	self.progress = 1

	if not arg_16_1 then
		self.taskRunner:DoTask(self)
	end

	self.taskRunner:RegisterTask(self)
end

function var_0_0:SetRunner(arg_17_1)
	self.taskRunner = arg_17_1
end

function var_0_0:Abort()
	if self.progress ~= -1 and not self:IsFinished() then
		self.progress = -1

		if self.onAbort then
			self:onAbort()
		end
	end
end

function var_0_0:IsCancelled()
	if self.cancellationSrc then
		return self.cancellationSrc()
	end
end

function var_0_0:IsStarted()
	return self.progress ~= 0
end

function var_0_0:IsFinished()
	return self.progress > #self.taskList
end

function var_0_0:IsAborted()
	return self.progress == -1
end

function var_0_0:SetCancellationSrc(arg_23_1)
	self.cancellationSrc = arg_23_1

	return self
end

function var_0_0:SetOnAbort(arg_24_1)
	self.onAbort = arg_24_1

	return self
end

function var_0_0:SetOnComplete(arg_25_1)
	self.onComplete = arg_25_1

	return self
end

return var_0_0

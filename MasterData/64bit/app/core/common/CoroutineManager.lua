local CoroutineManager = class("CoroutineManager")
local Co = class("Co")

function Co:ctor(arg_1_1, arg_1_2, arg_1_3)
	self.cs = arg_1_1
	self.co = arg_1_2
	self.target = arg_1_3
	self.callbacks = {}
end

function Co:WaitTime(arg_2_1)
	while 0 < arg_2_1 do
		local var_2_0 = 0 + coroutine.yield()
	end
end

function Co:WaitFrame(arg_3_1)
	while 0 < arg_3_1 do
		coroutine.yield()
	end
end

function Co:yield()
	return coroutine.yield()
end

function Co:runOnMainThread(arg_5_1)
	table.insert(self.callbacks, arg_5_1)
end

function Co:mainThreadCall()
	if #self.callbacks == 0 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(self.callbacks) do
		iter_6_1()
	end

	self.callbacks = {}
end

function Co:stop()
	self.cs:stop(self)
end

function CoroutineManager:ctor()
	self.tasks = {}
end

function CoroutineManager:start(arg_9_1, arg_9_2)
	if self._schedulerHandler == nil then
		self._schedulerHandler = g.core.common.Scheduler:newSchedule(handler(self, self.update), 0)
	end

	local var_9_0 = Co.new(self, coroutine.create(arg_9_1), arg_9_2)

	table.insert(self.tasks, var_9_0)
	coroutine.resume(var_9_0.co, var_9_0, ...)

	return var_9_0
end

function CoroutineManager:stop(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self.tasks) do
		if iter_10_1 == arg_10_1 then
			table.remove(self.tasks, iter_10_0)

			break
		end
	end
end

function CoroutineManager:update(arg_11_1, arg_11_2)
	for iter_11_0 = #self.tasks, 1, -1 do
		local var_11_0 = self.tasks[iter_11_0]

		if coroutine.status(self.tasks[iter_11_0].co) == "dead" then
			table.remove(self.tasks, iter_11_0)
		else
			local var_11_1, var_11_2 = coroutine.resume(var_11_0.co, arg_11_2)

			if not var_11_1 then
				print("[Coroutine Error]: " .. tostring(var_11_2))
				table.remove(self.tasks, iter_11_0)
			end
		end

		var_11_0:mainThreadCall()
	end
end

function CoroutineManager:reset()
	self:stopAll()

	if self._schedulerHandler then
		g.core.common.Scheduler:cancelSchedule(self._schedulerHandler)

		self._schedulerHandler = nil
	end
end

function CoroutineManager:stopByTarget(arg_13_1)
	assert(arg_13_1 ~= nil, "目标不能为空")

	for iter_13_0 = #self.tasks, 1, -1 do
		if self.tasks[iter_13_0].target == arg_13_1 then
			table.remove(self.tasks, iter_13_0)
		end
	end
end

function CoroutineManager:stopAll()
	self.tasks = {}
end

return CoroutineManager

local var_0_0 = table
local var_0_1 = table.insert
local var_0_2 = table.remove
local NetSocket = import("..NetSocket")
local ScheduleTask = import("..ScheduleTask")
local NetRequest = import("..NetRequest")
local InteractiveProxy = class("InteractiveProxy")

function InteractiveProxy:ctor(arg_1_1)
	self._netSocket = nil
	self._tasks = {}
	self._seqFactory = nil
	self._stateListener = arg_1_1
end

function InteractiveProxy:destroy()
	self:reset()
end

function InteractiveProxy:reset()
	for iter_3_0, iter_3_1 in ipairs(self._tasks) do
		iter_3_1:cancel()
	end

	self._tasks = {}

	if self._sendSchedule then
		g.core.common.Scheduler:cancelSchedule(self._sendSchedule)

		self._sendSchedule = nil
	end
end

function InteractiveProxy:enter(arg_4_1, arg_4_2, arg_4_3)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_INTERACTIVE_STATE_ENTER)

	self._netSocket = arg_4_1
	self._seqFactory = arg_4_2

	if arg_4_3 then
		local var_4_0 = 1

		while self._tasks[1] do
			local var_4_1 = self._tasks[1]:getMission():getResponse()

			if arg_4_3[var_4_1] and arg_4_3[var_4_1] > 0 then
				var_0_0.remove(self._tasks, var_4_0)

				arg_4_3[var_4_1] = arg_4_3[var_4_1] - 1
			else
				self._tasks[1]:start()

				var_4_0 = var_4_0 + 1
			end
		end
	else
		self._tasks = {}

		for iter_4_0, iter_4_1 in ipairs(self._tasks) do
			local var_4_3, var_4_4, var_4_5, var_4_6 = iter_4_1:getMission():getRequest()

			self:sendMsg(var_4_3, var_4_4, var_4_6)
		end
	end
end

function InteractiveProxy:exit()
	for iter_5_0, iter_5_1 in ipairs(self._tasks) do
		iter_5_1:cancel()
	end

	self._sendSchedule = nil

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_INTERACTIVE_STATE_EXIT)
end

function InteractiveProxy:isSending()
	return #self._tasks > 0
end

function InteractiveProxy:sendMsg(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = #self._tasks

	self:_addTask(ScheduleTask.new((self:_createRequest(arg_7_1, arg_7_2, false, arg_7_3, (self._seqFactory:cid())))))

	if not self._sendSchedule then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_REQUEST_START)

		self._sendSchedule = g.core.common.Scheduler:newScheduleOnce(function()
			if not self._sendSchedule then
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_REQUEST_CANCEL)

				return
			end

			self._sendSchedule = nil

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_REQUEST_CANCEL)

			if not self._netSocket:isConnected() then
				self:_stateListener("reset", var_7_0 == 0)
			else
				for iter_8_0, iter_8_1 in ipairs(self._tasks) do
					iter_8_1:start()
				end
			end
		end, 0)
	end
end

function InteractiveProxy:onNetEvent(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._tasks) do
		iter_9_1:result(arg_9_1, ...)
	end
end

function InteractiveProxy:cancelTaskById(arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(self._tasks) do
		if iter_10_1:getMissionId() == arg_10_1 then
			iter_10_1:cancel()
			var_0_2(self._tasks, iter_10_0)

			break
		end
	end
end

function InteractiveProxy:_createRequest(arg_11_1, arg_11_2)
	local var_11_0 = NetRequest.new(arg_11_1, arg_11_2, ...)

	function var_11_0:onStart(arg_12_1)
		NetRequest.onStart(self)
		self._netSocket:sendMsg(self:getRequest())
	end

	function var_11_0.onTimeup(arg_13_0, arg_13_1)
		NetRequest.onTimeup(arg_13_0)
		self:_onTimeout(arg_11_1)
	end

	function var_11_0.onResult(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if arg_14_2 == NetSocket.EVENT_NET_MSG then
			if NetRequest.onResult(arg_14_0, arg_14_3, arg_14_4) then
				arg_14_1:cancel()
				self:_removeTask(arg_14_1)
			end
		else
			arg_14_1:cancel()
			self:_stateListener("disconnected")
		end
	end

	return var_11_0
end

function InteractiveProxy:_addTask(arg_15_1)
	var_0_1(self._tasks, arg_15_1)

	return arg_15_1
end

function InteractiveProxy:_removeTask(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._tasks) do
		if iter_16_1 == arg_16_1 then
			var_0_2(self._tasks, iter_16_0)

			break
		end
	end

	if #self._tasks == 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_INTERACTIVE_TASK_FINISH)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_INTERACTIVE_TASK_FINISH_ASYNC, true)
	end
end

function InteractiveProxy:_onTimeout(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(self._tasks) do
		iter_17_1:cancel()
	end

	self:_stateListener("timeout", {
		msgId = arg_17_1 or 1
	})
end

return InteractiveProxy

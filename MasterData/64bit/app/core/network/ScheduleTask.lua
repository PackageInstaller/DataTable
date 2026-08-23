local var_0_0 = table.insert
local var_0_3 = pairs
local var_0_4 = ipairs
local var_0_5 = cc.Director:getInstance():getScheduler()
local var_0_6 = {}
local var_0_7 = {}
local var_0_8 = {}
local var_0_9 = 0
local var_0_10

local function var_0_11(arg_1_0)
	if var_0_9 == 0 then
		return
	end

	for iter_1_0 in var_0_3(var_0_6) do
		iter_1_0:_update(arg_1_0)

		if iter_1_0:isEnded() then
			var_0_0(var_0_8, iter_1_0)
		end
	end

	if #var_0_7 > 0 then
		var_0_7 = {}

		for iter_1_1, iter_1_2 in var_0_4(var_0_7) do
			var_0_6[iter_1_2] = true
		end
	end

	if #var_0_8 > 0 then
		for iter_1_3, iter_1_4 in var_0_4(var_0_8) do
			var_0_6[iter_1_4] = nil
		end

		var_0_9 = var_0_9 - #var_0_8

		if var_0_9 == 0 then
			var_0_5:unscheduleScriptEntry(var_0_10)
		end

		var_0_8 = {}
	end
end

local ScheduleTask = class("ScheduleTask")

function ScheduleTask:ctor(arg_2_1, arg_2_2)
	local var_2_0 = type(arg_2_1) == "table" and arg_2_1.onStart and arg_2_1.onTimeup and arg_2_1.onResult or false

	assert((false or nil) and true, "The mission must be table and have onStart、onTimeup and onResult function !")

	self._startTime = 0
	self._mission = arg_2_1
	self._duration = arg_2_2 or 100

	assert(type(self._duration) == "number" and self._duration > 0, "The duration must be number and greater than 0 !")

	self._isEnded = true
end

function ScheduleTask:getMission()
	return self._mission
end

function ScheduleTask:cancel()
	if self._isEnded or self._startTime == 0 then
		return
	end

	self._startTime = 0
	self._isEnded = true

	if type(self._mission.onCancel) == "function" then
		self._mission:onCancel(self)
	end
end

function ScheduleTask:start()
	if not self._isEnded or self._startTime ~= 0 then
		return
	end

	self._isEnded = false
	self._startTime = os.time()

	var_0_0(var_0_7, self)

	if var_0_9 == 0 then
		var_0_10 = var_0_5:scheduleScriptFunc(var_0_11, 1, false)
	end

	var_0_9 = var_0_9 + 1

	self._mission:onStart(self, self._startTime)
end

function ScheduleTask:result()
	if self._isEnded or self._startTime == 0 then
		return
	end

	self._mission:onResult(self, ...)
end

function ScheduleTask:isEnded()
	return self._isEnded
end

function ScheduleTask:getDuration()
	return self._duration
end

function ScheduleTask:_update(arg_9_1)
	if self._isEnded then
		return
	end

	local var_9_0 = os.time()

	if var_9_0 - self._startTime >= self._duration then
		self._mission:onTimeup(self, var_9_0, self._startTime, self._duration)

		self._isEnded = true
	end
end

function ScheduleTask:getMissionId()
	return self._mission:getMsgId()
end

return ScheduleTask

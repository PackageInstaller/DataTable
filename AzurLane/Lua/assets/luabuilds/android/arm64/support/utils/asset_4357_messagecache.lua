pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.MessageCache = var_0_10001("MessageCache")
var_0.MessageCache.DEFAULT_QUEUE_LENGTH = 10000
var_0.MessageCache.CMD_KILL = "CMD_KILL"
var_0.MessageCache.CMD_PUSH = "CMD_PUSH"
var_0.MessageCache.CMD_POP = "CMD_POP"
var_0.MessageCache.CMD_FLUSH = "CMD_FLUSH"
var_0.MessageCache.OK = "OK"
var_0.MessageCache.QUEUE_FULL = "QUEUE_FULL"
var_0.MessageCache.EXCEPTION = "EXCEPTION"

local function var_0_1(...)
	coroutine = var_1_10000

	return var_1_10000.yield(...)
end

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == var_0.MessageCache.CMD_PUSH then
		local var_2_0 = #arg_2_0.cacheQueue_ + (arg_2_0.curRQLen_ - arg_2_0.curRQPos_)
		local var_2_1

		if arg_2_0.cacheQueueLenLimit_ <= var_2_0 then
			var_2_1 = var_0_2
			var_1_10006 = arg_2_0

			local var_2_2 = var_0_1

			var_1_10009 = var_0.MessageCache.QUEUE_FULL
			string = var_1_10010

			return var_2_1(var_1_10006, var_2_2(var_1_10009, var_1_10010.format("                    the cache limit length is set with %s, the coming message will be ignored.\n                ", arg_2_0.cacheQueueLenLimit_)))
		else
			table = var_2_1

			var_2_1.insert(arg_2_0.cacheQueue_, arg_2_2)

			return var_0_2(arg_2_0, var_0_1(var_0.MessageCache.OK, var_2_0 + 1))
		end
	elseif arg_2_1 == var_0.MessageCache.CMD_POP then
		local var_2_3

		if arg_2_0.curRQPos_ < arg_2_0.curRQLen_ then
			arg_2_0.curRQPos_ = arg_2_0.curRQPos_ + 1
			var_2_3 = arg_2_0.retrieveQueue_[arg_2_0.curRQPos_]
			arg_2_0.retrieveQueue_[arg_2_0.curRQPos_] = nil

			return var_0_2(arg_2_0, var_0_1(var_0.MessageCache.OK, var_2_3))
		else
			assert = var_2_3

			local var_2_4 = arg_2_0.curRQPos_

			var_2_3(arg_2_0.curRQLen_ <= var_2_4)

			if arg_2_0.cacheQueue_[1] then
				arg_2_0.cacheQueue_, arg_2_0.retrieveQueue_ = arg_2_0.retrieveQueue_, arg_2_0.cacheQueue_
				arg_2_0.curRQPos_ = 1
				arg_2_0.curRQLen_ = #arg_2_0.retrieveQueue_

				local var_2_5 = arg_2_0.retrieveQueue_[arg_2_0.curRQPos_]

				arg_2_0.retrieveQueue_[arg_2_0.curRQPos_] = nil

				return var_0_2(arg_2_0, var_0_1(var_0.MessageCache.OK, var_2_5))
			else
				return var_0_2(arg_2_0, var_0_1(var_0.MessageCache.OK))
			end
		end
	elseif arg_2_1 == var_0.MessageCache.CMD_KILL then
		local var_2_6 = arg_2_0.curRQPos_
		local var_2_7 = arg_2_0.curRQLen_
		local var_2_8 = 1

		while var_2_6 < var_2_7 do
			table = var_1_10006

			var_1_10006.insert(arg_2_0.cacheQueue_, var_2_8, arg_2_0.retrieveQueue_[var_2_6])

			var_1_10006 = arg_2_0.retrieveQueue_
			var_1_10006[var_2_6] = nil
			var_2_8 = var_2_8 + 1
			var_2_6 = var_2_6 + 1
		end

		arg_2_0.curRQPos_ = 0
		arg_2_0.curRQLen_ = 0

		return var_0.MessageCache.OK, arg_2_0.cacheQueue_
	elseif arg_2_1 == var_0.MessageCache.CMD_FLUSH then
		local var_2_9 = arg_2_0.curRQPos_
		local var_2_10 = arg_2_0.curRQLen_
		local var_2_11 = 1

		while var_2_9 < var_2_10 do
			table = var_1_10006

			var_1_10006.insert(arg_2_0.cacheQueue_, var_2_11, arg_2_0.retrieveQueue_[var_2_9])

			var_1_10006 = arg_2_0.retrieveQueue_
			var_1_10006[var_2_9] = nil
			var_2_11 = var_2_11 + 1
			var_2_9 = var_2_9 + 1
		end

		arg_2_0.curRQPos_ = 0
		arg_2_0.curRQLen_ = 0

		local var_2_12 = arg_2_0.cacheQueue_

		arg_2_0.cacheQueue_ = {}

		return var_0_2(arg_2_0, var_0_1(var_0.MessageCache.OK, var_2_12))
	else
		local var_2_13 = var_0_2
		local var_2_14 = arg_2_0
		local var_2_15 = var_0_1
		local var_2_16 = var_0.MessageCache.EXCEPTION

		string = var_1_10009

		local var_2_17 = var_1_10009.format
		local var_2_18 = "unknown cmd type received %s"

		tostring = var_1_10012

		return var_2_13(var_2_14, var_2_15(var_2_16, var_2_17(var_2_18, var_1_10012(arg_2_1))))
	end

	return
end

local function var_0_3(arg_3_0)
	local var_3_0 = {
		curRQPos_ = 0,
		curRQLen_ = 0,
		cacheQueue_ = {},
		retrieveQueue_ = {},
		cacheQueueLenLimit_ = arg_3_0 or var_0.MessageCache.DEFAULT_QUEUE_LENGTH
	}

	return var_0_2(var_3_0, var_0_1(var_0.MessageCache.OK))
end

function var_0.MessageCache.Ctor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._name = arg_4_1
	coroutine = var_1_10003
	arg_4_0._thread = var_1_10003.create(var_0_3)
	coroutine = var_3

	local var_4_0, var_4_1 = var_3.resume(arg_4_0._thread, arg_4_2)

	assert = var_5

	var_5(var_4_1 == var_0.MessageCache.OK)

	return
end

function var_0.MessageCache.Push(arg_5_0, ...)
	coroutine = var_1_10001

	local var_5_1

	if var_1_10001.status(arg_5_0._thread) == "suspended" then
		coroutine = var_1_10002

		local var_5_0, var_5_2

		var_5_0, var_5_1, var_5_2 = var_1_10002.resume(arg_5_0._thread, var_0.MessageCache.CMD_PUSH, {
			...
		})

		if var_5_0 then
			return var_5_1, var_5_2
		else
			return var_0.MessageCache.EXCEPTION, var_5_1
		end
	else
		local var_5_3 = var_0.MessageCache.EXCEPTION

		string = var_5_1

		local var_5_4 = var_5_1.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Push operation.", var_1)

		return
	end

	return
end

function var_0.MessageCache.Pop(arg_6_0)
	coroutine = var_1_10001

	local var_6_1

	if var_1_10001.status(arg_6_0._thread) == "suspended" then
		coroutine = var_1_10002

		local var_6_0, var_6_2

		var_6_0, var_6_1, var_6_2 = var_1_10002.resume(arg_6_0._thread, var_0.MessageCache.CMD_POP)

		if var_6_0 then
			if var_6_1 == var_0.MessageCache.OK and var_6_2 ~= nil then
				local var_6_3 = var_6_1

				unpack = var_1_10006

				local var_6_4 = var_1_10006(var_6_2)

				return
			else
				return var_6_1, var_6_2
			end
		else
			return var_0.MessageCache.EXCEPTION, var_6_1
		end
	else
		local var_6_5 = var_0.MessageCache.EXCEPTION

		string = var_6_1

		local var_6_6 = var_6_1.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Pop operation.", var_1)

		return
	end

	return
end

function var_0.MessageCache.Flush(arg_7_0)
	coroutine = var_1_10001

	local var_7_1

	if var_1_10001.status(arg_7_0._thread) == "suspended" then
		coroutine = var_1_10002

		local var_7_0, var_7_2

		var_7_0, var_7_1, var_7_2 = var_1_10002.resume(arg_7_0._thread, var_0.MessageCache.CMD_FLUSH)

		if var_7_0 then
			return var_7_1, var_7_2
		else
			return var_0.MessageCache.EXCEPTION, var_7_1
		end
	else
		local var_7_3 = var_0.MessageCache.EXCEPTION

		string = var_7_1

		local var_7_4 = var_7_1.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Destroy operation.", var_1)

		return
	end

	return
end

function var_0.MessageCache.Destroy(arg_8_0)
	coroutine = var_1_10001

	local var_8_1

	if var_1_10001.status(arg_8_0._thread) == "suspended" then
		coroutine = var_1_10002

		local var_8_0, var_8_2

		var_8_0, var_8_1, var_8_2 = var_1_10002.resume(arg_8_0._thread, var_0.MessageCache.CMD_KILL)

		if var_8_0 then
			return var_8_1, var_8_2
		else
			return var_0.MessageCache.EXCEPTION, var_8_1
		end
	else
		local var_8_3 = var_0.MessageCache.EXCEPTION

		string = var_8_1

		local var_8_4 = var_8_1.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Destroy operation.", var_1)

		return
	end

	return
end

return

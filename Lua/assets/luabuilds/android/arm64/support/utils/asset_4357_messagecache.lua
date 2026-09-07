pg = pg or {}

local var_0_0 = pg

pg.MessageCache = class("MessageCache")
pg.MessageCache.DEFAULT_QUEUE_LENGTH = 10000
pg.MessageCache.CMD_KILL = "CMD_KILL"
pg.MessageCache.CMD_PUSH = "CMD_PUSH"
pg.MessageCache.CMD_POP = "CMD_POP"
pg.MessageCache.CMD_FLUSH = "CMD_FLUSH"
pg.MessageCache.OK = "OK"
pg.MessageCache.QUEUE_FULL = "QUEUE_FULL"
pg.MessageCache.EXCEPTION = "EXCEPTION"

local function var_0_1(...)
	return coroutine.yield(...)
end

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == var_0_0.MessageCache.CMD_PUSH then
		if #arg_2_0.cacheQueue_ + (arg_2_0.curRQLen_ - arg_2_0.curRQPos_) >= arg_2_0.cacheQueueLenLimit_ then
			return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.QUEUE_FULL, string.format("                    the cache limit length is set with %s, the coming message will be ignored.\n                ", arg_2_0.cacheQueueLenLimit_)))
		else
			table.insert(arg_2_0.cacheQueue_, arg_2_2)

			return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.OK, #arg_2_0.cacheQueue_ + (arg_2_0.curRQLen_ - arg_2_0.curRQPos_) + 1))
		end
	elseif arg_2_1 == var_0_0.MessageCache.CMD_POP then
		if arg_2_0.curRQPos_ < arg_2_0.curRQLen_ then
			arg_2_0.curRQPos_ = arg_2_0.curRQPos_ + 1
			arg_2_0.retrieveQueue_[arg_2_0.curRQPos_] = nil

			return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.OK, arg_2_0.retrieveQueue_[arg_2_0.curRQPos_]))
		else
			assert(arg_2_0.curRQPos_ >= arg_2_0.curRQLen_)

			if arg_2_0.cacheQueue_[1] then
				arg_2_0.cacheQueue_, arg_2_0.retrieveQueue_ = arg_2_0.retrieveQueue_, arg_2_0.cacheQueue_
				arg_2_0.curRQPos_ = 1
				arg_2_0.curRQLen_ = #arg_2_0.retrieveQueue_
				arg_2_0.retrieveQueue_[arg_2_0.curRQPos_] = nil

				return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.OK, arg_2_0.retrieveQueue_[arg_2_0.curRQPos_]))
			else
				return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.OK))
			end
		end
	elseif arg_2_1 == var_0_0.MessageCache.CMD_KILL then
		local var_2_0 = arg_2_0.curRQPos_
		local var_2_1 = 1

		while var_2_0 < arg_2_0.curRQLen_ do
			table.insert(arg_2_0.cacheQueue_, var_2_1, arg_2_0.retrieveQueue_[var_2_0])

			arg_2_0.retrieveQueue_[var_2_0] = nil
			var_2_1 = var_2_1 + 1
			var_2_0 = var_2_0 + 1
		end

		arg_2_0.curRQPos_ = 0
		arg_2_0.curRQLen_ = 0

		return var_0_0.MessageCache.OK, arg_2_0.cacheQueue_
	elseif arg_2_1 == var_0_0.MessageCache.CMD_FLUSH then
		local var_2_2 = arg_2_0.curRQPos_
		local var_2_3 = 1

		while var_2_2 < arg_2_0.curRQLen_ do
			table.insert(arg_2_0.cacheQueue_, var_2_3, arg_2_0.retrieveQueue_[var_2_2])

			arg_2_0.retrieveQueue_[var_2_2] = nil
			var_2_3 = var_2_3 + 1
			var_2_2 = var_2_2 + 1
		end

		arg_2_0.curRQPos_ = 0
		arg_2_0.curRQLen_ = 0
		arg_2_0.cacheQueue_ = {}

		return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.OK, arg_2_0.cacheQueue_))
	else
		return var_0_2(arg_2_0, var_0_1(var_0_0.MessageCache.EXCEPTION, string.format("unknown cmd type received %s", tostring(arg_2_1))))
	end

	return
end

local function var_0_3(arg_3_0)
	return var_0_2({
		curRQPos_ = 0,
		curRQLen_ = 0,
		cacheQueue_ = {},
		retrieveQueue_ = {},
		cacheQueueLenLimit_ = arg_3_0 or var_0_0.MessageCache.DEFAULT_QUEUE_LENGTH
	}, var_0_1(var_0_0.MessageCache.OK))
end

function pg.MessageCache:Ctor(arg_4_1, arg_4_2)
	self._name = arg_4_1
	self._thread = coroutine.create(var_0_3)

	local var_4_0, var_4_1 = coroutine.resume(self._thread, arg_4_2)

	assert(var_4_1 == var_0_0.MessageCache.OK)

	return
end

function pg.MessageCache:Push(...)
	local var_5_0 = coroutine.status(self._thread)

	if var_5_0 == "suspended" then
		local var_5_1, var_5_2, var_5_3 = coroutine.resume(self._thread, var_0_0.MessageCache.CMD_PUSH, {
			...
		})

		if var_5_1 then
			return var_5_2, var_5_3
		else
			return var_0_0.MessageCache.EXCEPTION, var_5_2
		end
	else
		local var_5_5 = string.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Push operation.", var_5_0)

		return
	end

	return
end

function pg.MessageCache:Pop()
	local var_6_0 = coroutine.status(self._thread)

	if var_6_0 == "suspended" then
		local var_6_1, var_6_2, var_6_3 = coroutine.resume(self._thread, var_0_0.MessageCache.CMD_POP)

		if var_6_1 then
			if var_6_2 == var_0_0.MessageCache.OK and var_6_3 ~= nil then
				local var_6_5 = unpack(var_6_3)

				return
			else
				return var_6_2, var_6_3
			end
		else
			return var_0_0.MessageCache.EXCEPTION, var_6_2
		end
	else
		local var_6_7 = string.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Pop operation.", var_6_0)

		return
	end

	return
end

function pg.MessageCache:Flush()
	local var_7_0 = coroutine.status(self._thread)

	if var_7_0 == "suspended" then
		local var_7_1, var_7_2, var_7_3 = coroutine.resume(self._thread, var_0_0.MessageCache.CMD_FLUSH)

		if var_7_1 then
			return var_7_2, var_7_3
		else
			return var_0_0.MessageCache.EXCEPTION, var_7_2
		end
	else
		local var_7_5 = string.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Destroy operation.", var_7_0)

		return
	end

	return
end

function pg.MessageCache:Destroy()
	local var_8_0 = coroutine.status(self._thread)

	if var_8_0 == "suspended" then
		local var_8_1, var_8_2, var_8_3 = coroutine.resume(self._thread, var_0_0.MessageCache.CMD_KILL)

		if var_8_1 then
			return var_8_2, var_8_3
		else
			return var_0_0.MessageCache.EXCEPTION, var_8_2
		end
	else
		local var_8_5 = string.format("current thread status %s,\n            maybe the MessageCache:Destroy() is called before the Destroy operation.", var_8_0)

		return
	end

	return
end

return

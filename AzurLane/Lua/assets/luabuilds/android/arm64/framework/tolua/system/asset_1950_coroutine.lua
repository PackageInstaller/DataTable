coroutine = var_0_10000

local var_0_0 = var_0_10000.create

coroutine = var_0_10001

local var_0_1 = var_0_10001.running

coroutine = var_0_10002

local var_0_2 = var_0_10002.resume

coroutine = var_0_10003

local var_0_3 = var_0_10003.yield

error = var_0_10004
unpack = var_0_10005
debug = var_0_10006
FrameTimer = var_0_10007
CoTimer = var_0_10008

local var_0_4 = {}
local var_0_5 = {}

setmetatable = var_0_10011

var_0_10011(var_0_4, {
	__mode = "kv"
})

coroutine = var_0_10011

function var_0_10011.start(arg_1_0, ...)
	local var_1_0 = var_0_0(arg_1_0)
	local var_1_1

	if var_0_1() == nil then
		local var_1_2

		var_1_1, var_1_2 = var_0_2(var_1_0, ...)

		if not var_1_1 then
			var_0_10004(var_0_10006.traceback(var_1_0, var_1_2))
		end
	else
		packEx = var_1_1

		local var_1_3 = var_1_1(...)
		local var_1_4

		local function var_1_5()
			var_0_4[var_1_0] = nil
			var_1_4.func = nil

			local var_2_0 = var_0_2
			local var_2_1 = var_1_0

			unpackEx = var_2_10003

			local var_2_2, var_2_3 = var_2_0(var_2_1, var_2_10003(var_1_3))

			table = var_2_1

			var_2_1.insert(var_0_5, var_1_4)

			if not var_2_2 then
				local var_2_4 = var_1_4

				var_2.Stop(var_2_4)
				var_0_10004(var_0_10006.traceback(var_1_0, var_2_3))
			end

			return
		end

		if #var_0_5 > 0 then
			table = var_5

			local var_1_6 = var_5.remove(var_0_5)

			var_1_4.Reset(var_1_6, var_1_5, 0, 1)
		else
			var_1_4 = var_0_10007.New(var_1_5, 0, 1)
		end

		var_0_4[var_1_0] = var_1_4

		var_1_4:Start()
	end

	return var_1_0
end

coroutine = var_0_10011

function var_0_10011.wait(arg_3_0, arg_3_1, ...)
	packEx = var_1_10002

	local var_3_0 = var_1_10002(...)

	arg_3_1 = arg_3_1 or var_0_1()

	local var_3_1

	local function var_3_2()
		var_0_4[arg_3_1] = nil
		var_3_1.func = nil

		local var_4_0 = var_0_2
		local var_4_1 = arg_3_1

		unpackEx = var_2_10003

		local var_4_2, var_4_3 = var_4_0(var_4_1, var_2_10003(var_3_0))

		if not var_4_2 then
			local var_4_4 = var_3_1

			var_2.Stop(var_4_4)
			var_0_10004(var_0_10006.traceback(arg_3_1, var_4_3))

			return
		end

		return
	end

	var_3_1 = var_0_10008.New(var_3_2, arg_3_0, 1)
	var_0_4[arg_3_1] = var_3_1

	var_3_1:Start()

	return var_0_3()
end

coroutine = var_0_10011

function var_0_10011.step(arg_5_0, arg_5_1, ...)
	packEx = var_1_10002

	local var_5_0 = var_1_10002(...)

	arg_5_1 = arg_5_1 or var_0_1()

	local var_5_1

	local function var_5_2()
		var_0_4[arg_5_1] = nil
		var_5_1.func = nil

		local var_6_0 = var_0_2
		local var_6_1 = arg_5_1

		unpackEx = var_2_10003

		local var_6_2, var_6_3 = var_6_0(var_6_1, var_2_10003(var_5_0))

		table = var_6_1

		var_6_1.insert(var_0_5, var_5_1)

		if not var_6_2 then
			local var_6_4 = var_5_1

			var_2.Stop(var_6_4)
			var_0_10004(var_0_10006.traceback(arg_5_1, var_6_3))

			return
		end

		return
	end

	if #var_0_5 > 0 then
		table = var_5

		local var_5_3 = var_5.remove(var_0_5)

		var_5_1.Reset(var_5_3, var_5_2, arg_5_0 or 1, 1)
	else
		var_5_1 = var_0_10007.New(var_5_2, arg_5_0 or 1, 1)
	end

	var_0_4[arg_5_1] = var_5_1

	var_5_1:Start()

	return var_0_3()
end

coroutine = var_0_10011

function var_0_10011.www(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or var_0_1()

	local var_7_0

	local function var_7_1()
		if not arg_7_0.isDone then
			return
		end

		var_0_4[arg_7_1] = nil

		local var_8_0 = var_7_0

		var_0.Stop(var_8_0)

		var_7_0.func = nil

		local var_8_1, var_8_2 = var_0_2(arg_7_1)

		table = var_2

		var_2.insert(var_0_5, var_7_0)

		if not var_8_1 then
			var_0_10004(var_0_10006.traceback(arg_7_1, var_8_2))

			return
		end

		return
	end

	if #var_0_5 > 0 then
		table = var_4

		local var_7_2 = var_4.remove(var_0_5)

		var_7_0.Reset(var_7_2, var_7_1, 1, -1)
	else
		var_7_0 = var_0_10007.New(var_7_1, 1, -1)
	end

	var_0_4[arg_7_1] = var_7_0

	var_7_0:Start()

	return var_0_3()
end

coroutine = var_0_10011

function var_0_10011.stop(arg_9_0)
	if var_0_4[arg_9_0] ~= nil then
		var_0_4[arg_9_0] = nil

		var_1:Stop()

		var_1.func = nil
	end

	return
end

return

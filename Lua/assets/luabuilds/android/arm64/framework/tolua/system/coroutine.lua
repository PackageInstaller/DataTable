local var_0_0 = coroutine.create
local var_0_1 = coroutine.running
local var_0_2 = coroutine.resume
local var_0_3 = coroutine.yield
local var_0_4 = error
local var_0_6 = debug
local var_0_7 = FrameTimer
local var_0_8 = CoTimer
local var_0_9 = {}

setmetatable({}, {
	__mode = "kv"
})

function coroutine.start(arg_1_0, ...)
	local var_1_0 = var_0_0(arg_1_0)

	if var_0_1() == nil then
		local var_1_1, var_1_2 = var_0_2(var_1_0, ...)

		if not var_1_1 then
			var_0_4(var_0_6.traceback(var_1_0, var_1_2))
		end
	else
		local var_1_3 = packEx(...)
		local var_1_4

		if #var_0_9 > 0 then
			var_1_4 = table.remove(var_0_9)

			var_1_4:Reset(function()
				var_0[var_1_0] = nil
				var_1_4.func = nil

				local var_2_0, var_2_1 = var_0_2(var_1_0, unpackEx(var_1_3))

				table.insert(var_0_9, var_1_4)

				if not var_2_0 then
					var_1_4:Stop()
					var_0_4(var_0_6.traceback(var_1_0, var_2_1))
				end

				return
			end, 0, 1)
		else
			var_1_4 = var_0_7.New(function()
				var_0[var_1_0] = nil
				var_1_4.func = nil

				local var_2_0, var_2_1 = var_0_2(var_1_0, unpackEx(var_1_3))

				table.insert(var_0_9, var_1_4)

				if not var_2_0 then
					var_1_4:Stop()
					var_0_4(var_0_6.traceback(var_1_0, var_2_1))
				end

				return
			end, 0, 1)
		end

		var_0[var_1_0] = var_1_4

		var_1_4:Start()
	end

	return var_1_0
end

function coroutine.wait(arg_3_0, arg_3_1, ...)
	local var_3_0 = packEx(...)

	arg_3_1 = arg_3_1 or var_0_1()

	local var_3_1

	var_3_1 = var_0_8.New(function()
		var_0[arg_3_1] = nil
		var_3_1.func = nil

		local var_4_0, var_4_1 = var_0_2(arg_3_1, unpackEx(var_3_0))

		if not var_4_0 then
			var_3_1:Stop()
			var_0_4(var_0_6.traceback(arg_3_1, var_4_1))

			return
		end

		return
	end, arg_3_0, 1)
	var_0[arg_3_1] = nil

	var_3_1:Start()

	return var_0_3()
end

function coroutine.step(arg_5_0, arg_5_1, ...)
	local var_5_0 = packEx(...)

	arg_5_1 = arg_5_1 or var_0_1()

	local var_5_1

	if #var_0_9 > 0 then
		var_5_1 = table.remove(var_0_9)

		var_5_1:Reset(function()
			var_0[arg_5_1] = nil
			var_5_1.func = nil

			local var_6_0, var_6_1 = var_0_2(arg_5_1, unpackEx(var_5_0))

			table.insert(var_0_9, var_5_1)

			if not var_6_0 then
				var_5_1:Stop()
				var_0_4(var_0_6.traceback(arg_5_1, var_6_1))

				return
			end

			return
		end, arg_5_0 or 1, 1)
	else
		var_5_1 = var_0_7.New(function()
			var_0[arg_5_1] = nil
			var_5_1.func = nil

			local var_6_0, var_6_1 = var_0_2(arg_5_1, unpackEx(var_5_0))

			table.insert(var_0_9, var_5_1)

			if not var_6_0 then
				var_5_1:Stop()
				var_0_4(var_0_6.traceback(arg_5_1, var_6_1))

				return
			end

			return
		end, arg_5_0 or 1, 1)
	end

	var_0[arg_5_1] = var_5_1

	var_5_1:Start()

	return var_0_3()
end

function coroutine.www(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or var_0_1()

	local var_7_0

	if #var_0_9 > 0 then
		var_7_0 = table.remove(var_0_9)

		var_7_0:Reset(function()
			if not arg_7_0.isDone then
				return
			end

			var_0[arg_7_1] = nil

			var_7_0:Stop()

			var_7_0.func = nil

			local var_8_0, var_8_1 = var_0_2(arg_7_1)

			table.insert(var_0_9, var_7_0)

			if not var_8_0 then
				var_0_4(var_0_6.traceback(arg_7_1, var_8_1))

				return
			end

			return
		end, 1, -1)
	else
		var_7_0 = var_0_7.New(function()
			if not arg_7_0.isDone then
				return
			end

			var_0[arg_7_1] = nil

			var_7_0:Stop()

			var_7_0.func = nil

			local var_8_0, var_8_1 = var_0_2(arg_7_1)

			table.insert(var_0_9, var_7_0)

			if not var_8_0 then
				var_0_4(var_0_6.traceback(arg_7_1, var_8_1))

				return
			end

			return
		end, 1, -1)
	end

	var_0[arg_7_1] = var_7_0

	var_7_0:Start()

	return var_0_3()
end

function coroutine.stop(arg_9_0)
	if var_0[arg_9_0] ~= nil then
		var_0[arg_9_0] = nil

		var_0[arg_9_0]:Stop()

		var_0[arg_9_0].func = nil
	end

	return
end

return

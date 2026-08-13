_G = var_0_10000
require = var_0_10001

local var_0_0 = var_0_10001("string")

require = var_2

local var_0_1 = var_2("math")

require = var_3

local var_0_2 = var_3("socket.core")

function var_0_2.connect4(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	return var_0.connect(arg_1_0, arg_1_1, arg_1_2, arg_1_3, "inet")
end

function var_0_2.connect6(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return var_0.connect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, "inet6")
end

function var_0_2.bind(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0 == "*" then
		arg_3_0 = "0.0.0.0"
	end

	local var_3_0, var_3_1 = var_0.dns.getaddrinfo(arg_3_0)

	if not var_3_0 then
		return nil, var_3_1
	end

	local var_3_2
	local var_3_3
	local var_3_4 = "no info on address"

	for iter_3_0, iter_3_1 in var_0_10000.ipairs(var_3_0) do
		if iter_3_1.family == "inet" then
			var_3_2, var_3_4 = var_0.tcp4()
		else
			var_3_2, var_3_4 = var_0.tcp6()
		end

		if not var_3_2 then
			return nil, var_3_4
		end

		var_3_2:setoption("reuseaddr", true)

		local var_3_5, var_3_6 = var_3_2:bind(iter_3_1.addr, arg_3_1)

		var_3_4 = var_3_6

		if not var_3_5 then
			var_3_2:close()
		else
			local var_3_7, var_3_8 = var_3_2:listen(arg_3_2)

			var_3_4 = var_3_8

			if not var_3_7 then
				var_3_2:close()
			else
				return var_3_2
			end
		end
	end

	return nil, var_3_4
end

var_0_2.try = var_0_2.newtry()

function var_0_2.choose(arg_4_0)
	return function(arg_5_0, arg_5_1, arg_5_2)
		if var_0_10000.type(arg_5_0) ~= "string" then
			arg_5_0, arg_5_1, arg_5_2 = "default", arg_5_0, arg_5_1
		end

		if not arg_4_0[arg_5_0 or "nil"] then
			var_0_10000.error("unknown key (" .. var_0_10000.tostring(arg_5_0) .. ")", 3)
		else
			return var_3(arg_5_1, arg_5_2)
		end

		return
	end
end

local var_0_3 = {}
local var_0_4 = {}

var_0_2.sourcet = var_0_3
var_0_2.sinkt = var_0_4
var_0_2.BLOCKSIZE = 2048
var_0_4["close-when-done"] = function(arg_6_0)
	return var_0_10000.setmetatable({
		getfd = function()
			local var_7_0 = arg_6_0

			return var_0.getfd(var_7_0)
		end,
		dirty = function()
			local var_8_0 = arg_6_0

			return var_0.dirty(var_8_0)
		end
	}, {
		__call = function(arg_9_0, arg_9_1, arg_9_2)
			if not arg_9_1 then
				local var_9_0 = arg_6_0

				var_3.close(var_9_0)

				return 1
			else
				local var_9_1 = arg_6_0

				return var_3.send(var_9_1, arg_9_1)
			end

			return
		end
	})
end
var_0_4["keep-open"] = function(arg_10_0)
	return var_0_10000.setmetatable({
		getfd = function()
			local var_11_0 = arg_10_0

			return var_0.getfd(var_11_0)
		end,
		dirty = function()
			local var_12_0 = arg_10_0

			return var_0.dirty(var_12_0)
		end
	}, {
		__call = function(arg_13_0, arg_13_1, arg_13_2)
			if arg_13_1 then
				local var_13_0 = arg_10_0

				return var_3.send(var_13_0, arg_13_1)
			else
				return 1
			end

			return
		end
	})
end
var_0_4.default = var_0_4["keep-open"]
var_0_2.sink = var_0_2.choose(var_0_4)
var_0_3["by-length"] = function(arg_14_0, arg_14_1)
	return var_0_10000.setmetatable({
		getfd = function()
			local var_15_0 = arg_14_0

			return var_0.getfd(var_15_0)
		end,
		dirty = function()
			local var_16_0 = arg_14_0

			return var_0.dirty(var_16_0)
		end
	}, {
		__call = function()
			if arg_14_1 <= 0 then
				return nil
			end

			local var_17_0 = var_0_1.min(var_0.BLOCKSIZE, arg_14_1)
			local var_17_1 = arg_14_0
			local var_17_2, var_17_3 = var_1.receive(var_17_1, var_17_0)

			if var_17_3 then
				return nil, var_17_3
			end

			arg_14_1 = arg_14_1 - var_0_0.len(var_17_2)

			return var_17_2
		end
	})
end
var_0_3["until-closed"] = function(arg_18_0)
	local var_18_0

	return var_0_10000.setmetatable({
		getfd = function()
			local var_19_0 = arg_18_0

			return var_0.getfd(var_19_0)
		end,
		dirty = function()
			local var_20_0 = arg_18_0

			return var_0.dirty(var_20_0)
		end
	}, {
		__call = function()
			if var_18_0 then
				return nil
			end

			local var_21_0 = arg_18_0
			local var_21_1, var_21_2, var_21_3 = var_0.receive(var_21_0, var_0.BLOCKSIZE)

			if not var_21_2 then
				return var_21_1
			elseif var_21_2 == "closed" then
				local var_21_4 = arg_18_0

				var_3.close(var_21_4)

				var_18_0 = 1

				return var_21_3
			else
				return nil, var_21_2
			end

			return
		end
	})
end
var_0_3.default = var_0_3["until-closed"]
var_0_2.source = var_0_2.choose(var_0_3)

return var_0_2

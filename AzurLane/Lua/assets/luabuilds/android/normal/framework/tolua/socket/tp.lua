_G = var_0_10000
require = var_0_10001

local var_0_0 = var_0_10001("string")

require = var_2

local var_0_1 = var_2("socket")

require = var_3

local var_0_2 = var_3("ltn12")

var_0_1.tp = {}

local var_0_3 = var_0_1.tp

var_0_3.TIMEOUT = 60

local function var_0_4(arg_1_0)
	local var_1_0
	local var_1_1
	local var_1_2
	local var_1_3, var_1_4 = arg_1_0:receive()
	local var_1_5 = var_1_3

	if var_1_4 then
		return nil, var_1_4
	end

	local var_1_6, var_1_7 = var_0_1.skip(2, var_0_0.find(var_1_3, "^(%d%d%d)(.?)"))
	local var_1_8 = var_1_7

	if not var_1_6 then
		return nil, "invalid server reply"
	end

	if var_1_8 == "-" then
		repeat
			local var_1_9, var_1_10 = arg_1_0:receive()

			if var_1_10 then
				return nil, var_1_10
			end

			local var_1_11, var_1_12 = var_0_1.skip(2, var_0_0.find(var_1_9, "^(%d%d%d)(.?)"))

			var_1_5 = var_1_5 .. "\n" .. var_1_9
		until var_1 == var_1_11 and var_1_12 == " "
	end

	return var_1, var_1_5
end

;({
	__index = {}
}).__index.getpeername = function(arg_2_0)
	local var_2_0 = arg_2_0.c

	return var_1.getpeername(var_2_0)
end

function var_6.__index.getsockname(arg_3_0)
	local var_3_0 = arg_3_0.c

	return var_1.getpeername(var_3_0)
end

function var_6.__index.check(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = var_0_4(arg_4_0.c)

	if not var_4_0 then
		return nil, var_4_1
	end

	if var_0_10000.type(arg_4_1) ~= "function" then
		if var_0_10000.type(arg_4_1) == "table" then
			for iter_4_0, iter_4_1 in var_0_10000.ipairs(arg_4_1) do
				if var_0_0.find(var_4_0, iter_4_1) then
					return var_0_10000.tonumber(var_4_0), var_4_1
				end
			end

			return nil, var_4_1
		elseif var_0_0.find(var_4_0, arg_4_1) then
			return var_0_10000.tonumber(var_4_0), var_4_1
		else
			return nil, var_4_1
		end
	else
		return arg_4_1(var_0_10000.tonumber(var_4_0), var_4_1)
	end

	return
end

function var_6.__index.command(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1 = var_0_0.upper(arg_5_1)

	if arg_5_2 then
		local var_5_0 = arg_5_0.c

		return var_3.send(var_5_0, arg_5_1 .. " " .. arg_5_2 .. "\r\n")
	else
		local var_5_1 = arg_5_0.c

		return var_3.send(var_5_1, arg_5_1 .. "\r\n")
	end

	return
end

function var_6.__index.sink(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.c
	local var_6_1, var_6_2 = var_3.receive(var_6_0, arg_6_2)

	return arg_6_1(var_6_1, var_6_2)
end

function var_6.__index.send(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.c

	return var_2.send(var_7_0, arg_7_1)
end

function var_6.__index.receive(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.c

	return var_2.receive(var_8_0, arg_8_1)
end

function var_6.__index.getfd(arg_9_0)
	local var_9_0 = arg_9_0.c

	return var_1.getfd(var_9_0)
end

function var_6.__index.dirty(arg_10_0)
	local var_10_0 = arg_10_0.c

	return var_1.dirty(var_10_0)
end

function var_6.__index.getcontrol(arg_11_0)
	return arg_11_0.c
end

function var_6.__index.source(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_1.sink("keep-open", arg_12_0.c)
	local var_12_1, var_12_2 = var_0_2.pump.all(arg_12_1, var_12_0, arg_12_2 or var_0_2.pump.step)

	return var_12_1, var_12_2
end

function var_6.__index.close(arg_13_0)
	local var_13_0 = arg_13_0.c

	var_1.close(var_13_0)

	return 1
end

function var_0_3.connect(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1 = (arg_14_3 or var_0_1.tcp)()

	if not var_14_0 then
		return nil, var_14_1
	end

	var_14_0:settimeout(arg_14_2 or var_0_3.TIMEOUT)

	local var_14_2, var_14_3 = var_14_0:connect(arg_14_0, arg_14_1)

	if not var_14_2 then
		var_14_0:close()

		return nil, var_14_3
	end

	return var_0_10000.setmetatable({
		c = var_14_0
	}, var_0)
end

return var_0_3

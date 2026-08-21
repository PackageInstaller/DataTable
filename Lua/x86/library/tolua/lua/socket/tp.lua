local var_0_0 = _G
local var_0_1 = require("string")
local var_0_2 = require("socket")
local var_0_3 = require("ltn12")

var_0_2.tp = {}

local var_0_4 = var_0_2.tp

var_0_4.TIMEOUT = 60

local function var_0_5(arg_1_0)
	local var_1_0
	local var_1_1
	local var_1_2
	local var_1_3, var_1_4 = arg_1_0:receive()
	local var_1_5 = var_1_3

	if var_1_4 then
		return nil, var_1_4
	end

	local var_1_6, var_1_7 = var_0_2.skip(2, var_0_1.find(var_1_3, "^(%d%d%d)(.?)"))

	if not var_1_6 then
		return nil, "invalid server reply"
	end

	if var_1_7 == "-" then
		repeat
			local var_1_8, var_1_9 = arg_1_0:receive()

			if var_1_9 then
				return nil, var_1_9
			end

			local var_1_10, var_1_11 = var_0_2.skip(2, var_0_1.find(var_1_8, "^(%d%d%d)(.?)"))

			var_1_5 = var_1_5 .. "\n" .. var_1_8
		until var_1_6 == var_1_10 and var_1_11 == " "
	end

	return var_1_6, var_1_5
end

local var_0_6 = {
	__index = {}
}

function var_0_6.__index.getpeername(arg_2_0)
	return arg_2_0.c:getpeername()
end

function var_0_6.__index.getsockname(arg_3_0)
	return arg_3_0.c:getpeername()
end

function var_0_6.__index.check(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = var_0_5(arg_4_0.c)

	if not var_4_0 then
		return nil, var_4_1
	end

	if var_0_0.type(arg_4_1) ~= "function" then
		if var_0_0.type(arg_4_1) == "table" then
			for iter_4_0, iter_4_1 in var_0_0.ipairs(arg_4_1) do
				if var_0_1.find(var_4_0, iter_4_1) then
					return var_0_0.tonumber(var_4_0), var_4_1
				end
			end

			return nil, var_4_1
		elseif var_0_1.find(var_4_0, arg_4_1) then
			return var_0_0.tonumber(var_4_0), var_4_1
		else
			return nil, var_4_1
		end
	else
		return arg_4_1(var_0_0.tonumber(var_4_0), var_4_1)
	end
end

function var_0_6.__index.command(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1 = var_0_1.upper(arg_5_1)

	if arg_5_2 then
		return arg_5_0.c:send(arg_5_1 .. " " .. arg_5_2 .. "\r\n")
	else
		return arg_5_0.c:send(arg_5_1 .. "\r\n")
	end
end

function var_0_6.__index.sink(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = arg_6_0.c:receive(arg_6_2)

	return arg_6_1(var_6_0, var_6_1)
end

function var_0_6.__index.send(arg_7_0, arg_7_1)
	return arg_7_0.c:send(arg_7_1)
end

function var_0_6.__index.receive(arg_8_0, arg_8_1)
	return arg_8_0.c:receive(arg_8_1)
end

function var_0_6.__index.getfd(arg_9_0)
	return arg_9_0.c:getfd()
end

function var_0_6.__index.dirty(arg_10_0)
	return arg_10_0.c:dirty()
end

function var_0_6.__index.getcontrol(arg_11_0)
	return arg_11_0.c
end

function var_0_6.__index.source(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_2.sink("keep-open", arg_12_0.c)
	local var_12_1, var_12_2 = var_0_3.pump.all(arg_12_1, var_12_0, arg_12_2 or var_0_3.pump.step)

	return var_12_1, var_12_2
end

function var_0_6.__index.close(arg_13_0)
	arg_13_0.c:close()

	return 1
end

function var_0_4.connect(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1 = (arg_14_3 or var_0_2.tcp)()

	if not var_14_0 then
		return nil, var_14_1
	end

	var_14_0:settimeout(arg_14_2 or var_0_4.TIMEOUT)

	local var_14_2, var_14_3 = var_14_0:connect(arg_14_0, arg_14_1)

	if not var_14_2 then
		var_14_0:close()

		return nil, var_14_3
	end

	return var_0_0.setmetatable({
		c = var_14_0
	}, var_0_6)
end

return var_0_4

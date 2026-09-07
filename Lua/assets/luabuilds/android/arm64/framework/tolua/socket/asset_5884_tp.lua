local var_0_0 = _G
local string = require("string")
local socket = require("socket")
local ltn12 = require("ltn12")

socket.tp = {}

local var_0_4 = socket.tp

socket.tp.TIMEOUT = 60

local function var_0_5(arg_1_0)
	local var_1_3, var_1_4 = arg_1_0:receive()
	local var_1_5 = var_1_3

	if var_1_4 then
		return nil, var_1_4
	end

	local var_1_6, var_1_7 = socket.skip(2, string.find(var_1_3, "^(%d%d%d)(.?)"))

	if not var_1_6 then
		return nil, "invalid server reply"
	end

	if var_1_7 == "-" then
		repeat
			local var_1_8, var_1_9 = arg_1_0:receive()

			if var_1_9 then
				return nil, var_1_9
			end

			local var_1_10, var_1_11 = socket.skip(2, string:find("^(%d%d%d)(.?)"))

			var_1_5 = var_1_5 .. "\n" .. var_1_8
		until var_1_6 == var_1_10 and var_1_11 == " "
	end

	return var_1_6, var_1_5
end

local var_0_6 = {
	__index = {}
}

function var_0_6.__index:getpeername()
	return self.c:getpeername()
end

function var_0_6.__index:getsockname()
	return self.c:getpeername()
end

function var_0_6.__index:check(arg_4_1)
	local var_4_0, var_4_1 = var_0_5(self.c)

	if not var_4_0 then
		return nil, var_4_1
	end

	if var_0_0.type(arg_4_1) ~= "function" then
		if var_0_0.type(arg_4_1) == "table" then
			for iter_4_0, iter_4_1 in var_0_0.ipairs(arg_4_1) do
				if string.find(var_4_0, iter_4_1) then
					return var_0_0.tonumber(var_4_0), var_4_1
				end
			end

			return nil, var_4_1
		elseif string.find(var_4_0, arg_4_1) then
			return var_0_0.tonumber(var_4_0), var_4_1
		else
			return nil, var_4_1
		end
	else
		return arg_4_1(var_0_0.tonumber(var_4_0), var_4_1)
	end

	return
end

function var_0_6.__index:command(arg_5_1, arg_5_2)
	arg_5_1 = string.upper(arg_5_1)

	if arg_5_2 then
		return self.c:send(arg_5_1 .. " " .. arg_5_2 .. "\r\n")
	else
		return self.c:send(arg_5_1 .. "\r\n")
	end

	return
end

function var_0_6.__index:sink(arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = self.c:receive(arg_6_2)

	return arg_6_1(var_6_0, var_6_1)
end

function var_0_6.__index:send(arg_7_1)
	return self.c:send(arg_7_1)
end

function var_0_6.__index:receive(arg_8_1)
	return self.c:receive(arg_8_1)
end

function var_0_6.__index:getfd()
	return self.c:getfd()
end

function var_0_6.__index:dirty()
	return self.c:dirty()
end

function var_0_6.__index:getcontrol()
	return self.c
end

function var_0_6.__index:source(arg_12_1, arg_12_2)
	local var_12_0, var_12_1 = ltn12.pump.all(arg_12_1, socket.sink("keep-open", self.c), arg_12_2 or ltn12.pump.step)

	return var_12_0, var_12_1
end

function var_0_6.__index:close()
	self.c:close()

	return 1
end

function socket.tp.connect(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0, var_14_1 = (arg_14_3 or socket.tcp)()

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

return socket.tp

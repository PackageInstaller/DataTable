local core = require("socket.core")
local var_0_1 = {
	settimeout = true,
	shutdown = true,
	connect = true,
	getsockname = true,
	setoption = true,
	close = true,
	getpeername = true,
	setstats = true,
	send = true
}
local socket = class("socket")

setmetatable(socket, {
	__index = function(arg_1_0, arg_1_1)
		if var_0_1[arg_1_1] then
			local function var_1_0(arg_2_0, ...)
				return arg_2_0.client[arg_1_1](arg_2_0.client, ...)
			end

			arg_1_0[arg_1_1] = var_1_0

			return var_1_0
		end

		return nil
	end
})

local function var_0_3(arg_3_0)
	local var_3_0 = false
	local var_3_1, var_3_2 = core.dns.getaddrinfo(arg_3_0)

	if var_3_1 ~= nil then
		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			if iter_3_1.family == "inet6" then
				var_3_0 = true

				break
			end
		end
	end

	return var_3_0
end

function socket:ctor(arg_4_1, arg_4_2, arg_4_3)
	assert(arg_4_1 and arg_4_2, "host and port are neccessary")

	self._ip = arg_4_1
	self._port = arg_4_2
	self._handler = arg_4_3
	self.client = var_0_3(arg_4_1) and core.tcp6() or core.tcp()
end

function socket:select()
	local var_5_0, var_5_1, var_5_2 = self.client:receive("*a")

	if var_5_0 and string.len(var_5_0) > 0 then
		self._handler(NET_EVENT_DATA, var_5_0)

		return
	end

	if var_5_2 and string.len(var_5_2) > 0 then
		self._handler(NET_EVENT_DATA, var_5_2)
	end

	if var_5_1 == "closed" or var_5_1 == "Socket is not connected" then
		self._handler(NET_EVENT_CLOSED)
	end
end

return socket

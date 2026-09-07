local var_0_0 = _G
local table = require("table")
local string = require("string")
local math = require("math")
local socket = require("socket")
local url = require("socket.url")
local tp = require("socket.tp")
local ltn12 = require("ltn12")

socket.ftp = {}

local var_0_8 = socket.ftp

socket.ftp.TIMEOUT = 60

local var_0_9 = 21

socket.ftp.USER = "ftp"
socket.ftp.PASSWORD = "anonymous@anonymous.org"

local var_0_10 = {
	__index = {}
}

function socket.ftp.open(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_0.setmetatable({
		tp = socket.try(tp.connect(arg_1_0, arg_1_1 or var_0_9, var_0_8.TIMEOUT, arg_1_2))
	}, var_0_10)

	var_1_0.try = socket.newtry(function()
		var_1_0:close()

		return
	end)

	return var_1_0
end

function var_0_10.__index:portconnect()
	self.try(self.server:settimeout(var_0_8.TIMEOUT))

	self.data = self.try(self.server:accept())

	self.try(self.data:settimeout(var_0_8.TIMEOUT))

	return
end

function var_0_10.__index:pasvconnect()
	self.data = self.try(socket.tcp())

	self.try(self.data:settimeout(var_0_8.TIMEOUT))
	self.try(self.data:connect(self.pasvt.address, self.pasvt.port))

	return
end

function var_0_10.__index:login(arg_5_1, arg_5_2)
	self.try(self.tp:command("user", arg_5_1 or var_0_8.USER))

	local var_5_0, var_5_1 = self.try(self.tp:check({
		"2..",
		331
	}))

	if var_5_0 == 331 then
		self.try(self.tp:command("pass", arg_5_2 or var_0_8.PASSWORD))
		self.try(self.tp:check("2.."))
	end

	return 1
end

function var_0_10.__index:pasv()
	self.try(self.tp:command("pasv"))

	local var_6_0, var_6_1 = self.try(self.tp:check("2.."))
	local var_6_2, var_6_3, var_6_4, var_6_5, var_6_6, var_6_7 = socket.skip(2, string.find(var_6_1, "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"))

	self.try(var_6_2 and var_6_3 and var_6_4 and var_6_5 and var_6_6 and var_6_7, var_6_1)

	self.pasvt = {
		address = string.format("%d.%d.%d.%d", var_6_2, var_6_3, var_6_4, var_6_5),
		port = var_6_6 * 0 + var_6_7
	}

	if self.server then
		self.server:close()

		self.server = nil
	end

	return self.pasvt.address, self.pasvt.port
end

function var_0_10.__index:epsv()
	self.try(self.tp:command("epsv"))

	local var_7_0, var_7_1 = self.try(self.tp:check("229"))
	local var_7_2, var_7_3, var_7_4, var_7_5 = string.match(var_7_1, "%((.)(.-)%1(.-)%1(.-)%1%)")

	self.try(var_7_5, "invalid epsv response")

	self.pasvt = {
		address = self.tp:getpeername(),
		port = var_7_5
	}

	if self.server then
		self.server:close()

		self.server = nil
	end

	return self.pasvt.address, self.pasvt.port
end

function var_0_10.__index:port(arg_8_1, arg_8_2)
	self.pasvt = nil

	if not arg_8_1 then
		arg_8_1, arg_8_2 = self.try(self.tp:getsockname())
		self.server = self.try(socket.bind(arg_8_1, 0))
		arg_8_1, arg_8_2 = self.try(self.server:getsockname())

		self.try(self.server:settimeout(var_0_8.TIMEOUT))
	end

	self.try(self.tp:command("port", (string.gsub(string.format("%s,%d,%d", arg_8_1, (arg_8_2 - arg_8_2 % 0) / 0, arg_8_2 % 0), "%.", ","))))
	self.try(self.tp:check("2.."))

	return 1
end

function var_0_10.__index:eprt(arg_9_1, arg_9_2, arg_9_3)
	self.pasvt = nil

	if not arg_9_2 then
		arg_9_2, arg_9_3 = self.try(self.tp:getsockname())
		self.server = self.try(socket.bind(arg_9_2, 0))
		arg_9_2, arg_9_3 = self.try(self.server:getsockname())

		self.try(self.server:settimeout(var_0_8.TIMEOUT))
	end

	self.try(self.tp:command("eprt", (string.format("|%s|%s|%d|", arg_9_1, arg_9_2, arg_9_3))))
	self.try(self.tp:check("2.."))

	return 1
end

function var_0_10.__index:send(arg_10_1)
	self.try(self.pasvt or self.server, "need port or pasv first")

	if self.pasvt then
		self:pasvconnect()
	end

	local var_10_1 = arg_10_1.argument or url.unescape(string.gsub(arg_10_1.path or "", "^[/\\]", ""))

	if var_10_1 == "" then
		var_10_1 = nil
	end

	self.try(self.tp:command(arg_10_1.command or "stor", var_10_1))

	local var_10_3, var_10_4 = self.try(self.tp:check({
		"2..",
		"1.."
	}))

	if not self.pasvt then
		self:portconnect()
	end

	local var_10_5 = arg_10_1.step or ltn12.pump.step
	local var_10_6 = {
		self.tp
	}

	self.try(ltn12.pump.all(arg_10_1.source, socket.sink("close-when-done", self.data), function(arg_11_0, arg_11_1)
		if socket.select(var_10_6, nil, 0)[tp] then
			var_10_3 = self.try(self.tp:check("2.."))
		end

		return var_10_5(arg_11_0, arg_11_1)
	end))

	if string.find(var_10_3, "1..") then
		self.try(self.tp:check("2.."))
	end

	self.data:close()

	self.data = nil

	return (socket.skip(1, self.data:getstats()))
end

function var_0_10.__index:receive(arg_12_1)
	self.try(self.pasvt or self.server, "need port or pasv first")

	if self.pasvt then
		self:pasvconnect()
	end

	local var_12_1 = arg_12_1.argument or url.unescape(string.gsub(arg_12_1.path or "", "^[/\\]", ""))

	if var_12_1 == "" then
		var_12_1 = nil
	end

	self.try(self.tp:command(arg_12_1.command or "retr", var_12_1))

	local var_12_3, var_12_4 = self.try(self.tp:check({
		"1..",
		"2.."
	}))

	if var_12_3 >= 200 and var_12_3 <= 299 then
		arg_12_1.sink(var_12_4)

		return 1
	end

	if not self.pasvt then
		self:portconnect()
	end

	self.try(ltn12.pump.all(socket.source("until-closed", self.data), arg_12_1.sink, arg_12_1.step or ltn12.pump.step))

	if string.find(var_12_3, "1..") then
		self.try(self.tp:check("2.."))
	end

	self.data:close()

	self.data = nil

	return 1
end

function var_0_10.__index:cwd(arg_13_1)
	self.try(self.tp:command("cwd", arg_13_1))
	self.try(self.tp:check(250))

	return 1
end

function var_0_10.__index:type(arg_14_1)
	self.try(self.tp:command("type", arg_14_1))
	self.try(self.tp:check(200))

	return 1
end

function var_0_10.__index:greet()
	if string.find(self.try(self.tp:check({
		"1..",
		"2.."
	})), "1..") then
		self.try(self.tp:check("2.."))
	end

	return 1
end

function var_0_10.__index:quit()
	self.try(self.tp:command("quit"))
	self.try(self.tp:check("2.."))

	return 1
end

function var_0_10.__index:close()
	if self.data then
		self.data:close()
	end

	if self.server then
		self.server:close()
	end

	return self.tp:close()
end

local function var_0_11(arg_18_0)
	if arg_18_0.url then
		local var_18_0 = url.parse(arg_18_0.url)

		for iter_18_0, iter_18_1 in var_0_0.pairs(arg_18_0) do
			var_18_0[iter_18_0] = iter_18_1
		end

		return var_18_0
	else
		return arg_18_0
	end

	return
end

local function var_0_12(arg_19_0)
	arg_19_0 = var_0_11(arg_19_0)

	socket.try(arg_19_0.host, "missing hostname")

	local var_19_0 = var_0_8.open(arg_19_0.host, arg_19_0.port, arg_19_0.create)

	var_19_0:greet()
	var_19_0:login(arg_19_0.user, arg_19_0.password)

	if arg_19_0.type then
		var_19_0:type(arg_19_0.type)
	end

	var_19_0:epsv()
	var_19_0:quit()
	var_19_0:close()

	return (var_19_0:send(arg_19_0))
end

local var_0_13 = {
	scheme = "ftp",
	path = "/"
}

local function var_0_14(arg_20_0)
	local var_20_0 = socket.try(url.parse(arg_20_0, var_0_13))

	socket.try(var_20_0.scheme == "ftp", "wrong scheme '" .. var_20_0.scheme .. "'")
	socket.try(var_20_0.host, "missing hostname")

	if var_20_0.params then
		var_20_0.type = socket.skip(2, string.find(var_20_0.params, "^type=(.)$"))

		socket.try(var_20_0.type == "a" or var_20_0.type == "i", "invalid type '" .. var_20_0.type .. "'")
	end

	return var_20_0
end

socket.ftp.genericform = var_0_14

local function var_0_15(arg_21_0, arg_21_1)
	local var_21_0 = var_0_14(arg_21_0)

	var_21_0.source = ltn12.source.string(arg_21_1)

	return var_0_12(var_21_0)
end

socket.ftp.put = socket.protect(function(arg_22_0, arg_22_1)
	if var_0_0.type(arg_22_0) == "string" then
		return var_0_15(arg_22_0, arg_22_1)
	else
		return var_0_12(arg_22_0)
	end

	return
end)

local function var_0_16(arg_23_0)
	arg_23_0 = var_0_11(arg_23_0)

	socket.try(arg_23_0.host, "missing hostname")

	local var_23_0 = var_0_8.open(arg_23_0.host, arg_23_0.port, arg_23_0.create)

	var_23_0:greet()
	var_23_0:login(arg_23_0.user, arg_23_0.password)

	if arg_23_0.type then
		var_23_0:type(arg_23_0.type)
	end

	var_23_0:epsv()
	var_23_0:receive(arg_23_0)
	var_23_0:quit()

	return var_23_0:close()
end

local function var_0_17(arg_24_0)
	local var_24_0 = var_0_14(arg_24_0)
	local var_24_1 = {}

	var_24_0.sink = ltn12.sink.table(var_24_1)

	var_0_16(var_24_0)

	return table.concat(var_24_1)
end

socket.ftp.command = socket.protect(function(arg_25_0)
	arg_25_0 = var_0_11(arg_25_0)

	socket.try(arg_25_0.host, "missing hostname")
	socket.try(arg_25_0.command, "missing command")

	local var_25_0 = var_0_8.open(arg_25_0.host, arg_25_0.port, arg_25_0.create)

	var_25_0:greet()
	var_25_0:login(arg_25_0.user, arg_25_0.password)

	if type(arg_25_0.command) == "table" then
		local var_25_1 = arg_25_0.argument or {}
		local var_25_2 = arg_25_0.check or {}

		for iter_25_0, iter_25_1 in ipairs(arg_25_0.command) do
			var_25_0.try(var_25_0.tp:command(iter_25_1, var_25_1[iter_25_0]))

			if var_25_2[iter_25_0] then
				var_25_0.try(var_25_0.tp:check(var_25_2[iter_25_0]))
			end
		end
	else
		var_25_0.try(var_25_0.tp:command(arg_25_0.command, arg_25_0.argument))

		if arg_25_0.check then
			var_25_0.try(var_25_0.tp:check(arg_25_0.check))
		end
	end

	var_25_0:quit()

	return var_25_0:close()
end)
socket.ftp.get = socket.protect(function(arg_26_0)
	if var_0_0.type(arg_26_0) == "string" then
		return var_0_17(arg_26_0)
	else
		return var_0_16(arg_26_0)
	end

	return
end)

return socket.ftp

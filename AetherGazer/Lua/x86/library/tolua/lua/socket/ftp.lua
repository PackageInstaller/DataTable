local var_0_0 = _G
local var_0_1 = require("table")
local var_0_2 = require("string")
local var_0_3 = require("math")
local var_0_4 = require("socket")
local var_0_5 = require("socket.url")
local var_0_6 = require("socket.tp")
local var_0_7 = require("ltn12")

var_0_4.ftp = {}

local var_0_8 = var_0_4.ftp

var_0_8.TIMEOUT = 60

local var_0_9 = 21

var_0_8.USER = "ftp"
var_0_8.PASSWORD = "anonymous@anonymous.org"

local var_0_10 = {
	__index = {}
}

function var_0_8.open(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_4.try(var_0_6.connect(arg_1_0, arg_1_1 or var_0_9, var_0_8.TIMEOUT, arg_1_2))
	local var_1_1 = var_0_0.setmetatable({
		tp = var_1_0
	}, var_0_10)

	var_1_1.try = var_0_4.newtry(function()
		var_1_1:close()
	end)

	return var_1_1
end

function var_0_10.__index.portconnect(arg_3_0)
	arg_3_0.try(arg_3_0.server:settimeout(var_0_8.TIMEOUT))

	arg_3_0.data = arg_3_0.try(arg_3_0.server:accept())

	arg_3_0.try(arg_3_0.data:settimeout(var_0_8.TIMEOUT))
end

function var_0_10.__index.pasvconnect(arg_4_0)
	arg_4_0.data = arg_4_0.try(var_0_4.tcp())

	arg_4_0.try(arg_4_0.data:settimeout(var_0_8.TIMEOUT))
	arg_4_0.try(arg_4_0.data:connect(arg_4_0.pasvt.address, arg_4_0.pasvt.port))
end

function var_0_10.__index.login(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.try(arg_5_0.tp:command("user", arg_5_1 or var_0_8.USER))

	local var_5_0, var_5_1 = arg_5_0.try(arg_5_0.tp:check({
		"2..",
		331
	}))

	if var_5_0 == 331 then
		arg_5_0.try(arg_5_0.tp:command("pass", arg_5_2 or var_0_8.PASSWORD))
		arg_5_0.try(arg_5_0.tp:check("2.."))
	end

	return 1
end

function var_0_10.__index.pasv(arg_6_0)
	arg_6_0.try(arg_6_0.tp:command("pasv"))

	local var_6_0, var_6_1 = arg_6_0.try(arg_6_0.tp:check("2.."))
	local var_6_2 = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
	local var_6_3, var_6_4, var_6_5, var_6_6, var_6_7, var_6_8 = var_0_4.skip(2, var_0_2.find(var_6_1, var_6_2))

	arg_6_0.try(var_6_3 and var_6_4 and var_6_5 and var_6_6 and var_6_7 and var_6_8, var_6_1)

	arg_6_0.pasvt = {
		address = var_0_2.format("%d.%d.%d.%d", var_6_3, var_6_4, var_6_5, var_6_6),
		port = var_6_7 * 256 + var_6_8
	}

	if arg_6_0.server then
		arg_6_0.server:close()

		arg_6_0.server = nil
	end

	return arg_6_0.pasvt.address, arg_6_0.pasvt.port
end

function var_0_10.__index.epsv(arg_7_0)
	arg_7_0.try(arg_7_0.tp:command("epsv"))

	local var_7_0, var_7_1 = arg_7_0.try(arg_7_0.tp:check("229"))
	local var_7_2 = "%((.)(.-)%1(.-)%1(.-)%1%)"
	local var_7_3, var_7_4, var_7_5, var_7_6 = var_0_2.match(var_7_1, var_7_2)

	arg_7_0.try(var_7_6, "invalid epsv response")

	arg_7_0.pasvt = {
		address = arg_7_0.tp:getpeername(),
		port = var_7_6
	}

	if arg_7_0.server then
		arg_7_0.server:close()

		arg_7_0.server = nil
	end

	return arg_7_0.pasvt.address, arg_7_0.pasvt.port
end

function var_0_10.__index.port(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.pasvt = nil

	if not arg_8_1 then
		arg_8_1, arg_8_2 = arg_8_0.try(arg_8_0.tp:getsockname())
		arg_8_0.server = arg_8_0.try(var_0_4.bind(arg_8_1, 0))
		arg_8_1, arg_8_2 = arg_8_0.try(arg_8_0.server:getsockname())

		arg_8_0.try(arg_8_0.server:settimeout(var_0_8.TIMEOUT))
	end

	local var_8_0 = arg_8_2 % 256
	local var_8_1 = (arg_8_2 - var_8_0) / 256
	local var_8_2 = var_0_2.gsub(var_0_2.format("%s,%d,%d", arg_8_1, var_8_1, var_8_0), "%.", ",")

	arg_8_0.try(arg_8_0.tp:command("port", var_8_2))
	arg_8_0.try(arg_8_0.tp:check("2.."))

	return 1
end

function var_0_10.__index.eprt(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.pasvt = nil

	if not arg_9_2 then
		arg_9_2, arg_9_3 = arg_9_0.try(arg_9_0.tp:getsockname())
		arg_9_0.server = arg_9_0.try(var_0_4.bind(arg_9_2, 0))
		arg_9_2, arg_9_3 = arg_9_0.try(arg_9_0.server:getsockname())

		arg_9_0.try(arg_9_0.server:settimeout(var_0_8.TIMEOUT))
	end

	local var_9_0 = var_0_2.format("|%s|%s|%d|", arg_9_1, arg_9_2, arg_9_3)

	arg_9_0.try(arg_9_0.tp:command("eprt", var_9_0))
	arg_9_0.try(arg_9_0.tp:check("2.."))

	return 1
end

function var_0_10.__index.send(arg_10_0, arg_10_1)
	arg_10_0.try(arg_10_0.pasvt or arg_10_0.server, "need port or pasv first")

	if arg_10_0.pasvt then
		arg_10_0:pasvconnect()
	end

	local var_10_0 = arg_10_1.argument or var_0_5.unescape(var_0_2.gsub(arg_10_1.path or "", "^[/\\]", ""))

	if var_10_0 == "" then
		var_10_0 = nil
	end

	local var_10_1 = arg_10_1.command or "stor"

	arg_10_0.try(arg_10_0.tp:command(var_10_1, var_10_0))

	local var_10_2, var_10_3 = arg_10_0.try(arg_10_0.tp:check({
		"2..",
		"1.."
	}))

	if not arg_10_0.pasvt then
		arg_10_0:portconnect()
	end

	local var_10_4 = arg_10_1.step or var_0_7.pump.step
	local var_10_5 = {
		arg_10_0.tp
	}

	local function var_10_6(arg_11_0, arg_11_1)
		if var_0_4.select(var_10_5, nil, 0)[var_0_6] then
			var_10_2 = arg_10_0.try(arg_10_0.tp:check("2.."))
		end

		return var_10_4(arg_11_0, arg_11_1)
	end

	local var_10_7 = var_0_4.sink("close-when-done", arg_10_0.data)

	arg_10_0.try(var_0_7.pump.all(arg_10_1.source, var_10_7, var_10_6))

	if var_0_2.find(var_10_2, "1..") then
		arg_10_0.try(arg_10_0.tp:check("2.."))
	end

	arg_10_0.data:close()

	local var_10_8 = var_0_4.skip(1, arg_10_0.data:getstats())

	arg_10_0.data = nil

	return var_10_8
end

function var_0_10.__index.receive(arg_12_0, arg_12_1)
	arg_12_0.try(arg_12_0.pasvt or arg_12_0.server, "need port or pasv first")

	if arg_12_0.pasvt then
		arg_12_0:pasvconnect()
	end

	local var_12_0 = arg_12_1.argument or var_0_5.unescape(var_0_2.gsub(arg_12_1.path or "", "^[/\\]", ""))

	if var_12_0 == "" then
		var_12_0 = nil
	end

	local var_12_1 = arg_12_1.command or "retr"

	arg_12_0.try(arg_12_0.tp:command(var_12_1, var_12_0))

	local var_12_2, var_12_3 = arg_12_0.try(arg_12_0.tp:check({
		"1..",
		"2.."
	}))

	if var_12_2 >= 200 and var_12_2 <= 299 then
		arg_12_1.sink(var_12_3)

		return 1
	end

	if not arg_12_0.pasvt then
		arg_12_0:portconnect()
	end

	local var_12_4 = var_0_4.source("until-closed", arg_12_0.data)
	local var_12_5 = arg_12_1.step or var_0_7.pump.step

	arg_12_0.try(var_0_7.pump.all(var_12_4, arg_12_1.sink, var_12_5))

	if var_0_2.find(var_12_2, "1..") then
		arg_12_0.try(arg_12_0.tp:check("2.."))
	end

	arg_12_0.data:close()

	arg_12_0.data = nil

	return 1
end

function var_0_10.__index.cwd(arg_13_0, arg_13_1)
	arg_13_0.try(arg_13_0.tp:command("cwd", arg_13_1))
	arg_13_0.try(arg_13_0.tp:check(250))

	return 1
end

function var_0_10.__index.type(arg_14_0, arg_14_1)
	arg_14_0.try(arg_14_0.tp:command("type", arg_14_1))
	arg_14_0.try(arg_14_0.tp:check(200))

	return 1
end

function var_0_10.__index.greet(arg_15_0)
	local var_15_0 = arg_15_0.try(arg_15_0.tp:check({
		"1..",
		"2.."
	}))

	if var_0_2.find(var_15_0, "1..") then
		arg_15_0.try(arg_15_0.tp:check("2.."))
	end

	return 1
end

function var_0_10.__index.quit(arg_16_0)
	arg_16_0.try(arg_16_0.tp:command("quit"))
	arg_16_0.try(arg_16_0.tp:check("2.."))

	return 1
end

function var_0_10.__index.close(arg_17_0)
	if arg_17_0.data then
		arg_17_0.data:close()
	end

	if arg_17_0.server then
		arg_17_0.server:close()
	end

	return arg_17_0.tp:close()
end

local function var_0_11(arg_18_0)
	if arg_18_0.url then
		local var_18_0 = var_0_5.parse(arg_18_0.url)

		for iter_18_0, iter_18_1 in var_0_0.pairs(arg_18_0) do
			var_18_0[iter_18_0] = iter_18_1
		end

		return var_18_0
	else
		return arg_18_0
	end
end

local function var_0_12(arg_19_0)
	arg_19_0 = var_0_11(arg_19_0)

	var_0_4.try(arg_19_0.host, "missing hostname")

	local var_19_0 = var_0_8.open(arg_19_0.host, arg_19_0.port, arg_19_0.create)

	var_19_0:greet()
	var_19_0:login(arg_19_0.user, arg_19_0.password)

	if arg_19_0.type then
		var_19_0:type(arg_19_0.type)
	end

	var_19_0:epsv()

	local var_19_1 = var_19_0:send(arg_19_0)

	var_19_0:quit()
	var_19_0:close()

	return var_19_1
end

local var_0_13 = {
	scheme = "ftp",
	path = "/"
}

local function var_0_14(arg_20_0)
	local var_20_0 = var_0_4.try(var_0_5.parse(arg_20_0, var_0_13))

	var_0_4.try(var_20_0.scheme == "ftp", "wrong scheme '" .. var_20_0.scheme .. "'")
	var_0_4.try(var_20_0.host, "missing hostname")

	local var_20_1 = "^type=(.)$"

	if var_20_0.params then
		var_20_0.type = var_0_4.skip(2, var_0_2.find(var_20_0.params, var_20_1))

		var_0_4.try(var_20_0.type == "a" or var_20_0.type == "i", "invalid type '" .. var_20_0.type .. "'")
	end

	return var_20_0
end

var_0_8.genericform = var_0_14

local function var_0_15(arg_21_0, arg_21_1)
	local var_21_0 = var_0_14(arg_21_0)

	var_21_0.source = var_0_7.source.string(arg_21_1)

	return var_0_12(var_21_0)
end

var_0_8.put = var_0_4.protect(function(arg_22_0, arg_22_1)
	if var_0_0.type(arg_22_0) == "string" then
		return var_0_15(arg_22_0, arg_22_1)
	else
		return var_0_12(arg_22_0)
	end
end)

local function var_0_16(arg_23_0)
	arg_23_0 = var_0_11(arg_23_0)

	var_0_4.try(arg_23_0.host, "missing hostname")

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

	var_24_0.sink = var_0_7.sink.table(var_24_1)

	var_0_16(var_24_0)

	return var_0_1.concat(var_24_1)
end

var_0_8.command = var_0_4.protect(function(arg_25_0)
	arg_25_0 = var_0_11(arg_25_0)

	var_0_4.try(arg_25_0.host, "missing hostname")
	var_0_4.try(arg_25_0.command, "missing command")

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
var_0_8.get = var_0_4.protect(function(arg_26_0)
	if var_0_0.type(arg_26_0) == "string" then
		return var_0_17(arg_26_0)
	else
		return var_0_16(arg_26_0)
	end
end)

return var_0_8

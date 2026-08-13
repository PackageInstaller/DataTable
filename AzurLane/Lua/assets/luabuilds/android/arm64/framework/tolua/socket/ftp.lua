_G = var_0_10000
require = var_0_10001

local var_0_0 = var_0_10001("table")

require = var_0_10002

local var_0_1 = var_0_10002("string")

require = var_3

local var_0_2 = var_3("math")

require = var_4

local var_0_3 = var_4("socket")

require = var_5

local var_0_4 = var_5("socket.url")

require = var_6

local var_0_5 = var_6("socket.tp")

require = var_7

local var_0_6 = var_7("ltn12")

var_0_3.ftp = {}

local var_0_7 = var_0_3.ftp

var_0_7.TIMEOUT = 60

local var_0_8 = 21

var_0_7.USER = "ftp"
var_0_7.PASSWORD = "anonymous@anonymous.org"

local var_0_9 = {
	__index = {}
}

function var_0_7.open(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_3.try(var_0_5.connect(arg_1_0, arg_1_1 or var_0_8, var_0_7.TIMEOUT, arg_1_2))
	local var_1_1 = var_0_10000.setmetatable({
		tp = var_1_0
	}, var_0_9)

	var_1_1.try = var_0_3.newtry(function()
		local var_2_0 = var_1_1

		var_0.close(var_2_0)

		return
	end)

	return var_1_1
end

function var_0_9.__index.portconnect(arg_3_0)
	local var_3_0 = arg_3_0.try
	local var_3_1 = arg_3_0.server

	var_3_0(var_3.settimeout(var_3_1, var_0_7.TIMEOUT))

	local var_3_2 = arg_3_0.try
	local var_3_3 = arg_3_0.server

	arg_3_0.data = var_3_2(var_3.accept(var_3_3))

	local var_3_4 = arg_3_0.try
	local var_3_5 = arg_3_0.data

	var_3_4(var_3.settimeout(var_3_5, var_0_7.TIMEOUT))

	return
end

function var_0_9.__index.pasvconnect(arg_4_0)
	arg_4_0.data = arg_4_0.try(var_0_3.tcp())

	local var_4_0 = arg_4_0.try
	local var_4_1 = arg_4_0.data

	var_4_0(var_3.settimeout(var_4_1, var_0_7.TIMEOUT))

	local var_4_2 = arg_4_0.try
	local var_4_3 = arg_4_0.data

	var_4_2(var_3.connect(var_4_3, arg_4_0.pasvt.address, arg_4_0.pasvt.port))

	return
end

function var_0_9.__index.login(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.try
	local var_5_1 = arg_5_0.tp

	var_5_0(var_5.command(var_5_1, "user", arg_5_1 or var_0_7.USER))

	local var_5_2 = arg_5_0.try
	local var_5_3 = arg_5_0.tp
	local var_5_4, var_5_5 = var_5_2(var_5.check(var_5_3, {
		"2..",
		331
	}))

	if var_5_4 == 331 then
		local var_5_6 = arg_5_0.try
		local var_5_7 = arg_5_0.tp

		var_5_6(var_7.command(var_5_7, "pass", arg_5_2 or var_0_7.PASSWORD))

		local var_5_8 = arg_5_0.try
		local var_5_9 = arg_5_0.tp

		var_5_8(var_7.check(var_5_9, "2.."))
	end

	return 1
end

function var_0_9.__index.pasv(arg_6_0)
	local var_6_0 = arg_6_0.try
	local var_6_1 = arg_6_0.tp

	var_6_0(var_3.command(var_6_1, "pasv"))

	local var_6_2 = arg_6_0.try
	local var_6_3 = arg_6_0.tp
	local var_6_4, var_6_5 = var_6_2(var_3.check(var_6_3, "2.."))
	local var_6_6 = "(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)%D(%d+)"
	local var_6_7, var_6_8, var_6_9, var_6_10, var_6_11, var_6_12 = var_0_3.skip(2, var_0_1.find(var_6_5, var_6_6))

	arg_6_0.try(var_6_7 and var_6_8 and var_6_9 and var_6_10 and var_6_11 and var_6_12, var_6_5)

	arg_6_0.pasvt = {
		address = var_0_1.format("%d.%d.%d.%d", var_6_7, var_6_8, var_6_9, var_6_10),
		port = var_6_11 * 0 + var_6_12
	}

	if arg_6_0.server then
		local var_6_13 = arg_6_0.server

		var_10.close(var_6_13)

		arg_6_0.server = nil
	end

	return arg_6_0.pasvt.address, arg_6_0.pasvt.port
end

function var_0_9.__index.epsv(arg_7_0)
	local var_7_0 = arg_7_0.try
	local var_7_1 = arg_7_0.tp

	var_7_0(var_3.command(var_7_1, "epsv"))

	local var_7_2 = arg_7_0.try
	local var_7_3 = arg_7_0.tp
	local var_7_4, var_7_5 = var_7_2(var_3.check(var_7_3, "229"))
	local var_7_6 = "%((.)(.-)%1(.-)%1(.-)%1%)"
	local var_7_7, var_7_8, var_7_9, var_7_10 = var_0_1.match(var_7_5, var_7_6)

	arg_7_0.try(var_7_10, "invalid epsv response")

	local var_7_11 = {}
	local var_7_12 = arg_7_0.tp

	var_7_11.address = var_9.getpeername(var_7_12)
	var_7_11.port = var_7_10
	arg_7_0.pasvt = var_7_11

	if arg_7_0.server then
		local var_7_13 = arg_7_0.server

		var_8.close(var_7_13)

		arg_7_0.server = nil
	end

	return arg_7_0.pasvt.address, arg_7_0.pasvt.port
end

function var_0_9.__index.port(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.pasvt = nil

	if not arg_8_1 then
		local var_8_0 = arg_8_0.try
		local var_8_1 = arg_8_0.tp

		arg_8_1, arg_8_2 = var_8_0(var_5.getsockname(var_8_1))
		arg_8_0.server = arg_8_0.try(var_0_3.bind(arg_8_1, 0))

		local var_8_2 = arg_8_0.try
		local var_8_3 = arg_8_0.server

		arg_8_1, arg_8_2 = var_8_2(var_5.getsockname(var_8_3))

		local var_8_4 = arg_8_0.try
		local var_8_5 = arg_8_0.server

		var_8_4(var_5.settimeout(var_8_5, var_0_7.TIMEOUT))
	end

	local var_8_6 = (arg_8_2 - arg_8_2 % 0) / 0
	local var_8_7 = var_0_1.gsub(var_0_1.format("%s,%d,%d", arg_8_1, var_8_6, var_3), "%.", ",")
	local var_8_8 = arg_8_0.try
	local var_8_9 = arg_8_0.tp

	var_8_8(var_8.command(var_8_9, "port", var_8_7))

	local var_8_10 = arg_8_0.try
	local var_8_11 = arg_8_0.tp

	var_8_10(var_8.check(var_8_11, "2.."))

	return 1
end

function var_0_9.__index.eprt(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.pasvt = nil

	if not arg_9_2 then
		local var_9_0 = arg_9_0.try
		local var_9_1 = arg_9_0.tp

		arg_9_2, arg_9_3 = var_9_0(var_6.getsockname(var_9_1))
		arg_9_0.server = arg_9_0.try(var_0_3.bind(arg_9_2, 0))

		local var_9_2 = arg_9_0.try
		local var_9_3 = arg_9_0.server

		arg_9_2, arg_9_3 = var_9_2(var_6.getsockname(var_9_3))

		local var_9_4 = arg_9_0.try
		local var_9_5 = arg_9_0.server

		var_9_4(var_6.settimeout(var_9_5, var_0_7.TIMEOUT))
	end

	local var_9_6 = var_0_1.format("|%s|%s|%d|", arg_9_1, arg_9_2, arg_9_3)
	local var_9_7 = arg_9_0.try
	local var_9_8 = arg_9_0.tp

	var_9_7(var_7.command(var_9_8, "eprt", var_9_6))

	local var_9_9 = arg_9_0.try
	local var_9_10 = arg_9_0.tp

	var_9_9(var_7.check(var_9_10, "2.."))

	return 1
end

function var_0_9.__index.send(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.try
	local var_10_1

	if not arg_10_0.pasvt then
		var_10_1 = arg_10_0.server
	end

	var_10_0(var_10_1, "need port or pasv first")

	if arg_10_0.pasvt then
		arg_10_0:pasvconnect()
	end

	local var_10_5

	if not arg_10_1.argument then
		local var_10_2 = var_0_4.unescape
		local var_10_3 = var_0_1.gsub
		local var_10_4

		if not arg_10_1.path then
			var_10_4 = ""
		end

		var_10_5 = var_10_2(var_10_3(var_10_4, "^[/\\]", ""))
	end

	if var_10_5 == "" then
		var_10_5 = nil
	end

	local var_10_6

	if not arg_10_1.command then
		var_10_6 = "stor"
	end

	local var_10_7 = arg_10_0.try
	local var_10_8 = arg_10_0.tp

	var_10_7(var_6.command(var_10_8, var_10_6, var_10_5))

	local var_10_9 = arg_10_0.try
	local var_10_10 = arg_10_0.tp
	local var_10_11, var_10_12 = var_10_9(var_6.check(var_10_10, {
		"2..",
		"1.."
	}))

	if not arg_10_0.pasvt then
		arg_10_0:portconnect()
	end

	local var_10_13

	if not arg_10_1.step then
		var_10_13 = var_0_6.pump.step
	end

	local var_10_14 = {
		arg_10_0.tp
	}

	local function var_10_15(arg_11_0, arg_11_1)
		if var_0_3.select(var_10_14, nil, 0)[var_0_5] then
			local var_11_0 = arg_10_0.try
			local var_11_1 = arg_10_0.tp

			var_10_11 = var_11_0(var_5.check(var_11_1, "2.."))
		end

		return var_10_13(arg_11_0, arg_11_1)
	end

	local var_10_16 = var_0_3.sink("close-when-done", arg_10_0.data)

	arg_10_0.try(var_0_6.pump.all(arg_10_1.source, var_10_16, var_10_15))

	if var_0_1.find(var_10_11, "1..") then
		local var_10_17 = arg_10_0.try
		local var_10_18 = arg_10_0.tp

		var_10_17(var_12.check(var_10_18, "2.."))
	end

	local var_10_19 = arg_10_0.data

	var_10.close(var_10_19)

	local var_10_20 = var_0_3.skip
	local var_10_21 = 1
	local var_10_22 = arg_10_0.data
	local var_10_23 = var_10_20(var_10_21, var_13.getstats(var_10_22))

	arg_10_0.data = nil

	return var_10_23
end

function var_0_9.__index.receive(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.try
	local var_12_1

	if not arg_12_0.pasvt then
		var_12_1 = arg_12_0.server
	end

	var_12_0(var_12_1, "need port or pasv first")

	if arg_12_0.pasvt then
		arg_12_0:pasvconnect()
	end

	local var_12_5

	if not arg_12_1.argument then
		local var_12_2 = var_0_4.unescape
		local var_12_3 = var_0_1.gsub
		local var_12_4

		if not arg_12_1.path then
			var_12_4 = ""
		end

		var_12_5 = var_12_2(var_12_3(var_12_4, "^[/\\]", ""))
	end

	if var_12_5 == "" then
		var_12_5 = nil
	end

	local var_12_6

	if not arg_12_1.command then
		var_12_6 = "retr"
	end

	local var_12_7 = arg_12_0.try
	local var_12_8 = arg_12_0.tp

	var_12_7(var_6.command(var_12_8, var_12_6, var_12_5))

	local var_12_9 = arg_12_0.try
	local var_12_10 = arg_12_0.tp
	local var_12_11, var_12_12 = var_12_9(var_6.check(var_12_10, {
		"1..",
		"2.."
	}))

	if var_12_11 >= 200 and var_12_11 <= 299 then
		arg_12_1.sink(var_12_12)

		return 1
	end

	if not arg_12_0.pasvt then
		arg_12_0:portconnect()
	end

	local var_12_13 = var_0_3.source("until-closed", arg_12_0.data)
	local var_12_14

	if not arg_12_1.step then
		var_12_14 = var_0_6.pump.step
	end

	arg_12_0.try(var_0_6.pump.all(var_12_13, arg_12_1.sink, var_12_14))

	if var_0_1.find(var_12_11, "1..") then
		local var_12_15 = arg_12_0.try
		local var_12_16 = arg_12_0.tp

		var_12_15(var_10.check(var_12_16, "2.."))
	end

	local var_12_17 = arg_12_0.data

	var_8.close(var_12_17)

	arg_12_0.data = nil

	return 1
end

function var_0_9.__index.cwd(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.try
	local var_13_1 = arg_13_0.tp

	var_13_0(var_4.command(var_13_1, "cwd", arg_13_1))

	local var_13_2 = arg_13_0.try
	local var_13_3 = arg_13_0.tp

	var_13_2(var_4.check(var_13_3, 250))

	return 1
end

function var_0_9.__index.type(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.try
	local var_14_1 = arg_14_0.tp

	var_14_0(var_4.command(var_14_1, "type", arg_14_1))

	local var_14_2 = arg_14_0.try
	local var_14_3 = arg_14_0.tp

	var_14_2(var_4.check(var_14_3, 200))

	return 1
end

function var_0_9.__index.greet(arg_15_0)
	local var_15_0 = arg_15_0.try
	local var_15_1 = arg_15_0.tp
	local var_15_2 = var_15_0(var_3.check(var_15_1, {
		"1..",
		"2.."
	}))

	if var_0_1.find(var_15_2, "1..") then
		local var_15_3 = arg_15_0.try
		local var_15_4 = arg_15_0.tp

		var_15_3(var_4.check(var_15_4, "2.."))
	end

	return 1
end

function var_0_9.__index.quit(arg_16_0)
	local var_16_0 = arg_16_0.try
	local var_16_1 = arg_16_0.tp

	var_16_0(var_3.command(var_16_1, "quit"))

	local var_16_2 = arg_16_0.try
	local var_16_3 = arg_16_0.tp

	var_16_2(var_3.check(var_16_3, "2.."))

	return 1
end

function var_0_9.__index.close(arg_17_0)
	if arg_17_0.data then
		local var_17_0 = arg_17_0.data

		var_1.close(var_17_0)
	end

	if arg_17_0.server then
		local var_17_1 = arg_17_0.server

		var_1.close(var_17_1)
	end

	local var_17_2 = arg_17_0.tp

	return var_1.close(var_17_2)
end

local function var_0_10(arg_18_0)
	if arg_18_0.url then
		local var_18_0 = var_0_4.parse(arg_18_0.url)

		for iter_18_0, iter_18_1 in var_0_10000.pairs(arg_18_0) do
			var_18_0[iter_18_0] = iter_18_1
		end

		return var_18_0
	else
		return arg_18_0
	end

	return
end

local function var_0_11(arg_19_0)
	arg_19_0 = var_0_10(arg_19_0)

	var_0_3.try(arg_19_0.host, "missing hostname")

	local var_19_0 = var_0_7.open(arg_19_0.host, arg_19_0.port, arg_19_0.create)

	var_1.greet(var_19_0)
	var_1:login(arg_19_0.user, arg_19_0.password)

	if arg_19_0.type then
		var_1:type(arg_19_0.type)
	end

	var_1:epsv()

	local var_19_1 = var_1:send(arg_19_0)

	var_1:quit()
	var_1:close()

	return var_19_1
end

local var_0_12 = {
	scheme = "ftp",
	path = "/"
}

function var_0_7.genericform(arg_20_0)
	local var_20_0 = var_0_3.try(var_0_4.parse(arg_20_0, var_0_12))

	var_0_3.try(var_20_0.scheme == "ftp", "wrong scheme '" .. var_20_0.scheme .. "'")
	var_0_3.try(var_20_0.host, "missing hostname")

	local var_20_1 = "^type=(.)$"

	if var_20_0.params then
		var_20_0.type = var_0_3.skip(2, var_0_1.find(var_20_0.params, var_20_1))

		var_0_3.try(var_20_0.type == "a" or var_20_0.type == "i", "invalid type '" .. var_20_0.type .. "'")
	end

	return var_20_0
end

local function var_0_13(arg_21_0, arg_21_1)
	local var_21_0 = var_0(arg_21_0)

	var_21_0.source = var_0_6.source.string(arg_21_1)

	return var_0_11(var_21_0)
end

var_0_7.put = var_0_3.protect(function(arg_22_0, arg_22_1)
	if var_0_10000.type(arg_22_0) == "string" then
		return var_0_13(arg_22_0, arg_22_1)
	else
		return var_0_11(arg_22_0)
	end

	return
end)

local function var_0_14(arg_23_0)
	arg_23_0 = var_0_10(arg_23_0)

	var_0_3.try(arg_23_0.host, "missing hostname")

	local var_23_0 = var_0_7.open(arg_23_0.host, arg_23_0.port, arg_23_0.create)

	var_1.greet(var_23_0)
	var_1:login(arg_23_0.user, arg_23_0.password)

	if arg_23_0.type then
		var_1:type(arg_23_0.type)
	end

	var_1:epsv()
	var_1:receive(arg_23_0)
	var_1:quit()

	return var_1:close()
end

local function var_0_15(arg_24_0)
	local var_24_0 = var_0(arg_24_0)
	local var_24_1 = {}

	var_24_0.sink = var_0_6.sink.table(var_24_1)

	var_0_14(var_24_0)

	return var_0_0.concat(var_24_1)
end

var_0_7.command = var_0_3.protect(function(arg_25_0)
	arg_25_0 = var_0_10(arg_25_0)

	var_0_3.try(arg_25_0.host, "missing hostname")
	var_0_3.try(arg_25_0.command, "missing command")

	local var_25_0 = var_0_7.open(arg_25_0.host, arg_25_0.port, arg_25_0.create)

	var_1.greet(var_25_0)
	var_1:login(arg_25_0.user, arg_25_0.password)

	type = var_2

	if var_2(arg_25_0.command) == "table" then
		local var_25_1

		if not arg_25_0.argument then
			var_25_1 = {}
		end

		local var_25_2

		if not arg_25_0.check then
			var_25_2 = {}
		end

		ipairs = var_4

		for iter_25_0, iter_25_1 in var_4(arg_25_0.command) do
			local var_25_3 = var_1.try
			local var_25_4 = var_1.tp

			var_25_3(var_11.command(var_25_4, iter_25_1, var_25_1[iter_25_0]))

			if var_25_2[iter_25_0] then
				local var_25_5 = var_1.try
				local var_25_6 = var_1.tp

				var_25_5(var_11.check(var_25_6, var_25_2[iter_25_0]))
			end
		end
	else
		local var_25_7 = var_1.try
		local var_25_8 = var_1.tp

		var_25_7(var_4.command(var_25_8, arg_25_0.command, arg_25_0.argument))

		if arg_25_0.check then
			local var_25_9 = var_1.try
			local var_25_10 = var_1.tp

			var_25_9(var_4.check(var_25_10, arg_25_0.check))
		end
	end

	var_1:quit()

	return var_1:close()
end)
var_0_7.get = var_0_3.protect(function(arg_26_0)
	if var_0_10000.type(arg_26_0) == "string" then
		return var_0_15(arg_26_0)
	else
		return var_0_14(arg_26_0)
	end

	return
end)

return var_0_7

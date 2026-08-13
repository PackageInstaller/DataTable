_G = var_0_10000
require = var_0_10001

local var_0_0 = var_0_10001("coroutine")

require = var_2

local var_0_1 = var_2("string")

require = var_3

local var_0_2 = var_3("math")

require = var_4

local var_0_3 = var_4("os")

require = var_5

local var_0_4 = var_5("socket")

require = var_6

local var_0_5 = var_6("socket.tp")

require = var_7

local var_0_6 = var_7("ltn12")

require = var_8

local var_0_7 = var_8("socket.headers")

require = var_9

local var_0_8 = var_9("mime")

var_0_4.smtp = {}

local var_0_9 = var_0_4.smtp

var_0_9.TIMEOUT = 60
var_0_9.SERVER = "localhost"
var_0_9.PORT = 25

local var_0_10

if not var_0_3.getenv("SERVER_NAME") then
	var_0_10 = "localhost"
end

var_0_9.DOMAIN = var_0_10
var_0_9.ZONE = "-0000"
;({
	__index = {}
}).__index.greet = function(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.try
	local var_1_1 = arg_1_0.tp

	var_1_0(var_3.check(var_1_1, "2.."))

	local var_1_2 = arg_1_0.try
	local var_1_3 = arg_1_0.tp

	var_1_2(var_3.command(var_1_3, "EHLO", arg_1_1 or var_0_9.DOMAIN))

	local var_1_4 = var_0_4.skip
	local var_1_5 = 1
	local var_1_6 = arg_1_0.try
	local var_1_7 = arg_1_0.tp

	return var_1_4(var_1_5, var_1_6(var_5.check(var_1_7, "2..")))
end

function var_11.__index.mail(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.try
	local var_2_1 = arg_2_0.tp

	var_2_0(var_3.command(var_2_1, "MAIL", "FROM:" .. arg_2_1))

	local var_2_2 = arg_2_0.try
	local var_2_3 = arg_2_0.tp

	return var_2_2(var_3.check(var_2_3, "2.."))
end

function var_11.__index.rcpt(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.try
	local var_3_1 = arg_3_0.tp

	var_3_0(var_3.command(var_3_1, "RCPT", "TO:" .. arg_3_1))

	local var_3_2 = arg_3_0.try
	local var_3_3 = arg_3_0.tp

	return var_3_2(var_3.check(var_3_3, "2.."))
end

function var_11.__index.data(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.try
	local var_4_1 = arg_4_0.tp

	var_4_0(var_4.command(var_4_1, "DATA"))

	local var_4_2 = arg_4_0.try
	local var_4_3 = arg_4_0.tp

	var_4_2(var_4.check(var_4_3, "3.."))

	local var_4_4 = arg_4_0.try
	local var_4_5 = arg_4_0.tp

	var_4_4(var_4.source(var_4_5, arg_4_1, arg_4_2))

	local var_4_6 = arg_4_0.try
	local var_4_7 = arg_4_0.tp

	var_4_6(var_4.send(var_4_7, "\r\n.\r\n"))

	local var_4_8 = arg_4_0.try
	local var_4_9 = arg_4_0.tp

	return var_4_8(var_4.check(var_4_9, "2.."))
end

function var_11.__index.quit(arg_5_0)
	local var_5_0 = arg_5_0.try
	local var_5_1 = arg_5_0.tp

	var_5_0(var_2.command(var_5_1, "QUIT"))

	local var_5_2 = arg_5_0.try
	local var_5_3 = arg_5_0.tp

	return var_5_2(var_2.check(var_5_3, "2.."))
end

function var_11.__index.close(arg_6_0)
	local var_6_0 = arg_6_0.tp

	return var_1.close(var_6_0)
end

function var_11.__index.login(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.try
	local var_7_1 = arg_7_0.tp

	var_7_0(var_4.command(var_7_1, "AUTH", "LOGIN"))

	local var_7_2 = arg_7_0.try
	local var_7_3 = arg_7_0.tp

	var_7_2(var_4.check(var_7_3, "3.."))

	local var_7_4 = arg_7_0.try
	local var_7_5 = arg_7_0.tp

	var_7_4(var_4.send(var_7_5, var_0_8.b64(arg_7_1) .. "\r\n"))

	local var_7_6 = arg_7_0.try
	local var_7_7 = arg_7_0.tp

	var_7_6(var_4.check(var_7_7, "3.."))

	local var_7_8 = arg_7_0.try
	local var_7_9 = arg_7_0.tp

	var_7_8(var_4.send(var_7_9, var_0_8.b64(arg_7_2) .. "\r\n"))

	local var_7_10 = arg_7_0.try
	local var_7_11 = arg_7_0.tp

	return var_7_10(var_4.check(var_7_11, "2.."))
end

function var_11.__index.plain(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = "PLAIN " .. var_0_8.b64("\x00" .. arg_8_1 .. "\x00" .. arg_8_2)
	local var_8_1 = arg_8_0.try
	local var_8_2 = arg_8_0.tp

	var_8_1(var_5.command(var_8_2, "AUTH", var_8_0))

	local var_8_3 = arg_8_0.try
	local var_8_4 = arg_8_0.tp

	return var_8_3(var_5.check(var_8_4, "2.."))
end

function var_11.__index.auth(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 or not arg_9_2 then
		return 1
	end

	if var_0_1.find(arg_9_3, "AUTH[^\n]+LOGIN") then
		return arg_9_0:login(arg_9_1, arg_9_2)
	elseif var_0_1.find(arg_9_3, "AUTH[^\n]+PLAIN") then
		return arg_9_0:plain(arg_9_1, arg_9_2)
	else
		arg_9_0.try(nil, "authentication not supported")
	end

	return
end

function var_11.__index.send(arg_10_0, arg_10_1)
	arg_10_0:mail(arg_10_1.from)

	if var_0_10000.type(arg_10_1.rcpt) == "table" then
		for iter_10_0, iter_10_1 in var_0_10000.ipairs(arg_10_1.rcpt) do
			arg_10_0:rcpt(iter_10_1)
		end
	else
		arg_10_0:rcpt(arg_10_1.rcpt)
	end

	arg_10_0:data(var_0_6.source.chain(arg_10_1.source, var_0_8.stuff()), arg_10_1.step)

	return
end

function var_0_9.open(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_4.try(var_0_5.connect(arg_11_0 or var_0_9.SERVER, arg_11_1 or var_0_9.PORT, var_0_9.TIMEOUT, arg_11_2))
	local var_11_1 = var_0_10000.setmetatable({
		tp = var_11_0
	}, var_0)

	var_11_1.try = var_0_4.newtry(function()
		local var_12_0 = var_11_1

		var_0.close(var_12_0)

		return
	end)

	return var_11_1
end

local function var_0_11(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in var_0_10000.pairs(arg_13_0 or var_13_0) do
		var_13_0[var_0_1.lower(iter_13_0)] = iter_13_1
	end

	return var_13_0
end

local var_0_12 = 0

local function var_0_13()
	var_0_12 = var_0_12 + 1

	return var_0_1.format("%s%05d==%05u", var_0_3.date("%d%m%Y%H%M%S"), var_0_2.random(0, 31), var_0_12)
end

local var_0_14

local function var_0_15(arg_15_0)
	local var_15_0 = var_0_7.canonic
	local var_15_1 = "\r\n"

	for iter_15_0, iter_15_1 in var_0_10000.pairs(arg_15_0) do
		local var_15_2

		if not var_15_0[iter_15_0] then
			var_15_2 = iter_15_0
		end

		var_15_1 = var_15_2 .. ": " .. iter_15_1 .. "\r\n" .. var_15_1
	end

	var_0_0.yield(var_15_1)

	return
end

local function var_0_16(arg_16_0)
	local var_16_0 = var_0_13()
	local var_16_1 = var_0_11
	local var_16_2

	if not arg_16_0.headers then
		var_16_2 = {}
	end

	local var_16_3

	if not var_16_1(var_16_2)["content-type"] then
		var_16_3 = "multipart/mixed"
	end

	var_2["content-type"] = var_16_3
	var_2["content-type"] = var_2["content-type"] .. "; boundary=\"" .. var_16_0 .. "\""

	var_0_15(var_2)

	if arg_16_0.body.preamble then
		var_0_0.yield(arg_16_0.body.preamble)
		var_0_0.yield("\r\n")
	end

	for iter_16_0, iter_16_1 in var_0_10000.ipairs(arg_16_0.body) do
		var_0_0.yield("\r\n--" .. var_16_0 .. "\r\n")
		var_0_14(iter_16_1)
	end

	var_0_0.yield("\r\n--" .. var_16_0 .. "--\r\n\r\n")

	if arg_16_0.body.epilogue then
		var_0_0.yield(arg_16_0.body.epilogue)
		var_0_0.yield("\r\n")
	end

	return
end

local function var_0_17(arg_17_0)
	local var_17_0 = var_0_11
	local var_17_1

	if not arg_17_0.headers then
		var_17_1 = {}
	end

	local var_17_2

	if not var_17_0(var_17_1)["content-type"] then
		var_17_2 = "text/plain; charset=\"iso-8859-1\""
	end

	var_1["content-type"] = var_17_2

	var_0_15(var_1)

	while true do
		local var_17_3, var_17_4 = arg_17_0.body()

		if var_17_4 then
			var_0_0.yield(nil, var_17_4)
		elseif var_17_3 then
			var_0_0.yield(var_17_3)
		else
			break
		end
	end

	return
end

local function var_0_18(arg_18_0)
	local var_18_0 = var_0_11
	local var_18_1

	if not arg_18_0.headers then
		var_18_1 = {}
	end

	local var_18_2

	if not var_18_0(var_18_1)["content-type"] then
		var_18_2 = "text/plain; charset=\"iso-8859-1\""
	end

	var_1["content-type"] = var_18_2

	var_0_15(var_1)
	var_0_0.yield(arg_18_0.body)

	return
end

function var_0_14(arg_19_0)
	if var_0_10000.type(arg_19_0.body) == "table" then
		var_0_16(arg_19_0)
	elseif var_0_10000.type(arg_19_0.body) == "function" then
		var_0_17(arg_19_0)
	else
		var_0_18(arg_19_0)
	end

	return
end

local function var_0_19(arg_20_0)
	local var_20_2

	if not var_0_11(arg_20_0.headers).date then
		local var_20_0 = var_0_3.date("!%a, %d %b %Y %H:%M:%S ")
		local var_20_1

		if not arg_20_0.zone then
			var_20_1 = var_0_9.ZONE
		end

		var_20_2 = var_20_0 .. var_20_1
	end

	var_1.date = var_20_2

	local var_20_3

	if not var_1["x-mailer"] then
		var_20_3 = var_0_4._VERSION
	end

	var_1["x-mailer"] = var_20_3
	var_1["mime-version"] = "1.0"

	return var_1
end

function var_0_9.message(arg_21_0)
	arg_21_0.headers = var_0_19(arg_21_0)

	local var_21_0 = var_0_0.create(function()
		var_0_14(arg_21_0)

		return
	end)

	return function()
		local var_23_0, var_23_1, var_23_2 = var_0_0.resume(var_21_0)

		if var_23_0 then
			return var_23_1, var_23_2
		else
			return nil, var_23_1
		end

		return
	end
end

var_0_9.send = var_0_4.protect(function(arg_24_0)
	local var_24_0 = var_0_9.open(arg_24_0.server, arg_24_0.port, arg_24_0.create)
	local var_24_1 = var_1.greet(var_24_0, arg_24_0.domain)

	var_1:auth(arg_24_0.user, arg_24_0.password, var_24_1)
	var_1:send(arg_24_0)
	var_1:quit()

	return var_1:close()
end)

return var_0_9

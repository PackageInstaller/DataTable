local var_0_0 = _G
local var_0_1 = require("coroutine")
local var_0_2 = require("string")
local var_0_3 = require("math")
local var_0_4 = require("os")
local var_0_5 = require("socket")
local var_0_6 = require("socket.tp")
local var_0_7 = require("ltn12")
local var_0_8 = require("socket.headers")
local var_0_9 = require("mime")

var_0_5.smtp = {}

local var_0_10 = var_0_5.smtp

var_0_5.smtp.TIMEOUT = 60
var_0_5.smtp.SERVER = "localhost"
var_0_5.smtp.PORT = 25
var_0_5.smtp.DOMAIN = require("os").getenv("SERVER_NAME") or "localhost"
var_0_5.smtp.ZONE = "-0000"

local var_0_11 = {
	__index = {}
}

;({
	__index = {}
}).__index.greet = function(arg_1_0, arg_1_1)
	arg_1_0.try(arg_1_0.tp:check("2.."))
	arg_1_0.try(arg_1_0.tp:command("EHLO", arg_1_1 or var_0_10.DOMAIN))

	return var_0_5.skip(1, arg_1_0.try(arg_1_0.tp:check("2..")))
end
;({
	__index = {}
}).__index.mail = function(arg_2_0, arg_2_1)
	arg_2_0.try(arg_2_0.tp:command("MAIL", "FROM:" .. arg_2_1))

	return arg_2_0.try(arg_2_0.tp:check("2.."))
end
;({
	__index = {}
}).__index.rcpt = function(arg_3_0, arg_3_1)
	arg_3_0.try(arg_3_0.tp:command("RCPT", "TO:" .. arg_3_1))

	return arg_3_0.try(arg_3_0.tp:check("2.."))
end
;({
	__index = {}
}).__index.data = function(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.try(arg_4_0.tp:command("DATA"))
	arg_4_0.try(arg_4_0.tp:check("3.."))
	arg_4_0.try(arg_4_0.tp:source(arg_4_1, arg_4_2))
	arg_4_0.try(arg_4_0.tp:send("\r\n.\r\n"))

	return arg_4_0.try(arg_4_0.tp:check("2.."))
end
;({
	__index = {}
}).__index.quit = function(arg_5_0)
	arg_5_0.try(arg_5_0.tp:command("QUIT"))

	return arg_5_0.try(arg_5_0.tp:check("2.."))
end
;({
	__index = {}
}).__index.close = function(arg_6_0)
	return arg_6_0.tp:close()
end
;({
	__index = {}
}).__index.login = function(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.try(arg_7_0.tp:command("AUTH", "LOGIN"))
	arg_7_0.try(arg_7_0.tp:check("3.."))
	arg_7_0.try(arg_7_0.tp:send(var_0_9.b64(arg_7_1) .. "\r\n"))
	arg_7_0.try(arg_7_0.tp:check("3.."))
	arg_7_0.try(arg_7_0.tp:send(var_0_9.b64(arg_7_2) .. "\r\n"))

	return arg_7_0.try(arg_7_0.tp:check("2.."))
end
;({
	__index = {}
}).__index.plain = function(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.try(arg_8_0.tp:command("AUTH", "PLAIN " .. var_0_9.b64("\x00" .. arg_8_1 .. "\x00" .. arg_8_2)))

	return arg_8_0.try(arg_8_0.tp:check("2.."))
end
;({
	__index = {}
}).__index.auth = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 or not arg_9_2 then
		return 1
	end

	if var_0_2.find(arg_9_3, "AUTH[^\n]+LOGIN") then
		return arg_9_0:login(arg_9_1, arg_9_2)
	elseif var_0_2.find(arg_9_3, "AUTH[^\n]+PLAIN") then
		return arg_9_0:plain(arg_9_1, arg_9_2)
	else
		arg_9_0.try(nil, "authentication not supported")
	end

	return
end
;({
	__index = {}
}).__index.send = function(arg_10_0, arg_10_1)
	arg_10_0:mail(arg_10_1.from)

	if var_0_0.type(arg_10_1.rcpt) == "table" then
		for iter_10_0, iter_10_1 in var_0_0.ipairs(arg_10_1.rcpt) do
			arg_10_0:rcpt(iter_10_1)
		end
	else
		arg_10_0:rcpt(arg_10_1.rcpt)
	end

	arg_10_0:data(var_0_7.source.chain(arg_10_1.source, var_0_9.stuff()), arg_10_1.step)

	return
end

function var_0_5.smtp.open(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_0.setmetatable({
		tp = var_0_5.try(var_0_6.connect(arg_11_0 or var_0_10.SERVER, arg_11_1 or var_0_10.PORT, var_0_10.TIMEOUT, arg_11_2))
	}, var_0_11)

	var_11_0.try = var_0_5.newtry(function()
		var_11_0:close()

		return
	end)

	return var_11_0
end

local function var_0_12(arg_13_0)
	for iter_13_0, iter_13_1 in var_0_0.pairs(arg_13_0 or {}) do
		({})[var_0_2.lower(iter_13_0)] = iter_13_1
	end

	return {}
end

local var_0_13 = 0

local function var_0_14()
	var_0_13 = var_0_13 + 1

	return var_0_2.format("%s%05d==%05u", var_0_4.date("%d%m%Y%H%M%S"), var_0_3.random(0, 31), var_0_13)
end

local var_0_15

local function var_0_16(arg_15_0)
	local var_15_0 = "\r\n"

	for iter_15_0, iter_15_1 in var_0_0.pairs(arg_15_0) do
		local var_15_1 = var_0_8.canonic[iter_15_0] or iter_15_0

		var_15_0 = var_15_1 .. ": " .. iter_15_1 .. "\r\n" .. var_15_0
	end

	var_0_1.yield(var_15_0)

	return
end

local function var_0_17(arg_16_0)
	local var_16_0 = var_0_14()
	local var_16_1 = arg_16_0.headers or {}
	local var_16_2 = var_0_12(var_16_1)

	var_16_2["content-type"] = var_16_2["content-type"] or "multipart/mixed"
	var_16_2["content-type"] = var_16_2["content-type"] .. "; boundary=\"" .. var_16_0 .. "\""

	var_0_16(var_16_2)

	if arg_16_0.body.preamble then
		var_0_1.yield(arg_16_0.body.preamble)
		var_0_1.yield("\r\n")
	end

	for iter_16_0, iter_16_1 in var_0_0.ipairs(arg_16_0.body) do
		var_0_1.yield("\r\n--" .. var_16_0 .. "\r\n")
		var_0_15(iter_16_1)
	end

	var_0_1.yield("\r\n--" .. var_16_0 .. "--\r\n\r\n")

	if arg_16_0.body.epilogue then
		var_0_1.yield(arg_16_0.body.epilogue)
		var_0_1.yield("\r\n")
	end

	return
end

local function var_0_18(arg_17_0)
	local var_17_0 = arg_17_0.headers or {}
	local var_17_1 = var_0_12(var_17_0)

	var_17_1["content-type"] = var_17_1["content-type"] or "text/plain; charset=\"iso-8859-1\""

	var_0_16(var_17_1)

	while true do
		local var_17_2, var_17_3 = arg_17_0.body()

		if var_17_3 then
			var_0_1.yield(nil, var_17_3)
		elseif var_17_2 then
			var_0_1.yield(var_17_2)
		else
			break
		end
	end

	return
end

local function var_0_19(arg_18_0)
	local var_18_0 = arg_18_0.headers or {}
	local var_18_1 = var_0_12(var_18_0)

	var_18_1["content-type"] = var_18_1["content-type"] or "text/plain; charset=\"iso-8859-1\""

	var_0_16(var_18_1)
	var_0_1.yield(arg_18_0.body)

	return
end

function var_0_15(arg_19_0)
	if var_0_0.type(arg_19_0.body) == "table" then
		var_0_17(arg_19_0)
	elseif var_0_0.type(arg_19_0.body) == "function" then
		var_0_18(arg_19_0)
	else
		var_0_19(arg_19_0)
	end

	return
end

local function var_0_20(arg_20_0)
	local var_20_0 = var_0_12(arg_20_0.headers)
	local var_20_1 = var_20_0.date

	if not var_20_0.date then
		local var_20_2 = arg_20_0.zone or var_0_10.ZONE

		var_20_1 = var_0_4.date("!%a, %d %b %Y %H:%M:%S ") .. var_20_2
	end

	var_20_0.date = var_20_1
	var_20_0["x-mailer"] = var_20_0["x-mailer"] or var_0_5._VERSION
	var_20_0["mime-version"] = "1.0"

	return var_20_0
end

function var_0_5.smtp.message(arg_21_0)
	arg_21_0.headers = var_0_20(arg_21_0)

	local var_21_0 = var_0_1.create(function()
		var_0_15(arg_21_0)

		return
	end)

	return function()
		local var_23_0, var_23_1, var_23_2 = var_0_1.resume(var_21_0)

		if var_23_0 then
			return var_23_1, var_23_2
		else
			return nil, var_23_1
		end

		return
	end
end

var_0_5.smtp.send = var_0_5.protect(function(arg_24_0)
	local var_24_0 = var_0_10.open(arg_24_0.server, arg_24_0.port, arg_24_0.create)

	var_24_0:auth(arg_24_0.user, arg_24_0.password, (var_24_0:greet(arg_24_0.domain)))
	var_24_0:send(arg_24_0)
	var_24_0:quit()

	return var_24_0:close()
end)

return var_0_5.smtp

local var_0_0 = _G
local coroutine = require("coroutine")
local string = require("string")
local math = require("math")
local os = require("os")
local socket = require("socket")
local tp = require("socket.tp")
local ltn12 = require("ltn12")
local headers = require("socket.headers")
local mime = require("mime")

socket.smtp = {}

local var_0_10 = socket.smtp

socket.smtp.TIMEOUT = 60
socket.smtp.SERVER = "localhost"
socket.smtp.PORT = 25
socket.smtp.DOMAIN = os.getenv("SERVER_NAME") or "localhost"
socket.smtp.ZONE = "-0000"

local var_0_11 = {
	__index = {}
}

function var_0_11.__index:greet(arg_1_1)
	self.try(self.tp:check("2.."))
	self.try(self.tp:command("EHLO", arg_1_1 or var_0_10.DOMAIN))

	return socket.skip(1, self.try(self.tp:check("2..")))
end

function var_0_11.__index:mail(arg_2_1)
	self.try(self.tp:command("MAIL", "FROM:" .. arg_2_1))

	return self.try(self.tp:check("2.."))
end

function var_0_11.__index:rcpt(arg_3_1)
	self.try(self.tp:command("RCPT", "TO:" .. arg_3_1))

	return self.try(self.tp:check("2.."))
end

function var_0_11.__index:data(arg_4_1, arg_4_2)
	self.try(self.tp:command("DATA"))
	self.try(self.tp:check("3.."))
	self.try(self.tp:source(arg_4_1, arg_4_2))
	self.try(self.tp:send("\r\n.\r\n"))

	return self.try(self.tp:check("2.."))
end

function var_0_11.__index:quit()
	self.try(self.tp:command("QUIT"))

	return self.try(self.tp:check("2.."))
end

function var_0_11.__index:close()
	return self.tp:close()
end

function var_0_11.__index:login(arg_7_1, arg_7_2)
	self.try(self.tp:command("AUTH", "LOGIN"))
	self.try(self.tp:check("3.."))
	self.try(self.tp:send(mime.b64(arg_7_1) .. "\r\n"))
	self.try(self.tp:check("3.."))
	self.try(self.tp:send(mime.b64(arg_7_2) .. "\r\n"))

	return self.try(self.tp:check("2.."))
end

function var_0_11.__index:plain(arg_8_1, arg_8_2)
	self.try(self.tp:command("AUTH", "PLAIN " .. mime.b64("\x00" .. arg_8_1 .. "\x00" .. arg_8_2)))

	return self.try(self.tp:check("2.."))
end

function var_0_11.__index:auth(arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1 or not arg_9_2 then
		return 1
	end

	if string.find(arg_9_3, "AUTH[^\n]+LOGIN") then
		return self:login(arg_9_1, arg_9_2)
	elseif string.find(arg_9_3, "AUTH[^\n]+PLAIN") then
		return self:plain(arg_9_1, arg_9_2)
	else
		self.try(nil, "authentication not supported")
	end

	return
end

function var_0_11.__index:send(arg_10_1)
	self:mail(arg_10_1.from)

	if var_0_0.type(arg_10_1.rcpt) == "table" then
		for iter_10_0, iter_10_1 in var_0_0.ipairs(arg_10_1.rcpt) do
			self:rcpt(iter_10_1)
		end
	else
		self:rcpt(arg_10_1.rcpt)
	end

	self:data(ltn12.source.chain(arg_10_1.source, mime.stuff()), arg_10_1.step)

	return
end

function socket.smtp.open(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_0.setmetatable({
		tp = socket.try(tp.connect(arg_11_0 or var_0_10.SERVER, arg_11_1 or var_0_10.PORT, var_0_10.TIMEOUT, arg_11_2))
	}, var_0_11)

	var_11_0.try = socket.newtry(function()
		var_11_0:close()

		return
	end)

	return var_11_0
end

local function var_0_12(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in var_0_0.pairs(arg_13_0 or var_13_0) do
		var_13_0[string.lower(iter_13_0)] = iter_13_1
	end

	return var_13_0
end

local var_0_13 = 0

local function var_0_14()
	var_0_13 = var_0_13 + 1

	return string.format("%s%05d==%05u", os.date("%d%m%Y%H%M%S"), math.random(0, 31), var_0_13)
end

local var_0_15

local function var_0_16(arg_15_0)
	local var_15_0 = "\r\n"

	for iter_15_0, iter_15_1 in var_0_0.pairs(arg_15_0) do
		var_15_0 = (headers.canonic[iter_15_0] or iter_15_0) .. ": " .. iter_15_1 .. "\r\n" .. var_15_0
	end

	coroutine.yield(var_15_0)

	return
end

local function var_0_17(arg_16_0)
	local var_16_0 = var_0_14()
	local var_16_1 = var_0_12(arg_16_0.headers or {})

	var_16_1["content-type"] = var_16_1["content-type"] or "multipart/mixed"
	var_16_1["content-type"] = var_16_1["content-type"] .. "; boundary=\"" .. var_16_0 .. "\""

	var_0_16(var_16_1)

	if arg_16_0.body.preamble then
		coroutine.yield(arg_16_0.body.preamble)
		coroutine.yield("\r\n")
	end

	for iter_16_0, iter_16_1 in var_0_0.ipairs(arg_16_0.body) do
		coroutine.yield("\r\n--" .. var_16_0 .. "\r\n")
		var_0_15(iter_16_1)
	end

	coroutine.yield("\r\n--" .. var_16_0 .. "--\r\n\r\n")

	if arg_16_0.body.epilogue then
		coroutine.yield(arg_16_0.body.epilogue)
		coroutine.yield("\r\n")
	end

	return
end

local function var_0_18(arg_17_0)
	local var_17_1 = var_0_12(arg_17_0.headers or {})

	var_17_1["content-type"] = var_17_1["content-type"] or "text/plain; charset=\"iso-8859-1\""

	var_0_16(var_17_1)

	while true do
		local var_17_2, var_17_3 = arg_17_0.body()

		if var_17_3 then
			coroutine.yield(nil, var_17_3)
		elseif var_17_2 then
			coroutine.yield(var_17_2)
		else
			break
		end
	end

	return
end

local function var_0_19(arg_18_0)
	local var_18_1 = var_0_12(arg_18_0.headers or {})

	var_18_1["content-type"] = var_18_1["content-type"] or "text/plain; charset=\"iso-8859-1\""

	var_0_16(var_18_1)
	coroutine.yield(arg_18_0.body)

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

	var_20_0.date = var_20_0.date or os.date("!%a, %d %b %Y %H:%M:%S ") .. (arg_20_0.zone or var_0_10.ZONE)
	var_20_0["x-mailer"] = var_20_0["x-mailer"] or socket._VERSION
	var_20_0["mime-version"] = "1.0"

	return var_20_0
end

function socket.smtp.message(arg_21_0)
	arg_21_0.headers = var_0_20(arg_21_0)

	local var_21_0 = coroutine.create(function()
		var_0_15(arg_21_0)

		return
	end)

	return function()
		local var_23_0, var_23_1, var_23_2 = coroutine.resume(var_21_0)

		if var_23_0 then
			return var_23_1, var_23_2
		else
			return nil, var_23_1
		end

		return
	end
end

socket.smtp.send = socket.protect(function(arg_24_0)
	local var_24_0 = var_0_10.open(arg_24_0.server, arg_24_0.port, arg_24_0.create)

	var_24_0:auth(arg_24_0.user, arg_24_0.password, (var_24_0:greet(arg_24_0.domain)))
	var_24_0:send(arg_24_0)
	var_24_0:quit()

	return var_24_0:close()
end)

return socket.smtp

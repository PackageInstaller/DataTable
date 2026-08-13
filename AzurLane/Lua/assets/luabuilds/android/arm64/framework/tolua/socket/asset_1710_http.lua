require = var_0_10000

local var_0_0 = var_0_10000("socket")

require = var_0_10001

local var_0_1 = var_0_10001("socket.url")

require = var_2

local var_0_2 = var_2("ltn12")

require = var_3

local var_0_3 = var_3("mime")

require = var_4

local var_0_4 = var_4("string")

require = var_5

local var_0_5 = var_5("socket.headers")

_G = var_6
require = var_7

local var_0_6 = var_7("table")

var_0_0.http = {}

local var_0_7 = var_0_0.http

var_0_7.TIMEOUT = 60
var_0_7.USERAGENT = var_0_0._VERSION

local var_0_8 = {
	http = true
}
local var_0_9 = 80

local function var_0_10(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1
	local var_1_2
	local var_1_3

	arg_1_1 = arg_1_1 or {}

	local var_1_4, var_1_5 = arg_1_0:receive()

	if var_1_5 then
		return nil, var_1_5
	end

	while var_1_4 ~= "" do
		local var_1_6, var_1_7 = var_0_0.skip(2, var_0_4.find(var_1_4, "^(.-):%s*(.*)"))
		local var_1_8 = var_1_7

		if not var_1_6 or not var_1_8 then
			return nil, "malformed reponse headers"
		end

		local var_1_9 = var_0_4.lower(var_3)
		local var_1_10

		var_1_4, var_1_10 = arg_1_0:receive()

		if var_1_10 then
			return nil, var_1_10
		end

		while var_0_4.find(var_1_4, "^%s") do
			var_1_8 = var_1_8 .. var_1_4
			var_1_4 = arg_1_0:receive()

			if var_1_10 then
				return nil, var_1_10
			end
		end

		if arg_1_1[var_1_9] then
			arg_1_1[var_1_9] = arg_1_1[var_1_9] .. ", " .. var_1_8
		else
			arg_1_1[var_1_9] = var_1_8
		end
	end

	return arg_1_1
end

var_0_0.sourcet["http-chunked"] = function(arg_2_0, arg_2_1)
	return var_0.setmetatable({
		getfd = function()
			local var_3_0 = arg_2_0

			return var_0.getfd(var_3_0)
		end,
		dirty = function()
			local var_4_0 = arg_2_0

			return var_0.dirty(var_4_0)
		end
	}, {
		__call = function()
			local var_5_0 = arg_2_0
			local var_5_1, var_5_2 = var_0.receive(var_5_0)

			if var_5_2 then
				return nil, var_5_2
			end

			if not var_0.tonumber(var_0_4.gsub(var_5_1, ";.*", ""), 16) then
				return nil, "invalid chunk size"
			end

			if var_2 > 0 then
				local var_5_3 = arg_2_0
				local var_5_4, var_5_5, var_5_6 = var_3.receive(var_5_3, var_2)

				if var_5_4 then
					local var_5_7 = arg_2_0

					var_6.receive(var_5_7)
				end

				return var_5_4, var_5_5
			else
				local var_5_8

				arg_2_1, var_5_8 = var_0_10(arg_2_0, arg_2_1)

				if not arg_2_1 then
					return nil, var_5_8
				end
			end

			return
		end
	})
end
var_0_0.sinkt["http-chunked"] = function(arg_6_0)
	return var_0.setmetatable({
		getfd = function()
			local var_7_0 = arg_6_0

			return var_0.getfd(var_7_0)
		end,
		dirty = function()
			local var_8_0 = arg_6_0

			return var_0.dirty(var_8_0)
		end
	}, {
		__call = function(arg_9_0, arg_9_1, arg_9_2)
			if not arg_9_1 then
				local var_9_0 = arg_6_0

				return var_3.send(var_9_0, "0\r\n\r\n")
			end

			local var_9_1 = var_0_4.format("%X\r\n", var_0_4.len(arg_9_1))
			local var_9_2 = arg_6_0

			return var_4.send(var_9_2, var_9_1 .. arg_9_1 .. "\r\n")
		end
	})
end

local var_0_11 = {
	__index = {}
}

function var_0_7.open(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_0.try((arg_10_2 or var_0_0.tcp)())
	local var_10_1 = var_0.setmetatable({
		c = var_10_0
	}, var_0_11)

	var_10_1.try = var_0_0.newtry(function()
		local var_11_0 = var_10_1

		var_0.close(var_11_0)

		return
	end)

	var_10_1.try(var_10_0:settimeout(var_0_7.TIMEOUT))
	var_10_1.try(var_10_0:connect(arg_10_0, arg_10_1 or var_0_9))

	return var_10_1
end

function var_0_11.__index.sendrequestline(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = var_0_4.format("%s %s HTTP/1.1\r\n", arg_12_1 or "GET", arg_12_2)
	local var_12_1 = arg_12_0.try
	local var_12_2 = arg_12_0.c

	return var_12_1(var_6.send(var_12_2, var_12_0))
end

function var_0_11.__index.sendheaders(arg_13_0, arg_13_1)
	local var_13_0 = var_0_5.canonic
	local var_13_1 = "\r\n"

	for iter_13_0, iter_13_1 in var_0.pairs(arg_13_1) do
		local var_13_2

		if not var_13_0[iter_13_0] then
			var_13_2 = iter_13_0
		end

		var_13_1 = var_13_2 .. ": " .. iter_13_1 .. "\r\n" .. var_13_1
	end

	local var_13_3 = arg_13_0.try
	local var_13_4 = arg_13_0.c

	var_13_3(var_6.send(var_13_4, var_13_1))

	return 1
end

function var_0_11.__index.sendbody(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_2 = arg_14_2 or var_0_2.source.empty()
	arg_14_3 = arg_14_3 or var_0_2.pump.step

	local var_14_0 = "http-chunked"

	if arg_14_1["content-length"] then
		var_14_0 = "keep-open"
	end

	return arg_14_0.try(var_0_2.pump.all(arg_14_2, var_0_0.sink(var_14_0, arg_14_0.c), arg_14_3))
end

function var_0_11.__index.receivestatusline(arg_15_0)
	local var_15_0 = arg_15_0.try
	local var_15_1 = arg_15_0.c

	if var_15_0(var_3.receive(var_15_1, 5)) ~= "HTTP/" then
		return nil, var_1
	end

	local var_15_2 = arg_15_0.try
	local var_15_3 = arg_15_0.c
	local var_15_4 = var_15_2(var_4.receive(var_15_3, "*l", var_1))
	local var_15_5 = var_0_0.skip(2, var_0_4.find(var_15_4, "HTTP/%d*%.%d* (%d%d%d)"))

	return arg_15_0.try(var_0.tonumber(var_15_5), var_15_4)
end

function var_0_11.__index.receiveheaders(arg_16_0)
	return arg_16_0.try(var_0_10(arg_16_0.c))
end

function var_0_11.__index.receivebody(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_2 = arg_17_2 or var_0_2.sink.null()
	arg_17_3 = arg_17_3 or var_0_2.pump.step

	local var_17_0 = var_0.tonumber(arg_17_1["content-length"])
	local var_17_1 = arg_17_1["transfer-encoding"]
	local var_17_2 = "default"

	if var_17_1 and var_17_1 ~= "identity" then
		var_17_2 = "http-chunked"
	elseif var_0.tonumber(arg_17_1["content-length"]) then
		var_17_2 = "by-length"
	end

	return arg_17_0.try(var_0_2.pump.all(var_0_0.source(var_17_2, arg_17_0.c, var_17_0), arg_17_2, arg_17_3))
end

function var_0_11.__index.receive09body(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	var_0_2.source.rewind(var_0_0.source("until-closed", arg_18_0.c))(arg_18_1)

	return arg_18_0.try(var_0_2.pump.all(var_4, arg_18_2, arg_18_3))
end

function var_0_11.__index.close(arg_19_0)
	local var_19_0 = arg_19_0.c

	return var_1.close(var_19_0)
end

local function var_0_12(arg_20_0)
	local var_20_0 = arg_20_0

	if not arg_20_0.proxy and not var_0_7.PROXY then
		var_20_0 = {
			path = var_0_0.try(arg_20_0.path, "invalid path 'nil'"),
			params = arg_20_0.params,
			query = arg_20_0.query,
			fragment = arg_20_0.fragment
		}
	end

	return var_0_1.build(var_20_0)
end

local function var_0_13(arg_21_0)
	local var_21_0

	if not arg_21_0.proxy then
		var_21_0 = var_0_7.PROXY
	end

	if var_21_0 then
		local var_21_1 = var_0_1.parse(var_21_0).host
		local var_21_2

		if not var_1.port then
			var_21_2 = 3128
		end

		return var_21_1, var_21_2
	else
		return arg_21_0.host, arg_21_0.port
	end

	return
end

local function var_0_14(arg_22_0)
	local var_22_0 = var_0_4.gsub(arg_22_0.authority, "^.-@", "")
	local var_22_1 = {
		te = "trailers",
		connection = "close, TE",
		["user-agent"] = var_0_7.USERAGENT,
		host = var_22_0
	}

	if arg_22_0.user and arg_22_0.password then
		var_22_1.authorization = "Basic " .. var_0_3.b64(arg_22_0.user .. ":" .. arg_22_0.password)
	end

	local var_22_2

	if not arg_22_0.proxy then
		var_22_2 = var_0_7.PROXY
	end

	if var_22_2 and var_0_1.parse(var_22_2).user and var_3.password then
		var_22_1["proxy-authorization"] = "Basic " .. var_0_3.b64(var_3.user .. ":" .. var_3.password)
	end

	local var_22_3 = var_0.pairs
	local var_22_4

	if not arg_22_0.headers then
		var_22_4 = var_22_1
	end

	for iter_22_0, iter_22_1 in var_22_3(var_22_4) do
		var_22_1[var_0_4.lower(iter_22_0)] = iter_22_1
	end

	return var_22_1
end

local var_0_15 = {
	scheme = "http",
	path = "/",
	host = "",
	port = var_0_9
}

local function var_0_16(arg_23_0)
	local var_23_0

	if not arg_23_0.url or not var_0_1.parse(arg_23_0.url, var_0_15) then
		var_23_0 = {}
	end

	for iter_23_0, iter_23_1 in var_0.pairs(arg_23_0) do
		var_23_0[iter_23_0] = iter_23_1
	end

	if var_23_0.port == "" then
		var_23_0.port = var_0_9
	end

	if not var_23_0.host or var_23_0.host == "" then
		var_0_0.try(nil, "invalid host '" .. var_0.tostring(var_23_0.host) .. "'")
	end

	local var_23_1

	if not arg_23_0.uri then
		var_23_1 = var_0_12(var_23_0)
	end

	var_23_0.uri = var_23_1
	var_23_0.headers = var_0_14(var_23_0)
	var_23_0.host, var_23_0.port = var_0_13(var_23_0)

	return var_23_0
end

local function var_0_17(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_2.location then
		return false
	end

	if var_0_4.gsub(var_3, "%s", "") == "" then
		return false
	end

	if var_0_4.match(var_3, "^([%w][%w%+%-%.]*)%:") and not var_0_8[var_4] then
		return false
	end

	return arg_24_0.redirect ~= false and (arg_24_1 == 301 or arg_24_1 == 302 or arg_24_1 == 303 or arg_24_1 == 307) and (not arg_24_0.method or arg_24_0.method == "GET" or arg_24_0.method == "HEAD") and (not arg_24_0.nredirects or arg_24_0.nredirects < 5)
end

local function var_0_18(arg_25_0, arg_25_1)
	if arg_25_0.method == "HEAD" then
		return nil
	end

	if arg_25_1 == 204 or arg_25_1 == 304 then
		return nil
	end

	if arg_25_1 >= 100 and arg_25_1 < 200 then
		return nil
	end

	return 1
end

local var_0_19
local var_0_20

local function var_0_21(arg_26_0, arg_26_1)
	local var_26_0 = var_0_19
	local var_26_1 = {
		url = var_0_1.absolute(arg_26_0.url, arg_26_1),
		source = arg_26_0.source,
		sink = arg_26_0.sink,
		headers = arg_26_0.headers,
		proxy = arg_26_0.proxy
	}
	local var_26_2

	if not arg_26_0.nredirects then
		var_26_2 = 0
	end

	var_26_1.nredirects = var_26_2 + 1
	var_26_1.create = arg_26_0.create

	local var_26_3, var_26_4, var_26_5, var_26_6 = var_26_0(var_26_1)

	var_26_5 = var_26_5 or {}

	local var_26_7

	if not var_26_5.location then
		var_26_7 = arg_26_1
	end

	var_26_5.location = var_26_7

	return var_26_3, var_26_4, var_26_5, var_26_6
end

function var_0_19(arg_27_0)
	local var_27_0 = var_0_16(arg_27_0)
	local var_27_1 = var_0_7.open(var_27_0.host, var_27_0.port, var_27_0.create)

	var_2.sendrequestline(var_27_1, var_27_0.method, var_27_0.uri)
	var_2:sendheaders(var_27_0.headers)

	if var_27_0.source then
		var_2:sendbody(var_27_0.headers, var_27_0.source, var_27_0.step)
	end

	local var_27_2, var_27_3 = var_2:receivestatusline()

	if not var_27_2 then
		var_2:receive09body(var_27_3, var_27_0.sink, var_27_0.step)

		return 1, 200
	end

	local var_27_4

	while var_27_2 == 100 do
		local var_27_5 = var_2:receiveheaders()

		var_27_2, var_27_3 = var_2:receivestatusline()
	end

	local var_27_6 = var_2:receiveheaders()

	if var_0_17(var_27_0, var_27_2, var_27_6) and not var_27_0.source then
		var_2:close()

		return var_0_21(arg_27_0, var_27_6.location)
	end

	if var_0_18(var_27_0, var_27_2) then
		var_2:receivebody(var_27_6, var_27_0.sink, var_27_0.step)
	end

	var_2:close()

	return 1, var_27_2, var_27_6, var_27_3
end

function var_0_7.genericform(arg_28_0, arg_28_1)
	local var_28_0 = {}
	local var_28_1 = {
		url = arg_28_0,
		sink = var_0_2.sink.table(var_28_0),
		target = var_28_0
	}

	if arg_28_1 then
		var_28_1.source = var_0_2.source.string(arg_28_1)
		var_28_1.headers = {
			["content-type"] = "application/x-www-form-urlencoded",
			["content-length"] = var_0_4.len(arg_28_1)
		}
		var_28_1.method = "POST"
	end

	return var_28_1
end

local function var_0_22(arg_29_0, arg_29_1)
	local var_29_0 = var_0(arg_29_0, arg_29_1)
	local var_29_1, var_29_2, var_29_3, var_29_4 = var_0_19(var_29_0)

	return var_0_6.concat(var_29_0.target), var_29_2, var_29_3, var_29_4
end

var_0_7.request = var_0_0.protect(function(arg_30_0, arg_30_1)
	if var_0.type(arg_30_0) == "string" then
		return var_0_22(arg_30_0, arg_30_1)
	else
		return var_0_19(arg_30_0)
	end

	return
end)

return var_0_7

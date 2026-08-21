local var_0_0 = require("socket")
local var_0_1 = require("socket.url")
local var_0_2 = require("ltn12")
local var_0_3 = require("mime")
local var_0_4 = require("string")
local var_0_5 = require("socket.headers")
local var_0_6 = _G
local var_0_7 = require("table")

var_0_0.http = {}

local var_0_8 = var_0_0.http

var_0_0.http.TIMEOUT = 60
var_0_0.http.USERAGENT = var_0_0._VERSION

local var_0_9 = {
	http = true
}
local var_0_10 = 80

local function var_0_11(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or {}

	local var_1_4, var_1_5 = arg_1_0:receive()

	if var_1_5 then
		return nil, var_1_5
	end

	while var_1_4 ~= "" do
		local var_1_6, var_1_7 = var_0_0.skip(2, var_0_4.find(var_1_4, "^(.-):%s*(.*)"))

		if not var_1_6 or not var_1_7 then
			return nil, "malformed reponse headers"
		end

		local var_1_8 = var_0_4.lower(var_1_6)
		local var_1_9

		var_1_4, var_1_9 = arg_1_0:receive()

		if var_1_9 then
			return nil, var_1_9
		end

		while var_0_4.find(var_1_4, "^%s") do
			var_1_7 = var_1_7 .. var_1_4
			var_1_4 = arg_1_0:receive()

			if var_1_9 then
				return nil, var_1_9
			end
		end

		arg_1_1[var_1_8] = arg_1_1[var_1_8] and arg_1_1[var_1_8] .. ", " .. var_1_7 or var_1_7
	end

	return arg_1_1
end

var_0_0.sourcet["http-chunked"] = function(arg_2_0, arg_2_1)
	return var_0_6.setmetatable({
		getfd = function()
			return arg_2_0:getfd()
		end,
		dirty = function()
			return arg_2_0:dirty()
		end
	}, {
		__call = function()
			local var_5_0, var_5_1 = arg_2_0:receive()

			if var_5_1 then
				return nil, var_5_1
			end

			local var_5_2 = var_0_6.tonumber(var_0_4.gsub(var_5_0, ";.*", ""), 16)

			if not var_5_2 then
				return nil, "invalid chunk size"
			end

			if var_5_2 > 0 then
				local var_5_3, var_5_4, var_5_5 = arg_2_0:receive(var_5_2)

				if var_5_3 then
					arg_2_0:receive()
				end

				return var_5_3, var_5_4
			else
				local var_5_6

				arg_2_1, var_5_6 = var_0_11(arg_2_0, arg_2_1)

				if not arg_2_1 then
					return nil, var_5_6
				end
			end

			return
		end
	})
end
var_0_0.sinkt["http-chunked"] = function(arg_6_0)
	return var_0_6.setmetatable({
		getfd = function()
			return arg_6_0:getfd()
		end,
		dirty = function()
			return arg_6_0:dirty()
		end
	}, {
		__call = function(arg_9_0, arg_9_1, arg_9_2)
			if not arg_9_1 then
				return arg_6_0:send("0\r\n\r\n")
			end

			return arg_6_0:send(var_0_4.format("%X\r\n", var_0_4.len(arg_9_1)) .. arg_9_1 .. "\r\n")
		end
	})
end

local var_0_12 = {
	__index = {}
}

function var_0_0.http.open(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = var_0_0.try((arg_10_2 or var_0_0.tcp)())
	local var_10_1 = var_0_6.setmetatable({
		c = var_10_0
	}, var_0_12)

	var_10_1.try = var_0_0.newtry(function()
		var_10_1:close()

		return
	end)

	var_10_1.try(var_10_0:settimeout(var_0_8.TIMEOUT))
	var_10_1.try(var_10_0:connect(arg_10_0, arg_10_1 or var_0_10))

	return var_10_1
end

;({
	__index = {}
}).__index.sendrequestline = function(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0.try(arg_12_0.c:send((var_0_4.format("%s %s HTTP/1.1\r\n", arg_12_1 or "GET", arg_12_2))))
end
;({
	__index = {}
}).__index.sendheaders = function(arg_13_0, arg_13_1)
	local var_13_0 = "\r\n"

	for iter_13_0, iter_13_1 in var_0_6.pairs(arg_13_1) do
		local var_13_1 = var_0_5.canonic[iter_13_0] or iter_13_0

		var_13_0 = var_13_1 .. ": " .. iter_13_1 .. "\r\n" .. var_13_0
	end

	arg_13_0.try(arg_13_0.c:send(var_13_0))

	return 1
end
;({
	__index = {}
}).__index.sendbody = function(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_2 = arg_14_2 or var_0_2.source.empty()
	arg_14_3 = arg_14_3 or var_0_2.pump.step

	local var_14_0 = "http-chunked"

	if arg_14_1["content-length"] then
		var_14_0 = "keep-open"
	end

	return arg_14_0.try(var_0_2.pump.all(arg_14_2, var_0_0.sink(var_14_0, arg_14_0.c), arg_14_3))
end
;({
	__index = {}
}).__index.receivestatusline = function(arg_15_0)
	local var_15_0 = arg_15_0.try(arg_15_0.c:receive(5))

	if var_15_0 ~= "HTTP/" then
		return nil, var_15_0
	end

	local var_15_1 = arg_15_0.try(arg_15_0.c:receive("*l", var_15_0))

	return arg_15_0.try(var_0_6.tonumber((var_0_0.skip(2, var_0_4.find(var_15_1, "HTTP/%d*%.%d* (%d%d%d)")))), var_15_1)
end
;({
	__index = {}
}).__index.receiveheaders = function(arg_16_0)
	return arg_16_0.try(var_0_11(arg_16_0.c))
end
;({
	__index = {}
}).__index.receivebody = function(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_2 = arg_17_2 or var_0_2.sink.null()
	arg_17_3 = arg_17_3 or var_0_2.pump.step

	local var_17_0 = var_0_6.tonumber(arg_17_1["content-length"])
	local var_17_1 = "default"

	if arg_17_1["transfer-encoding"] and arg_17_1["transfer-encoding"] ~= "identity" then
		var_17_1 = "http-chunked"
	elseif var_0_6.tonumber(arg_17_1["content-length"]) then
		var_17_1 = "by-length"
	end

	return arg_17_0.try(var_0_2.pump.all(var_0_0.source(var_17_1, arg_17_0.c, var_17_0), arg_17_2, arg_17_3))
end
;({
	__index = {}
}).__index.receive09body = function(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = var_0_2.source.rewind(var_0_0.source("until-closed", arg_18_0.c))

	var_18_0(arg_18_1)

	return arg_18_0.try(var_0_2.pump.all(var_18_0, arg_18_2, arg_18_3))
end
;({
	__index = {}
}).__index.close = function(arg_19_0)
	return arg_19_0.c:close()
end

local function var_0_13(arg_20_0)
	local var_20_0 = arg_20_0

	if not arg_20_0.proxy and not var_0_8.PROXY then
		var_20_0 = {
			path = var_0_0.try(arg_20_0.path, "invalid path 'nil'"),
			params = arg_20_0.params,
			query = arg_20_0.query,
			fragment = arg_20_0.fragment
		}
	end

	return var_0_1.build(var_20_0)
end

local function var_0_14(arg_21_0)
	local var_21_0 = arg_21_0.proxy or var_0_8.PROXY

	if var_21_0 then
		local var_21_1 = var_0_1.parse(var_21_0)
		local var_21_2 = var_21_1.port or 3128

		return var_21_1.host, var_21_2
	else
		return arg_21_0.host, arg_21_0.port
	end

	return
end

local function var_0_15(arg_22_0)
	local var_22_0 = {
		te = "trailers",
		connection = "close, TE",
		["user-agent"] = var_0_8.USERAGENT,
		host = var_0_4.gsub(arg_22_0.authority, "^.-@", "")
	}

	if arg_22_0.user and arg_22_0.password then
		var_22_0.authorization = "Basic " .. var_0_3.b64(arg_22_0.user .. ":" .. arg_22_0.password)
	end

	local var_22_1 = arg_22_0.proxy or var_0_8.PROXY

	if var_22_1 then
		local var_22_2 = var_0_1.parse(var_22_1)

		if var_22_2.user and var_22_2.password then
			var_22_0["proxy-authorization"] = "Basic " .. var_0_3.b64(var_22_2.user .. ":" .. var_22_2.password)
		end
	end

	local var_22_4 = arg_22_0.headers or var_22_0

	for iter_22_0, iter_22_1 in var_22_3(var_22_4) do
		var_22_0[var_0_4.lower(iter_22_0)] = iter_22_1
	end

	return var_22_0
end

local var_0_16 = {
	scheme = "http",
	path = "/",
	host = "",
	port = 80
}

local function var_0_17(arg_23_0)
	local var_23_0 = arg_23_0.url and var_0_1.parse(arg_23_0.url, var_0_16) or {}

	for iter_23_0, iter_23_1 in var_0_6.pairs(arg_23_0) do
		var_23_0[iter_23_0] = iter_23_1
	end

	if var_23_0.port == "" then
		var_23_0.port = var_0_10
	end

	if not var_23_0.host or var_23_0.host == "" then
		var_0_0.try(nil, "invalid host '" .. var_0_6.tostring(var_23_0.host) .. "'")
	end

	var_23_0.uri = arg_23_0.uri or var_0_13(var_23_0)
	var_23_0.headers = var_0_15(var_23_0)
	var_23_0.host, var_23_0.port = var_0_14(var_23_0)

	return var_23_0
end

local function var_0_18(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_2.location then
		return false
	end

	local var_24_0 = var_0_4.gsub(arg_24_2.location, "%s", "")

	if var_24_0 == "" then
		return false
	end

	local var_24_1 = var_0_4.match(var_24_0, "^([%w][%w%+%-%.]*)%:")

	if var_24_1 and not var_0_9[var_24_1] then
		return false
	end

	return arg_24_0.redirect ~= false and (arg_24_1 == 301 or arg_24_1 == 302 or arg_24_1 == 303 or arg_24_1 == 307) and (not arg_24_0.method or arg_24_0.method == "GET" or arg_24_0.method == "HEAD") and (not arg_24_0.nredirects or arg_24_0.nredirects < 5)
end

local function var_0_19(arg_25_0, arg_25_1)
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

local var_0_20

function var_0_20(arg_27_0)
	local var_27_0 = var_0_17(arg_27_0)
	local var_27_1 = var_0_8.open(var_27_0.host, var_27_0.port, var_27_0.create)

	var_27_1:sendrequestline(var_27_0.method, var_27_0.uri)
	var_27_1:sendheaders(var_27_0.headers)

	if var_27_0.source then
		var_27_1:sendbody(var_27_0.headers, var_27_0.source, var_27_0.step)
	end

	local var_27_2, var_27_3 = var_27_1:receivestatusline()

	if not var_27_2 then
		var_27_1:receive09body(var_27_3, var_27_0.sink, var_27_0.step)

		return 1, 200
	end

	while var_27_2 == 100 do
		local var_27_5 = var_27_1:receiveheaders()

		var_27_2, var_27_3 = var_27_1:receivestatusline()
	end

	local var_27_6 = var_27_1:receiveheaders()

	if var_0_18(var_27_0, var_27_2, var_27_6) and not var_27_0.source then
		var_27_1:close()

		return var_0_21(arg_27_0, var_27_6.location)
	end

	if var_0_19(var_27_0, var_27_2) then
		var_27_1:receivebody(var_27_6, var_27_0.sink, var_27_0.step)
	end

	var_27_1:close()

	return 1, var_27_2, var_27_6, var_27_3
end

function var_0_0.http.genericform(arg_28_0, arg_28_1)
	local var_28_0 = {
		url = arg_28_0,
		sink = var_0_2.sink.table({}),
		target = {}
	}

	if arg_28_1 then
		var_28_0.source = var_0_2.source.string(arg_28_1)
		var_28_0.headers = {
			["content-type"] = "application/x-www-form-urlencoded",
			["content-length"] = var_0_4.len(arg_28_1)
		}
		var_28_0.method = "POST"
	end

	return var_28_0
end

local function var_0_23(arg_29_0, arg_29_1)
	local var_29_0 = var_0(arg_29_0, arg_29_1)
	local var_29_1, var_29_2, var_29_3, var_29_4 = var_0_20(var_29_0)

	return var_0_7.concat(var_29_0.target), var_29_2, var_29_3, var_29_4
end

var_0_0.http.request = var_0_0.protect(function(arg_30_0, arg_30_1)
	if var_0_6.type(arg_30_0) == "string" then
		return var_0_23(arg_30_0, arg_30_1)
	else
		return var_0_20(arg_30_0)
	end

	return
end)

return var_0_0.http

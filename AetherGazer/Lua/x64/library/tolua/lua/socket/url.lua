local var_0_0 = require("string")
local var_0_1 = _G
local var_0_2 = require("table")
local var_0_3 = require("socket")

var_0_3.url = {}

local var_0_4 = var_0_3.url

var_0_4._VERSION = "URL 1.0.3"

function var_0_4.escape(arg_1_0)
	return (var_0_0.gsub(arg_1_0, "([^A-Za-z0-9_])", function(arg_2_0)
		return var_0_0.format("%%%02x", var_0_0.byte(arg_2_0))
	end))
end

local var_0_5 = (function(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs(arg_3_0) do
		var_3_0[arg_3_0[iter_3_0]] = 1
	end

	return var_3_0
end)({
	"-",
	"_",
	".",
	"!",
	"~",
	"*",
	"'",
	"(",
	")",
	":",
	"@",
	"&",
	"=",
	"+",
	"$",
	","
})

local function var_0_6(arg_4_0)
	return var_0_0.gsub(arg_4_0, "([^A-Za-z0-9_])", function(arg_5_0)
		if var_0_5[arg_5_0] then
			return arg_5_0
		else
			return var_0_0.format("%%%02x", var_0_0.byte(arg_5_0))
		end
	end)
end

function var_0_4.unescape(arg_6_0)
	return (var_0_0.gsub(arg_6_0, "%%(%x%x)", function(arg_7_0)
		return var_0_0.char(var_0_1.tonumber(arg_7_0, 16))
	end))
end

local function var_0_7(arg_8_0, arg_8_1)
	if var_0_0.sub(arg_8_1, 1, 1) == "/" then
		return arg_8_1
	end

	local var_8_0 = var_0_0.gsub(arg_8_0, "[^/]*$", "") .. arg_8_1
	local var_8_1 = var_0_0.gsub(var_8_0, "([^/]*%./)", function(arg_9_0)
		if arg_9_0 ~= "./" then
			return arg_9_0
		else
			return ""
		end
	end)
	local var_8_2 = var_0_0.gsub(var_8_1, "/%.$", "/")
	local var_8_3

	while var_8_3 ~= var_8_2 do
		var_8_3 = var_8_2
		var_8_2 = var_0_0.gsub(var_8_3, "([^/]*/%.%./)", function(arg_10_0)
			if arg_10_0 ~= "../../" then
				return ""
			else
				return arg_10_0
			end
		end)
	end

	return (var_0_0.gsub(var_8_3, "([^/]*/%.%.)$", function(arg_11_0)
		if arg_11_0 ~= "../.." then
			return ""
		else
			return arg_11_0
		end
	end))
end

function var_0_4.parse(arg_12_0, arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in var_0_1.pairs(arg_12_1 or var_12_0) do
		var_12_0[iter_12_0] = iter_12_1
	end

	if not arg_12_0 or arg_12_0 == "" then
		return nil, "invalid url"
	end

	arg_12_0 = var_0_0.gsub(arg_12_0, "#(.*)$", function(arg_13_0)
		var_12_0.fragment = arg_13_0

		return ""
	end)
	arg_12_0 = var_0_0.gsub(arg_12_0, "^([%w][%w%+%-%.]*)%:", function(arg_14_0)
		var_12_0.scheme = arg_14_0

		return ""
	end)
	arg_12_0 = var_0_0.gsub(arg_12_0, "^//([^/]*)", function(arg_15_0)
		var_12_0.authority = arg_15_0

		return ""
	end)
	arg_12_0 = var_0_0.gsub(arg_12_0, "%?(.*)", function(arg_16_0)
		var_12_0.query = arg_16_0

		return ""
	end)
	arg_12_0 = var_0_0.gsub(arg_12_0, "%;(.*)", function(arg_17_0)
		var_12_0.params = arg_17_0

		return ""
	end)

	if arg_12_0 ~= "" then
		var_12_0.path = arg_12_0
	end

	local var_12_1 = var_12_0.authority

	if not var_12_1 then
		return var_12_0
	end

	local var_12_2 = var_0_0.gsub(var_12_1, "^([^@]*)@", function(arg_18_0)
		var_12_0.userinfo = arg_18_0

		return ""
	end)
	local var_12_3 = var_0_0.gsub(var_12_2, ":([^:%]]*)$", function(arg_19_0)
		var_12_0.port = arg_19_0

		return ""
	end)

	if var_12_3 ~= "" then
		var_12_0.host = var_0_0.match(var_12_3, "^%[(.+)%]$") or var_12_3
	end

	local var_12_4 = var_12_0.userinfo

	if not var_12_4 then
		return var_12_0
	end

	var_12_0.user = var_0_0.gsub(var_12_4, ":([^:]*)$", function(arg_20_0)
		var_12_0.password = arg_20_0

		return ""
	end)

	return var_12_0
end

function var_0_4.build(arg_21_0)
	local var_21_0 = var_0_4.parse_path(arg_21_0.path or "")
	local var_21_1 = var_0_4.build_path(var_21_0)

	if arg_21_0.params then
		var_21_1 = var_21_1 .. ";" .. arg_21_0.params
	end

	if arg_21_0.query then
		var_21_1 = var_21_1 .. "?" .. arg_21_0.query
	end

	local var_21_2 = arg_21_0.authority

	if arg_21_0.host then
		var_21_2 = arg_21_0.host

		if var_0_0.find(var_21_2, ":") then
			var_21_2 = "[" .. var_21_2 .. "]"
		end

		if arg_21_0.port then
			var_21_2 = var_21_2 .. ":" .. arg_21_0.port
		end

		local var_21_3 = arg_21_0.userinfo

		if arg_21_0.user then
			var_21_3 = arg_21_0.user

			if arg_21_0.password then
				var_21_3 = var_21_3 .. ":" .. arg_21_0.password
			end
		end

		if var_21_3 then
			var_21_2 = var_21_3 .. "@" .. var_21_2
		end
	end

	if var_21_2 then
		var_21_1 = "//" .. var_21_2 .. var_21_1
	end

	if arg_21_0.scheme then
		var_21_1 = arg_21_0.scheme .. ":" .. var_21_1
	end

	if arg_21_0.fragment then
		var_21_1 = var_21_1 .. "#" .. arg_21_0.fragment
	end

	return var_21_1
end

function var_0_4.absolute(arg_22_0, arg_22_1)
	local var_22_0

	if var_0_1.type(arg_22_0) == "table" then
		var_22_0 = arg_22_0
		arg_22_0 = var_0_4.build(var_22_0)
	else
		var_22_0 = var_0_4.parse(arg_22_0)
	end

	local var_22_1 = var_0_4.parse(arg_22_1)

	if not var_22_0 then
		return arg_22_1
	elseif not var_22_1 then
		return arg_22_0
	elseif var_22_1.scheme then
		return arg_22_1
	else
		var_22_1.scheme = var_22_0.scheme

		if not var_22_1.authority then
			var_22_1.authority = var_22_0.authority

			if not var_22_1.path then
				var_22_1.path = var_22_0.path

				if not var_22_1.params then
					var_22_1.params = var_22_0.params

					if not var_22_1.query then
						var_22_1.query = var_22_0.query
					end
				end
			else
				var_22_1.path = var_0_7(var_22_0.path or "", var_22_1.path)
			end
		end

		return var_0_4.build(var_22_1)
	end
end

function var_0_4.parse_path(arg_23_0)
	local var_23_0 = {}

	arg_23_0 = arg_23_0 or ""

	var_0_0.gsub(arg_23_0, "([^/]+)", function(arg_24_0)
		var_0_2.insert(var_23_0, arg_24_0)
	end)

	for iter_23_0 = 1, #var_23_0 do
		var_23_0[iter_23_0] = var_0_4.unescape(var_23_0[iter_23_0])
	end

	if var_0_0.sub(arg_23_0, 1, 1) == "/" then
		var_23_0.is_absolute = 1
	end

	if var_0_0.sub(arg_23_0, -1, -1) == "/" then
		var_23_0.is_directory = 1
	end

	return var_23_0
end

function var_0_4.build_path(arg_25_0, arg_25_1)
	local var_25_0 = ""
	local var_25_1 = #arg_25_0

	if arg_25_1 then
		for iter_25_0 = 1, var_25_1 - 1 do
			var_25_0 = var_25_0 .. arg_25_0[iter_25_0]
			var_25_0 = var_25_0 .. "/"
		end

		if var_25_1 > 0 then
			var_25_0 = var_25_0 .. arg_25_0[var_25_1]

			if arg_25_0.is_directory then
				var_25_0 = var_25_0 .. "/"
			end
		end
	else
		for iter_25_1 = 1, var_25_1 - 1 do
			var_25_0 = var_25_0 .. var_0_6(arg_25_0[iter_25_1])
			var_25_0 = var_25_0 .. "/"
		end

		if var_25_1 > 0 then
			var_25_0 = var_25_0 .. var_0_6(arg_25_0[var_25_1])

			if arg_25_0.is_directory then
				var_25_0 = var_25_0 .. "/"
			end
		end
	end

	if arg_25_0.is_absolute then
		var_25_0 = "/" .. var_25_0
	end

	return var_25_0
end

return var_0_4

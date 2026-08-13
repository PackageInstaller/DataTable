pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
class = var_0_10001
var_0.IPAddress = var_0_10001("IPAddress")

local var_0_1 = var_0.IPAddress
local var_0_2 = "https://www.azurlane.tw/getip"
local var_0_3 = {
	{
		"202.39.128.0",
		"202.39.255.255"
	},
	{
		"203.66.0.0",
		"203.66.255.255"
	},
	{
		"203.69.0.0",
		"203.69.255.255"
	},
	{
		"203.75.0.0",
		"203.75.255.255"
	},
	{
		"203.74.0.0",
		"203.74.255.255"
	},
	{
		"210.65.0.0",
		"210.65.255.255"
	},
	{
		"210.71.128.0",
		"210.71.255.255"
	},
	{
		"210.61.0.0",
		"210.61.255.255"
	},
	{
		"210.62.248.0",
		"210.62.255.255"
	},
	{
		"210.59.128.0",
		"210.59.255.255"
	},
	{
		"210.242.0.0",
		"210.242.127.255"
	},
	{
		"210.242.128.0",
		"210.242.255.255"
	},
	{
		"210.241.224.0",
		"210.241.255.255"
	},
	{
		"211.72.0.0",
		"211.72.127.255"
	},
	{
		"211.72.128.0",
		"211.72.255.255"
	},
	{
		"211.75.0.0",
		" 211.75.127.255"
	},
	{
		"211.75.128.0",
		"211.75.255.255"
	},
	{
		"211.20.0.0",
		"211.20.255.255"
	},
	{
		"211.21.0.0",
		"211.21.255.255"
	},
	{
		"211.22.0.0",
		"211.22.255.255"
	},
	{
		"211.23.0.0",
		"211.23.255.255"
	},
	{
		"61.216.0.0",
		"61.219.255.255"
	},
	{
		"61.220.0.0",
		"61.227.255.255"
	},
	{
		"61.228.0.0",
		"61.231.255.255"
	},
	{
		"218.160.0.0",
		"218.165.255.255"
	}
}

function var_0_1.Ctor(arg_1_0)
	arg_1_0:ConvertIPRange()

	arg_1_0.requestUrl = var_0_2
	IsUnityEditor = var_1

	if not var_1 then
		VersionMgr = var_1

		local var_1_0 = var_1.Inst

		var_1.WebRequest(var_1_0, arg_1_0.requestUrl, function(arg_2_0, arg_2_1)
			arg_1_0.exportIP = arg_2_1

			local var_2_0 = arg_1_0
			local var_2_1 = arg_1_0

			var_2_0.isSpecialIP = var_3.CheckExportIP(var_2_1)

			return
		end)
	end

	return
end

function var_0_1.IsIPString(arg_3_0, arg_3_1)
	type = var_1_10002

	if var_1_10002(arg_3_1) ~= "string" then
		return false
	end

	string = var_2

	if var_2.len(arg_3_1) < 7 or 15 < var_2 then
		return false
	end

	string = var_3

	local var_3_0 = var_3.find(arg_3_1, "%p", 1)
	local var_3_1 = 0

	while var_3_0 ~= nil do
		string = var_5

		if var_5.sub(arg_3_1, var_3_0, var_3_0) ~= "." then
			return false
		end

		var_3_1 = var_3_1 + 1
		string = var_5
		var_3_0 = var_5.find(arg_3_1, "%p", var_3_0 + 1)

		if 3 < var_3_1 then
			return false
		end
	end

	if var_3_1 ~= 3 then
		return false
	end

	local var_3_2 = {}

	string = var_6

	for iter_3_0 in var_6.gmatch(arg_3_1, "%d+") do
		var_3_2[#var_3_2 + 1] = iter_3_0
		tonumber = var_10

		if var_10(iter_3_0) == nil or var_10 > 255 then
			return false
		end
	end

	if #var_3_2 ~= 4 then
		return false
	end

	return true
end

function var_0_1.IP2Int(arg_4_0, arg_4_1)
	local var_4_0 = 0
	local var_4_1, var_4_2, var_4_3, var_4_4 = arg_4_1:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")

	return 0 * var_4_1 + 0 * var_4_2 + 0 * var_4_3 + var_4_4
end

function var_0_1.ConvertIPRange(arg_5_0)
	arg_5_0.IPRangeIntList = {}
	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(var_0_3) do
		local var_5_0 = {}
		local var_5_1 = arg_5_0
		local var_5_2 = arg_5_0.IP2Int(var_5_1, iter_5_1[1])

		table = var_1_10008

		var_1_10008.insert(var_5_0, var_5_2)

		var_1_10008 = arg_5_0:IP2Int(iter_5_1[2])
		table = var_5_1

		var_5_1.insert(var_5_0, var_1_10008)

		assert = var_9

		var_9(var_5_2 < var_1_10008, "ip range is illegal" .. iter_5_1[1] .. "-" .. iter_5_1[2])

		table = var_9

		var_9.insert(arg_5_0.IPRangeIntList, var_5_0)
	end

	return
end

function var_0_1.CheckExportIP(arg_6_0)
	if not arg_6_0.exportIP or not arg_6_0:IsIPString(arg_6_0.exportIP) then
		return false
	end

	local var_6_0 = arg_6_0:IP2Int(arg_6_0.exportIP)

	ipairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.IPRangeIntList) do
		if var_6_0 >= iter_6_1[1] and var_6_0 <= iter_6_1[2] then
			return true
		end
	end

	return false
end

function var_0_1.GetExportIPString(arg_7_0)
	return arg_7_0.exportIP
end

function var_0_1.GetLocalIP(arg_8_0)
	ReflectionHelp = var_1_10001

	local var_8_0 = var_1_10001.RefGetProperty

	typeof = var_1_10003

	local var_8_1 = var_8_0(var_1_10003("UnityEngine.Network"), "player")

	ReflectionHelp = var_1_10002

	local var_8_2 = var_1_10002.RefGetProperty

	typeof = var_4
	arg_8_0.localIP = var_8_2(var_4("UnityEngine.NetworkPlayer"), "ipAddress", var_8_1)

	return arg_8_0.localIP
end

function var_0_1.IsSpecialIP(arg_9_0)
	return arg_9_0.isSpecialIP
end

return

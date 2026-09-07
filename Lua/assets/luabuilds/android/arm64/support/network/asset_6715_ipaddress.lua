pg = pg or {}
pg.IPAddress = class("IPAddress")

local var_0_0 = "https://www.azurlane.tw/getip"
local var_0_1 = {
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

function pg.IPAddress:Ctor()
	self:ConvertIPRange()

	self.requestUrl = var_0_0

	if not IsUnityEditor then
		VersionMgr.Inst:WebRequest(self.requestUrl, function(arg_2_0, arg_2_1)
			self.exportIP = arg_2_1
			self.isSpecialIP = self:CheckExportIP()

			return
		end)
	end

	return
end

function pg.IPAddress.IsIPString(arg_3_0, arg_3_1)
	if type(arg_3_1) ~= "string" then
		return false
	end

	local var_3_0 = string.len(arg_3_1)

	if var_3_0 < 7 or var_3_0 > 15 then
		return false
	end

	local var_3_1 = string.find(arg_3_1, "%p", 1)
	local var_3_2 = 0

	while var_3_1 ~= nil do
		if string.sub(arg_3_1, var_3_1, var_3_1) ~= "." then
			return false
		end

		var_3_2 = var_3_2 + 1
		var_3_1 = string.find(arg_3_1, "%p", var_3_1 + 1)

		if var_3_2 > 3 then
			return false
		end
	end

	if var_3_2 ~= 3 then
		return false
	end

	local var_3_3 = {}

	for iter_3_0 in string.gmatch(arg_3_1, "%d+") do
		var_3_3[#var_3_3 + 1] = iter_3_0

		local var_3_4 = tonumber(iter_3_0)

		if var_3_4 == nil or var_3_4 > 255 then
			return false
		end
	end

	if #var_3_3 ~= 4 then
		return false
	end

	return true
end

function pg.IPAddress.IP2Int(arg_4_0, arg_4_1)
	local var_4_1, var_4_2, var_4_3, var_4_4 = arg_4_1:match("(%d+)%.(%d+)%.(%d+)%.(%d+)")

	return 0 * var_4_1 + 0 * var_4_2 + 0 * var_4_3 + var_4_4
end

function pg.IPAddress:ConvertIPRange()
	self.IPRangeIntList = {}

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		local var_5_0 = {}
		local var_5_1 = self:IP2Int(iter_5_1[1])

		table.insert(var_5_0, var_5_1)

		local var_5_2 = self:IP2Int(iter_5_1[2])

		table.insert(var_5_0, var_5_2)
		assert(var_5_1 < var_5_2, "ip range is illegal" .. iter_5_1[1] .. "-" .. iter_5_1[2])
		table.insert(self.IPRangeIntList, var_5_0)
	end

	return
end

function pg.IPAddress:CheckExportIP()
	if not self.exportIP or not self:IsIPString(self.exportIP) then
		return false
	end

	local var_6_0 = self:IP2Int(self.exportIP)

	for iter_6_0, iter_6_1 in ipairs(self.IPRangeIntList) do
		if var_6_0 >= iter_6_1[1] and var_6_0 <= iter_6_1[2] then
			return true
		end
	end

	return false
end

function pg.IPAddress:GetExportIPString()
	return self.exportIP
end

function pg.IPAddress:GetLocalIP()
	self.localIP = ReflectionHelp.RefGetProperty(typeof("UnityEngine.NetworkPlayer"), "ipAddress", (ReflectionHelp.RefGetProperty(typeof("UnityEngine.Network"), "player")))

	return self.localIP
end

function pg.IPAddress:IsSpecialIP()
	return self.isSpecialIP
end

return

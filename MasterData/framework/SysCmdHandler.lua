-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/network/SysCmdHandler.lua

module("framework.network.SysCmdHandler", package.seeall)

local SysCmdHandler = class("SysCmdHandler")
local Byte_Mask = 256
local ReadString, ReadLong, ReadBoolean, WriteString, WriteBtye

function ReadString(bytes, bi)
	local highByte = string.byte(bytes, bi)
	local lowByte = string.byte(bytes, bi + 1)
	local strLength = highByte * Byte_Mask + lowByte
	local str = string.sub(bytes, bi + 2, bi + 2 + strLength - 1)

	return bi + 2 + strLength, str
end

function ReadLong(bytes, beginIndex)
	local res = 0

	for i = beginIndex, beginIndex + 8 - 1 do
		res = res * Byte_Mask + string.byte(bytes, i)
	end

	return beginIndex + 8, res
end

function ReadBoolean(bytes, bi)
	return bi + 1, string.byte(bytes, bi) ~= 0
end

function WriteString(str)
	local strLength = #str
	local highByte = math.floor(strLength / Byte_Mask)
	local lowByte = math.floor(strLength % Byte_Mask)

	return string.char(highByte) .. string.char(lowByte) .. str
end

function WriteBtye(byte)
	return string.char(byte)
end

local requests = {}

requests[1] = function(data)
	return WriteString(data.account) .. WriteString(data.password) .. WriteBtye(data.connectWay)
end
requests[3] = function(data)
	return (WriteBtye(data.downTag))
end

local responses = {}

responses[1] = function(data)
	local res = {}
	local bi = 1
	local bi, reason = ReadString(data, bi)
	local bi, userId = ReadLong(data, bi)

	res.reason = reason
	res.userId = userId

	return res
end
responses[2] = function(data)
	local res = {}
	local bi = 1
	local bi, reason = ReadString(data, bi)

	res.reason = reason

	return res
end
responses[3] = function(data)
	local res = {}
	local bi = 1
	local bi, canGet = ReadBoolean(data, bi)

	res.canGet = canGet

	return res
end
responses[4] = function(data)
	local res = {}
	local bi = 1
	local bi, reason = ReadString(data, bi)

	res.reason = reason

	return res
end

local responses2HandleNames = {}

responses2HandleNames[1] = "LoginResponse"
responses2HandleNames[2] = "LeaveResponse"
responses2HandleNames[3] = "GetLostCmdRespResponse"
responses2HandleNames[4] = "ForceLogoutResponse"
responses2HandleNames[5] = "GetLostCmdRespResponseStartTag"

function SysCmdHandler:GetSendMsg(cmdId, data, connType)
	return (requests[cmdId](data))
end

function SysCmdHandler:GetReceiveMsg(cmdId, data)
	local responseHandler = responses[cmdId]

	if responseHandler then
		data = responses[cmdId](data)
	end

	return responses2HandleNames[cmdId], data
end

return SysCmdHandler

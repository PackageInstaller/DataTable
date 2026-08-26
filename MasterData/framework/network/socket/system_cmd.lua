-- chunkname: @framework/network/socket/system_cmd.lua

module("framework.network.socket.system_cmd", package.seeall)

local system_cmd = {
	{
		"Login",
		"LoginRequest",
		"LoginResponse"
	},
	[3] = {
		"Login",
		"GetLostCmdRespRequest",
		"GetLostCmdRespResponse"
	},
	[4] = {
		"Login",
		"",
		"ForceLogoutResponse"
	},
	[5] = {
		"Login",
		"",
		"GetLostCmdRespResponseStartTag"
	}
}

function system_cmd.GetSendMsg(cmd, data)
	local requestName = system_cmd.GetRequestName(cmd)

	if requestName then
		return system_cmd[requestName](data)
	else
		logError("request handler not exist, cmd = " .. cmd)
	end
end

function system_cmd.GetReceiveMsg(cmd, data)
	local responseName = system_cmd.GetResponseName(cmd)

	if responseName then
		return system_cmd[responseName](data)
	else
		logError("response handler not exist, cmd = " .. cmd)
	end
end

function system_cmd.GetRequestName(cmd)
	return system_cmd[cmd][2]
end

function system_cmd.GetResponseName(cmd)
	return system_cmd[cmd][3]
end

function system_cmd.LoginRequest(data)
	return system_cmd.WriteString(data.account) .. system_cmd.WriteString(data.password) .. system_cmd.WriteByte(data.connectWay)
end

function system_cmd.GetLostCmdRespRequest(data)
	return (system_cmd.WriteByte(data.downTag))
end

function system_cmd.LoginResponse(data)
	local res = {}
	local bi = 1
	local bi, reason = system_cmd.ReadString(data, bi)
	local bi, userId = system_cmd.ReadLong(data, bi)

	res.reason = reason
	res.userId = userId

	return res
end

function system_cmd.LeaveResponse(data)
	local res = {}
	local bi = 1
	local bi, reason = system_cmd.ReadString(data, bi)

	res.reason = reason

	return res
end

function system_cmd.GetLostCmdRespResponse(data)
	local res = {}
	local bi = 1
	local bi, canGet = system_cmd.ReadBoolean(data, bi)

	res.canGet = canGet

	return res
end

function system_cmd.ForceLogoutResponse(data)
	local res = {}
	local bi = 1
	local bi, reason = system_cmd.ReadString(data, bi)

	res.reason = reason

	return res
end

function system_cmd.GetLostCmdRespResponseStartTag(data)
	return {}
end

local Byte_Mask = 256

function system_cmd.ReadString(bytes, bi)
	local highByte = string.byte(bytes, bi)
	local lowByte = string.byte(bytes, bi + 1)
	local strLength = highByte * Byte_Mask + lowByte
	local str = string.sub(bytes, bi + 2, bi + 2 + strLength - 1)

	return bi + 2 + strLength, str
end

function system_cmd.ReadLong(bytes, beginIndex)
	local res = 0

	for i = beginIndex, beginIndex + 8 - 1 do
		res = res * Byte_Mask + string.byte(bytes, i)
	end

	return beginIndex + 8, res
end

function system_cmd.ReadBoolean(bytes, bi)
	return bi + 1, string.byte(bytes, bi) ~= 0
end

function system_cmd.WriteString(str)
	local strLength = #str
	local highByte = math.floor(strLength / Byte_Mask)
	local lowByte = math.floor(strLength % Byte_Mask)

	return string.char(highByte) .. string.char(lowByte) .. str
end

function system_cmd.WriteByte(byte)
	return string.char(byte)
end

return system_cmd

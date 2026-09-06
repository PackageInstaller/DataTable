-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/bootstrap/Netkit.lua

module("bootstrap.Netkit", package.seeall)

local Netkit = {}

function Netkit.trackSocketData(data_length, eventId, eventName, gameId, host_ip, spend_time, start_timestamp)
	local param = {
		data_length = data_length,
		eventId = eventId,
		eventName = eventName,
		gameId = gameId,
		host_ip = host_ip,
		spend_time = spend_time,
		start_timestamp = start_timestamp
	}

	BootstrapUtil.invoke("com.baitian.netkitWrap.NetkitWrap", "trackSocketData", param)
end

function Netkit.trackPatchData(data_length, eventId, eventName, gameId, url, spend_time, start_timestamp)
	local param = {
		data_length = data_length,
		eventId = eventId,
		eventName = eventName,
		gameId = gameId,
		url = url,
		spend_time = spend_time,
		start_timestamp = start_timestamp
	}

	BootstrapUtil.invoke("com.baitian.netkitWrap.NetkitWrap", "trackPatchData", param)
end

function Netkit.trackHttpData(eventId, eventName, gameId, spend_time, start_timestamp)
	local param = {
		eventId = eventId,
		eventName = eventName,
		gameId = gameId,
		spend_time = spend_time,
		start_timestamp = start_timestamp
	}

	BootstrapUtil.invoke("com.baitian.netkitWrap.NetkitWrap", "trackHttpData", param)
end

return Netkit

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/network/IPv6Support.lua

module("framework.network.IPv6Support", package.seeall)

local IPv6Support = {}
local ipv6WrapClazz = "com.baitian.wrap.IPv6SupportWrap"
local MSG_KEY_IP_RECEIVE = "onReceiveAvailableIP"

IPv6Support.STATUS_OK = 0
IPv6Support.STATUS_FAILURE = -1

function IPv6Support.adaptIPv6(address, port, successFunc, failureFunc)
	if port == nil then
		port = 80
	end

	NativeBridge.instance:registerListener(MSG_KEY_IP_RECEIVE, function(result)
		if result.statusCode == IPv6Support.STATUS_OK then
			successFunc(result.address)
		else
			failureFunc()
		end

		NativeBridge.instance:unregisterListener(MSG_KEY_IP_RECEIVE)
	end)

	local params = {
		address = address,
		port = port
	}

	NativeBridge.instance:invoke(ipv6WrapClazz, "adaptIPv6", params)
end

return IPv6Support

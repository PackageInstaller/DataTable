-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/time/ServerTime.lua

module("framework.time.ServerTime", package.seeall)

local ServerTime = {}

ServerTime._serverUtcOffset = 0
ServerTime._clientUtcOffset = 0
ServerTime._clientToServerOffset = 0
ServerTime._serverLocalStamp = 0
ServerTime._syncClientLocalStamp = 0

function ServerTime.init(serverUtcOffset)
	ServerTime._serverUtcOffset = serverUtcOffset

	local now = os.time()
	local utcNow = os.time(os.date("!*t", os.time()))

	ServerTime._clientUtcOffset = os.difftime(now, utcNow)
	ServerTime._clientToServerOffset = ServerTime._serverUtcOffset - ServerTime._clientUtcOffset
end

function ServerTime.sync(serverLocalStamp)
	ServerTime._serverLocalStamp = serverLocalStamp
	ServerTime._syncClientLocalStamp = os.time()
	ServerTime._syncClientLocalStampMs = UnityEngine.Time.realtimeSinceStartup * 1000
end

function ServerTime.now()
	local elapsed = os.time() - ServerTime._syncClientLocalStamp

	return ServerTime._serverLocalStamp + elapsed
end

function ServerTime.nowMs()
	local elapsed = UnityEngine.Time.realtimeSinceStartup * 1000 - ServerTime._syncClientLocalStampMs

	return ServerTime._serverLocalStamp * 1000 + elapsed
end

function ServerTime.nowServerLook()
	local elapsed = os.time() - ServerTime._syncClientLocalStamp

	return ServerTime._serverLocalStamp + elapsed + ServerTime._clientToServerOffset
end

function ServerTime.nowDate()
	local serverLocalStamp = ServerTime.now()

	return (os.date("*t", serverLocalStamp))
end

function ServerTime.nowDateServerLook()
	local serverLocalStamp = ServerTime.nowServerLook()

	return (os.date("*t", serverLocalStamp))
end

function ServerTime.formatNow(fmt)
	return os.date(fmt, ServerTime.now())
end

function ServerTime.formatNowServerLook(fmt)
	local stamp = ServerTime.nowServerLook()

	return os.date(fmt, stamp)
end

return ServerTime

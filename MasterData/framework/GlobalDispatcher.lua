-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/notify/GlobalDispatcher.lua

module("framework.notify.GlobalDispatcher", package.seeall)

local GlobalDispatcher = {}

function GlobalDispatcher.init()
	NotifyEntry.initPool()
	DispatchEntry.initPool()
	NotifyDispatcher.extend(GlobalDispatcher)
end

return GlobalDispatcher

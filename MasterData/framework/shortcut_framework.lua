-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/shortcut_framework.lua

module("framework.shortcut_framework", package.seeall)

local gcount = 0
local gindex = 0
local glen = 0
local glist = {}
local gvec3 = Vector3.New()
local gvec2 = Vector2.New()
local gvec4 = Vector4.New()
local timer = Scheduler

function settimer(interval, handler, handlerObj, isRepeat)
	if isRepeat == nil then
		isRepeat = true
	end

	timer.addListener(interval, handler, handlerObj, isRepeat)
end

function removetimer(handler, handlerObj)
	timer.removeListener(handler, handlerObj)
end

local dispatcher = GlobalDispatcher

setglobal("gcount", gcount)
setglobal("gindex", gindex)
setglobal("glen", glen)
setglobal("glist", glist)
setglobal("gvec3", gvec3)
setglobal("gvec2", gvec2)
setglobal("gvec4", gvec4)
setglobal("settimer", settimer)
setglobal("removetimer", removetimer)
setglobal("dispatcher", dispatcher)

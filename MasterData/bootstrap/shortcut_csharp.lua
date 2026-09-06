-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/shortcut_csharp.lua

module("bootstrap.shortcut_csharp", package.seeall)

local rescache = Framework.ResourceCache.Instance

function getres(resPath, handler, handlerObj, resType, isPreload)
	resType = resType or 0

	if isPreload == nil then
		isPreload = true
	end

	rescache:GetResource(resPath, handler, handlerObj, resType, isPreload)
end

function removeresl(resPath, handler, handlerObj)
	rescache:RemoveListener(resPath, handler, handlerObj)
end

function parsecolor(colorStr)
	return (Framework.ColorUtil.ParseColor(colorStr))
end

setglobal("kScrollDirH", 0)
setglobal("kScrollDirV", 1)
setglobal("rescache", rescache)
setglobal("getres", getres)
setglobal("removeresl", removeresl)
setglobal("parsecolor", parsecolor)

-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/resource/rescache/ResGcMgr.lua

module("framework.resource.rescache.ResGcMgr", package.seeall)

local ResGcMgr = class("ResGcMgr")

ResGcMgr.gcInterval = 20
ResGcMgr._lastGcTime = 0

function ResGcMgr:delayTryGc(delay)
	delay = delay or 0.8

	Scheduler.addListener(delay, self.tryGc, self, false)
end

function ResGcMgr:tryGc()
	local time = Time.time

	if time - ResGcMgr._lastGcTime > ResGcMgr.gcInterval then
		self:gc()
	end
end

function ResGcMgr:gc()
	Framework.DynImageCache.Instance:ReleaseAllUnused()
	rescache:DestroyUnusedResources()
	collectgarbage("collect")

	ResGcMgr._lastGcTime = Time.time
end

ResGcMgr.instance = ResGcMgr.New()

return ResGcMgr

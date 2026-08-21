module("framework.resource.rescache.ResGcMgr", package.seeall)

local var_0_0 = class("ResGcMgr")

var_0_0.gcInterval = 20
var_0_0._lastGcTime = 0

function var_0_0.delayTryGc(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or 2

	Scheduler.addListener(arg_1_1, arg_1_0.tryGc, arg_1_0, false)
end

function var_0_0.tryGc(arg_2_0)
	if Time.time - var_0_0._lastGcTime > var_0_0.gcInterval then
		arg_2_0:gc()
	end
end

function var_0_0.gc(arg_3_0)
	Astral.DynImageCache.Instance:ReleaseAllUnused()
	System.GC.Collect()
	collectgarbage("collect")

	var_0_0._lastGcTime = Time.time
end

var_0_0.instance = var_0_0.New()

return var_0_0

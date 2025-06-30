module('GCUtil', Class.impl())

local luaGCEnable = true;
local csharpGCEnable = true;

function setLuaGCParam(pause,stepmul)
	collectgarbage("setpause",pause)
	collectgarbage("setstepmul",stepmul)
end

function restartLuaGC()
	Debug:log_info("GCUtil", "Lua允许GC")
	collectgarbage("restart")
	luaGCEnable = true;
end 

function stopLuaGC()
	Debug:log_info("GCUtil", "Lua禁止GC")
	collectgarbage("stop")
	luaGCEnable = false;
end

function collectLuaGC()
	Debug:log_info("GCUtil", "Lua开始GC")
	collectgarbage("collect")
end

function getLuaMemoryMB()
	local num = collectgarbage("count") / 1024
	return math.floor(num * 100) / 100;
end

function isLuaGCEnable()
	return luaGCEnable;
end

----------------------------------------------------------------------------------------------------------------------------------------

function restartCSharpGC()
	Debug:log_info("GCUtil", "C#允许GC")
	gs.GarbageCollectorUtil:EnableGC()
    -- gs.GarbageCollectorUtil:LogMode()
    -- csharpGCEnable = true
end

function stopCSharpGC()
	Debug:log_info("GCUtil", "C#禁止GC")
	gs.GarbageCollectorUtil:DisableGC()
    -- gs.GarbageCollectorUtil:LogMode()
    -- csharpGCEnable = false
end 

function colllectCSharpGC()
	Debug:log_info("GCUtil", "C#开始GC")
	gs.GarbageCollectorUtil:ForceCollect()
end

function getCSharpMemoryMB()
	return gs.GarbageCollectorUtil:GetTotalMemoryMB();
end

function isCSharpGCEnable()
	return csharpGCEnable;
end

return _M
---@class LuaLogger
LuaLogger = {}

local unpack = unpack or table.unpack
local pack = pack or table.pack

if G and G.Declare then
	G.Declare("ngx")
end


local function LuaLocalDebugS(...)
    local dbgInfo = debug.getinfo(3)
    Debugger.LuaLoggerCall = true
    Debugger.Line = dbgInfo.currentline
    Debugger.FilePath = dbgInfo.source

    local paramNum = select("#", ...)
    local params = {...}
    local str = ""
    for i = 1, paramNum do
		str = str .. tostring(params[i])
		if i < paramNum then
			str = str .. "  "
		end
    end

	-- if GV.IsServer then
		str = string.format("%s %s:%d", str, dbgInfo.source, dbgInfo.currentline)
	-- end

	return str
end

local function LuaLocalDebug(...)
    local dbgInfo = debug.getinfo(3)
    Debugger.LuaLoggerCall = true
    Debugger.Line = dbgInfo.currentline
    Debugger.FilePath = dbgInfo.source

	local temp = {...}
	local a = unpack(temp)
	if type(a) ~= "string" then
		return LuaLocalDebugS(...)
	else
		local str = string.format(unpack(temp))
		-- if GV.IsServer then
			str = string.format("%s %s:%d", str, dbgInfo.source, dbgInfo.currentline)
		-- end

		return str
	end
end

local function LuaLocalDebugD(...)
	if not LuaLogger.Enabled then
		return
	end
	
	local str = LuaLocalDebug(...)
	Debugger.Log(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugI(...)
	if not LuaLogger.Enabled then
		return
	end

	local str = LuaLocalDebug(...)
	Debugger.LogInfo(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugW(...)
	if not LuaLogger.Enabled then
		return
	end

	local str = string.format("%s\n%s", LuaLocalDebug(...), debug.traceback())
	Debugger.LogWarning(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugE(...)
	if not LuaLogger.Enabled then
		return
	end

	local str = string.format("%s\n%s", LuaLocalDebug(...), debug.traceback())
	Debugger.LogError(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugDS(...)
	local str = LuaLocalDebugS(...)
	--bugly
	if not GV.IsServer and BuglyAgent then
		-- print("LuaLocalDebugDS: " .. tostring(str))
		local safeStr = tostring(str):gsub("({)", "{{"):gsub("(})", "}}")
		-- print("safeStr LuaLocalDebugDS: " .. tostring(safeStr))
		BuglyAgent.PrintLog2(LogSeverity.Log, tostring(safeStr))
	end
	if not LuaLogger.Enabled then
		return
	end
	Debugger.Log(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugIS(...)
	if not LuaLogger.Enabled then
		return
	end

	local str = LuaLocalDebugS(...)
	Debugger.LogInfo(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugWS(...)
	local str = string.format("%s\n%s", LuaLocalDebugS(...), debug.traceback())
	--bugly
	if not GV.IsServer and BuglyAgent then
		local safeStr = tostring(str):gsub("({)", "{{"):gsub("(})", "}}")
		BuglyAgent.PrintLog2(LogSeverity.LogWarning, tostring(safeStr))
	end
	if not LuaLogger.Enabled then
		return
	end
	Debugger.LogWarning(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

local function LuaLocalDebugES(...)
	local a = LuaLocalDebugS(...)
	local b = debug.traceback()
	--关闭日志的情况下需要手动上报
	if not LuaLogger.Enabled then
		--bugly
		if not GV.IsServer and BuglyAgent then
			local safeA = tostring(a):gsub("({)", "{{"):gsub("(})", "}}")
			local safeB = tostring(b):gsub("({)", "{{"):gsub("(})", "}}")
			BuglyAgent.ReportException(safeA, safeA, safeB)
		end
		return
	end
		local str = string.format("%s\n%s", a, b)
	Debugger.LogError(str)
	if LuaLogger.RecordAll then
		LuaLogger.AddLogToAll(str)
	end
end

if not Debugger then
	Debugger = {}
	if GV.IsServer then
		local log = require "log"
		Debugger.Log = log.debug
		Debugger.LogWarning = log.warn
		Debugger.LogError = log.error
		Debugger.LogInfo = log.info
	elseif ngx then
		Debugger.Log = function (msg)
			ngx.log(ngx.DEBUG, msg)
		end

		Debugger.LogWarning = function (msg)
			ngx.log(ngx.WARN, msg)
		end

		Debugger.LogError = function (msg)
			ngx.log(ngx.ERR, msg)
		end

		Debugger.LogInfo = function (msg)
			ngx.log(ngx.INFO, msg)
		end
	else
		Debugger.Log = print
		Debugger.LogWarning = print
		Debugger.LogError = print
		Debugger.LogInfo = print
	end
end

LuaLogger.d = LuaLocalDebugD
LuaLogger.i = LuaLocalDebugI
LuaLogger.w = LuaLocalDebugW
LuaLogger.e = LuaLocalDebugE

LuaLogger.ds = LuaLocalDebugDS
LuaLogger.is = LuaLocalDebugIS
LuaLogger.ws = LuaLocalDebugWS
LuaLogger.es = LuaLocalDebugES

-- LuaLogger.d = Debugger.Log
-- LuaLogger.w = Debugger.LogWarning
-- LuaLogger.e = Debugger.LogError

function LuaLogger.AddLogToAll(msg)
	if not LuaLogger._allLog then
		LuaLogger._allLog = msg
	else
		LuaLogger._allLog = string.format("%s\n%s", LuaLogger._allLog, msg)
	end
end

function LuaLogger.GetAllLog()
	return LuaLogger._allLog
end

function LuaLogger.ClearAllLog()
	LuaLogger._allLog = nil
end

if GV.IsServer then
	LuaLogger.Enabled = true
else
	LuaLogger.Enabled = true
end

if GV.IsServer then
	print = function()	end
else
	local originPrint = print
	print = function(...)
		if LuaLogger.Enabled then
			originPrint(...)
		end
	end
end


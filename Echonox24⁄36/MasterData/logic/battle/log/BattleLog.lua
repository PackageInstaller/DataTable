-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/log/BattleLog.lua

module("logic.battle.log.BattleLog", package.seeall)

local BattleLog = {}

BattleLog.enableOutputLog = enableDebug and BattleTestUtil.isOutputLog()
BattleLog.enableLog = enableDebug and enableLog
BattleLog.enableWarn = enableDebug and enableWarnLog
BattleLog.enableError = enableErrorLog
BattleLog.enableServerLog = enableDebug and BattleTestUtil.isOutputServerLog()

local LOG_PREFIX = "[LOG  ]"
local WARN_PREFIX = "[WARN ]"
local ERROR_PREFIX = "[ERROR]"
local SERVER_PREFIX = "[SERVER]"
local clientOutputList = {}
local serverOutputList = {}
local clientLogPath = false
local serverLogPath = false

local function logTime()
	return os.date("[%H:%M:%S]")
end

local function toLogString(listTable)
	return table.concat(listTable, "", 1, #listTable)
end

local function outputLog(outputList, logPath)
	if outputList and #outputList > 0 then
		local sb = StringBuffer.New()

		for i, s in ipairs(outputList) do
			sb:append(s)
			sb:appendLine()

			outputList[i] = nil
		end

		Astral.FileUtils.Instance:WriteFile(sb:toString(), logPath, true)
	end
end

local function addToString(logString, isClient)
	local outputList = isClient and clientOutputList or serverOutputList

	table.insert(outputList, logString)

	if #outputList > 10 then
		outputLog(outputList, isClient and clientLogPath or serverLogPath)
	end
end

local function createLogPath(name)
	return string.format("%s/battle/%s_%s.log", Astral.FileUtils.Instance.LocalTempResRootPath, name, os.date("%Y%m%d%H%M%S", os.time()))
end

function BattleLog.init()
	BattleLog.enableOutputLog = enableDebug and BattleTestUtil.isOutputLog()
	BattleLog.enableServerLog = enableDebug and BattleTestUtil.isOutputServerLog()

	if not BattleLog.enableOutputLog then
		return
	end

	clientLogPath = createLogPath("client_log")
	serverLogPath = createLogPath("server_log")

	printInfo("BattleClientLogPath", clientLogPath)
	printInfo("BattleServerLogPath", serverLogPath)
end

function BattleLog.clear()
	if not BattleLog.enableOutputLog then
		return
	end

	outputLog(clientOutputList, clientLogPath)
	outputLog(serverOutputList, serverLogPath)
end

function BattleLog.log(...)
	if BattleLog.enableOutputLog then
		local s = toLogString({
			LOG_PREFIX,
			logTime(),
			...
		})

		printInfo(s)
		addToString(s, true)
	else
		printInfo(LOG_PREFIX, ...)
	end
end

function BattleLog.warn(...)
	if BattleLog.enableOutputLog then
		local s = toLogString({
			WARN_PREFIX,
			logTime(),
			...
		})

		printWarn(s)
		addToString(s, true)
	else
		printWarn(WARN_PREFIX, ...)
	end
end

function BattleLog.error(...)
	if BattleLog.enableOutputLog then
		local s = toLogString({
			ERROR_PREFIX,
			logTime(),
			...
		})

		printError(s)
		addToString(s, true)
	else
		printError(ERROR_PREFIX, ...)
	end
end

function BattleLog.logServer(msg)
	if BattleLog.enableOutputLog then
		local s = toLogString({
			SERVER_PREFIX,
			logTime(),
			tostring(msg)
		})

		printInfo(s)
		addToString(s, true)
		addToString(s, false)
	else
		printInfo(SERVER_PREFIX, tostring(msg))
	end
end

return BattleLog

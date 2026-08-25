local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local uploadedErrLogs
local oldPrint = print
local localLogInstance
local isTraceback = false
local GameObject = CS.UnityEngine.GameObject
local isDebug = ApplicationUtils.is_debug_mode() or Utils.__get_mode_from_debug_file()
local isEditor = ApplicationUtils.is_editor_mode()
local localLogState = isDebug
local reportApusCacheList = {}
local reportCacheLogMax = 50
local logPrintConfig = {
  debug = nil,
  info = isDebug,
  warn = isDebug,
  proto = isDebug,
  error = true
}
local s_apusLogger
local Logger = {}
Logger.isDestroying = nil

function Logger.Init()
  CS.UnityEngine.Debug.unityLogger.logEnabled = true
  if isDebug then
    logPrintConfig.debug = ApplicationUtils.is_editor_mode()
    Logger.ReportApusInfo("[Log]Switch State:{msg}", "是Debug模式，开启Debug级别日志")
    local mainAsset = ResLoadMgr.LoadAsset("GameBasePrefab/LocalLoger.prefab", Logger)
    local logerGo = GameObject.Instantiate(mainAsset)
    logerGo.name = "LocalLoger"
  else
    CS.UnityEngine.Debug.unityLogger.filterLogType = 0
    logPrintConfig.debug = false
    Logger.ReportApusInfo("[Log]Switch State:{msg}", "不是Debug模式，关闭Debug级别日志")
  end
end

function Logger.ForcePrint(...)
  local str = ""
  for i = 1, select("#", ...) do
    str = str .. tostring(select(i, ...)) .. " "
  end
  CS.UnityEngine.Debug.Log(str)
end

function Logger.SetDebugLogPrint(isOpen)
  logPrintConfig.debug = isOpen
end

function Logger.SetProtoLogPrint(isOpen)
  logPrintConfig.proto = isOpen
end

function Logger.SetApusLogger(logger)
  s_apusLogger = logger
end

function Logger.Exception()
end

function Logger.Debug(...)
  Logger._Log("debug", nil, ...)
end

function Logger.Info(...)
  Logger._Log("info", "#00C1D4", ...)
end

function Logger.Warn(...)
  Logger._Log("warn", "#FFC107", ...)
end

function Logger.Proto(...)
  Logger._Log("proto", "#00FF11", ...)
end

function Logger.Error(...)
  local content = Logger.GetFormatContent(...)
  if ApplicationUtils.is_editor_mode() then
    content = Logger.colorFirstLine(content, "#FF2222")
  end
  CS.UnityEngine.Debug.LogError(content .. "\n" .. debug.traceback())
end

function Logger.PopUpErrorTip(errorStr)
  if not Logger.isDestroying and isDebug and ApplicationUtils.is_innet_pcode() then
    local lineBreakIndex = string.find(errorStr, "\n")
    local firstLine = string.sub(errorStr, 1, lineBreakIndex)
    Alert.ShowTopTips(firstLine)
  end
end

function Logger.ReportApusErrorS(firstLineError, extraMsg, logTime)
  if not s_apusLogger then
    table.insert(reportApusCacheList, {
      firstLineError = firstLineError,
      extraMsg = extraMsg,
      logTime = logTime,
      logLevel = Utils.APUS_LOG_LEVEL.Error
    })
    Logger.ReportCacheLogs()
    return
  end
  local errorMsg = firstLineError .. (extraMsg or "")
  s_apusLogger.ManualLogS(Global.LogLevelEnum.ERROR, firstLineError, logTime or os.time(), errorMsg)
end

function Logger.ReportApusInfo(eventName, ...)
  if not s_apusLogger then
    local args = {}
    local values = table.pack(...)
    local cnt = 1
    for tagSymbol in string.gmatch(eventName, "%b{}") do
      local tag = string.match(tagSymbol, "%{(.+)}")
      if tagSymbol and values[cnt] then
        args[tag] = values[cnt]
      end
      cnt = cnt + 1
    end
    table.insert(reportApusCacheList, {
      eventName = eventName,
      args = args,
      logLevel = Utils.APUS_LOG_LEVEL.Info
    })
    return
  end
  s_apusLogger.InfoS(eventName, ...)
end

function Logger.ReportApusDebug(eventName, ...)
  if not s_apusLogger then
    return
  end
  s_apusLogger.DebugS(eventName, ...)
end

function Logger.SetLogState(state)
  if localLogState == state then
    return
  end
  for k, _ in pairs(logPrintConfig) do
    logPrintConfig[k] = state
  end
  if not localLogInstance then
    localLogInstance = CS.Z1Client.Z1LocalLog.Instance
  end
  if localLogInstance then
    localLogInstance.isSaveLog = state
    localLogState = state
  end
end

function Logger.ReportCacheLogs()
  if not reportApusCacheList or #reportApusCacheList <= 0 then
    return
  end
  
  local function _ReportLog(logInfo)
    if not s_apusLogger then
      if logInfo.logLevel == Utils.APUS_LOG_LEVEL.Error then
        Utils.ReportLogByHttpPost(logInfo.firstLineError, logInfo.extraMsg, {}, logInfo.logLevel)
        return
      end
      Utils.ReportLogByHttpPost(logInfo.eventName, "", logInfo.args, logInfo.logLevel)
    elseif logInfo.logLevel == Utils.APUS_LOG_LEVEL.Info then
      local args = {}
      for tagSymbol in string.gmatch(logInfo.eventName, "%b{}") do
        local tag = string.match(tagSymbol, "%{(.+)}")
        if tagSymbol and logInfo.args[tag] then
          table.insert(args, logInfo.args[tag])
        end
      end
      Logger.ReportApusInfo(logInfo.eventName, table.unpack(args))
    elseif logInfo.logLevel == Utils.APUS_LOG_LEVEL.Error then
      Logger.ReportApusErrorS(logInfo.firstLineError, logInfo.extraMsg, logInfo.logTime)
    end
  end
  
  local reportNum = math.min(#reportApusCacheList, reportCacheLogMax)
  for i = 1, reportNum do
    local logInfo = reportApusCacheList[i]
    if logInfo then
      _ReportLog(logInfo)
    end
  end
  reportApusCacheList = {}
end

function Logger.GetLogState()
  return localLogState
end

function Logger.RedirectLog()
  uploadedErrLogs = {}
  
  function RecordCsharpError(content, stackTrace)
    if Main.isAppDestroyed then
      return
    end
    local allContent = content .. stackTrace
    if uploadedErrLogs[allContent] then
      return
    end
    uploadedErrLogs[allContent] = true
    local errorMsg = content
    if content and string.find(content, "\n") then
      local lineBreakIndex = string.find(content, "\n")
      local firstLine = string.sub(content, 1, lineBreakIndex)
      local afterLines = string.sub(content, lineBreakIndex + 1, #content)
      errorMsg = firstLine
      stackTrace = afterLines .. "\n" .. stackTrace
    end
    Logger.ReportApusErrorS(errorMsg, stackTrace, TimeUtils.GetServerTime())
    Logger.PopUpErrorTip(content)
  end
  
  function warn(...)
    Logger.Warn(...)
  end
  
  if isDebug then
    function print(...)
      local args = {
        ...
      }
      oldPrint(table.unpack(args))
    end
  else
    function print()
    end
  end
end

function Logger.GetLocalInfo()
  local info = debug.getinfo(4, "Sl")
  local src = info.source
  src = string.replace(src, "@", "")
  return src .. ":" .. info.currentline
end

function Logger._Log(logLevelName, color, ...)
  if not logPrintConfig[logLevelName] then
    return
  end
  local content = Logger.GetFormatContent(...)
  local time = os.date("%X")
  content = string.format("[%s]%s", time, content)
  if isTraceback then
    content = content .. " " .. debug.traceback()
  end
  content = string.format("%s  【%s】", content, Logger.GetLocalInfo())
  if isEditor and color then
    content = Logger.colorFirstLine(content, color)
  end
  oldPrint(content)
  if "warn" == logLevelName then
    Logger.ReportApusErrorS(content, "", TimeUtils.GetServerTime())
  end
end

function Logger.GetFormatContent(...)
  local params = {
    ...
  }
  local str = params[1]
  local content = ""
  if type(str) == "string" and string.find(str, "%%s") then
    table.remove(params, 1)
    for index = 1, 5 do
      table.insert(params, "nil")
    end
    content = string.format(str, table.unpack(params))
  else
    for index = 1, select("#", ...) do
      content = string.format("%s  %s", content, nil == params[index] and "nil" or params[index])
    end
  end
  return content
end

function Logger.split(str, delimiter)
  delimiter = tostring(delimiter)
  assert("" ~= delimiter, "empty separator")
  local pos, arr = 0, {}
  for st, sp in function()
    do return string.find, str, delimiter, pos end
    return string.find, str, delimiter, pos, true
  end, nil, nil, nil do
    table.insert(arr, string.sub(str, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(str, pos))
  return arr
end

function Logger.color(str, color)
  do return string.format, "<color=%s>%s</color>", color end
  return string.format, "<color=%s>%s</color>", color, str
end

function Logger.colorFirstLine(str, color)
  local arr = Logger.split(str, "\n")
  if arr[1] then
    arr[1] = Logger.color(arr[1], color)
    local outStr = arr[1]
    for index, content in ipairs(arr) do
      if 1 ~= index then
        outStr = string.format([[
%s
%s]], outStr, content)
      end
    end
    return outStr
  end
  return str
end

function Logger.UpdateLogFileName(account)
  if not (localLogState and CS.Z1Client.Z1LocalLog.Instance) or not account then
    return
  end
  CS.Z1Client.Z1LocalLog.Instance:SetUserName(account)
end

return Logger

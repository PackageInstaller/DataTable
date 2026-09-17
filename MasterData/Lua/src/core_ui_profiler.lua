local CSVRankKeyName = {
  [1] = "avg_all_pure",
  [2] = "avg_newPage_pure",
  [3] = "avg_preOpen",
  [4] = "avg_doOpen",
  [5] = "max_all_pure"
}
local CSVKeyName1 = {
  [1] = "pageName",
  [2] = "openCount"
}
local CSVKeyName2 = {
  [1] = "total_all",
  [2] = "total_all_pure",
  [3] = "total_newPage",
  [4] = "total_newPage_pure",
  [5] = "total_check",
  [6] = "total_preOpen",
  [7] = "total_closeAnim",
  [8] = "total_openAnim",
  [9] = "total_doOpen"
}
local CSVKeyName3 = {
  [1] = "avg_all",
  [2] = "avg_all_pure",
  [3] = "avg_newPage",
  [4] = "avg_newPage_pure",
  [5] = "avg_check",
  [6] = "avg_preOpen",
  [7] = "avg_closeAnim",
  [8] = "avg_openAnim",
  [9] = "avg_doOpen"
}
local tableValueName = {
  [1] = "d_all",
  [2] = "d_all_pure",
  [3] = "d_newPage",
  [4] = "d_newPage_pure",
  [5] = "d_check",
  [6] = "d_preOpen",
  [7] = "d_closeAnim",
  [8] = "d_openAnim",
  [9] = "d_doOpen"
}
local clsProfiler = class("core.ui.profiler")
local tag = clsProfiler:getName()
local clsPageOpenRecord = class("core.ui.profiler.pageOpenRecord")
clsPageOpenRecord.pageName = nil
clsPageOpenRecord.t_allStart = -1
clsPageOpenRecord.t_newPageStart = -1
clsPageOpenRecord.t_checkStart = -1
clsPageOpenRecord.t_checkEnd = -1
clsPageOpenRecord.t_newPageEnd = -1
clsPageOpenRecord.t_preOpenStart = -1
clsPageOpenRecord.t_preOpenEnd = -1
clsPageOpenRecord.t_closeAnimStart = -1
clsPageOpenRecord.t_closeAnimEnd = -1
clsPageOpenRecord.t_openAnimStart = -1
clsPageOpenRecord.t_openAnimEnd = -1
clsPageOpenRecord.t_doOpenStart = -1
clsPageOpenRecord.t_doOpenEnd = -1
clsPageOpenRecord.t_allEnd = -1

function clsPageOpenRecord:ctor(pageName)
  self.pageName = pageName
end

function clsPageOpenRecord:reset()
  self.t_allStart = -1
  self.t_newPageStart = -1
  self.t_checkStart = -1
  self.t_checkEnd = -1
  self.t_newPageEnd = -1
  self.t_preOpenStart = -1
  self.t_preOpenEnd = -1
  self.t_closeAnimStart = -1
  self.t_closeAnimEnd = -1
  self.t_openAnimStart = -1
  self.t_openAnimEnd = -1
  self.t_doOpenStart = -1
  self.t_doOpenEnd = -1
  self.t_allEnd = -1
end

function clsPageOpenRecord:mark(markerName)
  if clsPageOpenRecord.libSocket == nil then
    clsPageOpenRecord.libSocket = require("socket")
  end
  self[markerName] = clsPageOpenRecord.libSocket.gettime()
end

local clsPageStatistics = class("core.ui.profiler.pageStatistics")

function clsPageStatistics:ctor(pageName)
  self.pageName = pageName
  self.openCount = 0
  self.openRecords = {}
  self.d_all = 0
  self.d_all_pure = 0
  self.d_newPage = 0
  self.d_newPage_pure = 0
  self.d_check = 0
  self.d_preOpen = 0
  self.d_closeAnim = 0
  self.d_openAnim = 0
  self.d_doOpen = 0
  self.avg_all_pure = 0
  self.avg_newPage_pure = 0
  self.avg_preOpen = 0
  self.avg_doOpen = 0
  self.max_all_pure = 0
end

function clsPageStatistics:addRecord(record)
  table.insert(self.openRecords, record)
  self.openCount = self.openCount + 1
  self:refresh(record)
end

function clsPageStatistics:refresh(record)
  local all = record.t_allEnd - record.t_allStart
  local newPage = record.t_newPageEnd - record.t_newPageStart
  local check = record.t_checkEnd - record.t_checkStart
  local preOpen = record.t_preOpenEnd - record.t_preOpenStart
  local closeAnim = record.t_closeAnimEnd - record.t_closeAnimStart
  local openAnim = record.t_openAnimEnd - record.t_openAnimStart
  local doOpen = record.t_doOpenEnd - record.t_doOpenStart
  local all_pure = all - check - closeAnim - openAnim
  self.d_all = self.d_all + all
  self.d_all_pure = self.d_all_pure + all_pure
  self.d_newPage = self.d_newPage + newPage
  self.d_newPage_pure = self.d_newPage_pure + (newPage - check)
  self.d_check = self.d_check + check
  self.d_preOpen = self.d_preOpen + preOpen
  self.d_closeAnim = self.d_closeAnim + closeAnim
  self.d_openAnim = self.d_openAnim + openAnim
  self.d_doOpen = self.d_doOpen + doOpen
  local milliX = 1000
  if all_pure * milliX > self.max_all_pure then
    self.max_all_pure = all_pure * milliX
  end
end

function clsProfiler:ctor(ui)
  self._ui = ui
  self._initialized = false
  self._remoteMode = false
  self._remoteServerUrl = "http://192.168.211.21/devserver/logUIPageOpenTime.php"
  self._reqParamCache = {}
  self._recordPool = {}
  self._records = {}
  self._recordingMap = {}
  self._statisticsMap = {}
end

function clsProfiler:initialize()
  if self._initialized then
    return
  end
  self._deviceName = Unity.SystemInfo.deviceName
  self._deviceModel = Unity.SystemInfo.deviceModel
  if C_InfoManager.isInstanced then
    self._platform = C_InfoManager.System
    self._appVersion = C_InfoManager.AppVersion
  else
    self._platform = nil
    self._appVersion = nil
  end
  for i = 1, 100 do
    local record = clsPageOpenRecord.new()
    table.insert(self._recordPool, record)
  end
  self._initialized = true
end

function clsProfiler:setEnabled(enabled)
  self._enabled = enabled
  if enabled then
    printf(tag, "[UI-Profiler] Started")
    self:initialize()
  else
    printf(tag, "[UI-Profiler] Stopped")
  end
end

function clsProfiler:isEnabled()
  return self._enabled
end

function clsProfiler:setRemoteMode(isRemote)
  self._remoteMode = isRemote
  if isRemote then
    printf(tag, "[UI-Profiler] Use RemoteMode")
  else
    printf(tag, "[UI-Profiler] Use LocalMode")
  end
end

function clsProfiler:reset()
  while #self._records > 0 do
    local record = table.remove(self._records)
    table.insert(self._recordPool, record)
  end
end

function clsProfiler:createRecord(pageName)
  if self._recordingMap[pageName] then
    printf("Duplicated PageName: " .. pageName)
    return nil
  end
  local record
  if #self._recordPool > 0 then
    record = table.remove(self._recordPool)
    record.pageName = pageName
    record:reset()
  else
    record = clsPageOpenRecord.new(pageName)
  end
  self._recordingMap[pageName] = record
  return record
end

function clsProfiler:completeRecord(record)
  table.insert(self._records, record)
  if self._remoteMode then
    self:_sendRecordToLogServer(record)
  else
    self:_addRecordToStatistics(record)
  end
  self._recordingMap[record.pageName] = nil
end

function clsProfiler:_addRecordToStatistics(record)
  if record == nil then
    return
  end
  local stat = self._statisticsMap[record.pageName]
  if stat == nil then
    stat = clsPageStatistics.new(record.pageName)
    self._statisticsMap[record.pageName] = stat
  end
  stat:addRecord(record)
end

function clsProfiler:_sendRecordToLogServer(record)
  if record == nil then
    return
  end
  self._reqParamCache.deviceName = self._deviceName
  self._reqParamCache.deviceModel = self._deviceModel
  self._reqParamCache.platform = self._platform
  self._reqParamCache.appVersion = self._appVersion
  self._reqParamCache.pageName = record.pageName
  self._reqParamCache.t_allStart = record.t_allStart
  self._reqParamCache.t_newPageStart = record.t_newPageStart
  self._reqParamCache.t_checkStart = record.t_checkStart
  self._reqParamCache.t_checkEnd = record.t_checkEnd
  self._reqParamCache.t_newPageEnd = record.t_newPageEnd
  self._reqParamCache.t_preOpenStart = record.t_preOpenStart
  self._reqParamCache.t_preOpenEnd = record.t_preOpenEnd
  self._reqParamCache.t_closeAnimStart = record.t_closeAnimStart
  self._reqParamCache.t_closeAnimEnd = record.t_closeAnimEnd
  self._reqParamCache.t_openAnimStart = record.t_openAnimStart
  self._reqParamCache.t_openAnimEnd = record.t_openAnimEnd
  self._reqParamCache.t_doOpenStart = record.t_doOpenStart
  self._reqParamCache.t_doOpenEnd = record.t_doOpenEnd
  self._reqParamCache.t_allEnd = record.t_allEnd
  C_HttpManager.PostJsonForText(self._remoteServerUrl, L_Json.encode(self._reqParamCache), nil, nil)
end

function clsProfiler:testRemoteServer(cb)
  if not cb then
    return
  end
  C_HttpManager.PostJsonForText(self._remoteServerUrl, "", function(rsp)
    cb(true)
  end, function(rsp)
    cb(false)
  end)
end

function clsProfiler:getRecordingRecord(pageName)
  return self._recordingMap[pageName]
end

function clsProfiler:generateReportCSV()
  local outputStr = ""
  for k, v in ipairs(CSVKeyName1) do
    outputStr = outputStr .. v .. ","
  end
  for k, v in pairs(CSVKeyName2) do
    outputStr = outputStr .. v .. ","
    outputStr = outputStr .. CSVKeyName3[k] .. ","
  end
  outputStr = outputStr .. "\n"
  for k, v in pairs(self._statisticsMap) do
    outputStr = outputStr .. self:generateSingleStatStr(v)
  end
  printf(tag, outputStr)
  if Unity.Application.IsMobilePlatformForUI then
    CS.UnityEngine.GUIUtility.systemCopyBuffer = outputStr
  end
  local outPutPath = Unity.Application.persistentDataPath .. "/ui_profiler_report.csv"
  printf(tag, "UI-Profile报告文件保存路径: " .. outPutPath)
  C_FileUtility.WriteTextFile(outPutPath, outputStr)
end

function clsProfiler:generateSingleStatStr(stat)
  local outputStr = ""
  local openCount = stat.openCount
  for k, v in ipairs(CSVKeyName1) do
    outputStr = outputStr .. stat[v] .. ","
  end
  local milliX = 1000
  for k, v in pairs(tableValueName) do
    local avgValue = self:getDecimalNumber(stat[v] * milliX / openCount)
    outputStr = outputStr .. self:getDecimalNumber(stat[v] * milliX) .. "," .. avgValue .. ","
    if stat[CSVKeyName3[k]] ~= nil then
      stat[CSVKeyName3[k]] = avgValue
    end
  end
  outputStr = outputStr .. "\n"
  return outputStr
end

function clsProfiler:getDecimalNumber(number)
  local decimal = 0.1
  return number - number % decimal
end

function clsProfiler:generateReportRankCSV(rankingLength)
  self:_generateReportRankCSV(rankingLength, CSVRankKeyName, "/ui_profiler_report_ranking.csv")
end

function clsProfiler:_generateReportRankCSV(rankingLength, keyNameTable, fileName)
  rankingLength = rankingLength or 10
  local outputStr = ""
  for k, v in ipairs(keyNameTable) do
    outputStr = outputStr .. v .. ","
  end
  outputStr = outputStr .. "\n"
  local sortTb = {}
  for k, v in pairs(self._statisticsMap) do
    table.insert(sortTb, v)
  end
  local res = {}
  for k, v in ipairs(keyNameTable) do
    res[k] = {}
    table.sort(sortTb, function(a, b)
      return a[v] > b[v]
    end)
    for i = 1, rankingLength do
      if sortTb[i] then
        res[k][i] = {
          pageName = sortTb[i].pageName,
          value = sortTb[i][v],
          openCount = sortTb[i].openCount
        }
      end
    end
  end
  for i = 1, rankingLength do
    for k, v in ipairs(keyNameTable) do
      if res[k][i] ~= nil then
        outputStr = outputStr .. res[k][i].pageName .. "(" .. self:getDecimalNumber(res[k][i].value) .. ")" .. "(" .. res[k][i].openCount .. "),"
      else
        outputStr = outputStr .. "/,"
      end
    end
    outputStr = outputStr .. "\n"
  end
  local outPutPath = Unity.Application.persistentDataPath .. fileName
  printf(tag, "UI-Profile报告文件保存路径: " .. outPutPath)
  C_FileUtility.WriteTextFile(outPutPath, outputStr)
end

return clsProfiler

local bg = require("Battle.DbgRender.BattleGlobal")
local bc = require("Share.Battle.BattleConst")
local BattleStatsDetailUtil = {}
local currentFilePath

local function GetStatsDetailCsvPath()
  if currentFilePath and "" ~= currentFilePath then
    return currentFilePath
  end
  local base = bg.battleRender and bg.battleRender:GetLogFileName()
  if not base or "" == base then
    base = "BattleLog"
  end
  local baseName = base .. "_StatsDetail"
  return "BattleLog/" .. baseName .. ".csv"
end

local function GetStatsDetailCsvKeys()
  local headerDefs = bc.RecordActionStats_Battle and bc.RecordActionStats_Battle.CsvHeader or {}
  local keys = {}
  for i, def in ipairs(headerDefs) do
    local key = string.split(def, "|")[1]
    keys[i] = key
  end
  return keys
end

local function BuildStatsDetailCsvHeader()
  local headerDefs = bc.RecordActionStats_Battle and bc.RecordActionStats_Battle.CsvHeader or {}
  local titles = {}
  for i, def in ipairs(headerDefs) do
    local sep = def:find("|", 1, true)
    local title = def
    if sep then
      title = def:sub(sep + 1)
    end
    titles[i] = title
  end
  do return table.concat, titles end
  return table.concat, titles, ",", ipairs(headerDefs)
end

local STATS_DETAIL_CSV_HEADER = BuildStatsDetailCsvHeader()
local statsDetailPendingRows = {}
local hasInitFile = false
local pendingHtmlRefreshCsvSet = {}
local htmlRefreshTimerId

local function RecordStatsDetailCsvForHtml(relativeCsvPath)
  if not relativeCsvPath or "" == relativeCsvPath then
    return
  end
  pendingHtmlRefreshCsvSet[relativeCsvPath] = true
  if htmlRefreshTimerId then
    return
  end
  htmlRefreshTimerId = TimerManager.Instance:CreateTimer(5, -1, function()
    if not next(pendingHtmlRefreshCsvSet) then
      if htmlRefreshTimerId then
        TimerManager.Instance:StopTimer(htmlRefreshTimerId)
        htmlRefreshTimerId = nil
      end
      return
    end
    local csvPath = next(pendingHtmlRefreshCsvSet)
    if csvPath then
      pendingHtmlRefreshCsvSet[csvPath] = nil
      BattleStatsDetailUtil.RefreshHtmlAfterCsvWrite(csvPath)
    end
  end, nil)
end

local function TrimStatsDetailFileCount()
  local rootDir = CS.UnityEngine.Application.persistentDataPath
  if ApplicationUtils and ApplicationUtils.is_editor_mode and ApplicationUtils.is_editor_mode() then
    rootDir = CS.System.Environment.CurrentDirectory
  end
  local dir = rootDir .. "\\BattleLog"
  local ok, fileList = pcall(function()
    do return CS.System.IO.Directory.GetFiles, dir end
    return CS.System.IO.Directory.GetFiles, dir, "*_StatsDetail*.csv"
  end)
  if not (ok and fileList) or fileList.Length <= 10 then
    return
  end
  local infoList = {}
  for i = 0, fileList.Length - 1 do
    local file = fileList[i]
    local writeTime = CS.System.IO.File.GetLastWriteTime(file).Ticks
    infoList[#infoList + 1] = {path = file, writeTime = writeTime}
  end
  table.sort(infoList, function(a, b)
    return a.writeTime > b.writeTime
  end)
  for i = 11, #infoList do
    pcall(function()
      CS.System.IO.File.Delete(infoList[i].path)
    end)
  end
end

local function ParseBoutFromRow(row)
  if not row or 0 == #row then
    return 0
  end
  local first = row:match("^\"([^\"]*)\"") or row:match("^([^,]*)")
  return tonumber(first) or 0
end

local function CsvEscape(v)
  local s = tostring(v or "")
  if s:find("[,\"\n\r]") then
    s = "\"" .. s:gsub("\"", "\"\"") .. "\""
  end
  return s
end

local function WriteStatsDetailRow(row)
  local path = GetStatsDetailCsvPath()
  local ok = pcall(function()
    for _, pendingRow in ipairs(statsDetailPendingRows) do
      BattleStatsDetailUtil.AppendLine(path, pendingRow)
    end
    BattleStatsDetailUtil.AppendLine(path, row)
  end)
  if ok then
    statsDetailPendingRows = {}
    RecordStatsDetailCsvForHtml(path)
    return true
  end
  Logger.Warn("WriteStatsDetailRow failed = %s", row)
  table.insert(statsDetailPendingRows, row)
  return false
end

function BattleStatsDetailUtil.LogBattleDetail(data)
  if not ApplicationUtils.IsEditor() then
    return
  end
  if not data or type(data) ~= "table" then
    return
  end
  if not hasInitFile then
    BattleStatsDetailUtil.ClearStatsDetailCsv()
  end
  local keys = GetStatsDetailCsvKeys()
  local cells = {}
  for i, key in ipairs(keys) do
    cells[i] = CsvEscape(data[key])
  end
  WriteStatsDetailRow(table.concat(cells, ","))
end

function BattleStatsDetailUtil.ClearStatsDetailCsv()
  statsDetailPendingRows = {}
  local content = STATS_DETAIL_CSV_HEADER .. "\n"
  local base = bg.battleRender and bg.battleRender:GetLogFileName()
  if not base or "" == base then
    base = "BattleLog"
  end
  local baseName = base .. "_StatsDetail"
  local relativePath = "BattleLog/" .. baseName .. ".csv"
  local rootDir = CS.UnityEngine.Application.persistentDataPath
  if ApplicationUtils and ApplicationUtils.is_editor_mode and ApplicationUtils.is_editor_mode() then
    rootDir = CS.System.Environment.CurrentDirectory
  end
  local dir = rootDir .. "\\BattleLog"
  local ok, fileList = pcall(function()
    do return CS.System.IO.Directory.GetFiles, dir end
    return CS.System.IO.Directory.GetFiles, dir, baseName .. "*.csv", "*.csv"
  end)
  local maxIndex = -1
  if ok and fileList and fileList.Length > 0 then
    for i = 0, fileList.Length - 1 do
      local fullPath = fileList[i]
      local name = fullPath:match("([^\\/]+)$") or ""
      local num = name:match("^" .. baseName .. "_(%d+)%.csv$")
      local idx = tonumber(num) or 0
      if maxIndex < idx then
        maxIndex = idx
      end
    end
  end
  if maxIndex >= 0 then
    local nextIndex = maxIndex + 1
    relativePath = string.format("BattleLog/%s_%d.csv", baseName, nextIndex)
  end
  currentFilePath = relativePath
  BattleStatsDetailUtil.WriteAll(relativePath, content)
  RecordStatsDetailCsvForHtml(relativePath)
  TrimStatsDetailFileCount()
  hasInitFile = true
end

function BattleStatsDetailUtil.TrimStatsDetailFromBout(boutNumber)
  local keep = {}
  for _, row in ipairs(statsDetailPendingRows) do
    if boutNumber > ParseBoutFromRow(row) then
      keep[#keep + 1] = row
    end
  end
  statsDetailPendingRows = keep
  local file = io.open(GetStatsDetailCsvPath(), "rb")
  if not file then
    Logger.Warn("TrimStatsDetailFromBout file not available = %s", GetStatsDetailCsvPath())
    return
  end
  local content = file:read("*a")
  file:close()
  if not content or 0 == #content then
    return
  end
  local lines = {}
  for line in (content .. "\n"):gmatch("(.-)\n") do
    if #line > 0 then
      lines[#lines + 1] = line
    end
  end
  if #lines <= 1 then
    return
  end
  local out = {
    lines[1]
  }
  for i = 2, #lines do
    if boutNumber > ParseBoutFromRow(lines[i]) then
      out[#out + 1] = lines[i]
    end
  end
  local newContent = table.concat(out, "\n") .. "\n"
  BattleStatsDetailUtil.WriteAll(GetStatsDetailCsvPath(), newContent)
  RecordStatsDetailCsvForHtml(GetStatsDetailCsvPath())
end

function BattleStatsDetailUtil.OnChooseRewindToBout(boutNumber)
  if not boutNumber or not bg.battleRender then
    return
  end
  BattleStatsDetailUtil.TrimStatsDetailFromBout(boutNumber)
end

function BattleStatsDetailUtil.WriteAll(path, content)
  if not ApplicationUtils.IsEditor() then
    return
  end
  CS.Z1Client.BattleStatsDetailFile.WriteAll(path, content)
end

function BattleStatsDetailUtil.AppendLine(path, line)
  if not ApplicationUtils.IsEditor() then
    return
  end
  CS.Z1Client.BattleStatsDetailFile.AppendLine(path, line)
end

function BattleStatsDetailUtil.RefreshHtmlAfterCsvWrite(path)
  if not ApplicationUtils.IsEditor() then
    return
  end
  CS.Z1Client.BattleStatsDetailFile.RefreshHtmlAfterCsvWrite(path)
end

return BattleStatsDetailUtil

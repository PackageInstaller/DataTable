_class("AILogger", Object)
AILogger = AILogger

function AILogger:Constructor(world)
  self._logs = {}
  self._world = world
  self._logDate = os.date("%y%m%d%H%M%S")
end

function AILogger:SaveAILog()
  if not EDITOR then
    return
  end
  self._world:GetDetailMatchLogger():SaveAILog()
  if not _G.ENABLE_MATCH_LOG then
    return
  end
  local dir = EngineGameHelper.StoragePath .. "AILog/"
  App.MakeDir(dir)
  local _filePath = dir .. "AILog" .. self._logDate .. ".lua"
  local file = io.open(_filePath, "w+")
  file:write("AIDebugInfo={")
  file:write([[

	]])
  for monsterID, i in pairs(self._logs) do
    local stMonsterID = "  [ '" .. monsterID .. [[
' ] = 
	  { 
	]]
    file:write(stMonsterID)
    for aiConfig, o in pairs(i) do
      local stAIConfig = "[ " .. tostring(aiConfig) .. [[
 ] = 
	  { 
	]]
      file:write(stAIConfig)
      for round, q in ipairs(o) do
        local stRound = "  [ " .. tostring(round) .. [[
 ] = 
	  { 
	]]
        file:write(stRound)
        for runCount, x in ipairs(q) do
          local stRunCount = "    [ " .. tostring(runCount) .. [[
 ] = 
	 { 
	]]
          file:write(stRunCount)
          for index, t in ipairs(x) do
            local stIndex = "    [ " .. tostring(index) .. [[
 ] = 
	 { 
	]]
            file:write(stIndex)
            local st = "     TreeID=" .. tostring(t.TreeID) .. [[
,
	]]
            file:write(st)
            st = "     Type=" .. tostring(t.Type) .. [[
,
	]]
            file:write(st)
            if t.SlotID then
              local slot = "     SlotID=" .. tostring(t.SlotID) .. [[
,
	]]
              file:write(slot)
            end
            if t.Info then
              local Info = "     Info='" .. tostring(t.Info) .. [[
',
	]]
              file:write(Info)
            end
            file:write([[

	]])
            file:write("},")
          end
          file:write([[

	]])
          file:write("},")
        end
        file:write([[

	]])
        file:write("},")
        file:write([[

	]])
      end
      file:write([[

	]])
      file:write("},")
      file:write([[

	]])
    end
    file:write([[

	]])
    file:write("},")
    file:write([[

	]])
  end
  file:write("}")
  file:write([[

	]])
  io.close(file)
end

function AILogger:InitDataStruct(monsterID, entityID, round, runCount, aiConfigID)
  local monster = tostring(monsterID) .. "." .. tostring(entityID)
  if not self._logs[monster] then
    self._logs[monster] = {}
  end
  if not self._logs[monster][aiConfigID] then
    self._logs[monster][aiConfigID] = {}
  end
  if not self._logs[monster][aiConfigID][round] then
    self._logs[monster][aiConfigID][round] = {}
  end
  if not self._logs[monster][aiConfigID][round][runCount] then
    self._logs[monster][aiConfigID][round][runCount] = {}
  end
end

function AILogger:AddToLogFile(monsterID, entityID, round, runCount, aiConfigID, t)
  local monster = tostring(monsterID) .. "." .. tostring(entityID)
  table.insert(self._logs[monster][aiConfigID][round][runCount], t)
end

function AILogger:AddAIStreamLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, slotID)
  self:InitDataStruct(monsterID, entityID, round, runCount, aiConfigID)
  local t = {
    Type = AILogDataType.AISteamLog,
    TreeID = aiTreeID,
    SlotID = slotID
  }
  self:AddToLogFile(monsterID, entityID, round, runCount, aiConfigID, t)
  self._world:GetDetailMatchLogger():AddAIStreamLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, slotID)
end

function AILogger:AddAIDebugInfoLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, info)
  self:InitDataStruct(monsterID, entityID, round, runCount, aiConfigID)
  local t = {
    Type = AILogDataType.AIDebugLog,
    TreeID = aiTreeID,
    Info = info
  }
  self:AddToLogFile(monsterID, entityID, round, runCount, aiConfigID, t)
  self._world:GetDetailMatchLogger():AddAIDebugInfoLog(monsterID, entityID, round, runCount, aiConfigID, aiTreeID, info)
end

local AILogDataType = {AISteamLog = 1, AIDebugLog = 2}
_enum("AILogDataType", AILogDataType)

local WorldExitBattleStatisticsPersist = {}
local MsgPack = require("cmsgpack")
local File = CS.System.IO.File
local Directory = CS.System.IO.Directory
local Path = CS.System.IO.Path
local REL_FILE = "_game_data_/GmDebug/world_exit_copy_battle_statistics.mpack"

function WorldExitBattleStatisticsPersist.GetSavePath()
  return Utils.GetApplicationPersistenDataPath() .. "/" .. REL_FILE
end

function WorldExitBattleStatisticsPersist.EnsureDirectoryForFile(fullPath)
  local dir = Path.GetDirectoryName(fullPath)
  if dir and not Directory.Exists(dir) then
    Directory.CreateDirectory(dir)
  end
end

function WorldExitBattleStatisticsPersist.SavePayload(data)
  if type(data) ~= "table" then
    return
  end
  local ok, err = pcall(function()
    local fullPath = WorldExitBattleStatisticsPersist.GetSavePath()
    WorldExitBattleStatisticsPersist.EnsureDirectoryForFile(fullPath)
    local bytes = MsgPack.pack(data)
    File.WriteAllBytes(fullPath, bytes)
  end)
  if not ok then
    Logger.Warn("WorldExitBattleStatisticsPersist.SavePayload failed: %s", tostring(err))
  end
end

function WorldExitBattleStatisticsPersist.TryLoadPayload()
  local fullPath = WorldExitBattleStatisticsPersist.GetSavePath()
  if not File.Exists(fullPath) then
    return nil
  end
  local ok, result = pcall(function()
    local bytes = File.ReadAllBytes(fullPath)
    do return MsgPack.unpack end
    return MsgPack.unpack, bytes
  end)
  if not ok or type(result) ~= "table" then
    Logger.Warn("WorldExitBattleStatisticsPersist.TryLoadPayload failed: %s", tostring(result))
    return nil
  end
  return result
end

return WorldExitBattleStatisticsPersist

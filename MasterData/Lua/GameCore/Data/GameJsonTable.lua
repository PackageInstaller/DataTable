local ConfigData = require("GameCore.Data.ConfigData")
local GameTableDefine = require("Game.CodeGen.GAME_TABLE_DEFINE")
local pairs = _ENV.pairs
local tableInsert = table.insert
local GameJsonTable = {}

local function ForEachTableLine(tb, f)
  if f == nil or tb == nil then
    return
  end
  for k, _ in pairs(tb) do
    f(tb[k])
  end
end

local function GetTableKeys(tb)
  if tb == nil then
    return
  end
  local keys = {}
  for k, _ in pairs(tb) do
    tableInsert(keys, k)
  end
  return keys
end

function LoadGameJsonTable(sLanguage)
  for k, v in pairs(GameTableDefine.CommonTable) do
    local tab = ConfigData.LoadCommonJsonTable(k, v, sLanguage)
    GameJsonTable[k] = tab
  end
  _G.DataTable = GameJsonTable
  _G.ForEachTableLine = ForEachTableLine
  _G.GetTableKeys = GetTableKeys
end

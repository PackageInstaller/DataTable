require("GameCore.GameCore")
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResTypeAny = GameResourceLoader.ResType.Any
local typeof = _ENV.typeof
local ClientManager = CS.ClientManager
local FrameworkMiscUtils = CS.FrameworkMiscUtils
NovaAPI.EnterModule("LoginModuleScene", true)
if NovaAPI.IsEditorPlatform() then
  local function forEachLine_Story(mapLineData)
    if mapLineData.AvgLuaName ~= "" then
      local nLanIdx = GetLanguageIndex(Settings.sCurrentTxtLanguage)
      
      local sRequireRootPath = GetAvgLuaRequireRoot(nLanIdx) .. "Config/"
      local sAvgCfgPath = NovaAPI.ApplicationDataPath .. "/../Lua/" .. sRequireRootPath .. mapLineData.AvgLuaName .. ".lua"
      local isFileExists = CS.System.IO.File.Exists(sAvgCfgPath)
      if not isFileExists then
        printError("Story表中有不存在的Avg文件，请检查Story表，AvgName：" .. sAvgCfgPath)
      end
    end
  end
  
  ForEachTableLine(DataTable.Story, forEachLine_Story)
end

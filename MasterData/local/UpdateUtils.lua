local UpdateUtil = {}
local JSON
UpdateUtil.LangList = {
  "CN",
  "TW",
  "EN",
  "JP",
  "KR",
  "ID",
  "TH",
  "VN",
  "DE",
  "FR",
  "PT",
  "RU",
  "ES",
  "IT",
  "TR",
  "BN"
}

function UpdateUtil.ResolutionAdaption(notchInfo)
  if not notchInfo then
    return
  end
  local safeArea = notchInfo.safe_inset
  local curOrientation = CS.UnityEngine.Screen.orientation
  local enumLandscapeRight = CS.UnityEngine.ScreenOrientation.LandscapeRight
  local top, bottom, left, right
  local sideLength = safeArea.left > safeArea.right and safeArea.left or safeArea.right
  if curOrientation == enumLandscapeRight then
    top = safeArea.top
    bottom = safeArea.bottom
    left = sideLength
    right = sideLength
  else
    top = safeArea.bottom
    bottom = safeArea.top
    left = sideLength
    right = sideLength
  end
  local safeAreaComp = CS.UnityEngine.GameObject.Find("SafeArea")
  local adaptationScript = safeAreaComp:GetComponent(typeof(CS.UIResolutionAdaptation))
  adaptationScript.leftNotchLenth = left
  adaptationScript.rightNotchLenth = right
  adaptationScript.topNotchLenth = top
  adaptationScript.bottomNotchLenth = bottom
  adaptationScript:DoAdaptation("special")
  print("UpdateManager:ResolutionAdaption", top, bottom, left, right)
end

function UpdateUtil.__GetQzPlatformCodeFromDebugFile()
  local GameUpdateConstant = require("Constant.GameUpdateConstant")
  local pathPrefix = CS.UnityEngine.Application.persistentDataPath .. "/"
  local debugConfigFilePath = GameUpdateConstant.DebugConfigFile
  local filePath = pathPrefix .. debugConfigFilePath
  local debugFileInfo = CS.System.IO.FileInfo(filePath)
  print("[test] pathPrefix:", pathPrefix, "debugConfigFilePath:", debugConfigFilePath, "filePath:", filePath)
  if debugFileInfo.Exists then
    local debugConfig = UpdateUtil.ReadJsonCache(debugConfigFilePath)
    local fieldName = GameUpdateConstant.DebugConfigField_QzPlatformCode
    print("[test] fieldName:", fieldName, "debugConfig[fieldName]:", debugConfig and debugConfig[fieldName])
    if debugConfig and debugConfig[fieldName] then
      return debugConfig[fieldName]
    end
  end
  return nil
end

function UpdateUtil.__GetIsDebugModeFromDebugFile()
  local GameUpdateConstant = require("Constant.GameUpdateConstant")
  local pathPrefix = CS.UnityEngine.Application.persistentDataPath .. "/"
  local debugConfigFilePath = GameUpdateConstant.DebugConfigFile
  local filePath = pathPrefix .. debugConfigFilePath
  local debugFileInfo = CS.System.IO.FileInfo(filePath)
  print("[test] pathPrefix:", pathPrefix, "debugConfigFilePath:", debugConfigFilePath, "filePath:", filePath)
  if debugFileInfo.Exists then
    local debugConfig = UpdateUtil.ReadJsonCache(debugConfigFilePath)
    local fieldName = GameUpdateConstant.DebugConfigField_IsDebugMode
    if debugConfig and nil ~= debugConfig[fieldName] then
      return debugConfig[fieldName]
    end
  end
  return nil
end

function UpdateUtil.WriteCache(fileName, text)
  if nil == fileName or nil == text then
    return
  end
  if nil ~= text and type(text) == "string" then
    CS.Framework.AssetLoadUtil.OnWriteGameFile(fileName, text)
  end
end

function UpdateUtil.WriteJsonCache(fileName, data)
  if nil == fileName or nil == data then
    return
  end
  if nil ~= data and type(data) == "table" then
    if not JSON then
      JSON = require("ejoysdk_lua.ejoysdk_json")
    end
    local text = JSON.encode(data)
    CS.Framework.AssetLoadUtil.OnWriteGameFile(fileName, text)
  end
end

function UpdateUtil.ReadJsonCache(fileName)
  if not fileName then
    return
  end
  if not JSON then
    JSON = require("ejoysdk_lua.ejoysdk_json")
  end
  local text = CS.Framework.AssetLoadUtil.OnReadGameFile(fileName)
  if not text or "" == text then
    return
  end
  do return JSON.decode end
  return JSON.decode, text
end

function string:split(delimiter)
  delimiter = tostring(delimiter)
  assert("" ~= delimiter, "empty separator")
  local pos, arr = 0, {}
  for st, sp in function()
    do return string.find, self, delimiter, pos end
    return string.find, self, delimiter, pos, true
  end, nil, nil, nil do
    table.insert(arr, string.sub(self, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(self, pos))
  return arr
end

function UpdateUtil.ExitGame()
  CS.UnityEngine.Application.Quit()
end

function UpdateUtil.GetLangFont(cur_lang)
  local fontResCode = {
    CN = "UI/UI_Font/SourceFont/FZXBSK.TTF",
    TW = "LangRes/TW/UI/UI_Font/SourceFont/FZXBSK_TW.TTF",
    TH = "LangRes/TH/UI/UI_Font/SourceFont/SYST_TH.ttf",
    JP = "LangRes/JP/UI/UI_Font/SourceFont/SYST_JP.ttf",
    KR = "LangRes/KR/UI/UI_Font/SourceFont/SYST_KR.ttf",
    BN = "LangRes/BN/UI/UI_Font/SourceFont/NotoSansBengali-Regular.ttf",
    COM = "LangRes/COM/UI/UI_Font/SourceFont/SYST_COM.ttf"
  }
  local fontRes = fontResCode[cur_lang] and fontResCode[cur_lang] or fontResCode.COM
  local font = CS.Framework.AssetLoadUtil.LoadAsset(fontRes)
  return font
end

return UpdateUtil

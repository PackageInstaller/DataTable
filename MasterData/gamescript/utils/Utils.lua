local table = _ENV.table
local string = _ENV.string
local VersionTools = CS.ResourceManager.VersionTools
local JSON
local persistentDataPath = CS.UnityEngine.Application.persistentDataPath
local dataPath = CS.UnityEngine.Application.dataPath
local isEditorMode = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.WindowsEditor
local isWinPlatform = CS.Z1Client.General.OSDef.RunOS == CS.Z1Client.General.OSDef.Win32
local Z1Const = CS.FrameWork.Z1Const
local Utils = System.NewClass("Utils")
local _QZCurResVersion, _QZCurResArchieve, http_apm_inited, apm_http_comm_params, E, http, encapsulate
Utils.APUS_LOG_LEVEL = {
  Info = "INF",
  Error = "ERR",
  Critical = "CRI"
}
local APUS_ENV_TYPE = {
  P11221 = "-test",
  P11104 = "-test",
  P11222 = "-global",
  P11103 = ""
}
local APUS_ENV_DOMAIN = {
  P11221 = "ejoy",
  P11104 = "ejoy",
  P11222 = "qookkagames",
  P11103 = "ejoy"
}
local __IsDebug

function Utils.GetConstantList(listOfStrMap)
  local constCfgList = {}
  for _, str in ipairs(listOfStrMap) do
    local list = string.split(str, ":")
    table.insert(constCfgList, {
      tonumber(list[1]),
      tonumber(list[2])
    })
  end
  return constCfgList
end

function Utils.GetQZResKey()
  if _QZCurResArchieve then
    return _QZCurResArchieve
  end
  local build_type, _, _ = VersionTools.GetUsingVersionInfo(nil, nil, nil)
  _QZCurResArchieve = build_type
  return _QZCurResArchieve
end

function Utils.CanSkipUpdate()
  return not CS.Framework.AssetLoadUtil.HasABManifest()
end

function Utils.GetQZCurResVersion()
  if _QZCurResVersion then
    return _QZCurResVersion
  end
  local _, using_res_version, _ = VersionTools.GetUsingVersionInfo(nil, nil, nil)
  _QZCurResVersion = VersionTools.GetVersionStr(using_res_version)
  return _QZCurResVersion
end

function Utils.GetArchiveName()
  do return end
  return Utils.GetQZResKey, nil
end

function Utils.GetApplicationPersistenDataPath()
  if isEditorMode then
    return persistentDataPath
  end
  if isWinPlatform then
    return dataPath .. "/.."
  end
  return persistentDataPath
end

function Utils.__load_debug_file()
  local pathPrefix = Utils.GetApplicationPersistenDataPath() .. "/"
  local debugConfigFilePath = DT.GetConstant("DebugConfigFile")
  local filePath = pathPrefix .. debugConfigFilePath
  local debugFileInfo = CS.System.IO.FileInfo(filePath)
  if debugFileInfo.Exists then
    local debugConfig = Utils.ReadJsonCache(debugConfigFilePath)
    return debugConfig
  end
end

function Utils.__get_specific_server_id()
  local debugConfig = Utils.__load_debug_file()
  if not debugConfig then
    return
  end
  local fieldName = DT.GetConstant("DebugConfigField_SpecificServerId")
  if nil ~= debugConfig[fieldName] then
    return debugConfig[fieldName]
  end
  return
end

function Utils.__get_game_platform_from_debug_file()
  local debugConfig = Utils.__load_debug_file()
  if not debugConfig then
    return
  end
  local fieldName = DT.GetConstant("DebugConfigField_PlatformCode")
  if nil ~= debugConfig[fieldName] then
    return debugConfig[fieldName]
  end
  return
end

function Utils.__get_mode_from_debug_file()
  local debugConfig = Utils.__load_debug_file()
  if not debugConfig then
    return
  end
  local fieldName = DT.GetConstant("DebugConfigField_IsDebugMode")
  print("[test] debugConfig: ", table.tostring(debugConfig), "fieldName:", fieldName, "debugConfig and debugConfig[fieldName]:", debugConfig and debugConfig[fieldName])
  if nil ~= debugConfig[fieldName] then
    return debugConfig[fieldName]
  end
  return
end

function Utils.GetGamePlatform()
  if isEditorMode then
    local editorCode = Z1Const.GetEditorQzPlatformCode and Z1Const.GetEditorQzPlatformCode() or nil
    if editorCode and #editorCode > 0 then
      return editorCode
    end
    return "P11104"
  end
  local pcode
  local review_pcode = CS.Z1Client.LuaCSharpUtil.GetGameProductCode()
  if review_pcode and "" ~= review_pcode then
    return review_pcode
  end
  local pkg_build_pcode = Z1Const.GetGamePlatformCode and Z1Const.GetGamePlatformCode()
  print("[test] pkg_build_pcode == ", pkg_build_pcode)
  if pkg_build_pcode and "" ~= pkg_build_pcode then
    pcode = pkg_build_pcode
  end
  local debug_file_pcode = Utils.__get_game_platform_from_debug_file()
  if debug_file_pcode then
    pcode = debug_file_pcode
  end
  if not pcode or 0 == string.len(pcode) then
    local publishRegion = Z1Const.GetPublishRegion() or ""
    if nil == __IsDebug then
      local isDebugMode = Z1Const.IsDebugMode() or Utils.__get_mode_from_debug_file()
      __IsDebug = isDebugMode or isEditorMode
    end
    local modeAffix = __IsDebug and "debug" or "release"
    local key = string.format("PlatformCode_%s_%s", publishRegion, modeAffix)
    print("[test] GetGamePlatform:", key, DT.GetConstant(key), debug.traceback())
    do return DT.GetConstant end
    return DT.GetConstant, key, key, DT.GetConstant(key), debug.traceback()
  else
    return pcode
  end
end

function Utils.GetSteamPCode()
  return "P11104"
end

function Utils.ClearQzVersionCache()
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  local local_res_key = Utils.GetQZResKey()
  EF.repair(local_res_key)
end

function Utils.WriteCache(fileName, text)
  if nil == fileName or nil == text then
    return
  end
  if nil ~= text and type(text) == "string" then
    ApplicationUtils.OnWriteGameFile(fileName, text)
  end
end

function Utils.ReadJsonCache(fileName)
  if not fileName then
    return
  end
  if not JSON then
    JSON = require("ejoysdk_lua.ejoysdk_json")
  end
  local text = CS.Framework.AssetLoadUtil.OnReadGameFile(fileName)
  do return JSON.decode end
  return JSON.decode, text
end

function Utils.SetClearResTag(needClearRes)
  if nil == needClearRes then
    needClearRes = false
  end
  local data = Utils.ReadJsonCache("GameTags")
  local cache = data and data.clearResTag == true
  if cache == needClearRes then
    return
  end
  data = data or {}
  data.clearResTag = needClearRes
  if not JSON then
    JSON = require("ejoysdk_lua.ejoysdk_json")
  end
  local cacheText = JSON.encode(data)
  Utils.WriteCache("GameTags", cacheText)
end

function Utils.SetHasCheckInComplete(hasCheck)
  if nil == hasCheck then
    hasCheck = false
  end
  local data = Utils.ReadJsonCache("GameTags")
  local cache = data and data.hasCheckInComplete == true
  if cache == hasCheck then
    return
  end
  data = data or {}
  data.hasCheckInComplete = hasCheck
  if not JSON then
    JSON = require("ejoysdk_lua.ejoysdk_json")
  end
  local cacheText = JSON.encode(data)
  Utils.WriteCache("GameTags", cacheText)
end

function Utils.InitApmForException()
  if http_apm_inited then
    return
  end
  local apm = require("ejoysdk_lua.apm-sdk-lua.apm")
  E = require("ejoysdk_lua.ejoysdk")
  http = E.HTTP
  encapsulate = require("ejoysdk_lua.apm-sdk-lua.reporter.otlp_http")
  local ejoysdk_init = require("ejoysdk_lua.ejoysdk_init")
  ejoysdk_init.config(Utils.GetGamePlatform(), {})
  apm.init()
  apm_http_comm_params = {
    product_code = Utils.GetGamePlatform(),
    local_res_key = Utils.GetQZResKey(),
    os = E.Sysinfo.os(),
    bundle_version_name = E.Sysinfo.app_version_name(),
    bundle_version_code = E.Sysinfo.app_version_code(),
    utdid = E.Sysinfo.utdid(),
    patch_res_ver = Utils.GetQZCurResVersion()
  }
  http_apm_inited = true
end

function Utils.ReportLogByHttpPost(event_name, message, args, log_level)
  if not http_apm_inited then
    Utils.InitApmForException()
  end
  local res = {
    utdid = apm_http_comm_params.utdid,
    game_ver = apm_http_comm_params.patch_res_ver,
    env = apm_http_comm_params.product_code,
    os = apm_http_comm_params.os
  }
  local event_name_result = event_name
  args = args or {}
  for tagSymbol in string.gmatch(event_name, "%b{}") do
    local tag = string.match(tagSymbol, "%{(.+)}")
    if tagSymbol and args[tag] then
      event_name_result = string.gsub(event_name_result, tagSymbol, args[tag])
    end
  end
  args.res_key = apm_http_comm_params.local_res_key or "no_local_res_key"
  args.bundle_version_name = apm_http_comm_params.bundle_version_name
  args.bundle_version_code = apm_http_comm_params.bundle_version_code
  message = event_name_result .. " " .. message
  local logs = {
    {
      body = {
        event_name = event_name,
        module = "app",
        message = message,
        args = args,
        level = log_level,
        timestamp = os.date("%Y-%m-%d %H:%M:%S", os.time())
      },
      type = "apm_log",
      timestamp = TimeUtils.GetServerTime()
    }
  }
  local req_body = encapsulate.build_otlp_logs_v2(res, logs)
  local product_code = string.upper(apm_http_comm_params.product_code)
  local env_type = product_code and APUS_ENV_TYPE[product_code]
  local env_domain = product_code and APUS_ENV_DOMAIN[product_code]
  if product_code and env_type and env_domain then
    local url = string.format("https://apus-ingester%s.%s.com/%s/v1/logs", env_type, env_domain, product_code)
    
    local function cb(resp)
      E.LOG.debug("[report]url=" .. url .. ", not resp")
      if not resp then
        return
      end
      local status = tostring(resp.status)
      E.LOG.debug("[report]url=" .. url .. ", status=" .. status)
      if resp.status ~= 200 then
        E.LOG.error("[report]error sending " .. ",status:" .. status, ", body:", resp.body)
        E.LOG.error("[report]", resp.body)
      end
    end
    
    http.post(url, {use_gzip = true}, E.HTTP.CT_JSON, req_body, cb)
  end
end

function Utils:CheckResUpdate(cb)
  if Utils.CanSkipUpdate() then
    cb(true, false, false)
    CS.UnityEngine.Debug.LogWarning("Utils:CheckResUpdate Skip")
  else
    local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
    local res_info = {
      res_key = Utils.GetQZResKey(),
      version = Utils.GetQZCurResVersion()
    }
    EF.check_res_update(res_info, cb)
    CS.UnityEngine.Debug.LogWarning(string.format("Utils:CheckResUpdate %s %s", Utils.GetQZCurResVersion(), Utils.GetQZResKey()))
  end
end

function Utils.IsLang(langCode)
  return DataCenter.gameData.CurrTextLanguage == langCode
end

function Utils.IsLangEN()
  return not Utils.IsLangChinese()
end

function Utils.IsLangChinese()
  return DataCenter.gameData.CurrTextLanguage == cd.Lang.CN or DataCenter.gameData.CurrTextLanguage == cd.Lang.TW
end

function Utils.IsLangCN_TW_EN()
  return DataCenter.gameData.CurrTextLanguage == cd.Lang.CN or DataCenter.gameData.CurrTextLanguage == cd.Lang.TW or DataCenter.gameData.CurrTextLanguage == cd.Lang.EN
end

return Utils

local E = require("ejoysdk_lua.ejoysdk")
local JF = require("ejoysdk_lua.vendors.jf")
local JfDataComp, Super = System.NewClass("JfDataComp", Component, IUpdater)

function JfDataComp:GetJfEnvInfo()
  local pkg_info = E.get_pkg_info()
  local devInfo = {
    utdid = pkg_info.utdid,
    os = pkg_info.os,
    brand = pkg_info.brand,
    model = pkg_info.model,
    country = pkg_info.country,
    language = pkg_info.language,
    timeZone = pkg_info.time_zone,
    ip = ""
  }
  if ApplicationUtils.IsWindows() then
    if SteamSdk.Instance:IsSteam() then
      devInfo.subOs = 51
    else
      devInfo.subOs = 52
    end
  end
  if ApplicationUtils.IsEditor() then
    devInfo.subOs = 0
  end
  local gmInfo = {
    pkgName = pkg_info.pkg_name,
    appVer = pkg_info.versions.game_version,
    apkBuildSeq = pkg_info.apk_build_seq,
    bundleVersionCode = E.Sysinfo.app_version_code(),
    bundleVersionName = E.Sysinfo.app_version_name()
  }
  local chInfo = {
    ch = pkg_info.channel_id,
    subCh = pkg_info.ds_sub_channel_id
  }
  local accInfo = {accountId = ""}
  local envInfo = {
    devInfo = devInfo,
    gmInfo = gmInfo,
    chInfo = chInfo,
    accInfo = accInfo
  }
  return envInfo
end

function JfDataComp:CommitEvent(eventName, params, options)
  params = params or {}
  params.bundleVersionCode = E.Sysinfo.app_version_code()
  params.bundleVersionName = E.Sysinfo.app_version_name()
  JF.commit_event(eventName, params, options)
end

return JfDataComp

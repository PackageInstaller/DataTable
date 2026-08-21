_G.PLATFORM = UnityEngine.Application.platform
local RuntimePlatform = UnityEngine.RuntimePlatform
_G.PUBLIC = PLATFORM ~= RuntimePlatform.OSXEditor and PLATFORM ~= RuntimePlatform.WindowsEditor
_G.EDITOR = PLATFORM == RuntimePlatform.OSXEditor or PLATFORM == RuntimePlatform.WindowsEditor
_G.NOGUIDE = false
_G.NoCache = false
App.ShowFps = false
_G.NoNoticeOut = false
_G.NoPopNotice = false
_G.IsInland = false
_G.EXCEPTION_REPORT_WORKWX = false
_G.EnalbeProfLog = false
App.Profiler = false
App.SpeedStatistics = false
_G.DEBUG_AUTO_FIGHT = false
_G.USEADX2AUDIO = true
App.LodLevel = LodLevel.normal
_G.ForceSyncHP = true
_G.ENABLE_SYNC_LOG = true
_G.ENABLE_MATCH_LOG = true
_G.ENABLE_DETAIL_MATCH_LOG = true
_G.AUTO_RELOAD_GAME_CFG = false
_G.CHECK_RENDER_ACCESS_LOGIC = true

function IsNewApp()
  local appVersion = EngineGameHelper.CurrentAppVersion()
  if not appVersion or appVersion ~= "1.0.2" and appVersion ~= "1.1.0" then
    return true
  end
  return false
end

local curVer
if EDITOR then
  curVer = System.Version:New("99.99.99")
else
  curVer = System.Version:New(EngineGameHelper.CurrentAppVersion())
end
_G.OPEN_NETSTAT = false
_G.APPVER125 = curVer:CompareTo(System.Version:New("1.2.5")) > -1
_G.APPVER130 = -1 < curVer:CompareTo(System.Version:New("1.3.0"))
_G.APPVER170 = -1 < curVer:CompareTo(System.Version:New("1.7.0"))
_G.APPVER184 = -1 < curVer:CompareTo(System.Version:New("1.8.4"))
_G.APPVER1100 = -1 < curVer:CompareTo(System.Version:New("1.10.0"))
_G.APPVERNETSTAT = -1 < curVer:CompareTo(System.Version:New("1.11.0")) and _G.OPEN_NETSTAT
_G.APPVER1110 = -1 < curVer:CompareTo(System.Version:New("1.11.2"))
_G.APPVER1140 = -1 < curVer:CompareTo(System.Version:New("1.14.0"))
_G.APPVER1142 = -1 < curVer:CompareTo(System.Version:New("1.14.2"))
_G.APPVER1150 = -1 < curVer:CompareTo(System.Version:New("1.15.0"))
_G.APPVER1170 = -1 < curVer:CompareTo(System.Version:New("1.17.0"))
_G.APPVER1190 = -1 < curVer:CompareTo(System.Version:New("1.19.0"))
_G.APPVER1210 = -1 < curVer:CompareTo(System.Version:New("1.21.0"))
_G.APPVER1220 = -1 < curVer:CompareTo(System.Version:New("1.22.0"))
_G.APPVER1250 = -1 < curVer:CompareTo(System.Version:New("1.25.0"))
_G.APPVER_LAYERORDER = -1 < curVer:CompareTo(System.Version:New("1.21.0"))
_G.APPVER_1430 = -1 < curVer:CompareTo(System.Version:New("1.43.0"))

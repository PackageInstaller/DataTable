_class("UIMainLobbyDownLoadPV", Object)
UIMainLobbyDownLoadPV = UIMainLobbyDownLoadPV
local IsDownloadDTPV = {
  Not = 0,
  Loaded = 1,
  Loading = 2
}
_enum("IsDownloadDTPV", IsDownloadDTPV)

function UIMainLobbyDownLoadPV:CheckPreDownLoadPV()
  local downLoadState = IsDownloadDTPV.Not
  local PREDOWNLOAD_PV_PACKAGE_ID = 3004
  if EDITOR then
    downLoadState = IsDownloadDTPV.Loaded
  elseif HotUpdate.ActivityLuaProxy.CurrProcessingActivityID() == PREDOWNLOAD_PV_PACKAGE_ID then
    downLoadState = IsDownloadDTPV.Loading
  elseif not HotUpdate.ActivityLuaProxy.HasDownloadList(PREDOWNLOAD_PV_PACKAGE_ID) then
  else
    downLoadState = IsDownloadDTPV.Not
  end
  if downLoadState ~= IsDownloadDTPV.Not then
    Log.debug("###[fx:] loading or loaded !", downLoadState)
    return
  end
  local wifi = false
  local reach_ability = UnityEngine.Application.internetReachability
  if reach_ability == UnityEngine.NetworkReachability.NotReachable then
    Log.error("###[fx:] UnityEngine.NetworkReachability.NotReachable !")
    return
  elseif reach_ability == UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork then
    wifi = false
  elseif reach_ability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
    wifi = true
  end
  if not wifi then
    Log.debug("###[fx:] not wifi !")
    return
  end
  Log.debug("###[fx:] Download!")
  local packageID = PREDOWNLOAD_PV_PACKAGE_ID
  Log.debug("###[fx:] packageID:", packageID)
  if HotUpdate.ActivityLuaProxy.IsDownloaderBusy() then
    Log.debug("###[fx:] IsDownloaderBusy")
    local curID = HotUpdate.ActivityLuaProxy.CurrProcessingActivityID()
    if curID == packageID then
      Log.debug("###[fx:] current package is loading,Loading id is", curID, "wait a moument")
    else
      Log.debug("###[fx:] other package is loading,Loading id is", curID, "please waitting other package Loaded")
    end
    return
  end
  Log.debug("###[fx] 开始下载PV资源包:", packageID)
  HotUpdate.ActivityLuaProxy.StartDownload(packageID)
end

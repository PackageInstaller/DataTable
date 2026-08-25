local DownLoadGroup = NewClass("DownLoadGroup")
local DownloadHelper = CS.ResourceManager.DownloadHelper
local UnityTime = CS.UnityEngine.Time
local AutoRetryTime = 2

function DownLoadGroup:ctor(group_name, foreground_notification_enabled, progress_update_interval_sec, downloadDoneCB)
  self._groupName = group_name
  self._opts = {
    foreground_notification_enabled = foreground_notification_enabled or false,
    progress_update_interval_sec = progress_update_interval_sec or 1,
    integrity_check_update = {enable = true}
  }
  self._status = GroupDownStatus.Init
  self._downloadDoneCB = downloadDoneCB
  self._isWaingNetworkOk2Start = false
  self:_SetupListeners()
end

function DownLoadGroup:GetDownLoadStatus()
  return self._status
end

function DownLoadGroup:GetGroupName()
  return self._groupName
end

function DownLoadGroup:SetDelegate(delegate)
  self._delegate = delegate
end

function DownLoadGroup:GetDelagate()
  return self._delegate
end

function DownLoadGroup:Update()
  self:_TryNetworkOk2Start()
  self:_WaitingNetReachable()
  self:_TryAutoRetryDownload()
end

function DownLoadGroup:RequestDownLoadGroup()
  self._status = GroupDownStatus.Init
  self._autoRetryHotUpdate = false
  self._hasPatchDownload = false
  self._isCancelDownload = false
  self._isWaitingNetWorkReachable = false
  self._WaitingNetWorkReachableCB = nil
  self._patchDownloadVersion = nil
  self._autoRetryTimeCount = 0
  self._pacthDownloadTotalSize = 0
  self._pacthDownloadSize = 0
  self._totalSuccess = true
  self._isHotUpdateCompleted = false
  self._isWaingNetworkOk2Start = false
  if not self:_IsNetReachable() then
    self._isWaingNetworkOk2Start = true
    self._status = GroupDownStatus.NotNetwork
    return
  end
  if self._delegate and self._delegate.OnStartDownLoadRequest then
    self._delegate:OnStartDownLoadRequest()
  end
  self._status = GroupDownStatus.Downloading
  self:_StartDownoadGroup()
end

function DownLoadGroup:Print(...)
  print(string.format("[DownloadGroup %s]", self._groupName), ...)
end

function DownLoadGroup:HasPatchDownload()
  return self._hasPatchDownload
end

function DownLoadGroup:GetPatchDownloadVersion()
  return self._patchDownloadVersion
end

function DownLoadGroup:GetDownloadSize()
  return self._pacthDownloadSize
end

function DownLoadGroup:GetDownloadTotalSize()
  return self._pacthDownloadTotalSize
end

function DownLoadGroup:_SetupListeners()
  self._listeners = {
    on_confirm_res_update = function(update_info, confirm_update_cb)
      self:_OnReceiveResUpdateConfirmed(update_info, confirm_update_cb)
    end,
    on_res_download_progress_change_listener = function(state, progress_info)
      self:_OnResDownloadProgressChanged(state, progress_info)
    end,
    on_res_apply_progress_change_listener = function(state, progress_info)
      self:_OnResApplyProgressChanged(state, progress_info)
    end,
    on_group_res_update_complete = function(update_result, ...)
      self:_OnHotUpdateCompleted(update_result, ...)
    end
  }
end

function DownLoadGroup:_TryAutoRetryDownload()
  if self._autoRetryHotUpdate then
    self._autoRetryTimeCount = self._autoRetryTimeCount + UnityTime.deltaTime
    if self._autoRetryTimeCount >= AutoRetryTime and self:_IsNetReachable() then
      self._autoRetryTimeCount = 0
      self._curRetryTimes = (self._curRetryTimes or 0) + 1
      self._autoRetryHotUpdate = false
      self:Print("[DownLoadGroupBase] Hot Update Failed, Auto Retry！", self._groupName)
      self:RequestDownLoadGroup()
    end
  end
end

function DownLoadGroup:_TryNetworkOk2Start()
  if self._isWaingNetworkOk2Start and self:_IsNetReachable() then
    self._isWaingNetworkOk2Start = false
    self:RequestDownLoadGroup()
  end
end

function DownLoadGroup:_WaitingNetReachable()
  if self._isWaitingNetWorkReachable and self:_IsNetReachable() and not self:_IsNetCarrierData() then
    self._isWaitingNetWorkReachable = false
    if self._WaitingNetWorkReachableCB then
      self._WaitingNetWorkReachableCB(true)
    end
  end
end

function DownLoadGroup:_GetDownLoadFileLocalPath()
  local E = require("ejoysdk_lua.ejoysdk")
  local file_dir = "files/"
  if E.Sysinfo.os() == "windows" then
    file_dir = ""
  elseif E.Sysinfo.os() == "ios" then
    file_dir = "Documents/"
  end
  return file_dir .. DownloadHelper.GetDownloadRelativePath()
end

function DownLoadGroup:_GetPackageFilesLocalPath()
  local E = require("ejoysdk_lua.ejoysdk")
  local relativePath = ""
  if E.Sysinfo.os() == "windows" then
    relativePath = "Morimens_Data/StreamingAssets"
  elseif E.Sysinfo.os() == "ios" then
    relativePath = "Data/Raw"
  end
  return relativePath
end

function DownLoadGroup:_GetDiskFreeSize()
  local GetAvailableDiskSpace = CS.Z1Client.LuaCSharpUtil.GetAvailableDiskSpace
  local free_size = GetAvailableDiskSpace and GetAvailableDiskSpace() or -1
  print("_GetDiskFreeSize==free_size=", free_size)
  if -1 == free_size then
    local E = require("ejoysdk_lua.ejoysdk")
    local storage_data = E and E.Sysinfo and E.Sysinfo.get_storage_info() or nil
    free_size = storage_data and storage_data.internal_available_storage_size or 0
    print("_GetDiskFreeSize==free_size=1111==", free_size)
  end
  return free_size
end

function DownLoadGroup:_IsDiskFull(total_size)
  local free_size = self:_GetDiskFreeSize()
  if free_size and free_size > 0 and total_size >= 209715200 and free_size < DownLoadGroup.GetDiskNeedSize(total_size) then
    return true
  end
  return false
end

function DownLoadGroup.GetDiskNeedSize(total_size)
  return total_size * 2.2
end

local SizeUnit = {
  KB = 1024,
  MB = 1048576,
  GB = 1073741824,
  TB = 1099511627776
}

function DownLoadGroup.GetSizeFmt(size)
  local ret
  if size >= SizeUnit.TB then
    ret = string.format("%.2f %s", size / SizeUnit.TB, "TB")
  elseif size >= SizeUnit.GB then
    ret = string.format("%.2f %s", size / SizeUnit.GB, "GB")
  elseif size >= SizeUnit.MB then
    ret = string.format("%.2f %s", size / SizeUnit.MB, "MB")
  elseif size >= SizeUnit.KB then
    ret = string.format("%.2f %s", size / SizeUnit.KB, "KB")
  else
    ret = string.format("%.2f %s", size, "B")
  end
  return ret
end

function DownLoadGroup:_OnReceiveResUpdateConfirmed(update_info, confirm_update_cb)
  local total_size = update_info.total_size
  local has_new_update = update_info.has_new_update
  local new_version = update_info.new_version
  local file_list_type = update_info.file_list_type
  self._patchDownloadVersion = new_version
  self._pacthDownloadTotalSize = total_size
  self._pacthDownloadSize = 0
  self._hasPatchDownload = has_new_update
  self._isCancelDownload = false
  self:Print("[DownLoadGroup][update_step][_OnReceiveResUpdateConfirmed] has_new_update=", has_new_update, new_version, file_list_type, total_size, self._groupName)
  if has_new_update then
    local function conformCB(isConfirm)
      if isConfirm then
        if not self:_TryCheckDiskFull() then
          GroupDownloadMgr.Instance:SaveDownloadingVersion(new_version)
        else
          isConfirm = false
          self:_ShowDiskFullDialog()
        end
      end
      confirm_update_cb(isConfirm)
      if self._delegate and self._delegate.OnConfirmDownload then
        self._delegate:OnConfirmDownload(isConfirm)
      end
    end
    
    self:_StartDownLoadRes(total_size, conformCB)
  else
    confirm_update_cb(true)
  end
  return true
end

function DownLoadGroup:_CheckIsDiskFull(total_size, confirm_update_cb)
  if self:_IsDiskFull(total_size) then
    self._status = GroupDownStatus.DiskFull
    local tipsParams = DownLoadGroup.GetSizeFmt(DownLoadGroup.GetDiskNeedSize(total_size))
    Alert.ShowWithParams(20188, {tipsParams}, function()
      confirm_update_cb(false)
      self._isCancelDownload = true
      GroupDownloadMgr.Instance:SetPlayerCancelDownload(true)
      GroupDownloadMgr.Instance:StopDownloadAllGroups()
      ApplicationUtils.ExitGame()
    end, function()
      self._isCancelDownload = false
      self._status = GroupDownStatus.Downloading
      confirm_update_cb(true)
    end)
  else
    confirm_update_cb(true)
  end
end

function DownLoadGroup:_StartDownLoadRes(total_size, confirm_update_cb)
  self._status = GroupDownStatus.WaitingConfirm
  
  local function confirm_updateFunc(isConfirm)
    if isConfirm then
      self._isCancelDownload = false
      self._status = GroupDownStatus.Downloading
      GroupDownloadMgr.Instance:SetPlayerCancelDownload(false)
      self:_TryNetworkWift(total_size, confirm_update_cb)
    else
      self._isCancelDownload = true
      GroupDownloadMgr.Instance:SetPlayerCancelDownload(true)
      GroupDownloadMgr.Instance:StopDownloadAllGroups()
      self._status = GroupDownStatus.Cancel
      confirm_update_cb(false)
    end
  end
  
  self:_OnConfirmDialog(total_size, confirm_updateFunc)
end

function DownLoadGroup:_TryNetworkWift(total_size, confirm_update_cb)
  if self:_IsNetCarrierData() and total_size >= 209715200 then
    self._status = GroupDownStatus.WaitingWifi
    
    local function confirm_updateFunc(isConfirm)
      if isConfirm then
        self._isCancelDownload = false
        self:_CheckIsDiskFull(total_size, confirm_update_cb)
      else
        self._isCancelDownload = true
        GroupDownloadMgr.Instance:StopDownloadAllGroups()
        self._status = GroupDownStatus.Cancel
        confirm_update_cb(false)
      end
    end
    
    if self._delegate and self._delegate.OnNetCarrierData then
      self._delegate:OnNetCarrierData()
    end
    self:_OnNetCarrierData(total_size, confirm_updateFunc)
  else
    confirm_update_cb(true)
  end
end

function DownLoadGroup:_OnResDownloadProgressChanged(state, progress_info)
  self:Print("[DownLoadGroup] _OnResDownloadProgressChanged >> ", progress_info.percent, progress_info.downloading_size, progress_info.total_size, progress_info.total_count, progress_info.finish_count, self._groupName)
  GroupDownloadMgr.Instance:SaveDownLoadSize(progress_info.downloading_size or 0)
  self._pacthDownloadTotalSize = progress_info.total_size
  self._pacthDownloadSize = progress_info.downloading_size
  GroupDownloadMgr.Instance:SaveDownLoadSize(progress_info.downloading_size)
  if self._delegate and self._delegate.OnDownloadProgressing then
    self._delegate:OnDownloadProgressing(progress_info.downloading_size, progress_info.total_size)
  end
end

function DownLoadGroup:_OnHotUpdateCompleted(update_result, ...)
  self:Print("[DownLoadGroup][update_step][_OnHotUpdateCompleted] update_result=", self._hasPatchDownload, update_result, self._groupName)
  self._isHotUpdateCompleted = true
  self:_HandleHotUpdateCompleted(update_result, ...)
end

function DownLoadGroup:_HandleHotUpdateCompleted(update_result, ...)
  self._autoRetryHotUpdate = false
  if self._isCancelDownload then
    self._totalSuccess = false
    return
  end
  self._isHotUpdateCompleted = true
  self._totalSuccess = self._totalSuccess and update_result
  self:Print("[DownLoadGroup][update_step][_HandleHotUpdateCompleted] totalSuccess=", self._totalSuccess)
  if self._totalSuccess then
    GroupDownloadMgr.Instance:SaveDownloadingVersion("0")
    self._autoRetryHotUpdate = false
    self._status = GroupDownStatus.Successed
    GroupDownloadMgr.Instance:SaveDownLoadSize(0)
    GroupDownloadMgr.Instance:SetGroupDownload(self._groupName)
    GroupDownloadMgr.Instance:ClearInGameDownloadGroup()
    self:_CommitFinishJFData()
    self:Print("[DownLoadGroup] Hot Update _OnDownloadGroupSuccess")
    if self._delegate and self._delegate.OnDownloadGroupSuccess then
      self._delegate:OnDownloadGroupSuccess()
    end
    if self._downloadDoneCB then
      self._downloadDoneCB()
    end
  else
    self._status = GroupDownStatus.Failed
    self._isHotUpdateCompleted = false
    local err_code, err_msg = ...
    self:Print("[DownLoadGroup] Hot Update _OnDownloadGroupFailed", err_code, err_msg)
    self:_OnDownloadGroupFailed(err_code, err_msg)
  end
end

function DownLoadGroup:_OnResApplyProgressChanged(state, progress_info)
  self._autoRetryHotUpdate = false
  
  local function cmdFunc()
    self:Print("[DownLoadGroup][_OnResApplyProgressChanged] state=", state)
    if "idle" == state then
      self:Print("_OnResApplyProgressChanged   idle")
      self._status = GroupDownStatus.Unzip
      if self._delegate and self._delegate.OnApplyResStart then
        self._delegate:OnApplyResStart()
      end
    elseif "complete" == state then
      self:Print("_OnResApplyProgressChanged   complete")
      self._totalSuccess = true
      self._status = GroupDownStatus.UnzipSuccessed
      if self._delegate and self._delegate.OnApplyResComplete then
        self._delegate:OnApplyResComplete()
      end
    elseif "patch" == state then
      local pb = progress_info and progress_info.percent or nil
      self:Print("_OnResApplyProgressChanged   patch=", pb)
      if self._delegate and self._delegate.OnApplyPatchingRes then
        self._delegate:OnApplyPatchingRes(pb)
      end
    elseif "check" == state then
      local pb = progress_info and progress_info.percent or nil
      self:Print("_OnResApplyProgressChanged   check=", pb)
      if self._delegate and self._delegate.OnApplyCheckingResMD5 then
        self._delegate:OnApplyCheckingResMD5(pb)
      end
    elseif "re_download" == state then
      local pb = progress_info and progress_info.percent or nil
      self:Print("_OnResApplyProgressChanged   re_download=", pb)
      if self._delegate and self._delegate.OnApplyResRedownload then
        self._delegate:OnApplyResRedownload(pb)
      end
    elseif "failed" == state then
      self:Print("_OnResApplyProgressChanged   failed")
      self._totalSuccess = false
      self._status = GroupDownStatus.Failed
      if self._delegate and self._delegate.OnApplyResFailed then
        self._delegate:OnApplyResFailed()
      end
    end
  end
  
  cmdFunc()
end

function DownLoadGroup:_IsNetReachable()
  return CS.UnityEngine.Application.internetReachability ~= CS.UnityEngine.NetworkReachability.NotReachable
end

function DownLoadGroup:_IsNetCarrierData()
  return CS.UnityEngine.Application.internetReachability == CS.UnityEngine.NetworkReachability.ReachableViaCarrierDataNetwork
end

function DownLoadGroup:_GetRemainDownloadSize(total_size)
  local downloadSize = GroupDownloadMgr.Instance:LoadDownLoadSize() or 0
  local remainSize = total_size
  if total_size > downloadSize then
    remainSize = total_size - downloadSize
  end
  return remainSize
end

function DownLoadGroup:_StartDownoadGroup()
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  if nil ~= EF then
    self:Print("[DownLoadGroup][_StartDownoadGroup]", self._groupName)
    EF.group_res_update(self._groupName, nil, self._opts, self._listeners)
  end
end

function DownLoadGroup:_OnConfirmDialog(total_size, cb)
  local remainSize = self:_GetRemainDownloadSize(total_size)
  local tipsParams = DownLoadGroup.GetSizeFmt(remainSize)
  Alert.ShowWithParams(20192, {tipsParams}, function()
    self:_CommitRejectJFData()
    cb(false)
  end, function()
    cb(true)
  end)
end

function DownLoadGroup:_OnNetCarrierData(total_size, cb)
  local remainSize = self:_GetRemainDownloadSize(total_size)
  local tipsParams = DownLoadGroup.GetSizeFmt(remainSize)
  Alert.ShowWithParams(20186, {tipsParams}, function()
    cb(false)
  end, function()
    cb(true)
  end)
end

function DownLoadGroup:_TryCheckDiskFull()
  local free_size = self:_GetDiskFreeSize()
  if free_size and free_size > 0 and free_size < 104857600 then
    return true
  end
  return false
end

function DownLoadGroup:_ShowDiskFullDialog()
  Alert.Show("DiskSpaceNotEnough", function()
    ApplicationUtils.ExitGame()
  end, function()
    local ingameDownloadGroup = GroupDownloadMgr.Instance:GetInGameDownloadGroup()
    if ingameDownloadGroup then
      ingameDownloadGroup:RequestDownLoadGroup()
    else
      GroupDownloadMgr.Instance:DownloadIngameGroup(true)
    end
  end)
end

function DownLoadGroup:_OnDownloadGroupFailed(err_code, err_msg)
  if self:_TryCheckDiskFull() then
    err_code = 7011015
  end
  if 7011015 == err_code then
    self:_OnDownloaFailWithRetry(err_code, err_msg)
    self:_ShowDiskFullDialog()
    return
  end
  self:Print("[DownLoadGroup] Hot Update Failed Continue Auto")
  if self._curRetryTimes and self._curRetryTimes >= 3 then
    self:_OnDownloaFailWithRetry(err_code, err_msg)
  else
    self._autoRetryHotUpdate = true
    self._autoRetryTimeCount = 0
    if not self._curRetryTimes then
      self._curRetryTimes = 0
    end
  end
end

function DownLoadGroup:_OnDownloaFailWithRetry(err_code, err_msg)
  self._autoRetryHotUpdate = false
  self._curRetryTimes = 0
  if self._delegate and self._delegate.OnDownloadGroupFailed then
    self._delegate:OnDownloadGroupFailed(err_code, err_msg)
  end
end

function DownLoadGroup:_CommitFinishJFData()
  local event_params = {}
  event_params.action = "Finish"
  event_params.groupName = self._groupName
  event_params.isNewbie = tostring(self._delegate ~= nil)
  SdkMgr.Instance:JfCommitEvent(CommonDefine.SdkJfEventNameType.IngameDownload, event_params)
end

function DownLoadGroup:_CommitRejectJFData()
  local event_params = {}
  event_params.action = "Reject"
  event_params.groupName = self._groupName
  event_params.isNewbie = tostring(self._delegate ~= nil)
  SdkMgr.Instance:JfCommitEvent(CommonDefine.SdkJfEventNameType.IngameDownload, event_params)
end

return DownLoadGroup

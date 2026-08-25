local UpdateGroupBase = class("UpdateGroupBase")
local UpdateManager = require("UpdateManager")
local UpdateUtils = require("UpdateUtils")
local UIMsgPopup = require("UI.UIMsgPopup")
local DownloadHelper = CS.ResourceManager.DownloadHelper
local Language = require("Lang.Language")
local ApusUpdateComp = require("ApusUpdateComp")
local Apus_Event_Name = UpdateManager.Apus_Event_Name

function UpdateGroupBase:ctor(group_name, foreground_notification_enabled, progress_update_interval_sec, groupIndex)
  self._groupName = group_name
  self._opts = {
    foreground_notification_enabled = foreground_notification_enabled or false,
    progress_update_interval_sec = progress_update_interval_sec or 1,
    integrity_check_update = {enable = true}
  }
  self.groupIndex = groupIndex or 0
  self.progressReach = {
    25,
    50,
    75
  }
  self:_SetupListeners()
end

function UpdateGroupBase:GetGroupName()
  return self._groupName
end

function UpdateGroupBase:Update()
end

function UpdateGroupBase:RequestDownLoadGroup()
  self._hasPatchDownload = false
  self._patchDownloadVersion = nil
  self._pacthDownloadTotalSize = 0
  self._pacthDownloadSize = 0
  self._confirm_update_cb = nil
  self._totalSuccess = true
  self._applyingResPercent = 0
  self._isHotUpdateCompleted = false
  self._hasReceiveResUpdateConfirmed = false
  self._progressRange = -1
  self:_StartDownoadGroup()
end

function UpdateGroupBase:SetProgressRange(pr)
  self._progressRange = pr or -1
end

function UpdateGroupBase:GetProgress()
  if not self:HasPatchDownload() then
    return 0
  end
  local tlSize = self:GetDownloadTotalSize()
  if 0 == tlSize then
    return 0
  end
  local dlSize = self:GetDownloadSize()
  local dlPb = dlSize / tlSize * 1 * self._progressRange
  local applyPb = self._applyingResPercent / 100 * 0 * self._progressRange
  return dlPb + applyPb
end

function UpdateGroupBase:Print(...)
  UpdateManager.MyPrint(...)
end

function UpdateGroupBase:IsDownloadSuccess()
  return self._totalSuccess
end

function UpdateGroupBase:IsHotUpdateCompleted()
  return self._isHotUpdateCompleted
end

function UpdateGroupBase:HasPatchDownload()
  return self._hasPatchDownload
end

function UpdateGroupBase:GetPatchDownloadVersion()
  return self._patchDownloadVersion
end

function UpdateGroupBase:GetDownloadSize()
  return self._pacthDownloadSize
end

function UpdateGroupBase:GetDownloadTotalSize()
  return self._pacthDownloadTotalSize
end

function UpdateGroupBase:HasReceiveResUpdateConfirmed()
  return self._hasReceiveResUpdateConfirmed
end

function UpdateGroupBase:GetApplyingResPercent()
  return self._applyingResPercent
end

function UpdateGroupBase:ConfirmUpdate(confirm)
  if not self._confirm_update_cb then
    return
  end
  self._confirm_update_cb(confirm)
end

function UpdateGroupBase:_SetupListeners()
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

function UpdateGroupBase:_GetDownLoadFileLocalPath()
  local E = require("ejoysdk_lua.ejoysdk")
  local file_dir = "files/"
  if E.Sysinfo.os() == "windows" then
    file_dir = ""
  elseif E.Sysinfo.os() == "ios" then
    file_dir = "Documents/"
  end
  return file_dir .. DownloadHelper.GetDownloadRelativePath()
end

function UpdateGroupBase:_GetPackageFilesLocalPath()
  local E = require("ejoysdk_lua.ejoysdk")
  local relativePath = ""
  if E.Sysinfo.os() == "windows" then
    relativePath = "Morimens_Data/StreamingAssets"
  elseif E.Sysinfo.os() == "ios" then
    relativePath = "Data/Raw"
  end
  return relativePath
end

function UpdateGroupBase:_OnReceiveResUpdateConfirmed(update_info, confirm_update_cb)
  local total_size = update_info.total_size
  local has_new_update = update_info.has_new_update
  local new_version = update_info.new_version
  local file_list_type = update_info.file_list_type
  self._patchDownloadVersion = new_version
  self._pacthDownloadTotalSize = total_size
  self._pacthDownloadSize = 0
  self._hasPatchDownload = has_new_update
  self._hasReceiveResUpdateConfirmed = true
  self._confirm_update_cb = confirm_update_cb
  self:Print("[UpdateGroupBase][update_step][_OnReceiveResUpdateConfirmed] has_new_update=", has_new_update, new_version, file_list_type, total_size, self._groupName)
  self:UploadApusInfo("On received one group update confirm", 4, {
    new_ver = new_version,
    has_new_update = has_new_update,
    total_size = total_size
  })
  UpdateManager:OnReceiveResUpdateConfirmed(self)
  return true
end

function UpdateGroupBase:_OnResDownloadProgressChanged(state, progress_info)
  self:Print("[UpdateGroupBase] _OnResDownloadProgressChanged >> ", progress_info.percent, progress_info.downloading_size, progress_info.total_size, progress_info.total_count, progress_info.finish_count, self._groupName)
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  if state == EF.DOWNLOAD_STATE.COMPLETE then
    self:Print("on_res_state_change complete", self._groupName)
  end
  UpdateManager:SaveDownLoadSize(self._groupName, progress_info.downloading_size)
  self._pacthDownloadTotalSize = progress_info.total_size
  self._pacthDownloadSize = progress_info.downloading_size
  self:_CheckCommitProgress(progress_info and progress_info.percent)
  UpdateManager:OnResDownloadProgressChanged(self)
end

function UpdateGroupBase:_OnHotUpdateCompleted(update_result, ...)
  self:Print("[UpdateGroupBase][update_step][_OnHotUpdateCompleted] update_result=", self._hasPatchDownload, update_result, self._groupName)
  self._isHotUpdateCompleted = true
  self:_HandleHotUpdateCompleted(update_result, ...)
end

function UpdateGroupBase:_HandleHotUpdateCompleted(update_result, ...)
  self._isHotUpdateCompleted = true
  self._hasReceiveResUpdateConfirmed = true
  self._totalSuccess = self._totalSuccess and update_result
  self:Print("[UpdateGroupBase][update_step][_HandleHotUpdateCompleted] totalSuccess=", self._totalSuccess, self._groupName)
  if self._totalSuccess then
    self._applyingResPercent = 100
    UpdateManager:SaveDownLoadSize(self._groupName, 0)
    self:UploadApusInfo("On group update sucess", 6, {
      hasPatchDownload = self._hasPatchDownload
    })
    UpdateManager.SetGroupDownload(self:GetGroupName())
    self:_OnDownloadGroupSuccess()
  else
    local err_code, err_msg = ...
    self:UploadApusInfo("On group update failed", 7, {
      err_code = error_code,
      err_msg = err_msg
    })
  end
  UpdateManager:OnGroupHotUpdateFinished(self, ...)
end

function UpdateGroupBase:_OnResApplyProgressChanged(state, progress_info)
  local progress = progress_info and progress_info.percent or 0
  self:UploadApusInfo("On res apply state", 8, {state = state, progress = progress})
  
  local function cmdFunc()
    self:Print("[UpdateGroupBase][_OnResApplyProgressChanged] state=", state, self._groupName)
    if "idle" == state then
      self:Print("_OnResApplyProgressChanged   idle", self._groupName)
      UpdateManager:OnResApplyStart(self)
    elseif "complete" == state then
      self:Print("_OnResApplyProgressChanged   complete", self._groupName)
      self._totalSuccess = true
      UpdateManager:OnApplyResComplete(self)
    elseif "patch" == state then
      self._applyingResPercent = progress
      self:Print("_OnResApplyProgressChanged   patch=", self._applyingResPercent, self._groupName)
      UpdateManager:OnResApplyProgressChanged(self)
    elseif "check" == state then
      self:Print("_OnResApplyProgressChanged   check=", progress, self._groupName)
    elseif "re_download" == state then
      self._applyingResPercent = progress
      self:Print("_OnResApplyProgressChanged   re_download=", progress, self._groupName)
      UpdateManager:OnReloadLoadRes(self)
    elseif "failed" == state then
      self:Print("_OnResApplyProgressChanged   failed", self._groupName)
      self._totalSuccess = false
      UpdateManager:OnResApplyProgressFailed(self)
    end
  end
  
  cmdFunc()
end

function UpdateGroupBase:_StartDownoadGroup()
  self:UploadApusInfo("Start req download group", 1)
  local EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  if nil ~= EF then
    self:Print("[UpdateGroupBase][_StartDownoadGroup]", self._groupName)
    EF.group_res_update(self._groupName, nil, self._opts, self._listeners)
  end
  self:UploadApusInfo("Finish req res update", 2)
end

function UpdateGroupBase:_OnDownloadGroupSuccess()
end

function UpdateGroupBase:_CheckCommitProgress(progress_percent)
  if not (progress_percent and self.progressReach) or #self.progressReach <= 0 then
    return false
  end
  local commit_percent
  for idx, percent in ipairs(self.progressReach) do
    if percent <= progress_percent then
      table.remove(self.progressReach, idx)
      commit_percent = percent
      break
    end
  end
  if commit_percent then
    self:UploadApusInfo("On group update progress", 5, {percent = commit_percent})
  end
end

function UpdateGroupBase:UploadApusInfo(key, index, msgData)
  msgData = msgData or {}
  msgData.groupName = self._groupName
  msgData.index = self:_GetStepIndex(index)
  ApusUpdateComp.UploadApusInfo(Apus_Event_Name, key, msgData)
end

function UpdateGroupBase:_GetStepIndex(index)
  return self.groupIndex * 100 + index
end

return UpdateGroupBase

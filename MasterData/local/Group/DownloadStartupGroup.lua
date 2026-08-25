local UpdateManager = require("UpdateManager")
local Language = require("Lang.Language")
local UIMsgPopup = require("UI.UIMsgPopup")
local UpdateUtils = require("UpdateUtils")
local DownloadGroup = require("Group.DownloadGroup")
local DownloadStartupGroup, Super = class("DownloadStartupGroup", DownloadGroup)
local EF, RTM
local Application = CS.UnityEngine.Application
local RP_WindowsPlayer = CS.UnityEngine.RuntimePlatform.WindowsPlayer
local GameUpdater = CS.Z1ClientUpdater.GameUpdater

function DownloadStartupGroup:ctor()
  Super.ctor(self, "default", true, 1, 0)
  EF = require("ejoysdk_lua.res.ejoysdk_res_facade_v2")
  RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
  self._resArchieveName = UpdateManager.local_res_key
  self.productCode = UpdateManager.productCode
  self:Print("[DownloadStartupGroup]resArchieveName=", self._resArchieveName)
end

function DownloadStartupGroup:_SetupListeners()
  local on_show_app_update_ui_listener
  if Application.platform == RP_WindowsPlayer then
    function on_show_app_update_ui_listener(update_info, close_cb)
      self:_ShowAppUpdateUiListener(update_info, close_cb)
    end
  end
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
    on_startup_config_changed = function(cur_product_code, is_review, public_startup_config, review_startup_config, cb)
      self:_OnGameConfigChanged(cur_product_code, is_review, public_startup_config, review_startup_config, cb)
    end,
    on_startup_update_complete = function(update_result, ...)
      self:_OnHotUpdateCompleted(update_result, ...)
    end,
    on_show_app_update_ui = on_show_app_update_ui_listener
  }
end

function DownloadStartupGroup:_ShowAppUpdateUiListener(update_info, close_cb)
  if UpdateManager.is_review then
    close_cb()
    return
  end
  if not update_info or 1 ~= update_info.isNeedUpdate then
    close_cb()
    return
  end
  local isForceUpdated = 0 == update_info.updateType
  local tipsText = Language.Text("PackageUpdateTips")
  UIMsgPopup:Show(tipsText, nil, function()
    CS.UnityEngine.Application.OpenURL(update_info.updateUrl)
    close_cb()
    UpdateUtils.ExitGame()
  end, Language.Text("GotoDownLoad"), function()
    if isForceUpdated then
      UpdateUtils.ExitGame()
      return
    end
    close_cb()
  end, "取消")
end

function DownloadStartupGroup:_OnGameConfigChanged(cur_product_code, is_review, public_startup_config, review_startup_config, cb)
  local review_product_code = review_startup_config and review_startup_config.product_code
  self:Print("on_startup_config_changed >> ", cur_product_code, is_review, public_startup_config, review_startup_config)
  UpdateManager.is_review = is_review
  self:UploadApusInfo("On startup config changed", 3, {qz_pcode = cur_product_code, is_review = is_review})
  if is_review and review_product_code then
    GameUpdater.Instance.gamePlatformCode = review_product_code
  end
  cb()
end

function DownloadStartupGroup:_StartDownoadGroup()
  self:Print("BeginQingzhouUpdate start")
  local relativeDownloadPath = self:_GetDownLoadFileLocalPath()
  local relativePackagePath = self:_GetPackageFilesLocalPath()
  self:Print("[DownloadStartupGroup]relativeDownloadPath=", relativeDownloadPath)
  self:Print("[DownloadStartupGroup]relativePackagePath=", relativePackagePath)
  local patchResVersion = UpdateManager.package_newer_version
  local inAppResVersion = UpdateManager.inapp_version
  self:Print("[DownloadStartupGroup]patchResVersion&patchResVersion=", tostring(patchResVersion), tostring(inAppResVersion))
  self._updateResInfo = {
    pkg_res_path = relativePackagePath,
    res_key = self._resArchieveName,
    version = patchResVersion,
    pkg_res_version = inAppResVersion,
    res_save_base_path = relativeDownloadPath,
    res_save_storage_type = RTM.STORAGE_TYPE.EXTERNAL_APP_PRIVATE
  }
  self:UploadApusInfo("Start req download group", 1)
  if nil ~= EF then
    EF.startup_res_update(self.productCode, self._updateResInfo, self._opts, self._listeners)
  end
  self:UploadApusInfo("Finish req res update", 2)
end

function DownloadStartupGroup:_OnDownloadGroupSuccess()
  self:Print("[DownloadStartupGroup]_OnDownloadGroupSuccess=")
end

return DownloadStartupGroup

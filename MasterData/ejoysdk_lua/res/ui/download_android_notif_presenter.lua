local DIF = require("ejoysdk_lua.res.ui.download_ui_presenter_interface")
local PUSH = require("ejoysdk_lua.push.ejoysdk_push")
local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local Lang = require("ejoysdk_lua.lang.util")
local VC = require("ejoysdk_lua.ejoysdk_version_check")
local VENDOR_NAME = "ANDROID_NOTIF"
local M = DIF:Inherit(VENDOR_NAME)
local TAG = "download_android_notif_presenter"
local _notify_id = PUSH.NOTIFY_ID_SDK_INNER.NOTIFY_ID_FOREGROUND_SERVICE
local last_log_progress = -1
local DEFAULT_PROGRESS_STYLE_HAS_PROGRESS = 1
local DEFAULT_PROGRESS_STYLE_NO_PROGRESS = 0
local default_progress_style = DEFAULT_PROGRESS_STYLE_HAS_PROGRESS
M.PROGRESS_STYLE = {PROGRESS_STYLE_HAS_PROGRESS = DEFAULT_PROGRESS_STYLE_HAS_PROGRESS, PROGRESS_STYLE_NO_PROGRESS = DEFAULT_PROGRESS_STYLE_NO_PROGRESS}
M.NOTIFICATION_ACTION = {
  ACTION_INVOKE_LUA = "ACTION_INVOKE_LUA",
  ACTION_STOP_SERVICE = "ACTION_STOP_SERVICE"
}

function M.set_default_progress_style(style)
  default_progress_style = style
  E.LOG.debug(TAG, "set_default_progress_style:" .. tostring(default_progress_style))
end

function M.present_download_complete()
  local _title = Lang.getString("noti_download_finish_title", "游戏资源下载完成")
  local _local_text = Lang.getString("noti_download_finish_desc", "请点击切换游戏完整版本体验~")
  local task_info = {
    title = _title,
    left_text = _local_text,
    right_text = "",
    task_status = 1,
    task_id = _notify_id,
    task_status_icon = "",
    progress = 100,
    progress_visibility = false
  }
  local ext = {}
  PUSH.update_foreground_service_notification(task_info, ext, true)
  PUSH.stop_notification_service_foreground()
end

function M.cancel_download_notification()
  _ejoysdk.log("cancel_download_notification for id:" .. tostring(_notify_id))
  PUSH.remove_local_notification(_notify_id)
end

function M.present_downloading(progress_info)
  local _title_txt_placeholder = Lang.getString("noti_downloading_title", "游戏资源下载中：${progress}%")
  local _speed_txt_placeholder = "${speed} KB/s"
  local _progress_txt_placeholder = "${downloading_size_in_mega}/${total_size_in_mega}M"
  local downloading_size_in_mega = progress_info.downloading_size / 1024 / 1024
  downloading_size_in_mega = string.format("%.1f", downloading_size_in_mega)
  local total_size_in_mega = progress_info.total_size / 1024 / 1024
  total_size_in_mega = string.format("%.1f", total_size_in_mega)
  local _right_text = string.gsub(_progress_txt_placeholder, "${downloading_size_in_mega}", tostring(downloading_size_in_mega))
  _right_text = string.gsub(_right_text, "${total_size_in_mega}", tostring(total_size_in_mega))
  local speed_format_txt = string.format("%.1f", progress_info.speed)
  local _local_text = string.gsub(_speed_txt_placeholder, "${speed}", tostring(speed_format_txt))
  local _title = string.gsub(_title_txt_placeholder, "${progress}", tostring(progress_info.progress))
  local task_info = {
    title = _title,
    left_text = _local_text,
    right_text = _right_text,
    task_status = 1,
    task_action = M.NOTIFICATION_ACTION.ACTION_STOP_SERVICE,
    task_id = _notify_id,
    task_status_icon = "epn_stop_service",
    progress = progress_info.progress
  }
  local ext = {}
  if last_log_progress ~= progress_info.progress then
    _ejoysdk.log("present_download_progress:" .. tostring(progress_info.progress) .. ", downloading_size:" .. tostring(downloading_size_in_mega) .. ", total_size:" .. tostring(total_size_in_mega))
  end
  PUSH.update_foreground_service_notification(task_info, ext, false)
end

function M.present_download_progress(progress_info)
  if progress_info.state == RTM.DOWNLOAD_STATE.COMPLETE then
    E.LOG.debug(TAG, "present_download_progress complete")
    E.LOG.debug(TAG, "present_download_progress before present_download_complete")
    M.present_download_complete()
  else
    M.present_downloading(progress_info)
  end
end

local function get_progress_with_custom_config(custom_config)
  local config = {}
  if custom_config.is_progress_visible ~= nil then
    config.is_progress_visible = custom_config.is_progress_visible
  elseif default_progress_style == DEFAULT_PROGRESS_STYLE_HAS_PROGRESS then
    config.is_progress_visible = true
  else
    config.is_progress_visible = false
  end
  if nil ~= custom_config.is_status_icon_visible then
    config.is_status_icon_visible = custom_config.is_status_icon_visible
  elseif default_progress_style == DEFAULT_PROGRESS_STYLE_HAS_PROGRESS then
    config.is_status_icon_visible = true
  else
    config.is_status_icon_visible = false
  end
  config.complete_title = custom_config.complete_title or Lang.getString("noti_download_finish_title", "游戏资源下载完成")
  config.complete_left_txt = custom_config.complete_left_txt or Lang.getString("noti_download_finish_desc", "欢迎进入游戏世界～")
  config.complete_right_txt = custom_config.complete_right_txt or ""
  local default_downloading_title = default_progress_style == DEFAULT_PROGRESS_STYLE_HAS_PROGRESS and Lang.getString("noti_downloading_title", "游戏资源下载中：${progress}%") or Lang.getString("noti_downloading_static_title", "游戏资源下载中")
  config.downloading_title = custom_config.downloading_title or default_downloading_title
  local default_downloading_left_txt = default_progress_style == DEFAULT_PROGRESS_STYLE_HAS_PROGRESS and "${speed} KB/s" or ""
  config.downloading_left_txt = custom_config.downloading_left_txt or default_downloading_left_txt
  local default_downloading_right_txt = default_progress_style == DEFAULT_PROGRESS_STYLE_HAS_PROGRESS and "${downloading_size_in_mega}/${total_size_in_mega}M" or ""
  config.downloading_right_txt = custom_config.downloading_right_txt or default_downloading_right_txt
  return config
end

function M.setup_passive_mode_progress_presenter_info(progress_info, _downloading_list_info, _opts)
  _opts = _opts or {}
  local custom_config = _opts.custom_config or {}
  _opts.custom_config = nil
  local config = get_progress_with_custom_config(custom_config)
  _opts.is_progress_visible = config.is_progress_visible
  _opts.is_status_icon_visible = config.is_status_icon_visible
  if type(_opts.default_progress_style) == "number" then
    M.set_default_progress_style(_opts.default_progress_style)
  end
  local complete_title_txt_placeholder = config.complete_title
  local complete_left_txt_placeholder = config.complete_left_txt
  local complete_right_txt_placeholder = config.complete_right_txt
  local _title_txt_placeholder = config.downloading_title
  local _title_txt_static = Lang.getString("noti_downloading_static_title", "游戏资源下载中")
  local _speed_txt_placeholder = config.downloading_left_txt
  local _progress_txt_placeholder = config.downloading_right_txt
  local _downloading_size_in_mega = progress_info.downloading_size / 1024 / 1024
  _downloading_size_in_mega = string.format("%.1f", _downloading_size_in_mega)
  local _total_size_in_mega = progress_info.total_size / 1024 / 1024
  _total_size_in_mega = string.format("%.1f", _total_size_in_mega)
  local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
  local _notify_id_val = _ejoysdk.os() == "ios" and VC.compare_versions(sdk_version, "2.12.2") < 0 and tostring(_notify_id) or _notify_id
  E.LOG.debug(TAG, "setup_passive_mode_progress_presenter_info sdk_version:" .. tostring(sdk_version) .. ", _notify_id_val:" .. tostring(_notify_id_val) .. ", type of notify_id_val:" .. type(_notify_id_val))
  local progress_presenter_info = {
    progress_info = progress_info,
    present_info = {
      task_id = _notify_id_val,
      title_txt_static = _title_txt_static,
      title_txt_placeholder = _title_txt_placeholder,
      left_txt_placeholder = _speed_txt_placeholder,
      right_txt_placeholder = _progress_txt_placeholder,
      complete_title_txt_placeholder = complete_title_txt_placeholder,
      complete_left_txt_placeholder = complete_left_txt_placeholder,
      complete_right_txt_placeholder = complete_right_txt_placeholder
    },
    present_info_data = {
      progress = progress_info.progress,
      speed = progress_info.speed,
      downloading_size_in_mega = _downloading_size_in_mega,
      total_size_in_mega = _total_size_in_mega
    },
    present_info_convert = {
      downloading_size_in_mega = {
        origin_key = "downloading_size",
        target_unit = "mega"
      },
      total_size_in_mega = {origin_key = "total_size", target_unit = "mega"}
    },
    downloading_list_info = _downloading_list_info,
    opts = _opts
  }
  PUSH.setup_passive_mode_progress_presenter_info(progress_presenter_info)
end

return M

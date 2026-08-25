local AbsReceiver = require("ejoysdk_lua.cloud_game.ctrl_proxys.abs_res_download_state_ctrl_proxy")
local EMF = require("ejoysdk_lua.res.ejoy_res_model_factory")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local DMM = require("ejoysdk_lua.res.model.ejoy_http_download_multi_model")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local RECEIVER_NAME = "CDLC_CloudResModel"
local TAG = RECEIVER_NAME
local M = AbsReceiver:Inherit(RECEIVER_NAME)
local E = require("ejoysdk_lua.ejoysdk")
local listening_res_model, listening_task_tag, listening_model_name, origin_model_name, origin_model_type, origin_task_tag, ctrl_type, download_state_listener
local current_speed_kbps = 0
local current_progress_info, last_stat_progress_index, current_download_state, download_server_config

local function ensure_model_instance()
  if listening_res_model then
    return listening_res_model
  end
  listening_res_model = EMF.get_model_by_type(origin_model_type, origin_model_name)
  if listening_res_model then
    listening_model_name = listening_res_model:get_model_name()
    if listening_res_model.update_download_config then
      local dl_config = {
        foreground_notification_enabled = true,
        max_downloading_count = -1,
        use_cache_complete_file_md5 = true,
        use_independent_pool = true
      }
      if download_server_config then
        if type(download_server_config.use_cache_complete_file_md5) == "boolean" then
          dl_config.use_cache_complete_file_md5 = download_server_config.use_cache_complete_file_md5
        end
        if type(download_server_config.max_downloading_count) == "number" then
          dl_config.max_downloading_count = download_server_config.max_downloading_count
        end
        if type(download_server_config.use_independent_pool) == "boolean" then
          dl_config.use_independent_pool = download_server_config.use_independent_pool
        end
        if type(download_server_config.foreground_notification_enabled) == "boolean" then
          dl_config.foreground_notification_enabled = download_server_config.foreground_notification_enabled
        end
      end
      E.LOG.debug(TAG, "set dl_config for model type:" .. tostring(origin_model_type) .. ", name:" .. tostring(origin_model_name))
      E.log(dl_config)
      listening_res_model:update_download_config(dl_config)
    end
  end
  listening_task_tag = origin_task_tag
  E.LOG.debug("ensure_model_instance >>listening_model_type:" .. tostring(origin_model_type) .. ", model_name:" .. tostring(listening_model_name))
  E.log(tostring(listening_res_model))
  return listening_res_model
end

local function res_download_state_change_handler(model_name, task_tag, download_state)
  E.LOG.debug(TAG, "res_state_change_handler:" .. tostring(model_name) .. ", task_tag:" .. tostring(task_tag) .. ", listening_model_name:" .. tostring(listening_model_name) .. ", listening_task_tag:" .. tostring(listening_task_tag))
  ensure_model_instance()
  if model_name == listening_model_name and task_tag == listening_task_tag then
    download_state = download_state or {}
    current_download_state = download_state[DMM.STATE_KEY.STATE]
    E.LOG.debug(TAG, "res_download_state_change_handler current_download_state changed:" .. tostring(current_download_state))
    if download_state_listener then
      download_state_listener(current_download_state)
    end
    local params = {
      duration = download_state.duration or 0,
      code = download_state[DMM.STATE_KEY.ERR_CODE],
      msg = download_state[DMM.STATE_KEY.ERR_MSG]
    }
    QL.commit_action_main("mini_res_model_download_state_change", model_name, current_download_state, params)
  end
end

local function res_progress_change_handler(model_name, task_tag, progress_info)
  E.LOG.debug(TAG, "res_progress_change_handler:" .. tostring(model_name) .. ", task_tag:" .. tostring(task_tag) .. ", listening_model_name:" .. tostring(listening_model_name) .. ", listening_task_tag:" .. tostring(listening_task_tag) .. ", speed:" .. tostring(progress_info[DMM.PROGRESS_INFO_KEY.SPEED]) .. ", percent:" .. tostring(progress_info[DMM.PROGRESS_INFO_KEY.PERCENT]))
  ensure_model_instance()
  if model_name == listening_model_name and task_tag == listening_task_tag then
    current_speed_kbps = progress_info[DMM.PROGRESS_INFO_KEY.SPEED]
    current_progress_info = progress_info
    local _progress = progress_info[DMM.PROGRESS_INFO_KEY.PERCENT]
    if _progress ~= last_stat_progress_index then
      last_stat_progress_index = _progress
      local params = {
        progress = _progress,
        total_count = progress_info[DMM.PROGRESS_INFO_KEY.TOTAL_COUNT],
        speed = progress_info[DMM.PROGRESS_INFO_KEY.SPEED]
      }
      QL.commit_action_main("mini_res_model_download_progress_change", model_name, true, params)
    end
  end
end

function M.set_download_speed_limit(speed_kbps)
  if not ensure_model_instance() then
    E.LOG.warn(TAG, "set_download_speed_limit skip, model is nil")
    return
  end
  local config = {max_band_width_kbytes_per_sec = speed_kbps}
  listening_res_model:update_download_config(config)
end

function M.get_current_download_speed(cb)
  local speed_info = {actual_speed = current_speed_kbps}
  cb(speed_info)
end

function M.get_current_download_progress(cb)
  if not current_progress_info then
    cb({})
    return
  end
  if not current_download_state then
    local res_model = ensure_model_instance()
    if listening_task_tag then
      local download_state_obj = res_model:get_download_state_by_tag(listening_task_tag) or {}
      current_download_state = download_state_obj[DMM.STATE_KEY.STATE]
    end
  end
  local progress_info, current_percent_float, percent
  if current_download_state == DMM.DOWNLOAD_STATE.COMPLETE then
    progress_info = {
      [AbsReceiver.PROGRESS_INFO_KEY.PERCENT] = 1,
      [AbsReceiver.PROGRESS_INFO_KEY.RECV_BYTES] = current_progress_info[DMM.PROGRESS_INFO_KEY.TOTAL_SIZE],
      [AbsReceiver.PROGRESS_INFO_KEY.TOTAL_BYTES] = current_progress_info[DMM.PROGRESS_INFO_KEY.TOTAL_SIZE],
      [AbsReceiver.PROGRESS_INFO_KEY.DOWNLOAD_STATE] = current_download_state,
      [AbsReceiver.PROGRESS_INFO_KEY.SPEED] = 0
    }
  else
    percent = current_progress_info[DMM.PROGRESS_INFO_KEY.PERCENT]
    current_percent_float = tonumber(percent) / 100
    progress_info = {
      [AbsReceiver.PROGRESS_INFO_KEY.PERCENT] = current_percent_float,
      [AbsReceiver.PROGRESS_INFO_KEY.RECV_BYTES] = current_progress_info[DMM.PROGRESS_INFO_KEY.DOWNLOADING_SIZE],
      [AbsReceiver.PROGRESS_INFO_KEY.TOTAL_BYTES] = current_progress_info[DMM.PROGRESS_INFO_KEY.TOTAL_SIZE],
      [AbsReceiver.PROGRESS_INFO_KEY.DOWNLOAD_STATE] = current_download_state,
      [AbsReceiver.PROGRESS_INFO_KEY.SPEED] = current_progress_info[DMM.PROGRESS_INFO_KEY.SPEED]
    }
  end
  cb(progress_info)
end

function M.get_current_download_state(cb)
  if not current_download_state then
    E.LOG.warn(TAG, "get_current_download_state no state_info, now return 0")
    cb({})
    return
  end
  cb(current_download_state)
end

function M.set_impl(download_controller_type, ctrl_impl_info)
  if not ctrl_impl_info then
    E.LOG.warn(TAG, "setup skip for controller data is invalid")
    return
  end
  local _ctrl_type = download_controller_type
  local _origin_model_type = ctrl_impl_info[AbsReceiver.CONTROLLER_PARAMS.MODEL_TYPE]
  local _origin_model_name = ctrl_impl_info[AbsReceiver.CONTROLLER_PARAMS.MODEL_NAME]
  local _origin_task_tag = ctrl_impl_info[AbsReceiver.CONTROLLER_PARAMS.TASK_TAG_NAME]
  if not _origin_model_name or not _origin_task_tag then
    E.LOG.warn(TAG, "setup skip for model_name or task tag is invalied")
    return
  end
  if _ctrl_type ~= ctrl_type or _origin_model_type ~= origin_model_type or _origin_model_name ~= origin_model_name or _origin_task_tag ~= origin_task_tag then
    E.LOG.debug(TAG, "set_impl model changed, now close before model cache")
    M.close()
  end
  ctrl_type = _ctrl_type
  origin_model_type = _origin_model_type
  origin_model_name = _origin_model_name
  origin_task_tag = _origin_task_tag
  if not download_server_config then
    local CC = require("ejoysdk_lua.ejoysdk_config_center")
    local biz_config = CC.get_config(CC.NAMESPACE.EJOYSDK_BIZ)
    if biz_config and biz_config.config then
      download_server_config = biz_config.config.cloud_download_switch
      E.LOG.debug(TAG, "get cloud_download_switch in setup >>")
      E.log(download_server_config)
    end
  end
  ensure_model_instance()
  ET.subscribe(ET.download.DOWNLOAD_MULTI_TASK_DOWNLOAD_PROGRESS_CHANGED, res_progress_change_handler)
  ET.subscribe(ET.download.DOWNLOAD_MULTI_TASK_STATE_CHANGED, res_download_state_change_handler)
end

function M.get_ctrl_type()
  return ctrl_type
end

function M.close()
  ET.unsubscribe(ET.download.DOWNLOAD_MULTI_TASK_DOWNLOAD_PROGRESS_CHANGED, res_progress_change_handler)
  ET.unsubscribe(ET.download.DOWNLOAD_MULTI_TASK_STATE_CHANGED, res_download_state_change_handler)
  origin_model_type = nil
  origin_model_name = nil
  origin_task_tag = nil
  listening_model_name = nil
  listening_task_tag = nil
  listening_res_model = nil
  ctrl_type = nil
end

function M.set_download_state_listener(_state_listener)
  E.LOG.debug(TAG, "set_download_state_listener received")
  download_state_listener = _state_listener
end

return M

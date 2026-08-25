local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local CIPM = require("ejoysdk_lua.cloud_game.cloud_install_pkg_manager")
local download_utils = require("ejoysdk_lua.cloud_game.download_utils")
local E = require("ejoysdk_lua.ejoysdk")
local MODEL_NAME = "EjoyInstallPkgSourceModel"
local M = RTM:Inherit(MODEL_NAME)
local TAG = MODEL_NAME
local _data = {
  res_update_info = {check_update_result = false, total_size = 0},
  res_file_list = nil,
  check_file_list_state = false,
  check_file_list_listeners = {}
}

function M:_init(_model_name)
  self._data = {
    model_name = _model_name,
    local_res_state_info = {
      [RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.UNDEFINED,
      [RTM.LOCAL_RES_STATE_INFO_KEY.DOWNLOADING_SIZE] = 0
    },
    res_update_info = {
      [RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
    },
    current_down_progress_info = {
      state = RTM.DOWNLOAD_STATE.UNDEFINED,
      speed = 0,
      progress = 0,
      total_size = 0,
      downloading_size = 0
    },
    download_progress_listener = nil
  }
  self:log_debug("_init begin")
  CIPM.init()
  CIPM.register_installed_listener(function(is_install)
    self:pkg_installed_listener(is_install)
  end)
end

function M:pkg_installed_listener(is_install)
  if is_install then
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.COMPLETE
    self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.COMPLETE
  else
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = RTM.DOWNLOAD_STATE.DOWNLOADING
    self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.DOWNLOADING
  end
  self:_on_download_progress_changed()
end

function M:_on_download_progress_changed()
  if self._data.download_progress_listener ~= nil then
    self._data.download_progress_listener(self._data.current_down_progress_info)
  end
end

function M:start_download()
  CIPM.jump_to_store_install()
  self._data.current_down_progress_info.state = RTM.DOWNLOAD_STATE.DOWNLOADING
  E.LOG.debug(TAG, "jump to store install, current state downloading")
end

function M:pause_download()
end

function M:resume_download()
end

function M:set_download_speed(_speed)
end

function M:check_res_update(cb)
  if _data.res_update_info.check_update_result == true then
    E.LOG.debug(TAG, "get_update_info already check succ, now directly return")
    cb(true, _data.res_update_info)
    return
  end
  _data.res_update_info.check_update_result = true
  _data.res_update_info[RTM.UPDATE_INFO_KEY.TOTAL_SIZE] = 0
  cb(true, _data.res_update_info)
end

function M:prepare_res_list_for_download(_res_tag_name, cb)
  self._data.res_file_list = {}
  if cb then
    cb(true, self._data.res_file_list, self._data.res_update_info, self._data.local_res_state_info)
  end
end

function M:check_local_res_state(_res_name, cb)
  download_utils.check_pkg_install_state(function(pkg_install_state_info)
    E.LOG.debug(TAG, "check pkg install state >>")
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.STATE] = pkg_install_state_info[download_utils.STATE_KEY.STATE]
    self._data.local_res_state_info[RTM.LOCAL_RES_STATE_INFO_KEY.VERSION_NAME] = pkg_install_state_info[download_utils.STATE_KEY.VERSION_NAME]
    E.LOG.debug(TAG, self._data.local_res_state_info)
    cb(self._data.local_res_state_info)
  end)
end

function M:get_res_state()
  local res_state = {
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOADING_INFO] = self._data.local_res_state_info,
    [RTM.INFO_TYPE_KEY.TYPE_RES_UPDATE_STATE] = self._data.res_update_info,
    [RTM.INFO_TYPE_KEY.TYPE_DOWNLOAD_PROGRESS_INFO] = self._data.current_down_progress_info
  }
  return res_state
end

function M:register_res_state_listener(listener)
  self._data.download_progress_listener = listener
end

return M

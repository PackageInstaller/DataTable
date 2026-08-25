local E = require("ejoysdk_lua.ejoysdk")
local DMT2 = require("ejoysdk_lua.res.model.http_download_multi_task2")
local DMPT2 = require("ejoysdk_lua.res.model.http_download_multi_priority_task2")
local Class = require("ejoysdk_lua.ejoysdk_class")
local M = Class:Inherit("EjoyHttpDownloadMultiTaskFacade")
M.DOWNLOAD_STATE = DMT2.DOWNLOAD_STATE
M.PROGRESS_INFO_KEY = DMT2.PROGRESS_INFO_KEY
M.STATE_KEY = DMT2.STATE_KEY
M._UNITEST_EVENT_EXPORT = DMT2._UNITEST_EVENT_EXPORT
M.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS = DMT2.DEFAULT_PROGRESS_NOTIFY_INTERVAL_MILLIS
M.NORMAL_STARTTIME_SUBMIT_DOWNLOADING_TASK_MAX_COUNT = DMT2.NORMAL_STARTTIME_SUBMIT_DOWNLOADING_TASK_MAX_COUNT
M.NORMAL_STARTTIME_SUBMIT_MAX_COST_TIME_MS = DMT2.NORMAL_STARTTIME_SUBMIT_MAX_COST_TIME_MS
local TAG = "http_download_multi_task_facade"
local s_requested_server_config = false

function M:_init(_task_id, _file_list, _file_ext, _opts, params, _model_instance, _single_model, use_multi_download_request)
  self._data = {multi_task_impl = nil}
  local is_support_multi_download_request = E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_MULTI_DOWNLOAD_REQUEST)
  E.LOG.debug(TAG, "is_support_multi_download_request:" .. tostring(is_support_multi_download_request) .. ", use_multi_download_request:" .. tostring(use_multi_download_request))
  if is_support_multi_download_request and use_multi_download_request then
    self._data.multi_task_impl = DMPT2:New(_task_id, _file_list, _file_ext, _opts, params, _model_instance, _single_model)
  else
    local DMT = require("ejoysdk_lua.res.model.http_download_multi_task")
    self._data.multi_task_impl = DMT:New(_task_id, _file_list, _file_ext, _opts, params, _model_instance, _single_model)
  end
end

local function _request_config_from_server()
  E.LOG.debug(TAG, "_request_namespace_res_update biz begin")
  if not s_requested_server_config then
    s_requested_server_config = true
    local ER = require("ejoysdk_lua.res.ejoysdk_res")
    local ECC = require("ejoysdk_lua.ejoysdk_config_center")
    ER.request_namespace_res_update({
      ECC.NAMESPACE.EJOYSDK_BIZ
    }, nil, function(succ, ...)
      E.LOG.debug(TAG, "request_namespace_res_update biz result:" .. tostring(succ))
    end)
  else
    E.LOG.debug(TAG, "already request config skip _request_config_from_server")
  end
end

function M:start_download()
  _request_config_from_server()
  self._data.multi_task_impl:start_download_impl()
end

function M:reset_download()
  self._data.multi_task_impl:reset_download_impl()
end

function M:stop_download(cb)
  self._data.multi_task_impl:stop_download_impl(cb)
end

function M:pause_download(cb)
  self._data.multi_task_impl:pause_download_impl(cb)
end

function M:remove_download(cb)
  self._data.multi_task_impl:remove_download_impl(cb)
end

function M:get_download_state()
  do return self._data.multi_task_impl.get_download_state_impl end
  return self._data.multi_task_impl.get_download_state_impl, self._data.multi_task_impl
end

function M:task_id()
  do return self._data.multi_task_impl.task_id_impl end
  return self._data.multi_task_impl.task_id_impl, self._data.multi_task_impl
end

function M:task_tag_name()
  do return self._data.multi_task_impl.task_tag_name_impl end
  return self._data.multi_task_impl.task_tag_name_impl, self._data.multi_task_impl
end

function M:task_info()
  do return self._data.multi_task_impl.task_info_impl end
  return self._data.multi_task_impl.task_info_impl, self._data.multi_task_impl
end

function M:is_downloading()
  do return self._data.multi_task_impl.is_downloading_impl end
  return self._data.multi_task_impl.is_downloading_impl, self._data.multi_task_impl
end

function M:get_download_properties()
  do return self._data.multi_task_impl.get_download_properties end
  return self._data.multi_task_impl.get_download_properties, self._data.multi_task_impl
end

function M:update_download_properties(properties)
  self._data.multi_task_impl:update_download_properties(properties)
end

function M:update_download_config(config)
  self._data.multi_task_impl:update_download_config(config)
end

function M:set_single_file_state_listener(listener)
  self._data.multi_task_impl:set_single_file_state_listener_impl(listener)
end

return M

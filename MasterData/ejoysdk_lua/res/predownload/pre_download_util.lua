local E = require("ejoysdk_lua.ejoysdk")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local CONFIG = require("ejoysdk_lua.res.predownload.predown_config")
local M = {}
local TAG = "EjoyPredownload#DownloadMgr#Util"

function M.get_task(res_key)
  if M.is_predownload(res_key) then
    return res_key
  end
  return RTM.RES_PREDOWNLOAD_INFO_KEY.PREFIX .. tostring(res_key)
end

function M.is_predownload(res_key)
  if E.Utils.start_with(res_key, RTM.RES_PREDOWNLOAD_INFO_KEY.PREFIX) then
    return true
  end
  return false
end

function M.get_real_res_key(res_key)
  if not E.Utils.start_with(res_key, RTM.RES_PREDOWNLOAD_INFO_KEY.PREFIX) then
    return res_key
  end
  local split_arr = E.Utils.split_string(res_key, "-")
  if split_arr and #split_arr > 1 then
    local new_split_aar = {}
    for i = 2, #split_arr do
      table.insert(new_split_aar, split_arr[i])
    end
    local real_key = table.concat(new_split_aar, "-")
    E.LOG.debug(TAG, "get_real_res_key, task_key is " .. tostring(res_key) .. ", real_key is " .. tostring(real_key))
    return real_key
  else
    E.LOG.error(TAG, "get_real_res_key fail, task_key is " .. tostring(res_key))
  end
end

function M.repair(namespace, res_key, group)
  local _res_key = res_key
  if group then
    local GRM = require("ejoysdk_lua.res.group_res_manager")
    _res_key = GRM.get_task_key(res_key, group)
  end
  local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
  PREDOWNLOAD_MGR.static_get_mgr(namespace, _res_key):clean()
end

function M.get_using_info(namespace, res_key)
  local _req_res_key = M.get_task(res_key)
  E.LOG.d(TAG, "req_res_key=" .. _req_res_key)
  local predown_res_state = RTM.static_get_local_res_state(namespace, _req_res_key)
  local predown_using_res_info = (predown_res_state or {}).using_res_info
  E.LOG.d(TAG, {predown_using_res_info = predown_using_res_info})
  return predown_using_res_info
end

function M.will_become_official(namespace, res_key)
  if M.is_predownload(res_key) == true then
    return false
  end
  local PREDOWNLOAD_MGR = require("ejoysdk_lua.res.predownload.download_manager")
  local GMR = require("ejoysdk_lua.res.group_res_manager")
  local MGR = PREDOWNLOAD_MGR.static_get_mgr(namespace, GMR.get_real_res_key(res_key)) or {}
  local ret = MGR:get_state() == PREDOWNLOAD_MGR.STATUS.FINISH and M.get_using_info(namespace, res_key) ~= nil
  E.LOG.d(TAG, "will become official:" .. tostring(ret))
  return ret
end

function M.get_config(key)
  do return CONFIG.get end
  return CONFIG.get, key
end

return M

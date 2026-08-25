local E = require("ejoysdk_lua.ejoysdk")
local SC = require("ejoysdk_lua.res.startup.startup_res_config")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local JF, APM
local M = {}
local TAG = "res_stat"
local is_jf_inited = false

local function get_jf_vendor()
  if JF then
    return JF
  end
  JF = require("ejoysdk_lua.vendors.jf")
  return JF
end

local is_apm_inited = false

local function get_apm_vendor()
  if APM then
    return APM
  end
  APM = require("ejoysdk_lua.vendors.apm")
  return APM
end

local function _init_jf()
  local configed_product = E.CONFIG.get_config("product")
  if not configed_product then
    _ejoysdk.log("not configed, cannot init jf.")
    return false
  end
  if true == is_jf_inited then
    return true
  end
  E.LOG.debug(TAG, "jf begin init")
  local jf = get_jf_vendor()
  local init_params = {}
  init_params.debug = SC.DEBUG.debuggable
  jf.init(init_params, function(succ)
    if succ then
      is_jf_inited = true
    end
  end)
  M.stat("res_update_begin", "init_jf")
  return is_jf_inited
end

local function _init_apm()
  if not E.has_apus_vendor() then
    return false
  end
  local configed_product = E.CONFIG.get_config("product")
  if not configed_product then
    _ejoysdk.log("not configed, cannot init apm.")
    return false
  end
  if true == is_apm_inited then
    return true
  end
  E.LOG.debug(TAG, "apm begin init")
  local apm = get_apm_vendor()
  local init_params = {}
  apm.init(init_params, function(succ)
    if succ then
      is_apm_inited = true
    end
  end)
  return is_apm_inited
end

function M.init_jf()
  _init_jf()
end

function M.stat(action, action_type, result, params, is_upload_now)
  local init_result = _init_jf()
  if not init_result then
    E.LOG.warn(TAG, "init_jf init failed, skip stat: " .. tostring(action) .. ", type: " .. tostring(action_type))
    return
  end
  local jf = get_jf_vendor()
  local opts = {
    [jf.OPTION_KEY.IS_PRIORITY_HIGH] = true
  }
  if is_upload_now then
    opts[jf.OPTION_KEY.IS_UPLOAD_NOW] = true
    E.LOG.debug(TAG, "stat with upload_now, now flush jf high level cache:" .. tostring(action))
    jf.flush_high_level_events()
  end
  params = params or {}
  params.action = action
  params.type = action_type
  params.result = result
  jf.commit_event("sdk.lua.action", params, opts)
  local init_apm_result = _init_apm()
  if not init_apm_result then
    E.LOG.debug(TAG, "init apm failed skip stat event to apm")
    return
  end
  E.LOG.debug(TAG, "stat action to apus, action is " .. tostring(action))
  local ETAPUS = require("ejoysdk_lua.ejoysdk_to_apus")
  ETAPUS.commit_event("sdk.lua.action", params, opts)
end

function M.stat_err(action, type, code, msg, params)
  params = params or {}
  params.code = code
  params.msg = msg
  M.stat(action, type, false, params)
end

function M.stat_app_update_not_enable(game_param_enable, config_enable)
  M.stat("qz_startup_app_update_not_enable", game_param_enable, config_enable)
end

function M.stat_update_result(result, params, code, msg)
  params = params or {}
  params.code = code
  params.msg = msg
  M.stat("qz_startup_app_update_check_result", params.type, result, params)
end

local function get_ns_rs_key(namespace, res_key)
  return tostring(namespace) .. "-" .. tostring(res_key)
end

function M.stat_startup_res_update_begin()
  M.stat("su_res_startup_update_begin", "", true)
end

function M.stat_startup_res_update_end(succ, code, msg)
  if succ then
    M.stat("su_res_startup_update_end", "", succ, nil, true)
    M.stat("su_res_startup_update_end_inner", "", succ)
  else
    M.stat_err("su_res_startup_update_end", "", code, msg)
  end
end

function M.stat_namespace_empty_upate_skip()
  M.stat("su_res_ns_empty_update_skip")
end

function M.stat_namespace_white_list(white_list_str)
  M.stat("su_res_ns_white_list", white_list_str)
end

function M.stat_request_ns_res_update_begin()
  M.stat("su_res_update_req_begin")
end

function M.stat_request_ns_res_update_end(succ, type, code, msg)
  if succ then
    M.stat("su_req_ns_res_update_end", type, succ)
  else
    M.stat_err("su_req_ns_res_update_end", type, code, msg)
  end
end

function M.stat_check_res_update_state_begin(namespace, res_key, is_force)
  M.stat("su_check_res_update_st_begin", get_ns_rs_key(namespace, res_key), is_force)
end

function M.stat_check_res_update_state_end(namespace, res_key, succ, ...)
  if succ then
    local action_type = (...)
    local params = {msg = action_type}
    M.stat("su_check_res_update_st_end", get_ns_rs_key(namespace, res_key), true, params)
  else
    local code, msg = ...
    M.stat_err("su_check_res_update_st_end", get_ns_rs_key(namespace, res_key), code, msg)
  end
end

function M.stat_res_download_result(namespace, res_key, ver, succ, ...)
  if succ then
    M.stat("su_res_download_succ", get_ns_rs_key(namespace, res_key), ver)
  else
    local code, msg = ...
    local params = {code = code, msg = msg}
    M.stat("su_res_download_fail", get_ns_rs_key(namespace, res_key), ver, params)
  end
end

function M.stat_update_wait_confirm(namespace, res_key, update_ver, local_version, is_upload_now)
  if not namespace or "" == namespace then
    return
  end
  if not res_key or "" == res_key then
    return
  end
  local res_stat_info = M.get_res_stat_info(namespace, res_key, local_version)
  local params = {}
  params = utils.merge_table(params, res_stat_info)
  params.p3 = update_ver
  local ns_rk_pk = tostring(namespace) .. "-" .. tostring(res_key) .. "-" .. tostring(res_stat_info.p1)
  M.stat("qz_stat_on_res_update_confirm", ns_rk_pk, false, params, is_upload_now)
end

function M.stat_update_wait_confirm_result(namespace, res_key, update_ver, result)
  local params = {msg = result}
  M.stat("su_update_wait_confirm_ret", get_ns_rs_key(namespace, res_key), update_ver, params)
end

function M.stat_res_update_req_end(_succ, _code, _msg)
  if _succ then
    M.stat("su_res_update_req_end", "", true)
  else
    M.stat_err("su_res_update_req_end", "", _code, _msg)
  end
end

function M.stat_download_start_info()
end

function M.stat_startup_init_begin()
  M.stat("startup_init_begin")
end

function M.stat_startup_init_end(_succ, ...)
  if _succ then
    M.stat("startup_init_end", "", true)
  else
    local code, msg = ...
    M.stat_err("startup_init_end", "", code, msg)
  end
end

function M.stat_update_prepare_begin()
  M.stat("update_prepare_begin")
end

function M.stat_update_prepare_end(_succ, ...)
  if _succ then
    M.stat("update_prepare_end", "", true)
  else
    local code, msg = ...
    M.stat_err("update_prepare_end", "", code, msg)
  end
end

function M.stat_update_check_begin()
  M.stat("update_check_begin")
end

function M.stat_update_check_end(_succ, ...)
  if _succ then
    M.stat("update_check_end", "", true)
  else
    local code, msg = ...
    M.stat_err("update_check_end", "", code, msg)
  end
end

function M.stat_on_cache_res_incompatible_begin()
  M.stat("on_cache_res_incompatible_begin")
end

function M.stat_on_cache_res_incompatible_end(_succ, ...)
  if _succ then
    M.stat("on_cache_res_incompatible_end", "", true)
  else
    local code, msg = ...
    M.stat_err("on_cache_res_incompatible_end", "", code, msg)
  end
end

function M.stat_startup_config_changed_begin()
  M.stat("startup_config_changed_begin")
end

function M.stat_startup_config_changed_end(_succ, ...)
  if _succ then
    M.stat("startup_config_changed_end", "", true)
  else
    local code, msg = ...
    M.stat_err("startup_config_changed_end", "", code, msg)
  end
end

function M.stat_on_res_complete_apply_begin()
  M.stat("on_res_complete_apply_begin")
end

function M.stat_on_res_complete_apply_end(_succ, file_list_type, ...)
  if _succ then
    local data = (...)
    M.stat("on_res_complete_apply_succ", file_list_type, tostring(data))
  else
    local code, msg = ...
    M.stat_err("on_res_complete_apply_failed", file_list_type, code, msg)
  end
end

function M.stat_on_startup_update_complete_begin()
  M.stat("on_startup_update_complete_begin")
end

function M.stat_on_startup_update_complete_end(_succ, ...)
  if _succ then
    M.stat("on_startup_update_complete_end", "", true)
  else
    local code, msg = ...
    M.stat_err("on_startup_update_complete_end", "", code, msg)
  end
end

function M.stat_down_files_begin(namespace, res_key, res_version, list_size)
  local nrk = tostring(namespace) .. "-" .. tostring(res_key)
  local params = {p1 = list_size}
  M.stat("su_down_files_begin", nrk, res_version, params)
end

function M.stat_down_files_end(namespace, res_key, res_version, list_size, succ, cost, _code, _msg)
  local nrk = tostring(namespace) .. "-" .. tostring(res_key)
  local params = {
    p1 = list_size,
    p2 = res_version,
    p3 = cost,
    code = _code,
    msg = _msg
  }
  M.stat("su_down_files_end", nrk, succ, params)
end

function M.stat_on_patch_dir_begin(namespace, res_key, diff_file_name)
  local nrk = tostring(namespace) .. "-" .. tostring(res_key)
  local params = {file = diff_file_name}
  M.stat("on_patch_dir_begin", nrk, true, params)
end

function M.stat_on_patch_dir_end(namespace, res_key, diff_file_name, succ, cost, _code)
  local nrk = tostring(namespace) .. "-" .. tostring(res_key)
  local params = {
    file = diff_file_name,
    cost = cost,
    code = _code
  }
  M.stat("on_patch_dir_end", nrk, succ, params)
end

function M.stat_on_patch_dir_md5_end(namespace, res_key, diff_file_name, succ, cost, code, msg)
  local nrk = tostring(namespace) .. "-" .. tostring(res_key)
  local params = {
    file = diff_file_name,
    cost = cost,
    code = code,
    msg = msg
  }
  M.stat("on_patch_dir_md5_end", nrk, succ, params)
end

function M.stat_on_res_update_complete(namespace, res_key, local_version, is_upload_now)
  if not namespace or "" == namespace then
    return
  end
  if not res_key or "" == res_key then
    return
  end
  local res_stat_info = M.get_res_stat_info(namespace, res_key, local_version)
  local params = {}
  params = utils.merge_table(params, res_stat_info)
  local ns_rk_pk = tostring(namespace) .. "-" .. tostring(res_key) .. "-" .. tostring(res_stat_info.p1)
  M.stat("qz_stat_on_res_update_complete", ns_rk_pk, true, params, is_upload_now)
  M.stat("qz_stat_on_res_update_complete_inner", ns_rk_pk, true, params)
end

function M.stat_on_res_update_downloading(namespace, res_key, local_version, is_upload_now)
  if not namespace or "" == namespace then
    return
  end
  if not res_key or "" == res_key then
    return
  end
  local res_stat_info = M.get_res_stat_info(namespace, res_key, local_version)
  local params = {}
  params = utils.merge_table(params, res_stat_info)
  local ns_rk_pk = tostring(namespace) .. "-" .. tostring(res_key) .. "-" .. tostring(res_stat_info.p1)
  M.stat("qz_stat_on_res_update_downloading", ns_rk_pk, true, params, is_upload_now)
  M.stat("qz_stat_on_res_update_downloading_inner", ns_rk_pk, true, params)
end

function M.stat_on_res_update_download_complete(namespace, res_key, local_version, is_upload_now)
  if not namespace or "" == namespace then
    return
  end
  if not res_key or "" == res_key then
    return
  end
  local res_stat_info = M.get_res_stat_info(namespace, res_key, local_version)
  local params = {}
  params = utils.merge_table(params, res_stat_info)
  local ns_rk_pk = tostring(namespace) .. "-" .. tostring(res_key) .. "-" .. tostring(res_stat_info.p1)
  M.stat("qz_stat_on_res_update_download_complete", ns_rk_pk, true, params, is_upload_now)
  M.stat("qz_stat_on_res_update_download_complete_inner", ns_rk_pk, true, params)
end

function M.stat_on_res_update_applying(namespace, res_key, local_version, is_upload_now)
  if not namespace or "" == namespace then
    return
  end
  if not res_key or "" == res_key then
    return
  end
  local res_stat_info = M.get_res_stat_info(namespace, res_key, local_version)
  local params = {}
  params = utils.merge_table(params, res_stat_info)
  local ns_rk_pk = tostring(namespace) .. "-" .. tostring(res_key) .. "-" .. tostring(res_stat_info.p1)
  M.stat("qz_stat_on_res_update_applying", ns_rk_pk, false, params, is_upload_now)
  M.stat("qz_stat_on_res_update_applying_inner", ns_rk_pk, false, params)
end

function M.stat_on_res_update_fail(namespace, res_key, code, msg, state, local_version, is_upload_now)
  if not namespace or "" == namespace then
    return
  end
  if not res_key or "" == res_key then
    return
  end
  local res_stat_info = M.get_res_stat_info(namespace, res_key, local_version)
  local params = {
    err_code = code,
    msg = msg,
    state = state
  }
  params = utils.merge_table(params, res_stat_info)
  local ns_rk_pk = tostring(namespace) .. "-" .. tostring(res_key) .. "-" .. tostring(res_stat_info.p1)
  M.stat("qz_stat_on_res_update_fail", ns_rk_pk, false, params, is_upload_now)
end

function M.stat_startup_res_download_list_check(namespace, res_key, download_list)
  local SU = require("ejoysdk_lua.res.startup.startup_utils")
  local game_startup_params = SC.get_game_startup_params() or {}
  local local_startup_res_infos = SC.get_startup_local_res_infos_cache() or {}
  local trim_downlist = {}
  local reuse_check = SU.can_reuse_res()
  if reuse_check then
    for _, file_info in ipairs(download_list.file_list or {}) do
      table.insert(trim_downlist, {
        name = file_info.name,
        md5 = file_info.md5,
        size = file_info.size
      })
    end
  end
  local params = {
    reuse_check = reuse_check,
    versions = {
      pkg_version = (game_startup_params[namespace] or {})[res_key] or {}.pkg_res_version or "",
      req_versions = (local_startup_res_infos[namespace] or {})[res_key] or {}.versions or {}
    },
    download_list = trim_downlist
  }
  local nrk = tostring(namespace) .. "-" .. tostring(res_key)
  M.stat("qz_stat_res_download_check", nrk, true, params)
end

function M.get_res_stat_info(namespace, res_key, _local_version)
  local ER = require("ejoysdk_lua.res.ejoysdk_res")
  local res_state = ER.get_res_state(namespace, res_key)
  local res_update_info = res_state and res_state.res_update_info or {}
  local update_body = res_update_info.update_body or {}
  local pack_key = update_body.packKey or ""
  local update_version = update_body.version or ""
  local local_version = _local_version
  if not local_version then
    local local_infos = SC.get_startup_local_res_infos()
    local ns_infos = local_infos[namespace] or {}
    local rk_infos = ns_infos[res_key] or {}
    local_version = rk_infos.version or ""
  end
  local res_stat_info = {
    p1 = pack_key,
    p2 = local_version,
    p3 = update_version
  }
  return res_stat_info
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local SIGN = require("ejoysdk_lua.libs.signature")
local RTM = require("ejoysdk_lua.res.model.ejoy_res_type_model")
local VENDOR_NAME = "SPLITPKG"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = VENDOR_NAME
local SYNC_ON_LOG_UPLOAD_RESULT = "SYNC_ON_LOG_UPLOAD_RESULT"
local SYNC_ENABLE_ASSET_MISSING_HOOK = "SYNC_ENABLE_ASSET_MISSING_HOOK"
local SYNC_DISABLE_ASSET_MISSING_HOOK = "SYNC_DISABLE_ASSET_MISSING_HOOK"
local SYNC_NOTIFY_MISSING_RESOURCE = "SYNC_NOTIFY_MISSING_RESOURCE"
local SYNC_CLEAR_ASSET_MISSING_STATE = "SYNC_CLEAR_ASSET_MISSING_STATE"
local ASYNC_SET_RES_UPDATE_INFOS = "ASYNC_SET_RES_UPDATE_INFOS"
local EVT_ON_UPLOAD_LOG_FILE = "EVT_ON_UPLOAD_LOG_FILE"
local EVT_ON_FLOATER_CLICKED = "EVT_ON_FLOATER_CLICKED"
local EVT_ON_MISSING_RESOURCE = "EVT_ON_MISSING_RESOURCE"
local UPLOAD_LOG_PATH = "/v2/subPack/uploadResource"
local PACK_CONFIG_FILE
do
  local _os = _ejoysdk.os()
  if "ios" == _os then
    PACK_CONFIG_FILE = "ejoysdk/ejoy_pack_config.json"
  else
    PACK_CONFIG_FILE = "unisdk/ejoy_pack_config.json"
  end
end
local ENV_DEBUG = {
  UPLOAD_LOG_BASE_URL = "http://ww-hk-carbon-mng-test.qookkagames.com",
  UPLOAD_LOG_SECRET = "a2bd29cf998ac3a801d05d12e87483be"
}
local ENV_PRE_RELEASE = {
  UPLOAD_LOG_BASE_URL = "https://carbon-mng-pre.lingxigames.com",
  UPLOAD_LOG_SECRET = "b47cc68492fbbf97fdf7b637d7f22608"
}
local ENV_RELEASE = {
  UPLOAD_LOG_BASE_URL = "https://carbon-mng.lingxigames.com",
  UPLOAD_LOG_SECRET = "b47cc68492fbbf97fdf7b637d7f22608"
}
local UPLOAD_LOG_BASE_URL = ENV_RELEASE.UPLOAD_LOG_BASE_URL
local UPLOAD_LOG_SECRET = ENV_RELEASE.UPLOAD_LOG_SECRET
local m_env, m_res_key, m_res_pack_key, m_res_version
local inited = false

function M.set_env(env)
  E.LOG.debug(TAG, "set_env: " .. tostring(env))
  if m_env == env then
    return
  end
  m_env = env
  local ejoy_init = require("ejoysdk_lua.ejoysdk_init")
  if env == ejoy_init.ENV.DEBUG then
    UPLOAD_LOG_BASE_URL = ENV_DEBUG.UPLOAD_LOG_BASE_URL
    UPLOAD_LOG_SECRET = ENV_DEBUG.UPLOAD_LOG_SECRET
  else
    UPLOAD_LOG_BASE_URL = ENV_RELEASE.UPLOAD_LOG_BASE_URL
    UPLOAD_LOG_SECRET = ENV_RELEASE.UPLOAD_LOG_SECRET
  end
end

local function upload_log_request(log_file, duration)
  if not log_file then
    E.LOG.warn(TAG, "upload_log_request: log_file is nil")
    return
  end
  local url = UPLOAD_LOG_BASE_URL .. UPLOAD_LOG_PATH
  local headers = {}
  headers.Date = os.date("%a, %d %b %Y %X GMT")
  local caller = "qz_sub_pack_" .. tostring(E.get_pkg_info().game_id)
  local file_name = HRU.guess_url_filename(log_file)
  local filemd5 = HRU.check_file_md5(log_file)
  local request_id = tostring(E.get_pkg_info().utdid) .. tostring(E.time_ms())
  local sign_content = "caller=" .. tostring(caller) .. "|duration=" .. tostring(duration) .. "|fileMd5=" .. tostring(filemd5) .. "|requestId=" .. tostring(request_id) .. "|resourceKey=" .. tostring(m_res_key) .. "|resourcePackKey=" .. tostring(m_res_pack_key) .. "|version=" .. tostring(m_res_version) .. "|caller_secret=" .. UPLOAD_LOG_SECRET
  local sign = SIGN.sign_string_with_md5(sign_content)
  local formdata = E.HTTP.NativeBuildFormData.New()
  formdata:add_part("caller", caller)
  formdata:add_part("duration", duration)
  formdata:add_part("fileMd5", filemd5)
  formdata:add_part("requestId", request_id)
  formdata:add_part("resourceKey", m_res_key)
  formdata:add_part("resourcePackKey", m_res_pack_key)
  formdata:add_part("version", m_res_version)
  formdata:add_file("resourceListFile", log_file, "multipart/form-data", file_name)
  formdata:add_part("sign", sign)
  E.LOG.debug(TAG, "upload_log_request: url: " .. tostring(url) .. ", caller: " .. tostring(caller) .. ", duration: " .. tostring(duration) .. ", fileMd5: " .. tostring(filemd5) .. ", requestId: " .. tostring(request_id) .. ", resourceKey: " .. tostring(m_res_key) .. ", resourcePackKey: " .. tostring(m_res_pack_key) .. ", version: " .. tostring(m_res_version) .. ", sign: " .. tostring(sign))
  E.HTTP.post(url, {
    safe_formdata = formdata:get_part(),
    headers = headers
  }, formdata:content_type(), formdata:empty_body(), function(resp)
    E.LOG.debug(TAG, "upload_log_request: resp: ")
    E.log(resp)
    local succ = true
    local code = resp.status
    local msg
    if 200 == code then
      local body_str = resp and resp.body or ""
      local body_obj = JSON.decode(body_str)
      body_obj = body_obj or {}
      local state_obj = body_obj.state or {}
      local state_msg = state_obj.desc or state_obj.msg or ""
      local state_code = state_obj.code or state_obj.subCode or -1
      if 2000000 ~= state_code then
        succ = false
        msg = state_msg
        code = state_code
      end
    else
      succ = false
    end
    if succ then
      UNI.sync_call(VENDOR_NAME, SYNC_ON_LOG_UPLOAD_RESULT, {succ = true})
      E.File.remove_fullpath(log_file)
      E.LOG.debug(TAG, "upload_log_request: success, log_file: " .. tostring(log_file) .. ", remove it successfully")
    else
      E.LOG.debug(TAG, "upload_log_request: failed, log_file: " .. tostring(log_file) .. ", code: " .. tostring(code) .. ", msg: " .. tostring(msg))
      UNI.sync_call(VENDOR_NAME, SYNC_ON_LOG_UPLOAD_RESULT, {
        succ = false,
        code = code,
        msg = msg
      })
    end
  end)
end

local EVT_HANDLERS = {}
EVT_HANDLERS[EVT_ON_UPLOAD_LOG_FILE] = function(data)
  local log_path = data and data.log_path or nil
  local duration = data and data.duration or 0
  E.LOG.debug(TAG, "EVT_ON_UPLOAD_LOG_FILE: " .. tostring(log_path) .. ", duration: " .. tostring(duration))
  upload_log_request(log_path, duration)
end
EVT_HANDLERS[EVT_ON_FLOATER_CLICKED] = function()
  E.LOG.debug(TAG, "EVT_ON_FLOATER_CLICKED received")
  M.ProgressBox.on_progressbox_clicked()
end
EVT_HANDLERS[EVT_ON_MISSING_RESOURCE] = function(data)
  E.LOG.debug(TAG, "EVT_ON_MISSING_RESOURCE: data=")
  E.log(data)
  local resource_path = data and data.path or ""
  local ERSP = require("ejoysdk_lua.res.splitpkg.presenters.ejoy_res_splitpkg_presenter")
  ERSP.open_block_popup_h5(resource_path)
end

local function load_game_res_config()
  local pack_config_content = _ejoysdk.lread(PACK_CONFIG_FILE)
  local config_data = JSON.decode(pack_config_content)
  if not config_data then
    E.LOG.error(TAG, "load_game_res_config: failed to decode config content")
    return
  end
  local resource_list_config = config_data.sub_pkg_pack_resource_list
  if not resource_list_config then
    E.LOG.warn(TAG, "load_game_res_config failed, not found sub_pkg_pack_resource_list in unisdk/ejoy_pack_config.json")
    return
  end
  m_res_key = resource_list_config.res_key
  m_res_pack_key = resource_list_config.res_pack_key
  m_res_version = resource_list_config.res_version
  E.LOG.debug(TAG, "load_game_res_config, res_key: " .. tostring(m_res_key) .. ", res_pack_key: " .. tostring(m_res_pack_key) .. ", res_version: " .. tostring(m_res_version))
end

function M.enable_missing_res_hook(enable)
  local enable_msg = enable and SYNC_ENABLE_ASSET_MISSING_HOOK or SYNC_DISABLE_ASSET_MISSING_HOOK
  UNI.sync_call(VENDOR_NAME, enable_msg, {})
end

function M.notify_missing_resource(path)
  E.LOG.debug(TAG, "notify_missing_resource, path:" .. tostring(path))
  UNI.sync_call(VENDOR_NAME, SYNC_NOTIFY_MISSING_RESOURCE, {path = path})
end

function M.clear_asset_missing_state()
  if _ejoysdk.os() ~= "android" then
    E.LOG.debug(TAG, "clear_asset_missing_state: skip on non-android platform")
    return
  end
  E.LOG.debug(TAG, "clear_asset_missing_state: notifying native to clear state")
  UNI.sync_call(VENDOR_NAME, SYNC_CLEAR_ASSET_MISSING_STATE, {})
end

function M.set_res_update_infos(infos)
  _ejoysdk.log("set_res_update_infos received")
  local params = {}
  local cjson = require("ejoysdk_lua.ejoysdk_cjson")
  local infos_str = cjson.encode(infos)
  local dest_file_name = "ejoy_splitpkg_temp/_split_update_list.json"
  E.File.remove(dest_file_name)
  local write_result = E.File.writefile(dest_file_name, infos_str)
  local file_path
  if write_result then
    file_path = E.Path.join(E.File.get_ext_file_dir(), dest_file_name)
    params.file = file_path
    _ejoysdk.log("set_res_update_infos succ file_path:" .. tostring(file_path))
  else
    params.data = infos
  end
  UNI.async_call(VENDOR_NAME, ASYNC_SET_RES_UPDATE_INFOS, params, nil, function()
    E.LOG.debug(TAG, "set_res_update_infos complete")
  end)
end

function M.init(_opt, cb)
  if inited then
    if cb then
      cb(true)
    end
    return
  end
  inited = true
  E.LOG.debug(TAG, "init entered")
  load_game_res_config()
  UNI.register_event_cb(VENDOR_NAME, function(type, body_data)
    if not type or "" == type then
      E.LOG.debug(TAG, "type is invalid")
      return
    end
    local handler = EVT_HANDLERS[type]
    if handler then
      E.LOG.debug(TAG, "handled event with type:" .. tostring(type or "nil"))
      handler(body_data)
    end
  end)
  if cb then
    cb(true)
  end
end

local ProgressBox = {
  m_onclick_listener = nil,
  m_current_progress_state = {
    state = RTM.PUBLIC_DOWNLOAD_STATE.UNKNOWN,
    progress = 0
  }
}
M.ProgressBox = ProgressBox
local SYNC_PROGRESS_BOX = "PROGRESS_BOX"
local OPERATIONS = {
  SHOW_BOX = "show_box",
  HIDE_BOX = "hide_box",
  UPDATE_BOX = "update_box",
  SHOW_TIPS = "show_tips",
  HIDE_TIPS = "hide_tips"
}

function ProgressBox.show()
  E.LOG.debug(TAG, "show_progress_box received")
  local params = {
    operation = OPERATIONS.SHOW_BOX
  }
  UNI.sync_call(VENDOR_NAME, SYNC_PROGRESS_BOX, params)
end

function ProgressBox.hide()
  E.LOG.debug(TAG, "hide_progress_box received")
  local params = {
    operation = OPERATIONS.HIDE_BOX
  }
  UNI.sync_call(VENDOR_NAME, SYNC_PROGRESS_BOX, params)
end

function ProgressBox.update_progress(progress)
  E.LOG.debug(TAG, "update_progress_box received, progress:" .. tostring(progress) .. ", current_state:" .. tostring(ProgressBox.m_current_progress_state.state))
  ProgressBox.m_current_progress_state.progress = progress
  local params = {
    operation = OPERATIONS.UPDATE_BOX,
    progress = progress
  }
  UNI.sync_call(VENDOR_NAME, SYNC_PROGRESS_BOX, params)
end

function ProgressBox.update_state(state)
  E.LOG.debug(TAG, "update_progress_box received, state:" .. tostring(state))
  ProgressBox.m_current_progress_state.state = state
  local params = {
    operation = OPERATIONS.UPDATE_BOX,
    state = state
  }
  UNI.sync_call(VENDOR_NAME, SYNC_PROGRESS_BOX, params)
end

function ProgressBox.show_tips(message)
  E.LOG.debug(TAG, "show_progress_box_tips received, message:" .. tostring(message))
  local params = {
    operation = OPERATIONS.SHOW_TIPS,
    message = message
  }
  UNI.sync_call(VENDOR_NAME, SYNC_PROGRESS_BOX, params)
end

function ProgressBox.hide_tips()
  E.LOG.debug(TAG, "hide_progress_box_tips received")
  local params = {
    operation = OPERATIONS.HIDE_TIPS
  }
  UNI.sync_call(VENDOR_NAME, SYNC_PROGRESS_BOX, params)
end

function ProgressBox.set_onclick_listener(lis)
  E.LOG.debug(TAG, "set_onclick_listener received:" .. tostring(lis))
  ProgressBox.m_onclick_listener = lis
end

function ProgressBox.on_progressbox_clicked()
  E.LOG.debug(TAG, "on_progressbox_clicked lis:" .. tostring(ProgressBox.m_onclick_listener))
  if ProgressBox.m_onclick_listener then
    ProgressBox.m_onclick_listener()
  end
end

return M

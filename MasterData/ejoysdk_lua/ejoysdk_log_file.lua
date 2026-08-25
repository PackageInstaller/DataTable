local E = require("ejoysdk_lua.ejoysdk")
local uuid = require("ejoysdk_lua.ejoysdk_uuid")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local JOSN = require("ejoysdk_lua.ejoysdk_json")
local M = {}
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "elog"
local inited = false
local can_log_local_file = false
local DEFAULT_CHECK_FILE_SIZDE = 2097152
local LOOP_CHECK_FILE_TIMER_SEC = 120
local log_dir = "ejoysdklogv1"

function M.today_str()
  local date_str = os.date("%Y-%m-%d")
  return date_str
end

function M.del_log_file(file_name, _file_path)
  local dir_file_name = string.format("%s/%s", log_dir, file_name)
  local dir_file_zip = string.format("%s/%s.zip", log_dir, file_name)
  E.File.remove(dir_file_name)
  E.File.remove(dir_file_zip)
end

function M.compress_log_file(file_path, file_name, file_index, cb)
  local src_file_path = file_path
  local tar_file_path = string.format("%s.zip", tostring(file_path))
  
  local function cb_inner(succ, ...)
    if succ then
      local z_path = (...)
      if z_path then
        M.upload_file(z_path, file_name, file_index, cb)
      end
    elseif cb then
      cb(false, -1, "compress_log_file fail, index:" .. tostring(file_index))
    end
  end
  
  E.File.zip(src_file_path, file_name, tar_file_path, cb_inner)
end

function M.upload_file(full_path, file_name, index, cb)
  if not full_path or 0 == #full_path then
    if cb then
      cb(false, -1, "upload_client_log fail path is nil:" .. tostring(index))
    end
    return
  end
  local UCL = require("ejoysdk_lua.ejoysdk_upload_log")
  local gdp = require("ejoysdk_lua.gangplank_data_provider")
  local userinfo = gdp.USER_INFO.get()
  local ufile_index = index or 0
  local ufile_id = uuid()
  local account_info = {}
  account_info.accountId = userinfo.uid
  account_info.chuid = userinfo.pid
  if userinfo.platform ~= nil and userinfo.platform ~= "" then
    account_info.chUserType = userinfo.platform
  else
    account_info.chUserType = E.get_channel()
  end
  local ext_params = {
    account_info = account_info,
    from_info = "ejoy.sdk",
    log_package_id = ufile_id,
    log_package_index = ufile_index
  }
  UCL.upload_client_log_v2(full_path, ext_params, function(succ, ...)
    if succ then
      E.log("upload_client_log_v2 suc")
      M.del_log_file(file_name, full_path)
      if cb then
        cb(true, index)
      end
    else
      E.log("upload_client_log_v2 fail")
      if cb then
        cb(false, -1, "upload_client_log fail index:" .. tostring(index))
      end
    end
  end)
end

function M.upload_files_with_date(u_date_str, cb)
  local function cb_handler(info)
    E.log(info)
    
    E.log("u_date_str:" .. tostring(u_date_str))
    if info and info.data and type(info.data) == "table" then
      local f_index = 0
      local f_count = #info.data
      local file_limit_count = 10
      if f_count >= file_limit_count then
        f_count = file_limit_count
      end
      local finish_count = 0
      local suc_count = 0
      for _, v in pairs(info.data) do
        if v.file_name and v.file_path then
          f_index = f_index + 1
          
          local function timer_cb()
            M.compress_log_file(v.file_path, v.file_name, f_index, function(suc, ...)
              if cb then
                finish_count = finish_count + 1
                if suc then
                  suc_count = suc_count + 1
                end
                if finish_count == f_count then
                  cb(true, {suc_count = suc_count, finish_count = finish_count})
                end
              end
            end)
          end
          
          E.Timer.once(f_index, timer_cb)
        end
        if file_limit_count <= f_index then
          E.log("upload_all_logs limit 10 files")
          break
        end
      end
      if f_index > 0 then
        E.scroll_log_file()
      end
    end
  end
  
  local params = {date_filter = u_date_str}
  E.get_log_file_infos(params, cb_handler)
end

function M.upload_files_today(cb)
  M.upload_files_with_date(M.today_str(), cb)
end

function M.upload_all_logs(cb)
  local function cb_handler(info)
    if info and info.data and type(info.data) == "table" then
      local f_index = 0
      
      local f_count = #info.data
      local file_limit_count = 10
      if f_count >= file_limit_count then
        f_count = file_limit_count
      end
      local finish_count = 0
      local suc_count = 0
      for _, v in pairs(info.data) do
        if v.file_name and v.file_path then
          f_index = f_index + 1
          
          local function timer_cb()
            M.compress_log_file(v.file_path, v.file_name, f_index, function(suc, ...)
              if cb then
                finish_count = finish_count + 1
                if suc then
                  suc_count = suc_count + 1
                end
                if finish_count == f_count then
                  cb(true, {suc_count = suc_count, finish_count = finish_count})
                end
              end
            end)
          end
          
          E.Timer.once(f_index, timer_cb)
        end
        if file_limit_count <= f_index then
          E.log("upload_all_logs limit 10 files")
          break
        end
      end
      if f_index > 0 then
        E.scroll_log_file()
      end
    end
  end
  
  local params = {}
  E.get_log_file_infos(params, cb_handler)
end

function M.upload_log_to_apus(url, params, log_file_path, log_file_name, opts, cb)
  if not E.is_log_file_support() or not E.has_apus_vendor() then
    cb(false, CONSTANTS.APUS_ERROR.CODE_NOT_SUPPORT, "sdk not support")
    return
  end
  if not _ejoysdk_lua_cjson then
    cb(false, CONSTANTS.APUS_ERROR.CODE_NOT_SUPPORT, "sdk version not support")
    return
  end
  if not log_file_path or not log_file_name then
    cb(false, CONSTANTS.APUS_ERROR.CODE_ERROR_PARAMS, "log_file_path and log_file_name should not be nil")
    return
  end
  M.flush()
  E.get_current_log_file({}, function(...)
    local current_file_info = (...)
    if current_file_info and current_file_info.file_path == log_file_path and tostring(current_file_info.file_name) == tostring(log_file_name) and (tonumber(current_file_info.sizes) or 0) > 0 then
      E.scroll_log_file()
    end
    local _params = params or {}
    local formdata = E.HTTP.NativeBuildFormData.New()
    formdata:add_file("log_file", log_file_path, "application/octet-stream", log_file_name)
    if params.form_header and type(params.form_header) == "table" then
      formdata:add_part("resource", JOSN.encode(_params.form_header))
    end
    local _opts = opts or {}
    E.HTTP.post(url, {
      safe_formdata = formdata:get_part(),
      headers = _params.http_header or {}
    }, formdata:content_type(), formdata:empty_body(), function(resp)
      if resp.status == 200 then
        cb(true, {log_file_path = log_file_path, log_file_name = log_file_name})
        if _opts.delete_after_upload and log_file_path then
          local dir_file_name = E.Path.join(tostring(log_dir), tostring(log_file_name))
          E.File.remove(dir_file_name)
        end
      else
        local code = resp and resp.status or -1
        local msg = resp and resp.body or ""
        if type(msg) == "string" then
          cb(false, code, tostring(msg))
        else
          cb(false, code, "")
        end
      end
    end)
  end)
end

function M.flush()
  E.flush_log()
end

function M.scroll_file_name()
  E.log("scroll_file nearest:" .. tostring(os.time()))
  E.scroll_log_file()
end

function M.check_current_file()
  local function cb_handler(info)
    if info and type(info) == "table" then
      M.flush()
      
      if (tonumber(info.sizes) or 0) > DEFAULT_CHECK_FILE_SIZDE and info.file_name then
        M.scroll_file_name()
      end
    end
  end
  
  E.get_current_log_file({}, cb_handler)
end

local function check_current_file_timer()
  if E.is_log_open() then
    E.Timer.once(LOOP_CHECK_FILE_TIMER_SEC, function()
      M.check_current_file()
      check_current_file_timer()
    end)
  end
end

local function config_log_from_cc()
  local CC = require("ejoysdk_lua.ejoysdk_config_center")
  local core_config = CC.get_config(CC.NAMESPACE.EJOYSDK_CORE)
  if core_config and core_config.config then
    local elog = core_config.config.elog
    if elog and E.open_log_from_cc then
      E.open_log_from_cc(elog)
    end
  end
end

function M.init()
  if _ejoysdk.os() ~= "android" and _ejoysdk.os() ~= "ios" and _ejoysdk.os() ~= "windows" and _ejoysdk.os() ~= "harmonyos" then
    return
  end
  if inited then
    E.LOG.debug(TAG, "already inited, just notify init success and return")
    return
  end
  inited = true
  local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
  CJSON.prepare()
  local ELOG = require("ejoysdk_lua.ejoysdk_log")
  local ej_debugable = E.get_ej_debugable()
  _ejoysdk.log("=======>ej_debugable:" .. tostring(ej_debugable))
  ELOG.setup_ej_debugable(ej_debugable)
  if ej_debugable then
    E.open_log(ej_debugable)
  elseif not E.has_apus_vendor() then
    config_log_from_cc()
  end
  if _ejoysdk.log2 then
    can_log_local_file = true
  end
  if can_log_local_file then
    check_current_file_timer()
  end
end

return M

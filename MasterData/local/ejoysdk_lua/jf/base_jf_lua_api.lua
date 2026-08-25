local E = require("ejoysdk_lua.ejoysdk")
local JF_LUA_CONFIG = require("ejoysdk_lua.jf.jf_lua_config")
local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
local LZ = _ejoysdk_crypt.zlib
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.JF .. "BASE_JF_LUA_API"
local EC = require("ejoysdk_lua.ejoysdk_constants")
local HTTP = E.HTTP
local M = {}

local function prepare_content_body(event_arr)
  local log_count = #event_arr
  E.LOG.debug(TAG, "jf_lua log count is " .. tostring(log_count))
  local encode_content
  local tmp = {}
  for _, event_log in ipairs(event_arr) do
    local str = CJSON.encode(event_log)
    if str then
      table.insert(tmp, str)
    end
  end
  if 0 == #tmp then
    E.LOG.warn(TAG, "content_body had unsupported value")
    return
  end
  encode_content = table.concat(tmp, "\n")
  E.LOG.debug(TAG, "prepare_content_body >>")
  E.LOG.debug(TAG, encode_content)
  local deflated_content, _shrink_eof = LZ.deflate(5, 31)(encode_content, "finish")
  return deflated_content
end

local function create_http_resp_handler(cb, fail_arr)
  return function(resp)
    if resp.status == 200 then
      local is_body_json_str = type(resp.body) == "string"
      local resp_body_obj = resp.body
      if is_body_json_str then
        resp_body_obj = CJSON.safe_decode(resp.body)
      end
      if resp_body_obj and 0 == resp_body_obj.code then
        cb(true, resp.body)
      else
        local safe_resp_body_obj = resp_body_obj or {}
        cb(false, safe_resp_body_obj.code or -1, "upload error")
        E.LOG.warn(TAG, "upload error")
      end
    else
      cb(false, resp.status, "HTTP error", fail_arr)
      E.LOG.warn(TAG, "http error")
    end
  end
end

function M.upload(event_arr, cb)
  local api_server = JF_LUA_CONFIG.get_api_server()
  if api_server then
    local content = prepare_content_body(event_arr)
    if not content then
      return
    end
    local form_data = E.HTTP.FormData.New()
    form_data:add_part("data", content, "binary/octet-stream", false, "xdata-log")
    local headers = {}
    headers["User-Agent"] = "AGA"
    local params = {headers = headers}
    if E.Sysinfo.os() == "weixin" then
      params.enable_http2 = true
    end
    HTTP.post(api_server, params, form_data:content_type(), form_data:build(), create_http_resp_handler(cb, event_arr))
  else
    E.LOG.warn(TAG, "jf api server is nil")
  end
end

function M.check_support_file_upload(cb)
  M.upload_file("", "", function(is_success, error_code)
    E.LOG.debug(TAG, "check_support_file_upload is_success: " .. tostring(is_success) .. ", error_code: " .. tostring(error_code))
    if error_code == EC.JF_FILE_CACHE_ERROR_CODES.LACK_PARAMS then
      cb(true)
    else
      cb(false)
    end
  end)
end

function M.upload_file(file_name, file_path, cb)
  local api_server = JF_LUA_CONFIG.get_api_server()
  if api_server then
    local file_api_server = api_server .. "_v2"
    E.LOG.debug(TAG, "upload_file file_api_server: " .. file_api_server)
    E.LOG.debug(TAG, "upload_file file_name: " .. tostring(file_name))
    local form_data = E.HTTP.NativeBuildFormData.New()
    if file_name and file_path then
      form_data:add_file("data", file_path, "application/octet-stream", file_name)
    end
    form_data:add_part("log_format", "sdk")
    local headers = {}
    headers["User-Agent"] = "AGA"
    HTTP.post(file_api_server, {
      safe_formdata = form_data:get_part(),
      headers = headers
    }, form_data:content_type(), form_data:empty_body(), create_http_resp_handler(cb, nil))
  else
    E.LOG.warn(TAG, "jf api server is nil")
  end
end

return M

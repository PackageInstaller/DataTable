local md5 = require("ejoysdk_lua.libs.md5")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "file"

local function cache_dir()
  local file_path = ""
  if E.Sysinfo.os() == "ios" then
    local paths = _ejoysdk.sysinfo_paths()
    file_path = paths.document_path
  elseif E.Sysinfo.os() == "android" then
    local dir = E.sync_call("GET_EXT_STG_DIR")
    file_path = dir.path
  elseif E.Sysinfo.os() == "weixin" then
    file_path = _ejoysdk.wx.env.USER_DATA_PATH
  elseif E.Sysinfo.os() == "douyin" then
    file_path = _ejoysdk.dy.env.USER_DATA_PATH
  end
  return file_path
end

local function get_file_data(path)
  local rfile = io.open(path, "r")
  if not rfile then
    return ""
  end
  local current = rfile:read("*all")
  return current, md5.sumhexa(current)
end

function M.download_file(url, opts, cb)
  local function safeCallCb(a_cb, ...)
    if a_cb and type(a_cb) == "function" then
      a_cb(...)
    end
  end
  
  if not cb or type(cb) ~= "function" then
    return
  end
  opts = opts or {}
  if not url or type(url) ~= "string" then
    safeCallCb(cb, false, 0, "url invalid")
    return
  else
    local is_http = 1 == string.find(url, "http://") or 1 == string.find(url, "https://")
    if not is_http then
      safeCallCb(cb, false, 0, "not http protocol")
      return
    end
  end
  local need_bin_data = opts.loadBinData == true
  local is_native_call = true == opts.isNativeCall
  local file_name = url:match("([^/]+)$")
  local local_save_path = cache_dir() .. "/" .. file_name
  local param = {
    progress = function(_url, _file, _recv, _total)
    end,
    finish_cb = function()
    end,
    file = local_save_path
  }
  E.HTTP.get(url, param, function(resp)
    if resp.status == 200 then
      local file_data, md5_value = get_file_data(local_save_path)
      local body = {
        fileLocalPath = local_save_path or "",
        md5 = md5_value or ""
      }
      if need_bin_data and true ~= is_native_call and file_data then
        body.fileData = file_data
      end
      safeCallCb(cb, true, body)
    else
      safeCallCb(cb, false, 0, "download fail")
    end
  end)
end

return M

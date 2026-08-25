local JSON = require("ejoysdk_lua.ejoysdk_json")
local GDP = require("ejoysdk_lua.gangplank_data_provider")
local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local string_len = string.len
local string_sub = string.sub
local MAX_SIZE = 4194304
local M = {}
local _TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "upload_log"

local function string_end_with(str, end_str)
  local st = string_len(str) - string_len(end_str) + 1
  if st < 1 then
    return false
  end
  return string_sub(str, st) == end_str
end

function M.get_max_size()
  return MAX_SIZE
end

function M.set_max_size(new_size)
  if new_size and type(new_size) == "number" then
    MAX_SIZE = new_size
  end
end

function M.upload_client_log(file_path_name)
  local url = E.CONFIG.get_config("log-collector") .. "/client_api/upload_log"
  _ejoysdk.log(">>>>>>>>>>>>>>> upload_client_log begin2:" .. tostring(file_path_name))
  if not string_end_with(file_path_name, ".zip") then
    _ejoysdk.log(string.format("file_path_name is not a zip file, file_path_name = '%s'", file_path_name))
    return
  end
  local data
  if E.Sysinfo.os() == "ios" then
    data = E.sync_call("read_file", file_path_name)
  else
    data = _ejoysdk.lread(file_path_name)
  end
  _ejoysdk.log(">>>>>>>>>>>>>>> upload_client_log begin3:" .. tostring(file_path_name))
  if not data then
    _ejoysdk.log(string.format("file no found. file_path_name = '%s'", file_path_name))
    return
  end
  _ejoysdk.log(">>>>>>>>>>>>>>> upload_client_log begin4:" .. tostring(file_path_name))
  _ejoysdk.log("file length:" .. tostring(#data) .. ", max length:" .. tostring(MAX_SIZE))
  if #data > MAX_SIZE then
    _ejoysdk.log("file too large. must less than " .. tostring(MAX_SIZE / 1048576) .. "M")
    return
  end
  local player_id = GDP.PLAYER_INFO.get("player_id")
  local json = {
    player_id = player_id,
    device_id = E.Sysinfo.device_id()
  }
  local formdata = E.HTTP.FormData.New()
  formdata:add_simple_part("_json", JSON.encode(json))
  formdata:add_part("log_file", data, false, false, file_path_name)
  _ejoysdk.log("upload_client_log url " .. url)
  E.HTTP.post(url, {
    acceptable = E.HTTP.CT_JSON
  }, formdata:content_type(), formdata:build(), function(resp)
    if resp.status ~= 200 then
      E.log({
        error = "send event error",
        resp = resp
      })
    else
      local body = resp.body
      if body and (0 == body.code or 200 == body.code) then
        _ejoysdk.log(string.format("upload_client_log ok. file_path_name = '%s'", file_path_name))
      else
        E.log({
          error = "send event error",
          resp = resp
        })
      end
    end
  end)
end

function M.upload_client_log_v2(file_path_name, params, cb)
  local url = E.CONFIG.get_config("log-collector") .. "/client_api/upload_log"
  if not string_end_with(file_path_name, ".zip") then
    _ejoysdk.log(string.format("file_path_name is not a zip file, file_path_name = '%s'", file_path_name))
    return
  end
  local data
  if E.Sysinfo.os() == "ios" then
    data = E.sync_call("read_file", file_path_name)
  else
    data = _ejoysdk.lread(file_path_name)
  end
  if not data then
    _ejoysdk.log(string.format("file no found. file_path_name = '%s'", file_path_name))
    return
  end
  _ejoysdk.log("file length:" .. tostring(#data) .. ", max length:" .. tostring(MAX_SIZE))
  if #data > MAX_SIZE then
    _ejoysdk.log("file too large. must less than " .. tostring(MAX_SIZE / 1048576) .. "M")
    return
  end
  local player_id = GDP.PLAYER_INFO.get("player_id")
  local device_id = E.Sysinfo.utdid() or E.Sysinfo.device_id()
  local json = {
    player_id = player_id,
    device_id = device_id,
    ext = params or {}
  }
  local formdata = E.HTTP.FormData.New()
  formdata:add_simple_part("_json", JSON.encode(json))
  formdata:add_part("log_file", data, false, false, file_path_name)
  _ejoysdk.log("upload_client_log url " .. url)
  E.HTTP.post(url, {
    acceptable = E.HTTP.CT_JSON
  }, formdata:content_type(), formdata:build(), function(resp)
    if resp.status ~= 200 then
      E.log({
        error = "send event error",
        resp = resp
      })
    else
      local body = resp.body
      if body and (0 == body.code or 200 == body.code) then
        _ejoysdk.log(string.format("upload_client_log2 ok. file_path_name = '%s'", file_path_name))
        cb(true)
      else
        E.log({
          error = "send event error",
          resp = resp
        })
        cb(false, resp.status or -1, "request error")
      end
    end
  end)
end

return M

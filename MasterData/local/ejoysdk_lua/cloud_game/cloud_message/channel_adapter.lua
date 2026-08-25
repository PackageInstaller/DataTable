local MSG_CHANNEL = require("ejoysdk_lua.cloud_game.cloud_message.msg_channel")
local pack_config = require("ejoysdk_lua.cloud_game.cloud_message.pack_config")
local E = require("ejoysdk_lua.ejoysdk")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local CRASH = require("ejoysdk_lua.vendors.crashsdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.CLOUD_GAME .. "channel_adapter"
local msg_channel

local function stat_channel_error(err_msg)
  CSTAT.stat_err_msg(err_msg)
  if E.Sysinfo.os() == "windows" then
    E.LOG.warn(TAG, "stat_channel_error upload crash stat begin :" .. tostring(err_msg))
    local md5_err_msg
    if type(_ejoysdk_crypt.md5) == "function" then
      md5_err_msg = _ejoysdk_crypt.md5(err_msg)
    elseif type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.sum then
      md5_err_msg = _ejoysdk_crypt.hexencode(_ejoysdk_crypt.md5.sum(err_msg))
    end
    local ext_params = CSTAT.get_cloud_stat_info()
    local ok, encode_params = pcall(JSON.encode, ext_params)
    local ext_data = ""
    if ok then
      ext_data = tostring(encode_params)
    end
    CRASH.create_custom_log("exception", "on_connect_error", err_msg, md5_err_msg, ext_data)
  end
end

function M.create_msg_channel(ip, port, pkg_name, ok_cb)
  stat_channel_error("create_msg_channel begin, its not error")
  if msg_channel then
    E.LOG.debug(TAG, "重复创建msg_channel")
    return msg_channel
  end
  pack_config.init_pkg_name(pkg_name)
  local is_init = false
  msg_channel = MSG_CHANNEL.create(ip, port, function()
    if not is_init then
      E.LOG.debug(TAG, "create_msg_channel success")
      is_init = true
      if ok_cb then
        ok_cb()
      end
    end
  end, function(err_msg)
    local connect_err_msg = "on_connect_error:" .. tostring(err_msg)
    E.LOG.warn(TAG, connect_err_msg)
    stat_channel_error(connect_err_msg)
  end, function(err_msg)
    local on_err_msg = "on_error:" .. tostring(err_msg)
    E.LOG.warn(TAG, on_err_msg)
    stat_channel_error(on_err_msg)
  end)
end

function M.set_message_handle(on_message)
  msg_channel:set_message_handler(on_message)
end

function M.send_message(data, callback, id)
  local function send_cb(succ, ...)
    if callback then
      callback(succ, ...)
    end
    if not succ then
      local code, msg_body, _send_id = ...
      msg_body = msg_body or {}
      local err_msg = msg_body.error_msg or ""
      stat_channel_error(err_msg .. ", " .. tostring(code))
    end
  end
  
  msg_channel:send_msg(data, send_cb, id)
end

function M.parse_command_line()
  local function parse()
    local origin_cmd = _ejoysdk.get_command_line()
    
    print("parse_command_line origin_cmd:", origin_cmd)
    local cmd = string.gsub(origin_cmd, "\"([^\"]*)\"", "")
    cmd = string.gsub(cmd, "^[ \t\n\r]+", "")
    print("parse_command_line parse_cmd:", cmd)
    
    local function split(str, reps)
      local resultStrList = {}
      string.gsub(str, "[^" .. reps .. "]+", function(w)
        table.insert(resultStrList, w)
      end)
      return resultStrList
    end
    
    local params = split(cmd, " ")
    local tb = {}
    for i = 1, #params, 2 do
      tb[params[i]] = params[i + 1]
      print(params[i], params[i + 1])
    end
    return tb
  end
  
  local ok, ret = pcall(parse)
  if ok then
    return ret
  else
    E.LOG.error(TAG, "parse_command_line error " .. tostring(ret))
    return {}
  end
end

return M

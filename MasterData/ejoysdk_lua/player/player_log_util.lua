local _utils = require("ejoysdk_lua.ejoysdk_utils")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
local M = {}
local _header

function M.header()
  if _header then
    return _header
  end
  local player_id, account_id
  if EG.player_info() then
    player_id = EG.player_info().player_id
  end
  if EG.user_info() then
    account_id = EG.user_info().account
  end
  local header = {}
  header.player_id = player_id
  header.acc_id = account_id
  header.brand = ESTAT.dev_info().brand
  local server = require("ejoysdk_lua.chat.ejoysdk_chat_server")
  local socket_server = server.get_curr_socket_server()
  if socket_server and socket_server.addr and #socket_server.addr > 0 then
    header.socket_addr = socket_server.addr
  end
  if socket_server and socket_server.port then
    header.socket_port = socket_server.port
  end
  _header = log_mgr.encode_header(header)
  return _header
end

function M.resset_header()
  _header = nil
end

function M.simple_player_info(player_info)
  local v = {}
  v.player_id = player_info.player_id or "id_miss"
  v.account = player_info.account or "id_miss"
  v.server_id = player_info.server_id or "id_miss"
  return v
end

function M.simple_player_infos(player_infos)
  local list = {}
  for _, player_info in pairs(player_infos) do
    local v = M.simple_player_info(player_info)
    table.insert(list, v)
  end
  return list
end

function M.simple_player_info_map(player_info_map)
  local map = {}
  for k, player_info in pairs(player_info_map) do
    local v = M.simple_player_info(player_info)
    map[tostring(k)] = v
  end
  return map
end

function M.simple_scene_info(_tag, _log_level, _scene_info)
end

return M

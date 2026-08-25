local utils = require("ejoysdk_lua.ejoysdk_utils")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
local _E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.CHAT .. "log_util"
local M = {}
local _header

function M.simple_login_result(ret)
  local copyed_ret = utils.deepcopy(ret)
  local simple_groups = M.simple_group_infos(copyed_ret.groups)
  copyed_ret.log_groups = simple_groups
  copyed_ret.groups = nil
  return copyed_ret
end

function M.session_ids(sessions)
  local session_ids = {}
  for _, v in pairs(sessions) do
    if v.session_info and v.session_info.id then
      table.insert(session_ids, v.session_info.id)
    end
  end
  return session_ids
end

function M.simple_msg_infos(msgs)
  local msg_infos = {}
  for _, v in pairs(msgs) do
    if v.msg_id then
      local msg_info = {}
      msg_info.msg_id = v.msg_id
      msg_info.session_id = v.session_id
      table.insert(msg_infos, msg_info)
    end
  end
  return msg_infos
end

function M.simple_group_info(group)
  if not group then
    return {}
  end
  local v = group
  local group_info = {}
  if v.group_id then
    group_info.group_id = v.group_id
  else
    group_info.group_id = "id_miss"
  end
  if v.info and v.info.name then
    group_info.name = v.info.name
  else
    group_info.name = "name_miss"
  end
  if v.info and v.info.type then
    group_info.type = v.info.type
  else
    group_info.type = "type_miss"
  end
  if v.attr and v.attr.enable_voice == true then
    group_info.enable_voice = true
  else
    group_info.enable_voice = false
  end
  if v.attr and v.attr.voice_channel_mode then
    group_info.voice_channel_mode = v.attr.voice_channel_mode
  else
    group_info.voice_channel_mode = "mode_miss"
  end
  if v.attr and true == v.attr.sync_member then
    group_info.sync_member = true
  else
    group_info.sync_member = false
  end
  if v.personal_info and v.personal_info.agora_channel_token then
    group_info.agora_token = v.personal_info.agora_channel_token
  else
    group_info.agora_token = "agora_token_miss"
  end
  if v.member_infos then
    local m_infos = {}
    for _, v2 in pairs(v.member_infos) do
      local m_info = {}
      m_info.user_id = v2.user_id or "uid_miss"
      m_info.user_type = v2.user_type or "utype_miss"
      table.insert(m_infos, m_info)
    end
    group_info.member_infos = m_infos
  else
    group_info.member_infos = {}
  end
  return group_info
end

function M.simple_group_infos(groups)
  local group_infos = {}
  for _, v in pairs(groups) do
    local group_info = M.simple_group_info(v)
    table.insert(group_infos, group_info)
  end
  return group_infos
end

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
  local voice = require("ejoysdk_lua.chat.ejoysdk_voice")
  if voice.get_curr_channel_id() then
    header.voice_channel = voice.get_curr_channel_id()
  end
  if voice.get_state() then
    header.voice_state = voice.get_state()
  end
  if voice.get_mute_local_value() then
    header.voice_mute = voice.get_mute_local_value()
  else
    header.voice_mute = false
  end
  _header = log_mgr.encode_header(header)
  return _header
end

function M.resset_header()
  _header = nil
end

return M

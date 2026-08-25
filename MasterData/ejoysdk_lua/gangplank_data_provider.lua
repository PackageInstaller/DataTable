local ET = require("ejoysdk_lua.ejoysdk_topic")
local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local E = require("ejoysdk_lua.ejoysdk")
local M = {}
M.USER_INFO_KEY = {UID = "uid", SERVER = "server"}
M.PLAYER_INFO_KEY = {
  PLAYER_TOKEN = "player_token"
}
M.PLAYER_UPDATE_TYPE = {
  MOMENT_TOKEN = "moment_token"
}
local TAG = "gangplank_data"
local UserInfoMt = {
  game = nil,
  server = nil,
  region = nil,
  token = nil,
  uid = nil,
  platform = nil,
  ptoken = nil,
  pid = nil,
  guest = nil,
  with = nil,
  with_account = nil,
  isPga = nil,
  substitute = nil,
  ext = nil,
  reg = nil,
  pinfo = nil,
  permit_info = nil,
  is_magic_guest = nil
}
UserInfoMt.__index = UserInfoMt
local disk_player_info_model = E.LazyKeyStore:New("LAST_SET_PLAYER_INFOS", false, true, false)

local function new_user_info(tbl)
  tbl = tbl or {}
  do return setmetatable, tbl end
  return setmetatable, tbl, UserInfoMt
end

local m_user_info = new_user_info()
M.USER_INFO = {}

function M.USER_INFO.new(tbl)
  do return new_user_info end
  return new_user_info, tbl
end

function M.USER_INFO.set(info)
  info = info or {}
  m_user_info = info
  ET.publish(ET.gangplank.USER_INFO_CHANGED, m_user_info)
end

function M.USER_INFO.clear()
  M.USER_INFO.set(new_user_info())
end

function M.USER_INFO.update(key, value)
  if not key then
    E.LOG.warn(TAG, "update with nil key")
    return false
  end
  m_user_info[key] = value
  return true
end

function M.USER_INFO.get(key, ...)
  if not key or "" == key then
    local deep_copy = (...)
    if deep_copy then
      do return end
      return M.USER_INFO.clone
    else
      return m_user_info
    end
  else
    local def_val = (...)
    local data = m_user_info[key]
    if not data and def_val then
      return def_val
    else
      return data
    end
  end
end

function M.USER_INFO.clone()
  do return UTILS.deepcopy end
  return UTILS.deepcopy, m_user_info
end

local m_player_info
M.PLAYER_INFO = {}

function M.PLAYER_INFO.set(_player_info)
  if not _player_info then
    m_player_info = nil
  else
    m_player_info = UTILS.deepcopy(_player_info)
  end
end

function M.PLAYER_INFO.clear()
  M.PLAYER_INFO.set(nil)
end

function M.PLAYER_INFO.update(key, value)
  if not key then
    E.LOG.warn(TAG, "update with nil key")
    return false
  end
  if m_player_info then
    m_player_info[key] = value
    return true
  else
    E.LOG.warn(TAG, "update player_info failed, player_info is nil")
    return false
  end
end

function M.PLAYER_INFO.get(key, ...)
  if not key or "" == key then
    local deep_copy = (...)
    if deep_copy then
      do return end
      return M.PLAYER_INFO.clone
    else
      return m_player_info
    end
  else
    local def_val = (...)
    if not m_player_info then
      return def_val
    end
    local data = m_player_info[key]
    if not data and def_val then
      return def_val
    else
      return data
    end
  end
end

function M.PLAYER_INFO.clone()
  if nil == m_player_info then
    return nil
  end
  do return UTILS.deepcopy end
  return UTILS.deepcopy, m_player_info
end

function M.PLAYER_INFO.save_simple(_player_info)
  disk_player_info_model:set({
    uid = M.USER_INFO.get("uid"),
    player_id = tostring(_player_info and _player_info.player_id),
    player_name = tostring(_player_info and _player_info.player_name),
    server_id = _player_info and _player_info.server_id
  })
end

function M.PLAYER_INFO.get_simple()
  local last_pinfo = disk_player_info_model:get()
  if last_pinfo and last_pinfo.uid and last_pinfo.uid == M.USER_INFO.get("uid") then
    return last_pinfo
  end
  return nil
end

function M.PLAYER_INFO.clear_simple()
  disk_player_info_model:set({})
end

M.SESSION_INFO = {}
local session_ids = {}

function M.SESSION_INFO.generate_login_session_id()
  local l_session_id = tostring(math.floor(E.time())) .. "-" .. tostring(E.Sysinfo.utdid())
  return l_session_id
end

function M.SESSION_INFO.set(login_type)
  if "account" == login_type then
    session_ids.account = M.SESSION_INFO.generate_login_session_id()
  elseif "player" == login_type then
    session_ids.player = M.SESSION_INFO.generate_login_session_id()
  end
end

function M.SESSION_INFO.get(key)
  return session_ids and session_ids[key]
end

function M.SESSION_INFO.clear()
  session_ids = {}
end

return M

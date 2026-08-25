local EVENT = require("ejoysdk_lua.chat.ejoysdk_voice_event")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local QL = require("ejoysdk_lua.ejoysdk_qualitylog")
local E = require("ejoysdk_lua.ejoysdk")
local EG = require("ejoysdk_lua.ejoysdk_gangplank")
local utils = require("ejoysdk_lua.ejoysdk_utils")
local chat_cache = require("ejoysdk_lua.chat.ejoysdk_chat_cache")
local voice_topic = require("ejoysdk_lua.chat.ejoysdk_voice_topic")
local _chat_log = require("ejoysdk_lua.ejoysdk_log_mgr")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
local AGORA_JF_UPLOAD_NOW = false
local TAG = EM.MODULE.CHAT .. "voice"
local fsm = utils.fsm
local STATES = {}
STATES.NOT_JOIN = "not_join"
STATES.JOINING = "joining"
STATES.JOINED = "joined"
STATES.NOT_READY = "not_ready"
STATES.LEAVING = "leaving"
local EVENTS = {}
EVENTS.JOIN = "join"
EVENTS.JOIN_SUCC = "join_succ"
EVENTS.JOIN_FAIL = "join_fail"
EVENTS.LEAVE = "leave"
EVENTS.LEAVE_SUCC = "leave_succ"
EVENTS.LEAVE_FAIL = "leave_fail"
EVENTS.INIT = "init"
local VOICE_STATUS = {}
VOICE_STATUS.JOINED = "joined"
VOICE_STATUS.NOT_JOIN = "not_join"
local mute_remote_cache_by_user = {}
local mute_remote_cache_by_server = {}
local EJVOICE_MUTE_REMOTE_CACHE = E.LazyKeyStore:New("EJVOICE_Mute_Remote_Cache", true, true, false)
local channel_voice_date_map = {}
local M = {}
M.STATES = STATES
M.VOICE_STATUS = VOICE_STATUS
M.CHANNEL_INFO_DESC_MAX_LENGTH = 200
local voice_vendor
local join_timestamp = 0
local _local_is_mute_remote_all = false
M.auto_join_channel = false
M.auto_leave_channel = true
M.SCENARIO = {
  DEFAULT = 0,
  GAME_STREAMING = 3,
  CHATROOM = 5,
  CHORUS = 7,
  MEETING = 8,
  AI_CLIENT = 10
}
local channel_params = {}
local multi_channel_mode = false
local cur_channel, cur_voice_user_id
local mute_local_value = false
local voice_status = VOICE_STATUS.NOT_JOIN
local lazy_join_cache = {}
local lazy_joined_channels = {}
local voice_listener, state_before_leave
local open_mic_start_time = 0
local join_channel_start_time = 0

local function callback(handler_name, ...)
  if voice_listener then
    local handler = voice_listener[handler_name]
    if handler then
      handler(...)
    end
  end
  ET.publish("voice_" .. handler_name, ...)
end

local fsm_callbacks = {}
fsm_callbacks["on" .. EVENTS.INIT] = function(self, _from, ...)
  return fsm.SYNC, STATES.NOT_JOIN
end
fsm_callbacks["on" .. EVENTS.JOIN] = function(self, _from, ...)
  if voice_vendor then
    local channel_id, player_id, channel_param = ...
    voice_vendor.join_channel(channel_id, player_id, channel_param)
  end
  return fsm.SYNC, STATES.JOINING
end
fsm_callbacks["on" .. EVENTS.JOIN_SUCC] = function(self, _from, ...)
  return fsm.SYNC, STATES.JOINED, "join_succ", ...
end
fsm_callbacks["on" .. EVENTS.JOIN_FAIL] = function(self, _from, ...)
  return fsm.SYNC, STATES.NOT_JOIN, "join_fail", ...
end
fsm_callbacks["on" .. EVENTS.LEAVE_SUCC] = function(self, _from, ...)
  return fsm.SYNC, STATES.NOT_JOIN, "leave_succ", ...
end
fsm_callbacks["on" .. EVENTS.LEAVE_FAIL] = function(self, _from, ...)
  assert(nil ~= state_before_leave, "state_before_leave is nil")
  return fsm.SYNC, state_before_leave, "leave_fail", ...
end
fsm_callbacks["on" .. EVENTS.LEAVE] = function(self, from, ...)
  local channel_id, _options = ...
  if from == STATES.JOINING then
    state_before_leave = from
    voice_vendor.leave_channel(_options)
    return fsm.SYNC, STATES.LEAVING, "cancel"
  elseif from == STATES.JOINED then
    local joined_channels = M._get_joined_channels_inner()
    if channel_id == cur_channel or channel_id == joined_channels.main_channel then
      state_before_leave = from
      voice_vendor.leave_channel(_options)
      return fsm.SYNC, STATES.LEAVING, "leave"
    end
  end
end
fsm_callbacks["onenter" .. STATES.NOT_JOIN] = function(self, _from, ...)
  local event_type = (...)
  if "leave_succ" == event_type then
    local _, channel_id = ...
    E.LOG.d(TAG, "tell cp EVENT.ON_LEAVE_CHANNEL_SUCC, channel_id=" .. tostring(channel_id))
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    local agora_vendor = require("ejoysdk_lua.vendors.agora")
    callback(EVENT.ON_LEAVE_CHANNEL_SUCC, channel_id)
    if open_mic_start_time > 0 then
      local self_player_id = EG.player_info() and EG.player_info().player_id
      local self_player_name = EG.player_info() and EG.player_info().player_name
      local cached_group = chat_cache.get_group(cur_channel) or {}
      local group_type = cached_group.info and cached_group.info.type
      if os.time() > open_mic_start_time then
        local duration = os.time() - open_mic_start_time
        local jf_params = {duration = duration}
        if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
          jf_params.roleId = self_player_id
        end
        if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
          jf_params.roleName = self_player_name
        end
        jf_params.type = group_type or ""
        jf_params.result = duration
        jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
        jf_params.voice_channel_id = channel_id
        ESTAT.stat_bizid("duration.user.voice.online", "0", "0", jf_params)
      end
      open_mic_start_time = 0
    end
  elseif "join_fail" == event_type then
    local _, code, message = ...
    E.LOG.d(TAG, "tell cp EVENT.ON_JOIN_CHANNEL_FAIL, code=" .. tostring(code) .. ", message=" .. tostring(message))
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    callback(EVENT.ON_JOIN_CHANNEL_FAIL, code, message)
  end
end

function M.update_mute_remote_config(channel_id)
  if not channel_id then
    return
  end
  if not voice_vendor then
    return
  end
  if mute_remote_cache_by_user and type(mute_remote_cache_by_user) == "table" then
    for player_id, m_value in pairs(mute_remote_cache_by_user) do
      local p_is_mute = m_value or false
      voice_vendor.mute_remote(player_id, p_is_mute, channel_id)
    end
  end
end

fsm_callbacks["onenter" .. STATES.JOINED] = function(self, _from, ...)
  local type = (...)
  if "join_succ" == type then
    local _, channel_id, uid = ...
    E.LOG.d(TAG, "tell cp EVENT.ON_JOIN_CHANNEL_SUCC, channel_id=" .. tostring(channel_id) .. ", uid=" .. tostring(uid))
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    M.update_mute_remote_config(channel_id)
    callback(EVENT.ON_JOIN_CHANNEL_SUCC, channel_id, uid)
  elseif "leave_fail" == type then
    local _, code, msg = ...
    E.LOG.d(TAG, "tell cp EVENT.ON_LEAVE_CHANNEL_FAIL, code=" .. tostring(code) .. ", msg=" .. tostring(msg))
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    callback(EVENT.ON_LEAVE_CHANNEL_FAIL, code, msg)
  elseif "rejoin_succ" == type then
    local _, channel_id, uid = ...
    E.LOG.d(TAG, "tell cp EVENT.ON_REJOIN_CHANNEL_SUCC, channel_id=" .. tostring(channel_id) .. ", uid=" .. tostring(uid))
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    callback(EVENT.ON_REOIN_CHANNEL_SUCC, channel_id, uid)
  end
  return fsm.ASYNC
end

function fsm_callbacks:onstatechange(from, to, ...)
  ET.publish("voice_onstatechange", from, to)
end

local voice_fsm = fsm.create({
  initial = STATES.NOT_READY,
  events = {
    {
      name = EVENTS.JOIN,
      from = STATES.NOT_JOIN
    },
    {
      name = EVENTS.JOIN_SUCC,
      from = STATES.JOINING
    },
    {
      name = EVENTS.JOIN_FAIL,
      from = STATES.JOINING
    },
    {
      name = EVENTS.LEAVE,
      from = STATES.JOINING
    },
    {
      name = EVENTS.LEAVE,
      from = STATES.JOINED
    },
    {
      name = EVENTS.LEAVE_SUCC,
      from = STATES.JOINED
    },
    {
      name = EVENTS.LEAVE_SUCC,
      from = STATES.LEAVING
    },
    {
      name = EVENTS.LEAVE_FAIL,
      from = STATES.LEAVING
    },
    {
      name = EVENTS.INIT,
      from = STATES.NOT_READY
    }
  },
  callbacks = fsm_callbacks
})

function M.init()
  if mute_remote_cache_by_user and 0 == #mute_remote_cache_by_user then
    local current_player_mute_list = EJVOICE_MUTE_REMOTE_CACHE and EJVOICE_MUTE_REMOTE_CACHE:get() or {}
    if EG.player_info() then
      mute_remote_cache_by_user = current_player_mute_list[EG.player_info().player_id] or {}
    end
  end
  E.LOG.d(TAG, "voice_fsm.add_event -> STATES.INIT")
  voice_fsm:add_event(EVENTS.INIT)
end

function M.uninit()
  if voice_fsm.current == STATES.JOINED then
    E.LOG.d(TAG, "voice_fsm.add_event -> STATES.LEAVE")
    voice_fsm:add_event(EVENTS.LEAVE, cur_channel)
  elseif voice_fsm.current == STATES.JOINING then
    if voice_vendor then
      voice_vendor.leave_channel()
      voice_fsm:add_event(EVENTS.JOIN_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_INIT_SERVER_FAIL, "socket is reconnecting")
    end
  else
    voice_fsm:reset()
  end
end

function M.get_voice_fsm()
  return voice_fsm
end

function M.get_voice_vendor()
  return voice_vendor
end

function M.get_state()
  local res = voice_fsm.current
  return res
end

function M.async_get_state(cb)
  local res = M.get_state()
  if cb then
    cb(res)
  end
end

function M.get_curr_channel_id()
  local res = cur_channel
  return res
end

function M.get_curr_voice_user_id()
  return cur_voice_user_id
end

function M.get_mute_local_value()
  local res = mute_local_value
  return res
end

function M.get_voice_status()
  local res = voice_status
  return res
end

function M.voice_channel_user_change(channel_id, removes_map, updates_map)
  removes_map = removes_map or {}
  updates_map = updates_map or {}
  E.LOG.d(TAG, "voice_channel_user_change start, channel_id=" .. tostring(channel_id) .. ", cur_channel=" .. tostring(cur_channel))
  if lazy_join_cache and lazy_join_cache.channel_id == channel_id and not lazy_joined_channels[channel_id] then
    local is_active = M.is_voice_channel_active(channel_id)
    if is_active then
      local start_time_ts = E.time_ms()
      M._do_lazy_join_channel(lazy_join_cache.channel_id, lazy_join_cache.channel_param, {
        is_lazy_join = true,
        start_time_ts = start_time_ts,
        is_first_user = false
      })
      lazy_join_cache = {}
    end
  end
  local joined_channels = M._get_joined_channels_inner()
  if not multi_channel_mode and channel_id ~= cur_channel or multi_channel_mode and joined_channels.channels and joined_channels.channels[channel_id] == nil then
    E.LOG.d(TAG, "voice_channel_user_change, channel_id not same")
    return
  end
  if not EG.player_info() then
    E.LOG.d(TAG, "voice_channel_user_change, not have player_info")
    return
  end
  if EG.player_info().player_id and removes_map[EG.player_info().player_id] then
    E.LOG.d(TAG, "voice_channel_user_change, self in removes_map, need leave_channel")
    M.leave_channel(channel_id)
    return
  end
  for uid, user in pairs(updates_map) do
    if uid == EG.player_info().player_id then
      M.mute_local_from_server_sync(user.mute, channel_id)
    else
      if user.management_mute then
        mute_remote_cache_by_server[uid] = true
      else
        mute_remote_cache_by_server[uid] = nil
      end
      M._mute_remote_for_server_sync(uid, user.management_mute or mute_remote_cache_by_user[uid] or false)
    end
  end
  if voice_vendor and voice_vendor.execute_delay_uid_callbacks then
    voice_vendor.execute_delay_uid_callbacks()
  end
end

function M.voice_channel_info_update(channel_id, voice_channel)
  local voice_data = voice_channel and voice_channel.data
  if channel_id and voice_data then
    channel_voice_date_map[channel_id] = voice_data
  end
end

function M.get_channel_voice_info(channel_id)
  if channel_id then
    return channel_voice_date_map[channel_id]
  end
  return nil
end

function M.get_history_channel_voice_infos()
  do return utils.deepcopy end
  return utils.deepcopy, channel_voice_date_map
end

function M.report(channel_id, report_type_id, report_desc, player_id, extend_data, cb)
  if not channel_id then
    cb(false, CONSTANTS.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "channel_id is nil")
    return
  end
  local voice_data = M.get_channel_voice_info(channel_id)
  if not voice_data then
    E.LOG.warn(TAG, "current voice_data is not valid")
    voice_data = {}
  end
  local contents = {}
  extend_data = extend_data or {}
  extend_data.join_timestamp = join_timestamp
  local report_timestamp = E.time()
  extend_data.report_interval = report_timestamp - join_timestamp
  extend_data.join_time = os.date("%Y-%m-%d %H:%M:%S", extend_data.join_timestamp)
  extend_data.report_time = os.date("%Y-%m-%d %H:%M:%S", report_timestamp)
  local voice_user_id = "0"
  local group_info = M.get_voice_group_info(channel_id)
  if group_info and group_info.voice_channel_users then
    for _, user in pairs(group_info.voice_channel_users) do
      if user and user.user_id == player_id then
        voice_user_id = user.voice_user_id
        break
      end
    end
  end
  contents[1] = {
    content_type = "audio_raw",
    audio_raw = {
      channel_name = channel_id,
      sid = voice_data.sid,
      voice_user_id = tostring(voice_user_id)
    },
    extend_data = extend_data
  }
  local suspect_info = {player_id = player_id}
  M.report_to_platform(report_type_id, report_desc, nil, suspect_info, contents, cb)
end

function M.get_report_types(cb)
  local RAPI = require("ejoysdk_lua.server_api.ejoysdk_report_mailbox")
  RAPI.get_report_types(cb)
end

function M.report_to_platform(report_type_id, report_desc, scene, suspect_info, contents, cb)
  local RAPI = require("ejoysdk_lua.server_api.ejoysdk_report_mailbox")
  RAPI.report(report_type_id, report_desc, scene, suspect_info, contents, cb)
end

local function update_voice_mute(group_id)
  if not cur_channel then
    return
  end
  if not EG.player_info() then
    return
  end
  local group = chat_cache.get_group(group_id)
  if group and group.voice_channel_users then
    for _, user in pairs(group.voice_channel_users) do
      if user.user_id == EG.player_info().player_id then
        M.mute_local_from_server_sync(user.mute, group_id)
      else
        M._mute_remote_for_server_sync(user.user_id, user.management_mute or mute_remote_cache_by_user[user.user_id] or false)
      end
    end
  end
end

function M.update_voice_mute(group_id)
  update_voice_mute(group_id)
end

local function voice_channel_status_update(group_id, _voice_status, _mute_local_value, voice_user_id, channel_info)
  E.LOG.debug(TAG, "voice_channel_status_update, group_id=" .. tostring(group_id) .. ", voice_status=" .. tostring(_voice_status) .. ", _mute_local_value=" .. tostring(_mute_local_value))
  if group_id then
    ET.publish(voice_topic.VOICE_CHANNEL_STATUS_UPDATE, group_id, _voice_status, _mute_local_value, voice_user_id, channel_info)
  end
end

local function async_voice_channel_status_update(group_id, _voice_status, _mute_local_value, voice_user_id, channel_info, cb)
  E.LOG.debug(TAG, "async_voice_channel_status_update, group_id=" .. tostring(group_id) .. ", voice_status=" .. tostring(_voice_status) .. ", _mute_local_value=" .. tostring(_mute_local_value))
  if group_id then
    local EC = require("ejoysdk_lua.chat.ejoysdk_chat")
    EC.set_voice_channel_status(group_id, _voice_status, _mute_local_value, voice_user_id, channel_info, cb)
  end
end

local function inner_renew_token_with_params(renew_channel_id)
  if voice_vendor and voice_vendor.is_support_token_refresh() and renew_channel_id then
    local voice_version = M.get_agora_token_version()
    M.get_voice_token(renew_channel_id, voice_version, function(succ, ...)
      if succ then
        local ret_info = (...)
        if ret_info and type(ret_info) == "table" and ret_info.token and ret_info.uid then
          voice_vendor.renew_token_with_params({
            token = ret_info.token
          })
        else
          local channel_param = channel_params[renew_channel_id]
          if channel_param then
            voice_vendor.renew_token_with_params(channel_param)
          end
        end
      else
        E.LOG.d(TAG, "renew token: get_voice_token fail")
      end
    end)
  end
end

function M.get_joined_channels()
  do return utils.deepcopy, M._get_joined_channels_inner() end
  return utils.deepcopy, M._get_joined_channels_inner()
end

function M._get_joined_channels_inner()
  if voice_vendor and voice_vendor.get_joined_channels then
    do return end
    return voice_vendor.get_joined_channels, nil
  else
    return {
      channels = {}
    }
  end
end

local voice_listener_wrapper = {
  [EVENT.ON_JOIN_CHANNEL_SUCC] = function(channel_id, uid, voice_user_id)
    QL.commit_event("sdk.ejoy_voice_join_succ", {})
    if not multi_channel_mode or nil == cur_channel then
      cur_channel = channel_id
      cur_voice_user_id = voice_user_id
    end
    voice_status = M.VOICE_STATUS.JOINED
    join_timestamp = E.time()
    local joined_channels = M._get_joined_channels_inner()
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    local channel_info
    local log_opts = {}
    local channel_param = channel_params[channel_id]
    if channel_param then
      channel_info = channel_param and channel_param.channel_info
      log_opts = channel_param and channel_param.opts or {}
    end
    update_voice_mute(channel_id)
    E.LOG.d(TAG, "voice_channel_status_update, mute=" .. tostring(mute_local_value) .. ", on join channel")
    voice_channel_status_update(channel_id, M.VOICE_STATUS.JOINED, mute_local_value, voice_user_id, channel_info)
    E.LOG.d(TAG, "voice_fsm.add_event -> STATES.JOIN_SUCC")
    voice_fsm:add_event(EVENTS.JOIN_SUCC, channel_id, uid)
    if multi_channel_mode and joined_channels.channels then
      local channel_count = utils.tablelength(joined_channels.channels)
      if channel_count > 1 then
        M.update_mute_remote_config(channel_id)
        callback(EVENT.ON_JOIN_CHANNEL_SUCC, channel_id, uid)
      end
    end
    local agora_vendor = require("ejoysdk_lua.vendors.agora")
    local self_player_id = EG.player_info() and EG.player_info().player_id
    local self_player_name = EG.player_info() and EG.player_info().player_name
    local cached_group = chat_cache.get_group(channel_id) or {}
    local group_type = cached_group.info and cached_group.info.type
    local jf_params = {}
    if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
      jf_params.roleId = self_player_id
    end
    if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
      jf_params.roleName = self_player_name
    end
    jf_params.type = group_type or ""
    jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
    jf_params.voice_channel_id = channel_id
    jf_params.is_lazy_join = log_opts.is_lazy_join or false
    jf_params.is_first_user = log_opts.is_first_user or false
    local join_cost_ms = E.time_ms() - (log_opts.start_time_ts or join_channel_start_time)
    if join_channel_start_time > 0 and join_cost_ms > 0 and join_cost_ms < 20000 then
      jf_params.join_cost = join_cost_ms
    end
    ESTAT.stat_bizid("voice.user.online", "0", "0", jf_params)
    M.start_heartbeat_timer()
    join_channel_start_time = 0
  end,
  [EVENT.ON_REOIN_CHANNEL_SUCC] = function(channel_id, uid)
    QL.commit_event("sdk.ejoy_voice_rejoin_succ", {})
    join_timestamp = E.time()
    E.LOG.d(TAG, "voice_fsm.transition -> STATES.JOINED")
    voice_fsm:transition(voice_fsm.current, STATES.JOINED, "rejoin_succ", channel_id, uid)
    voice_channel_status_update(channel_id, M.VOICE_STATUS.JOINED, mute_local_value, cur_voice_user_id)
    M.start_heartbeat_timer()
  end,
  [EVENT.ON_CONNECTION_INTERRUPT] = function()
    QL.commit_event("sdk.ejoy_voice_interrupt", {
      stime = E.time() - join_timestamp
    })
  end,
  [EVENT.ON_CONNECTION_LOST] = function()
    QL.commit_event("sdk.ejoy_voice_lost", {
      stime = E.time() - join_timestamp
    })
    M.stop_heartbeat_timer()
  end,
  [EVENT.ON_JOIN_CHANNEL_FAIL] = function(code, message)
    QL.commit_event("sdk.ejoy_voice_join_fail", {})
    _ejoysdk.log("lua EVENT ON JOIN CHANNEL FAIL")
    E.LOG.d(TAG, "voice_fsm.add_event -> STATES.JOIN_FAIL")
    voice_fsm:add_event(EVENTS.JOIN_FAIL, code, message)
  end,
  [EVENT.ON_LEAVE_CHANNEL_SUCC] = function(channel_id)
    QL.commit_event("sdk.ejoy_voice_leave", {
      stime = E.time() - join_timestamp
    })
    _ejoysdk.log("lua EVENT ON LEAVE CHANNEL SUCC, channel_id =" .. tostring(channel_id))
    local joined_channels = M._get_joined_channels_inner()
    if multi_channel_mode and joined_channels.channels then
      local channel_count = utils.tablelength(joined_channels.channels)
      if channel_count > 0 then
        voice_status = M.VOICE_STATUS.JOINED
      else
        voice_status = M.VOICE_STATUS.NOT_JOIN
      end
    else
      voice_status = M.VOICE_STATUS.NOT_JOIN
    end
    if voice_status == M.VOICE_STATUS.NOT_JOIN then
      cur_channel = nil
      cur_voice_user_id = nil
      mute_remote_cache_by_server = {}
      local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
      chat_log_util.resset_header()
      E.LOG.d(TAG, "voice_fsm.add_event -> STATES.LEAVE_SUCC")
      voice_fsm:add_event(EVENTS.LEAVE_SUCC, channel_id)
      M.stop_heartbeat_timer()
    else
      callback(EVENT.ON_LEAVE_CHANNEL_SUCC, channel_id)
    end
    voice_channel_status_update(channel_id, M.VOICE_STATUS.NOT_JOIN, mute_local_value, nil)
  end,
  [EVENT.ON_LEAVE_CHANNEL_FAIL] = function(code, message)
    _ejoysdk.log("lua EVENT ON LEAVE CHANNEL FAIL")
    E.LOG.d(TAG, "voice_fsm.add_event -> STATES.LEAVE_FAIL")
    voice_fsm:add_event(EVENTS.LEAVE_FAIL, code, message)
  end,
  [EVENT.ON_CONNECTION_STATE_CHANGED] = function(...)
    local _, reason, last_join_suc_channel = ...
    if last_join_suc_channel and reason and reason == voice_vendor.CONNECTION_CHANGED_TOKEN_EXPIRED then
      inner_renew_token_with_params(last_join_suc_channel)
    end
    callback(EVENT.ON_CONNECTION_STATE_CHANGED, ...)
  end,
  [EVENT.ON_TOKEN_PRIVILEGE_WILL_EXPIRE] = function(...)
    inner_renew_token_with_params(cur_channel)
    callback(EVENT.ON_TOKEN_PRIVILEGE_WILL_EXPIRE, ...)
  end
}
local mt = {}

function mt:__index(key)
  return voice_listener and voice_listener[key]
end

setmetatable(voice_listener_wrapper, mt)

function M.set_voice_vendor(vendor)
  voice_vendor = vendor
  voice_vendor.set_listener(voice_listener_wrapper)
end

function M.set_listener(listener)
  voice_listener = listener
end

function M.remove_listener()
  voice_listener = nil
end

function M.add_channel_param(channel_id, param)
  channel_params[channel_id] = param
end

function M.remove_channel_param(channel_id)
  channel_params[channel_id] = nil
end

function M.get_channel_param(channel_id)
  if channel_params and channel_params[channel_id] then
    utils.deepcopy(channel_params[channel_id])
  else
    return {}
  end
end

function M.get_voice_token(channel_id, versions, cb)
  local ejoysdk_chat = require("ejoysdk_lua.chat.ejoysdk_chat")
  ejoysdk_chat.get_agora_channel_token(channel_id, versions, cb)
end

function M.get_agora_token_version()
  return {"1"}
end

function M.is_support_token_join()
  if voice_vendor then
    do return end
    return voice_vendor.is_support_token_join, nil
  end
  return false
end

function M.join_channel(channel_id, channel_info)
  if channel_info and channel_info.desc and #channel_info.desc > M.CHANNEL_INFO_DESC_MAX_LENGTH then
    E.LOG.d(TAG, "channel_info.desc over max length")
    channel_info.desc = string.sub(channel_info.desc, 1, M.CHANNEL_INFO_DESC_MAX_LENGTH)
  end
  local current_state = M.get_state()
  E.LOG.d(TAG, "join_channel current_state=" .. tostring(current_state))
  if voice_fsm:is(STATES.NOT_JOIN) == false then
    callback(EVENT.ON_JOIN_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_STATE_INVALID_JOIN_FAIL, "only NOT_JOIN state can join")
    return
  end
  E.LOG.d(TAG, "join_channel >>>")
  E.LOG.d(TAG, {channel_id = channel_id})
  join_channel_start_time = E.time_ms()
  if voice_vendor then
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    local player_id = gangplank.player_info().player_id
    if not player_id then
      return
    end
    if mute_remote_cache_by_user and 0 == #mute_remote_cache_by_user then
      local current_player_mute_list = EJVOICE_MUTE_REMOTE_CACHE and EJVOICE_MUTE_REMOTE_CACHE:get() or {}
      mute_remote_cache_by_user = current_player_mute_list[EG.player_info().player_id] or {}
    end
    
    local function join_channel_with_account()
      local channel_param = channel_params[channel_id]
      if channel_param then
        E.LOG.d(TAG, "voice_fsm.add_event -> STATES.JOIN")
        channel_param.use_account_join = true
        channel_param.channel_info = nil
        if channel_info then
          channel_param.channel_info = channel_info
        end
        voice_fsm:add_event(EVENTS.JOIN, channel_id, player_id, channel_param)
      else
        callback(EVENT.ON_JOIN_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_NO_CHANNEL, "current channel_id is not valid，maybe current player not in the group")
      end
    end
    
    if M.is_support_token_join() then
      local voice_version = M.get_agora_token_version()
      M.get_voice_token(channel_id, voice_version, function(succ, ...)
        if succ then
          local ret_info = (...)
          if ret_info and type(ret_info) == "table" and ret_info.token and ret_info.uid then
            E.LOG.d(TAG, "voice_fsm.add_event -> STATES.JOIN")
            local channel_param = channel_params[channel_id]
            if channel_param then
              channel_param.token = ret_info.token
              channel_param.channel_info = channel_info
              channel_param.sleep_time = ret_info.sleep_time
            end
            if channel_info and channel_info.enable_lazy_join then
              local is_active = M.is_voice_channel_active(channel_id)
              if not is_active then
                E.LOG.d(TAG, "join_channel lazy join >>>")
                lazy_join_cache = {
                  channel_id = channel_id,
                  channel_param = channel_param,
                  timestamp = os.time()
                }
                callback(EVENT.ON_LAZY_JOIN_CHANNEL_SUCC, channel_id, player_id)
                voice_channel_status_update(channel_id, M.VOICE_STATUS.JOINED, mute_local_value, ret_info.uid, channel_info)
                return
              end
            end
            voice_fsm:add_event(EVENTS.JOIN, channel_id, player_id, {
              token = ret_info.token,
              voice_user_id = ret_info.uid,
              channel_info = channel_info
            })
          else
            E.LOG.w(TAG, "chat server is old")
            join_channel_with_account()
          end
        else
          local code, msg = ...
          callback(EVENT.ON_JOIN_CHANNEL_FAIL, code or CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_ERROR_ON_GET_VOICE_TOKEN_FAIL, msg or "get voice_token fail")
        end
      end)
    else
      join_channel_with_account()
    end
  end
end

function M.leave_channel(channel_id, options)
  local current_state = M.get_state()
  E.LOG.d(TAG, "leave_channel current_state=" .. tostring(current_state))
  if voice_fsm:is(STATES.JOINED) == false and false == voice_fsm:is(STATES.NOT_JOIN) or voice_fsm:is(STATES.NOT_JOIN) and lazy_join_cache and lazy_join_cache.channel_id == nil then
    callback(EVENT.ON_LEAVE_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_STATE_INVALID_LEAVE_FAIL, "only JOINED state can leave")
    return
  end
  if voice_fsm:is(STATES.NOT_JOIN) and lazy_join_cache and lazy_join_cache.channel_id then
    lazy_join_cache = {}
    callback(EVENT.ON_LEAVE_CHANNEL_SUCC, lazy_join_cache and lazy_join_cache.channel_id)
    return
  end
  if lazy_joined_channels[channel_id] then
    lazy_joined_channels[channel_id] = nil
  end
  if not multi_channel_mode then
    voice_fsm:add_event(EVENTS.LEAVE, channel_id, options)
  else
    local joined_channels = M._get_joined_channels_inner()
    if nil ~= channel_id and channel_id ~= joined_channels.main_channel then
      callback(EVENT.ON_LEAVE_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_NO_CHANNEL, "in multi-channel mode, only main channel can leave all channels")
      return
    end
    E.LOG.d(TAG, "leave all channel >>>")
    voice_fsm:add_event(EVENTS.LEAVE, channel_id, options)
  end
end

function M.enable_multi_channel(_multi_channel_mode)
  multi_channel_mode = _multi_channel_mode
end

function M.set_client_role(_role)
  if voice_vendor then
    do return voice_vendor.set_client_role end
    return voice_vendor.set_client_role, _role
  end
end

function M.join_channel_ex(channel_id, channel_info)
  if voice_fsm:is(STATES.JOINED) == false then
    callback(EVENT.ON_JOIN_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_MULTI_CHANNEL_JOIN_FAIL, "pls use join_channel to join first channel")
    return
  end
  if channel_info and channel_info.desc and #channel_info.desc > M.CHANNEL_INFO_DESC_MAX_LENGTH then
    E.LOG.d(TAG, "channel_info.desc over max length")
    channel_info.desc = string.sub(channel_info.desc, 1, M.CHANNEL_INFO_DESC_MAX_LENGTH)
  end
  E.LOG.d(TAG, "join_channel_ex >>>")
  E.LOG.d(TAG, {channel_id = channel_id})
  if not multi_channel_mode then
    E.LOG.d(TAG, "not enable multi_channel_mode")
    callback(EVENT.ON_JOIN_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_NOT_SUPPORT_MULTI_CHANNEL, "join_channel_ex fail")
    return
  end
  if voice_vendor then
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    local player_id = gangplank.player_info().player_id
    if not player_id then
      return
    end
    if mute_remote_cache_by_user and 0 == #mute_remote_cache_by_user then
      local current_player_mute_list = EJVOICE_MUTE_REMOTE_CACHE and EJVOICE_MUTE_REMOTE_CACHE:get() or {}
      mute_remote_cache_by_user = current_player_mute_list[EG.player_info().player_id] or {}
    end
    local voice_version = M.get_agora_token_version()
    M.get_voice_token(channel_id, voice_version, function(succ, ...)
      if succ then
        local ret_info = (...)
        E.LOG.d(TAG, "voice_vendor.join_channel_ex -> channel_id: " .. channel_id)
        local channel_param = channel_params[channel_id]
        if channel_param then
          channel_param.token = ret_info.token
          channel_param.channel_info = channel_info
        end
        voice_vendor.join_channel_ex(channel_id, player_id, {
          token = ret_info.token,
          voice_user_id = ret_info.uid,
          channel_info = channel_info
        })
      else
        local code, msg = ...
        callback(EVENT.ON_JOIN_CHANNEL_FAIL, code or CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_ERROR_ON_GET_VOICE_TOKEN_FAIL, msg or "get voice_token fail")
      end
    end)
  end
end

function M.leave_channel_ex(channel_id, options)
  E.LOG.d(TAG, "leave_channel_ex >>>")
  E.LOG.d(TAG, {channel_id = channel_id})
  if not multi_channel_mode then
    E.LOG.w(TAG, "Multi-channel mode not enabled, use regular leave_channel")
    M.leave_channel(channel_id, options)
    return
  end
  local joined_channels = M._get_joined_channels_inner()
  if not joined_channels.channels or not joined_channels.channels[channel_id] then
    callback(EVENT.ON_LEAVE_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_NO_CHANNEL, "channel not joined")
    return
  end
  local channel_info = joined_channels.channels[channel_id]
  local voice_user_id = channel_info and tostring(channel_info.voice_user_id)
  if voice_vendor then
    voice_vendor.leave_channel_ex(channel_id, voice_user_id, options)
  end
end

function M.is_voice_channel(channel_id)
  local ret = false
  for id, _ in pairs(channel_params) do
    if id == channel_id then
      ret = true
      break
    end
  end
  return ret
end

function M.set_enable_speaker(enable)
  if voice_vendor then
    voice_vendor.set_enable_speaker(enable)
  end
end

function M.mute_local_from_server_sync(mute, _channel_id)
  if voice_vendor then
    mute_local_value = mute
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    if multi_channel_mode and _channel_id then
      local joined_channels = M._get_joined_channels_inner()
      if _channel_id == (joined_channels and joined_channels.main_channel) then
        voice_vendor.mute_local(mute)
      else
        local channel_info = joined_channels.channels[_channel_id]
        local voice_user_id = channel_info and tostring(channel_info.voice_user_id)
        voice_vendor.mute_local_ex(_channel_id, voice_user_id, mute)
      end
    else
      voice_vendor.mute_local(mute)
    end
  end
end

local function mute_local_with_atom_privilege(mute, cb, prefer_channel_id)
  local start_time_ts = E.time_ms()
  
  local function finish_handle()
    mute_local_value = mute
    local chat_log_util = require("ejoysdk_lua.chat.ejoysdk_chat_log_util")
    chat_log_util.resset_header()
    local agora_vendor = require("ejoysdk_lua.vendors.agora")
    if not mute then
      if lazy_join_cache.channel_id and not lazy_joined_channels[lazy_join_cache.channel_id] then
        E.log("do lazy join:" .. tostring(lazy_join_cache.channel_id))
        M._do_lazy_join_channel(lazy_join_cache.channel_id, lazy_join_cache.channel_param, {
          is_lazy_join = true,
          start_time_ts = start_time_ts,
          is_first_user = true
        })
        local wait_4_others_cost_time = lazy_join_cache.channel_param and lazy_join_cache.channel_param.sleep_time or 2
        E.Timer.once(wait_4_others_cost_time, function()
          E.log("first mute local false and sleep join cb:" .. tostring(E.time_ms()))
          utils.safe_call_cb(cb, true)
        end)
        lazy_join_cache = {}
      else
        utils.safe_call_cb(cb, true)
      end
      open_mic_start_time = os.time()
      local self_player_id = EG.player_info() and EG.player_info().player_id
      local self_player_name = EG.player_info() and EG.player_info().player_name
      local cached_group = chat_cache.get_group(prefer_channel_id) or {}
      local group_type = cached_group.info and cached_group.info.type
      local jf_params = {}
      if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
        jf_params.roleId = self_player_id
      end
      if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
        jf_params.roleName = self_player_name
      end
      jf_params.type = group_type or ""
      jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
      jf_params.voice_channel_id = prefer_channel_id
      ESTAT.stat_bizid("mic.user.online", "0", "0", jf_params)
      ESTAT.stat_bizid("click.mic.online", "0", "0", jf_params)
    else
      utils.safe_call_cb(cb, true)
      if open_mic_start_time > 0 then
        local self_player_id = EG.player_info() and EG.player_info().player_id
        local self_player_name = EG.player_info() and EG.player_info().player_name
        local cached_group = chat_cache.get_group(prefer_channel_id) or {}
        local group_type = cached_group.info and cached_group.info.type
        if os.time() > open_mic_start_time then
          local duration = os.time() - open_mic_start_time
          local jf_params = {duration = duration}
          if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
            jf_params.roleId = self_player_id
          end
          if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
            jf_params.roleName = self_player_name
          end
          jf_params.type = group_type or ""
          jf_params.result = duration
          jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
          jf_params.voice_channel_id = prefer_channel_id
          ESTAT.stat_bizid("duration.user.voice.online", "0", "0", jf_params)
        end
        open_mic_start_time = 0
      end
    end
  end
  
  local prefer_voice_status = voice_status
  if lazy_join_cache and lazy_join_cache.channel_id then
    prefer_voice_status = M.VOICE_STATUS.JOINED
  end
  if mute then
    if voice_vendor then
      voice_vendor.mute_local(mute)
    end
    finish_handle()
    voice_channel_status_update(prefer_channel_id, prefer_voice_status, mute_local_value, cur_voice_user_id)
    return
  end
  async_voice_channel_status_update(prefer_channel_id, prefer_voice_status, mute, cur_voice_user_id, nil, function(succ, ...)
    if not succ then
      local code, msg = ...
      utils.safe_call_cb(cb, false, code, msg)
      return
    end
    finish_handle()
  end)
end

function M.mute_local(mute, cb)
  if not voice_vendor then
    utils.safe_call_cb(cb, false, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_VENDOR_MISS, "voice vendor not found")
    return
  end
  mute_local_with_atom_privilege(mute, cb, not cur_channel and lazy_join_cache and lazy_join_cache.channel_id)
end

local function mute_local_ex_with_atom_privilege(mute, cb, options)
  if mute then
    if voice_vendor then
      voice_vendor.mute_local_ex(options.channel_id, options.voice_user_id, mute)
    end
    utils.safe_call_cb(cb, true)
    voice_channel_status_update(options.channel_id, voice_status, mute, options.voice_user_id)
    return
  end
  async_voice_channel_status_update(options.channel_id, voice_status, mute, options.voice_user_id, nil, function(succ, ...)
    if not succ then
      local code, msg = ...
      utils.safe_call_cb(cb, false, code, msg)
      return
    end
    utils.safe_call_cb(cb, true)
  end)
end

function M.mute_local_ex(channel_id, mute, cb)
  E.LOG.d(TAG, "mute_local_ex, channel_id=" .. tostring(channel_id) .. ", mute=" .. tostring(mute))
  if not voice_vendor then
    utils.safe_call_cb(cb, false, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_VENDOR_MISS, "voice vendor not found")
    return
  end
  if not multi_channel_mode then
    E.LOG.d(TAG, "multi_channel_mode is false")
    return
  end
  local joined_channels = M._get_joined_channels_inner()
  if not joined_channels.channels or not joined_channels.channels[channel_id] then
    utils.safe_call_cb(cb, false, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_NO_CHANNEL, "channel not joined")
    return
  end
  local channel_info = joined_channels.channels[channel_id]
  local voice_user_id = channel_info and tostring(channel_info.voice_user_id)
  mute_local_ex_with_atom_privilege(mute, cb, {channel_id = channel_id, voice_user_id = voice_user_id})
end

function M.get_mute_remote_config_by_user()
  if mute_remote_cache_by_user then
    do return utils.deepcopy end
    return utils.deepcopy, mute_remote_cache_by_user
  else
    return {}
  end
end

function M.mute_remote(player_id, mute, cb)
  if not voice_vendor then
    utils.safe_call_cb(cb, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_VENDOR_MISS, "vendor miss")
    return
  end
  if not player_id then
    utils.safe_call_cb(cb, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_PARAMS_INVALID, "target_player_id miss")
    return
  end
  if not cur_channel or voice_fsm.current ~= STATES.JOINED then
    utils.safe_call_cb(cb, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_CHANNEL_STATES_INVALID, "channel states must is joined")
    return
  end
  mute = mute or false
  if mute then
    mute_remote_cache_by_user[player_id] = mute
  else
    mute_remote_cache_by_user[player_id] = nil
  end
  if not multi_channel_mode then
    voice_vendor.mute_remote(player_id, mute, cur_channel)
  else
    local joined_channels = M._get_joined_channels_inner()
    voice_vendor.mute_remote(player_id, mute, joined_channels and joined_channels.main_channel or cur_channel)
  end
  if EJVOICE_MUTE_REMOTE_CACHE then
    local current_player_mute_list = EJVOICE_MUTE_REMOTE_CACHE:get() or {}
    current_player_mute_list[EG.player_info().player_id] = mute_remote_cache_by_user
    EJVOICE_MUTE_REMOTE_CACHE:set(current_player_mute_list)
    EJVOICE_MUTE_REMOTE_CACHE:save()
  end
  local agora_vendor = require("ejoysdk_lua.vendors.agora")
  local self_player_id = EG.player_info() and EG.player_info().player_id
  local self_player_name = EG.player_info() and EG.player_info().player_name
  local cached_group = chat_cache.get_group(M.get_curr_channel_id()) or {}
  local group_type = cached_group.info and cached_group.info.type
  local jf_params = {mutetype = mute, target_player_id = player_id}
  if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
    jf_params.roleId = self_player_id
  end
  if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
    jf_params.roleName = self_player_name
  end
  jf_params.type = group_type or ""
  jf_params.result = mute
  jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
  jf_params.voice_channel_id = cur_channel
  ESTAT.stat_bizid("muteperson.mic.online", "0", "0", jf_params)
end

function M.mute_remote_ex(player_id, mute, channel_id, cb)
  if not voice_vendor then
    utils.safe_call_cb(cb, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_VENDOR_MISS, "vendor miss")
    return
  end
  if not player_id then
    utils.safe_call_cb(cb, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_PARAMS_INVALID, "target_player_id miss")
    return
  end
  if not channel_id then
    utils.safe_call_cb(cb, CONSTANTS.CHAT_ERROR_CODES.CODE_VOICE_PARAMS_INVALID, "channel_id miss")
    return
  end
  mute = mute or false
  if mute then
    mute_remote_cache_by_user[player_id] = mute
  else
    mute_remote_cache_by_user[player_id] = nil
  end
  local joined_channels = M._get_joined_channels_inner()
  local channel_info = joined_channels.channels and joined_channels.channels[channel_id]
  local voice_user_id = channel_info and tostring(channel_info.voice_user_id)
  voice_vendor.mute_remote_ex(player_id, mute, channel_id, voice_user_id)
  if EJVOICE_MUTE_REMOTE_CACHE then
    local current_player_mute_list = EJVOICE_MUTE_REMOTE_CACHE:get() or {}
    current_player_mute_list[EG.player_info().player_id] = mute_remote_cache_by_user
    EJVOICE_MUTE_REMOTE_CACHE:set(current_player_mute_list)
    EJVOICE_MUTE_REMOTE_CACHE:save()
  end
end

function M._mute_remote_for_server_sync(player_id, mute)
  if not voice_vendor then
    return
  end
  if not player_id then
    return
  end
  mute = mute or false
  if _local_is_mute_remote_all then
    return
  end
  voice_vendor.mute_remote(player_id, mute, cur_channel)
end

function M.mute_remote_all(mute)
  if voice_vendor then
    voice_vendor.mute_remote_all(mute)
    _local_is_mute_remote_all = mute
    if false == _local_is_mute_remote_all and mute_remote_cache_by_server and type(mute_remote_cache_by_server) == "table" then
      for player_id, m_value in pairs(mute_remote_cache_by_server) do
        if cur_channel and m_value then
          if not multi_channel_mode then
            voice_vendor.mute_remote(player_id, mute, cur_channel)
          else
            local joined_channels = M._get_joined_channels_inner()
            voice_vendor.mute_remote(player_id, mute, joined_channels and joined_channels.main_channel or cur_channel)
          end
        end
      end
    end
  end
end

function M.mute_remote_all_ex(channel_id, mute)
  local joined_channels = M._get_joined_channels_inner()
  local channel_info = joined_channels.channels and joined_channels.channels[channel_id]
  local voice_user_id = channel_info and tostring(channel_info.voice_user_id)
  if voice_vendor then
    voice_vendor.mute_remote_all_ex(channel_id, voice_user_id, mute)
  end
end

function M.enable_volume_indication(interval)
  if voice_vendor then
    voice_vendor.enable_volume_indication(interval)
  end
end

function M.set_parameters(params)
  if voice_vendor then
    voice_vendor.set_parameters(params)
  end
end

function M.enable_ai_denoise(_enable)
  if voice_vendor then
    voice_vendor.enable_ai_denoise(_enable)
  end
end

function M.adjust_record_volume(volume)
  if voice_vendor then
    voice_vendor.adjust_record_volume(volume)
  end
end

function M.adjust_playing_volume(volume)
  if voice_vendor then
    voice_vendor.adjust_playing_volume(volume)
  end
end

function M.enable_local_audio(enable)
  if voice_vendor then
    voice_vendor.enable_local_audio(enable)
  end
end

function M.is_voice_channel_active(channel_id)
  local group = chat_cache.get_group(channel_id)
  if not (group and group.voice_channel) or not group.voice_channel.status then
    return true
  end
  return group.voice_channel.status == "active"
end

function M._do_lazy_join_channel(channel_id, channel_param, opts)
  if voice_vendor then
    local gangplank = require("ejoysdk_lua.ejoysdk_gangplank")
    local player_id = gangplank.player_info().player_id
    if not player_id then
      return
    end
    lazy_joined_channels[channel_id] = true
    local voice_version = M.get_agora_token_version()
    M.get_voice_token(channel_id, voice_version, function(succ, ...)
      if succ then
        local ret_info = (...)
        if ret_info and type(ret_info) == "table" and ret_info.token and ret_info.uid then
          E.LOG.d(TAG, "voice_fsm.add_event -> STATES.JOIN")
          local cache_channel_param = channel_params[channel_id]
          if channel_param then
            cache_channel_param.token = ret_info.token
            cache_channel_param.opts = opts
          end
          voice_fsm:add_event(EVENTS.JOIN, channel_id, player_id, {
            token = ret_info.token,
            voice_user_id = ret_info.uid,
            channel_info = channel_param.channel_info
          })
        else
          callback(EVENT.ON_JOIN_CHANNEL_FAIL, CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_ERROR_ON_GET_VOICE_TOKEN_FAIL, "get voice_token fail")
        end
      else
        local code, msg = ...
        callback(EVENT.ON_JOIN_CHANNEL_FAIL, code or CONSTANTS.CHAT_ERROR_CODES.CODE_SERVER_ERROR_ON_GET_VOICE_TOKEN_FAIL, msg or "get voice_token fail")
      end
    end)
  end
end

function M.get_voice_group_info(group_id)
  local res = chat_cache.get_group(group_id)
  return res
end

function M.start_echo_test(interval_in_seconds)
  if voice_vendor then
    voice_vendor.start_echo_test(interval_in_seconds)
  end
end

function M.stop_echo_test()
  if voice_vendor then
    voice_vendor.stop_echo_test()
  end
end

function M.start_lastmile_probe_test(config)
  if voice_vendor then
    voice_vendor.start_lastmile_probe_test(config)
  end
end

function M.stop_lastmile_probe_test()
  if voice_vendor then
    voice_vendor.stop_lastmile_probe_test()
  end
end

function M.renew_token(token)
  if voice_vendor then
    voice_vendor.renew_token(token)
  end
end

function M.get_count(type)
  if voice_vendor then
    do return voice_vendor.get_count end
    return voice_vendor.get_count, type
  end
  return 0
end

function M.get_application_volume(type)
  if voice_vendor then
    do return voice_vendor.get_application_volume end
    return voice_vendor.get_application_volume, type
  end
  return 0
end

function M.is_application_mute(type)
  if voice_vendor then
    do return voice_vendor.is_application_mute end
    return voice_vendor.is_application_mute, type
  end
  return false
end

function M.enumerate_playback_devices()
  if voice_vendor then
    do return end
    return voice_vendor.enumerate_playback_devices, nil
  end
  return {}
end

function M.enumerate_recording_devices()
  if voice_vendor then
    do return end
    return voice_vendor.enumerate_recording_devices, nil
  end
  return {}
end

function M.set_profile_scenario(profile, scenario)
  if voice_vendor then
    voice_vendor.set_profile_scenario(profile, scenario)
  end
end

function M.set_audio_scenario(scenario)
  if voice_vendor then
    voice_vendor.set_audio_scenario(scenario)
  end
end

function M.enable_loopback_recording(enable, device_name)
  if voice_vendor then
    voice_vendor.enable_loopback_recording(enable, device_name)
  end
end

function M.set_device(type, device_id)
  if voice_vendor then
    voice_vendor.set_device(type, device_id)
  end
end

function M.get_default_device(type)
  if voice_vendor then
    do return voice_vendor.get_default_device end
    return voice_vendor.get_default_device, type
  end
  return {}
end

function M.get_device(type, index)
  if voice_vendor then
    do return voice_vendor.get_device, type end
    return voice_vendor.get_device, type, index
  end
  return {}
end

function M.set_application_volume(type, volume)
  if voice_vendor then
    voice_vendor.set_application_volume(type, volume)
  end
end

function M.set_application_mute(type, mute)
  if voice_vendor then
    voice_vendor.set_application_mute(type, mute)
  end
end

function M.follow_system_playback_device(enable)
  if voice_vendor then
    voice_vendor.follow_system_playback_device(enable)
  end
end

function M.follow_system_recording_device(enable)
  if voice_vendor then
    voice_vendor.follow_system_recording_device(enable)
  end
end

function M.set_playback_device(device_id)
  if voice_vendor then
    voice_vendor.set_playback_device(device_id)
  end
end

function M.get_playback_device()
  if voice_vendor then
    do return end
    return voice_vendor.get_playback_device, nil
  end
  return ""
end

function M.get_playback_device_info()
  if voice_vendor then
    do return end
    return voice_vendor.get_playback_device_info, nil
  end
  return {}
end

function M.set_recording_device(device_id)
  if voice_vendor then
    voice_vendor.set_recording_device(device_id)
  end
end

function M.get_recording_device()
  if voice_vendor then
    do return end
    return voice_vendor.get_recording_device, nil
  end
  return ""
end

function M.get_recording_device_info()
  if voice_vendor then
    do return end
    return voice_vendor.get_recording_device_info, nil
  end
  return {}
end

function M.set_recording_device_volume(volume)
  if voice_vendor then
    voice_vendor.set_recording_device_volume(volume)
  end
end

function M.start_playback_device_test(test_audio_file_path)
  if voice_vendor then
    voice_vendor.start_playback_device_test(test_audio_file_path)
  end
end

function M.stop_playback_device_test()
  if voice_vendor then
    voice_vendor.stop_playback_device_test()
  end
end

function M.start_recording_device_test(interval)
  if voice_vendor then
    voice_vendor.start_recording_device_test(interval)
  end
end

function M.stop_recording_device_test()
  if voice_vendor then
    voice_vendor.stop_recording_device_test()
  end
end

function M.start_audio_device_loopback_test(interval)
  if voice_vendor then
    voice_vendor.start_audio_device_loopback_test(interval)
  end
end

function M.stop_audio_device_loopback_test()
  if voice_vendor then
    voice_vendor.stop_audio_device_loopback_test()
  end
end

function M.is_start_echo_test_process()
  if voice_vendor then
    do return end
    return voice_vendor.is_start_echo_test_process, nil
  end
end

function M.is_start_lastmile_probe_test_process()
  if voice_vendor then
    do return end
    return voice_vendor.is_start_lastmile_probe_test_process, nil
  end
end

function M.is_start_playback_device_test_process()
  if voice_vendor then
    do return end
    return voice_vendor.is_start_playback_device_test_process, nil
  end
end

function M.is_start_recording_device_test_process()
  if voice_vendor then
    do return end
    return voice_vendor.is_start_recording_device_test_process, nil
  end
end

function M.is_start_audio_device_loopback_test_process()
  if voice_vendor then
    do return end
    return voice_vendor.is_start_audio_device_loopback_test_process, "is_start_audio_device_loopback_test_process"
  end
end

function M.set_auto_leave_channel(_auto_leave_channel)
  M.auto_leave_channel = _auto_leave_channel
end

M.default_log_interval = 10
local heartbeat_timer
local stop_timer_flag = false
local cur_timer_id

function M.log_heartbeat_action()
  local jf_params = {}
  jf_params.is_upload_now = false
  jf_params.voice_channel_id = cur_channel
  jf_params.voice_user_id = cur_voice_user_id
  jf_params.mute = mute_local_value
  jf_params.voice_player_id = tostring(EG.player_info() and EG.player_info().player_id)
  ESTAT.stat_bizid("voice.heartbeat", "0", "0", jf_params)
end

function M.start_heartbeat_timer()
  if nil == heartbeat_timer then
    stop_timer_flag = false
    cur_timer_id = tostring(E.system_ms())
    
    function heartbeat_timer(last_timer_id)
      if false == stop_timer_flag and last_timer_id == cur_timer_id then
        M.log_heartbeat_action()
        E.Timer.once(M.default_log_interval, function()
          if false == stop_timer_flag and heartbeat_timer then
            heartbeat_timer(last_timer_id)
          end
        end)
      end
    end
    
    E.Timer.once(1, function()
      if false == stop_timer_flag and heartbeat_timer then
        heartbeat_timer(cur_timer_id)
      end
    end)
  end
end

function M.stop_heartbeat_timer()
  stop_timer_flag = true
  heartbeat_timer = nil
  cur_timer_id = nil
end

function M.set_voice_channel_mode(group_id, mode, cb)
  local chat_base = require("ejoysdk_lua.chat.ejoysdk_chat_base")
  chat_base.set_voice_channel_mode(group_id, mode, function(...)
    if cb then
      cb(...)
    end
    local succ = (...)
    E.LOG.d(TAG, "设置语音频道的模式")
    if succ then
      local agora_vendor = require("ejoysdk_lua.vendors.agora")
      local self_player_id = EG.player_info() and EG.player_info().player_id
      local self_player_name = EG.player_info() and EG.player_info().player_name
      local cached_group = chat_cache.get_group(M.get_curr_channel_id()) or {}
      local group_type = cached_group.info and cached_group.info.type
      local jf_params = {changetype = mode}
      if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
        jf_params.roleId = self_player_id
      end
      if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not agora_vendor.is_forbid_upload_role_name_from_cc() then
        jf_params.roleName = self_player_name
      end
      jf_params.type = group_type or ""
      jf_params.result = mode
      jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
      jf_params.voice_channel_id = cur_channel
      ESTAT.stat_bizid("change.mic.online", "0", "0", jf_params)
    end
  end)
end

function M.manage_voice_channel_status(group_id, operations, cb)
  local chat_base = require("ejoysdk_lua.chat.ejoysdk_chat_base")
  chat_base.manage_voice_channel_status(group_id, operations, function(...)
    if cb then
      cb(...)
    end
  end)
end

return M

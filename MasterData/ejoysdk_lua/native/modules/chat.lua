local E = require("ejoysdk_lua.ejoysdk")
local Utils = require("ejoysdk_lua.native.utils.Utils")
local EU = require("ejoysdk_lua.ejoysdk_utils")
local EC = require("ejoysdk_lua.chat.ejoysdk_chat")
local EV = require("ejoysdk_lua.chat.ejoysdk_voice")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.NATIVE .. "modules.chat"
local M = {}
local notify_callback
local CONNECT_STATE = {
  WAITING = 0,
  CONNECTED = 1,
  DISCONNECT = 2,
  ERROR = 3,
  LOST = 4
}
local MSG_TYPE = {NEW_PERSONAL_MSG = 100, UPDATE_CONNECT = 101}
local state = CONNECT_STATE.WAITING

local function notify_native(type, data_table)
  Utils.notify(notify_callback, 9999, "收到推送", {type = type, data = data_table})
end

function M.init(cb)
  notify_callback = cb
  notify_native(MSG_TYPE.UPDATE_CONNECT, {state = state})
end

function M.send_msg(params, cb)
  local msg = params.msg or ""
  local player_id = params.player_id or ""
  if string.len(msg) <= 0 then
    Utils.notify(cb, -1, "消息为空")
    return
  end
  if string.len(player_id) <= 0 then
    Utils.notify(cb, -1, "player_id为空")
    return
  end
  local session_id = EC.personal_session_id(player_id)
  if session_id and string.len(session_id) > 0 then
    EC.send_text_msg(msg, session_id, function(succ, ...)
      if succ then
        local sid, msg_id = ...
        Utils.notify(cb, 200, "发送个人消息 成功, session_id: " .. sid .. " , msg_id: " .. msg_id, {session_id = sid, msg_id = msg_id})
      else
        local code, error_msg = ...
        Utils.notify(cb, -1, "发送个人消息 失败, code: " .. code .. " ,msg: " .. error_msg)
      end
    end)
  else
    Utils.notify(cb, -1, "session_id为空")
    return
  end
end

function M.async_is_login_succ(cb)
  local res = EC.is_login_succ()
  EU.safe_call_cb(cb, res)
end

function M.async_personal_session_id(with_player_id, cb)
  local session_id = EC.personal_session_id(with_player_id)
  EU.safe_call_cb(cb, session_id)
end

function M.acc_session_id(with_player_id, cb)
  local session_id = EC.personal_session_id(with_player_id)
  EU.safe_call_cb(cb, session_id)
end

function M.async_get_voice_group_info(group_id, cb)
  local group_info = EV.get_voice_group_info(group_id)
  EU.safe_call_cb(cb, group_info)
end

function M.async_get_count(type, cb)
  local count = EV.get_count(type)
  EU.safe_call_cb(cb, count)
end

function M.async_get_application_volume(type, cb)
  local volume = EV.get_application_volume(type)
  EU.safe_call_cb(cb, volume)
end

function M.async_is_application_mute(type, cb)
  local mute = EV.is_application_mute(type)
  EU.safe_call_cb(cb, mute)
end

function M.async_enumerate_playback_devices(cb)
  local devices = EV.enumerate_playback_devices()
  EU.safe_call_cb(cb, devices)
end

function M.async_enumerate_recording_devices(cb)
  local devices = EV.enumerate_recording_devices()
  EU.safe_call_cb(cb, devices)
end

function M.async_get_device(type, index, cb)
  local device_info = EV.get_device(type, index)
  EU.safe_call_cb(cb, device_info or {})
end

function M.async_get_playback_device(cb)
  local device_id = EV.get_playback_device()
  EU.safe_call_cb(cb, device_id or "")
end

function M.async_get_playback_device_info(cb)
  local device_info = EV.get_playback_device_info()
  EU.safe_call_cb(cb, device_info or {})
end

function M.async_get_recording_device(cb)
  local device_id = EV.get_recording_device()
  EU.safe_call_cb(cb, device_id or "")
end

function M.async_get_recording_device_info(cb)
  local device_info = EV.get_recording_device_info()
  EU.safe_call_cb(cb, device_info or {})
end

function M.async_get_default_device(type, cb)
  local device_info = EV.get_default_device(type)
  EU.safe_call_cb(cb, device_info or {})
end

function M.async_is_start_echo_test_process(cb)
  local value = EV.is_start_echo_test_process()
  EU.safe_call_cb(cb, value or false)
end

function M.async_is_start_lastmile_probe_test_process(cb)
  local value = EV.is_start_lastmile_probe_test_process()
  EU.safe_call_cb(cb, value or false)
end

function M.async_is_start_playback_device_test_process(cb)
  local value = EV.is_start_playback_device_test_process()
  EU.safe_call_cb(cb, value or false)
end

function M.async_is_start_recording_device_test_process(cb)
  local value = EV.is_start_recording_device_test_process()
  EU.safe_call_cb(cb, value or false)
end

function M.async_is_start_audio_device_loopback_test_process(cb)
  local value = EV.is_start_audio_device_loopback_test_process()
  EU.safe_call_cb(cb, value or false)
end

function M.on_connected()
  E.LOG.debug(TAG, "获取聊天连接状态 成功")
  state = CONNECT_STATE.CONNECTED
  notify_native(MSG_TYPE.UPDATE_CONNECT, {state = state})
end

function M.on_disconnect()
  E.LOG.debug(TAG, "获取聊天断开连接状态 成功")
  state = CONNECT_STATE.DISCONNECT
  notify_native(MSG_TYPE.UPDATE_CONNECT, {state = state})
end

function M.on_error()
  E.LOG.debug(TAG, "获取聊天错误状态 成功")
  state = CONNECT_STATE.ERROR
  notify_native(MSG_TYPE.UPDATE_CONNECT, {state = state})
end

function M.on_connect_lost()
  E.LOG.debug(TAG, "聊天连接丢失")
  state = CONNECT_STATE.LOST
  notify_native(MSG_TYPE.UPDATE_CONNECT, {state = state})
end

function M.receive_personal_msg(msgs)
  for _, msg in pairs(msgs) do
    notify_native(MSG_TYPE.NEW_PERSONAL_MSG, msg)
  end
end

return M

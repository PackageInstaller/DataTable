local E = require("ejoysdk_lua.ejoysdk")
local cache = require("ejoysdk_lua.chat.ejoysdk_chat_cache")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local voice_event = require("ejoysdk_lua.chat.ejoysdk_voice_event")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local log_mgr = require("ejoysdk_lua.ejoysdk_log_mgr")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local ECC = require("ejoysdk_lua.ejoysdk_config_center")
local VENDOR_NAME = "AGORA"
local SYNC_IS_COMPAT_NEW_API = "SYNC_IS_COMPAT_NEW_API"
local CAST_INIT_ENGINE = "CAST_INIT_ENGINE"
local CAST_JOIN_CHANNEL = "CAST_JOIN_CHANNEL"
local CAST_JOIN_CHANNEL_WITH_TOKEN = "CAST_JOIN_CHANNEL_WITH_TOKEN"
local CAST_LEAVE_CHANNEL = "CAST_LEAVE_CHANNEL"
local CAST_ENABLE_AUDIO_VOLUME_INDICATION = "CAST_ENABLE_AUDIO_VOLUME_INDICATION"
local CAST_MUTE_LOCAL = "CAST_MUTE_LOCAL"
local CAST_MUTE_REMOTE = "CAST_MUTE_REMOTE"
local CAST_MUTE_REMOTE_ALL = "CAST_MUTE_REMOTE_ALL"
local CAST_SET_ENABLE_SPEAKER = "CAST_SET_ENABLE_SPEAKER"
local CAST_SET_PARAMETERS = "CAST_SET_PARAMETERS"
local CAST_ADJUST_RECORD_VOLUME = "CAST_ADJUST_RECORD_VOLUME"
local CAST_ADJUST_PLAYING_VOLUME = "CAST_ADJUST_PLAYING_VOLUME"
local CAST_SET_DEFAULT_AUDIO_ROUTE_TO_SPEAKER = "CAST_SET_DEFAULT_AUDIO_ROUTE_TO_SPEAKER"
local CAST_SET_AUDIO_PROFILE = "CAST_SET_AUDIO_PROFILE"
local CAST_ENABLE_LOCAL_AUDIO = "CAST_ENABLE_LOCAL_AUDIO"
local CAST_SET_CLIENT_ROLE = "CAST_SET_CLIENT_ROLE"
local CAST_START_ECHO_TEST = "CAST_START_ECHO_TEST"
local CAST_STOP_ECHO_TEST = "CAST_STOP_ECHO_TEST"
local CAST_START_LASTMILE_PROBE_TEST = "CAST_START_LASTMILE_PROBE_TEST"
local CAST_STOP_LASTMILE_PROBE_TEST = "CAST_STOP_LASTMILE_PROBE_TEST"
local SYNC_DESTROY_ENGINE = "SYNC_DESTROY_ENGINE"
local EVT_USER_JOINED = "EVT_USER_JOINED"
local EVT_USER_OFFLINE = "EVT_USER_OFFLINE"
local EVT_USER_MUTED = "EVT_USER_MUTED"
local EVT_JOIN_CHANNEL_SUCC = "EVT_JOIN_CHANNEL_SUCC"
local EVT_JOIN_CHANNEL_FAIL = "EVT_JOIN_CHANNEL_FAIL"
local EVT_REJOIN_CHANNEL_SUCC = "EVT_REJOIN_CHANNEL_SUCC"
local EVT_LEAVE_CHANNEL_SUCC = "EVT_LEAVE_CHANNEL_SUCC"
local EVT_LEAVE_CHANNEL_FAIL = "EVT_LEAVE_CHANNEL_FAIL"
local EVT_ERROR = "EVT_ERROR"
local EVT_CONNECTION_LOST = "EVT_CONNECTION_LOST"
local EVT_CONNECTION_BANNED = "EVT_CONNECTION_BANNED"
local EVT_CONNECTION_INTERRUPT = "EVT_CONNECTION_INTERRUPT"
local EVT_AUDIO_VOLUME_INDICATION = "EVT_AUDIO_VOLUME_INDICATION"
local EVT_LASTMILE_QUALITY = "EVT_LASTMILE_QUALITY"
local EVT_LASTMILE_PROBE_RESULT = "EVT_LASTMILE_PROBE_RESULT"
local EVT_AUDIO_QUALITY = "EVT_AUDIO_QUALITY"
local EVT_CONNECTION_STATE_CHANGED = "EVT_CONNECTION_STATE_CHANGED"
local EVT_REQUEST_TOKEN = "EVT_REQUEST_TOKEN"
local EVT_TOKEN_PRIVILEGE_WILL_EXPIRE = "EVT_TOKEN_PRIVILEGE_WILL_EXPIRE"
local EVT_LOCAL_AUDIO_STATE_CHANGED = "EVT_LOCAL_AUDIO_STATE_CHANGED"
local EVT_AUDIO_DEVICE_STATE_CHANGED = "EVT_AUDIO_DEVICE_STATE_CHANGED"
local EVT_REMOTE_AUDIO_STATS = "EVT_REMOTE_AUDIO_STATS"
local AGORA_V4_FUNTIONS = {
  CAST_SET_CHANNEL_PROFILE = "CAST_SET_CHANNEL_PROFILE",
  CAST_SET_AUDIO_SCENARIO = "CAST_SET_AUDIO_SCENARIO",
  CAST_JOIN_CHANNEL_EX = "CAST_JOIN_CHANNEL_EX",
  CAST_LEAVE_CHANNEL_EX = "CAST_LEAVE_CHANNEL_EX",
  CAST_MUTE_REMOTE_EX = "CAST_MUTE_REMOTE_EX",
  CAST_MUTE_REMOTE_ALL_EX = "CAST_MUTE_REMOTE_ALL_EX",
  CAST_MUTE_LOCAL_EX = "CAST_MUTE_LOCAL_EX"
}
local EVT_RTC_STATS = "EVT_RTC_STATS"
local AGORA_JF_UPLOAD_NOW = false
local agora_listener
local TAG = EM.MODULE.VENDORS.AGORA

local function is_forbid_upload_role_name_from_cc()
  local cc_config = ECC.get_config(ECC.NAMESPACE.EJOYSDK_BIZ)
  local agora_config = cc_config and cc_config.config and cc_config.config.agora
  if agora_config and agora_config.is_forbid_upload_role_name then
    return true
  end
  return false
end

local function callback(handler_name, ...)
  if not agora_listener then
    return
  end
  local handler = agora_listener[handler_name]
  if handler then
    handler(...)
  end
  if "on_error" == handler_name then
    local voice = require("ejoysdk_lua.chat.ejoysdk_voice")
    local ESTAT = require("ejoysdk_lua.ejoysdk_stat")
    local error_code, error_msg = ...
    local EG = require("ejoysdk_lua.ejoysdk_gangplank")
    local chat_cache = require("ejoysdk_lua.chat.ejoysdk_chat_cache")
    local self_player_id = EG.player_info() and EG.player_info().player_id
    local self_player_name = EG.player_info() and EG.player_info().player_name
    local cached_group = chat_cache.get_group(voice.get_curr_channel_id()) or {}
    local group_type = cached_group.info and cached_group.info.type
    local jf_params = {
      code = tostring(error_code),
      msg = tostring(error_msg)
    }
    if self_player_id and type(self_player_id) == "string" and #self_player_id > 0 then
      jf_params.roleId = self_player_id
    end
    if self_player_name and type(self_player_name) == "string" and #self_player_name > 0 and not is_forbid_upload_role_name_from_cc() then
      jf_params.roleName = self_player_name
    end
    jf_params.type = group_type or ""
    jf_params.result = false
    jf_params.is_upload_now = AGORA_JF_UPLOAD_NOW
    ESTAT.stat_bizid("error.voice.online", "0", "0", jf_params)
  end
end

local delay_callback_list = {}

local function add_delay_uid_callback(handler_name, body)
  table.insert(delay_callback_list, {handler_name = handler_name, body = body})
end

local M = Vendor:Inherit(VENDOR_NAME)
M.AUDIO_SCENARIO_DEFAULT = 0
M.AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT = 1
M.AUDIO_SCENARIO_EDUCATION = 2
M.AUDIO_SCENARIO_GAME_STREAMING = 3
M.AUDIO_SCENARIO_SHOWROOM = 4
M.AUDIO_SCENARIO_CHATROOM_GAMING = 5
M.AUDIO_SCENARIO_CHORUS = 7
M.AUDIO_SCENARIO_MEETING = 8
M.AUDIO_SCENARIO_AI_CLIENT = 10
M.AUDIO_PROFILE_DEFAULT = 0
M.AUDIO_PROFILE_SPEECH_STANDARD = 1
M.AUDIO_PROFILE_MUSIC_STANDARD = 2
M.AUDIO_PROFILE_MUSIC_STANDARD_STEREO = 3
M.AUDIO_PROFILE_MUSIC_HIGH_QUALITY = 4
M.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO = 5
M.CONNECTION_CHANGED_TOKEN_EXPIRED = 9
local audio_scenario = M.AUDIO_SCENARIO_DEFAULT
local audio_profile = M.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO
local is_joining_channel = false
local is_leaveing_channel = false
local last_join_suc_uid, last_join_suc_channel
M.is_forbid_upload_role_name_from_cc = is_forbid_upload_role_name_from_cc

function M.set_parameters(params)
  log_mgr.call_api({}, TAG, "set_parameters", log_mgr.LOG_LEVEL.LOW, {}, params)
  UNI.cast(VENDOR_NAME, CAST_SET_PARAMETERS, {params = params})
end

local function initialize_engine()
  E.LOG.debug(TAG, "agora initialize engine")
  UNI.cast(VENDOR_NAME, CAST_INIT_ENGINE, {})
end

local _is_enable_version

function M.sync_enable_version()
  if nil ~= _is_enable_version then
    E.LOG.debug(TAG, "sync_version_check, result: " .. tostring(_is_enable_version))
    return _is_enable_version
  end
  if _ejoysdk.os() == "android" then
    local version = E.Sdkinfo.getSDKVersionName("AGORA")
    local version_check = require("ejoysdk_lua.ejoysdk_version_check")
    local result_3 = version_check.compare_versions(version, "3.0.0")
    local result_4 = version_check.compare_versions(version, "4.0.0")
    if tonumber(result_4) >= 0 then
      _is_enable_version = true
    elseif tonumber(result_3) >= 0 then
      local os_version = E.Sysinfo.os_version() or ""
      local os_version_number = tonumber(os_version) or -1
      if 28 == os_version_number and E.Sysinfo.is_simulator() then
        _is_enable_version = false
      else
        _is_enable_version = true
      end
    else
      _is_enable_version = true
    end
    _ejoysdk.log(TAG .. "sync_version_check, result: " .. tostring(_is_enable_version))
    return _is_enable_version
  end
  _is_enable_version = true
  return _is_enable_version
end

function M.init(_opt, cb)
  pcall(M.sync_enable_version)
  if false == _is_enable_version then
    cb(true)
    return
  end
  initialize_engine()
  local ejoysdk_voice = require("ejoysdk_lua.chat.ejoysdk_voice")
  ejoysdk_voice.set_voice_vendor(M)
  cb(true)
end

local is_support_cache = {}

function M.is_compat_agora_api(api_name)
  if nil ~= is_support_cache[api_name] then
    return is_support_cache[api_name]
  end
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_IS_COMPAT_NEW_API, {name = api_name})
  if ret then
    local result = ret.value or false
    is_support_cache[api_name] = result
    return result
  end
  is_support_cache[api_name] = false
  return false
end

function M.is_support_token_join()
  return M.is_compat_agora_api(CAST_JOIN_CHANNEL_WITH_TOKEN) or false
end

local _is_v4_agora

function M.is_v4_agora()
  if nil ~= _is_v4_agora then
    return _is_v4_agora
  end
  local VCheck = require("ejoysdk_lua.ejoysdk_version_check")
  if _ejoysdk.os() == "windows" then
    local sdk_version = E.Sdkinfo.getSDKVersionName("EJOYSDK")
    E.log(string.format("Current SDK Version: %s", sdk_version))
    local check_result = VCheck.compare_versions(sdk_version, "2.8.2")
    if tonumber(check_result) >= 0 then
      _is_v4_agora = true
    else
      _is_v4_agora = false
    end
    return _is_v4_agora
  end
  local sdk_version = E.Sdkinfo.getSDKVersionName("AGORA")
  E.log(string.format("Current SDK Version: %s", sdk_version))
  local check_result = VCheck.compare_versions(sdk_version, "4.0.0")
  if tonumber(check_result) >= 0 then
    _is_v4_agora = true
  else
    _is_v4_agora = false
  end
  return _is_v4_agora
end

function M.join_channel(channel_id, uid, opt)
  log_mgr.call_api({}, TAG, "join_channel", log_mgr.LOG_LEVEL.LOW, {}, channel_id, uid, opt)
  local agora_token = opt.token
  is_joining_channel = true
  M.set_parameters("{\"che.audio.keep.audiosession\":true}")
  M.set_parameters("{\"che.audio.mix_with_others\": true}")
  M.set_parameters("{\"rtc.sync_user_account_callback\":true}")
  M.set_default_to_speaker(true)
  UNI.cast(VENDOR_NAME, CAST_SET_AUDIO_PROFILE, {profile = audio_profile, scenario = audio_scenario})
  if M.is_v4_agora() then
    M.set_channel_profile(0)
  end
  local is_support_token_join = M.is_support_token_join()
  local use_account_join = opt and opt.use_account_join or false
  if not is_support_token_join or use_account_join then
    E.LOG.d(TAG, "join_channel with old api: joinChannelByUserAccount, is_support_token_join:" .. tostring(is_support_token_join) .. ", use_account_join:" .. tostring(use_account_join))
    UNI.cast(VENDOR_NAME, CAST_JOIN_CHANNEL, {
      token = agora_token,
      voice_channel = channel_id,
      uid = uid
    })
  else
    local voice_user_id = opt and opt.voice_user_id
    M.update_id_maps(channel_id, uid, voice_user_id)
    UNI.cast(VENDOR_NAME, CAST_JOIN_CHANNEL_WITH_TOKEN, {
      token = agora_token,
      voice_channel = channel_id,
      uid = uid,
      voice_user_id = voice_user_id
    })
  end
  last_join_suc_uid = uid
  last_join_suc_channel = channel_id
end

function M.leave_channel(options)
  log_mgr.call_api({}, TAG, "leave_channel", log_mgr.LOG_LEVEL.LOW, {}, options)
  is_leaveing_channel = true
  local params = {options = options}
  UNI.cast(VENDOR_NAME, CAST_LEAVE_CHANNEL, params)
end

function M.join_channel_ex(channel_id, uid, opt)
  log_mgr.call_api({}, TAG, "join_channel_ex", log_mgr.LOG_LEVEL.LOW, {}, channel_id, uid, opt)
  local agora_token = opt.token
  is_joining_channel = true
  local voice_user_id = opt and opt.voice_user_id
  M.update_id_maps(channel_id, uid, voice_user_id)
  local options = opt and opt.channel_info and opt.channel_info.options or {}
  if options.publishMicrophoneTrack == nil then
    options.publishMicrophoneTrack = true
  end
  if nil == options.autoSubscribeAudio then
    options.autoSubscribeAudio = true
  end
  if nil == options.enableAudioRecordingOrPlayout then
    options.enableAudioRecordingOrPlayout = true
  end
  if nil == options.channelProfile then
    options.channelProfile = 0
  end
  if nil == options.clientRoleType then
    options.clientRoleType = 1
  end
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_JOIN_CHANNEL_EX, {
    token = agora_token,
    voice_channel = channel_id,
    uid = uid,
    voice_user_id = voice_user_id,
    options = options
  })
  last_join_suc_channel = channel_id
  last_join_suc_uid = uid
end

function M.leave_channel_ex(channel_id, voice_user_id, options)
  log_mgr.call_api({}, TAG, "leave_channel_ex", log_mgr.LOG_LEVEL.LOW, {}, channel_id, options)
  is_leaveing_channel = true
  local params = {
    voice_channel = channel_id,
    voice_user_id = voice_user_id,
    options = options
  }
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_LEAVE_CHANNEL_EX, params)
end

function M.set_listener(listener)
  log_mgr.call_api({}, TAG, "set_listener", log_mgr.LOG_LEVEL.LOW, {}, listener)
  agora_listener = listener
end

function M.enable_volume_indication(interval, smooth)
  log_mgr.call_api({}, TAG, "enable_volume_indication", log_mgr.LOG_LEVEL.LOW, {}, interval, smooth)
  UNI.cast(VENDOR_NAME, CAST_ENABLE_AUDIO_VOLUME_INDICATION, {interval = interval, smooth = smooth})
end

function M.set_enable_speaker(enable)
  log_mgr.call_api({}, TAG, "set_enable_speaker", log_mgr.LOG_LEVEL.LOW, {}, enable)
  UNI.cast(VENDOR_NAME, CAST_SET_ENABLE_SPEAKER, {enable = enable})
end

function M.enable_local_audio(enable)
  log_mgr.call_api({}, TAG, "enable_local_audio", log_mgr.LOG_LEVEL.LOW, {}, enable)
  UNI.cast(VENDOR_NAME, CAST_ENABLE_LOCAL_AUDIO, {enable = enable})
end

function M.mute_local(mute)
  log_mgr.call_api({}, TAG, "mute_local", log_mgr.LOG_LEVEL.LOW, {}, mute)
  UNI.cast(VENDOR_NAME, CAST_MUTE_LOCAL, {mute = mute})
end

function M.mute_local_ex(channel_id, voice_user_id, mute)
  log_mgr.call_api({}, TAG, "mute_local_ex", log_mgr.LOG_LEVEL.LOW, {}, channel_id, mute)
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_MUTE_LOCAL_EX, {
    mute = mute,
    voice_channel = channel_id,
    voice_user_id = voice_user_id
  })
end

function M.mute_remote(uid, mute, channel_id)
  log_mgr.call_api({}, TAG, "mute_remote", log_mgr.LOG_LEVEL.LOW, {}, uid, mute)
  local voice_user_id
  if channel_id and uid then
    E.LOG.d(TAG, string.format("mute_remote params => channel_id=%s", tostring(channel_id)))
    voice_user_id = M.get_cache_voice_user_id_with(channel_id, uid)
  end
  E.LOG.d(TAG, string.format("mute_remote params => uid=%s, voice_user_id=%s, mute=%s", tostring(uid), tostring(voice_user_id), tostring(mute)))
  UNI.cast(VENDOR_NAME, CAST_MUTE_REMOTE, {
    mute = mute,
    uid = uid,
    voice_user_id = voice_user_id
  })
end

function M.mute_remote_ex(uid, mute, channel_id, voice_user_id)
  log_mgr.call_api({}, TAG, "mute_remote_ex", log_mgr.LOG_LEVEL.LOW, {}, uid, mute)
  local target_voice_user_id
  if channel_id and uid then
    E.LOG.d(TAG, string.format("mute_remote_ex params => channel_id=%s", tostring(channel_id)))
    target_voice_user_id = M.get_cache_voice_user_id_with(channel_id, uid)
  end
  E.LOG.d(TAG, string.format("mute_remote_ex params => uid=%s, player_id=%s, mute=%s, channel_id=%s", tostring(uid), tostring(target_voice_user_id), tostring(mute), tostring(channel_id)))
  if not target_voice_user_id or not voice_user_id then
    E.LOG.d(TAG, "can not found target user_id or voice_user_id")
    return
  end
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_MUTE_REMOTE_EX, {
    mute = mute,
    target_voice_user_id = target_voice_user_id,
    voice_channel = channel_id,
    voice_user_id = voice_user_id
  })
end

function M.mute_remote_all(mute)
  log_mgr.call_api({}, TAG, "mute_remote_all", log_mgr.LOG_LEVEL.LOW, {}, mute)
  UNI.cast(VENDOR_NAME, CAST_MUTE_REMOTE_ALL, {mute = mute})
end

function M.mute_remote_all_ex(channel_id, voice_user_id, mute)
  log_mgr.call_api({}, TAG, "mute_remote_all_ex", log_mgr.LOG_LEVEL.LOW, {}, channel_id, mute)
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_MUTE_REMOTE_ALL_EX, {
    mute = mute,
    voice_channel = channel_id,
    voice_user_id = voice_user_id
  })
end

function M.adjust_record_volume(volume)
  log_mgr.call_api({}, TAG, "adjust_record_volume", log_mgr.LOG_LEVEL.LOW, {}, volume)
  UNI.cast(VENDOR_NAME, CAST_ADJUST_RECORD_VOLUME, {volume = volume})
end

function M.adjust_playing_volume(volume)
  log_mgr.call_api({}, TAG, "adjust_playing_volume", log_mgr.LOG_LEVEL.LOW, {}, volume)
  UNI.cast(VENDOR_NAME, CAST_ADJUST_PLAYING_VOLUME, {volume = volume})
end

function M.set_channel_profile(profile)
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_SET_CHANNEL_PROFILE, {profile = profile})
end

function M.set_audio_profile(profile, scenario)
  UNI.cast(VENDOR_NAME, CAST_SET_AUDIO_PROFILE, {profile = profile, scenario = scenario})
end

function M.set_audio_scenario(scenario)
  UNI.cast(VENDOR_NAME, AGORA_V4_FUNTIONS.CAST_SET_AUDIO_SCENARIO, {scenario = scenario})
end

function M.set_default_to_speaker(default_to_speaker)
  log_mgr.call_api({}, TAG, "set_default_to_speaker", log_mgr.LOG_LEVEL.LOW, {}, default_to_speaker)
  UNI.cast(VENDOR_NAME, CAST_SET_DEFAULT_AUDIO_ROUTE_TO_SPEAKER, {default_to_speaker = default_to_speaker})
end

function M.set_profile_scenario(profile, scenario)
  log_mgr.call_api({}, TAG, "set_profile_scenario", log_mgr.LOG_LEVEL.LOW, {}, profile, scenario)
  E.LOG.d(TAG, "set_profile_scenario, profile=" .. tostring(profile) .. ", scenario=" .. tostring(scenario))
  audio_profile = profile
  audio_scenario = scenario
end

function M.set_client_role(role)
  log_mgr.call_api({}, TAG, "set_client_role", log_mgr.LOG_LEVEL.LOW, {}, role)
  UNI.cast(VENDOR_NAME, CAST_SET_CLIENT_ROLE, {role = role})
end

function M.start_echo_test(interval_in_seconds)
  log_mgr.call_api({}, TAG, "start_echo_test", log_mgr.LOG_LEVEL.LOW, {}, interval_in_seconds)
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "start_echo_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, CAST_START_ECHO_TEST, {interval_in_seconds = interval_in_seconds})
end

function M.stop_echo_test()
  log_mgr.call_api({}, TAG, "stop_echo_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "stop_echo_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, CAST_STOP_ECHO_TEST, {})
end

function M.start_lastmile_probe_test(config)
  log_mgr.call_api({}, TAG, "start_lastmile_probe_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "start_lastmile_probe_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, CAST_START_LASTMILE_PROBE_TEST, config or {})
end

function M.stop_lastmile_probe_test()
  log_mgr.call_api({}, TAG, "stop_lastmile_probe_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "stop_lastmile_probe_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, CAST_STOP_LASTMILE_PROBE_TEST, {})
end

function M.enable_loopback_recording(enable, device_name)
  log_mgr.call_api({}, TAG, "enable_loopback_recording", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "enable_loopback_recording不支持移动端")
    return
  end
  if device_name and type(device_name) == "string" and #device_name > 0 then
    UNI.cast(VENDOR_NAME, "CAST_ENABLE_LOOPBACK_RECORDING", {enable = enable, device_name = device_name})
  else
    UNI.cast(VENDOR_NAME, "CAST_ENABLE_LOOPBACK_RECORDING", {enable = enable})
  end
end

function M.set_device(type, device_id)
  log_mgr.call_api({}, TAG, "set_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "set_device不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_SET_DEVICE", {type = type, device_id = device_id})
end

function M.get_default_device(type)
  log_mgr.call_api({}, TAG, "get_default_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_default_device不支持移动端")
    return {}
  end
  local ret = UNI.sync_call(VENDOR_NAME, "CAST_GET_DEFAULT_DEVICE", {type = type})
  if ret then
    return ret.value or {}
  else
    return {}
  end
end

function M.get_device(type, index)
  log_mgr.call_api({}, TAG, "get_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_device不支持移动端")
    return {}
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_GET_DEVICE", {type = type, index = index})
  if ret then
    return ret.value or {}
  else
    return {}
  end
end

function M.get_count(type)
  log_mgr.call_api({}, TAG, "get_count", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_count不支持移动端")
    return 0
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_GET_COUNT", {type = type})
  if ret then
    return ret.value or 0
  else
    return 0
  end
end

function M.set_application_volume(type, volume)
  log_mgr.call_api({}, TAG, "set_application_volume", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "set_application_volume不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_SET_APPLICATION_VOLUME", {type = type, volume = volume})
end

function M.get_application_volume(type)
  log_mgr.call_api({}, TAG, "get_application_volume", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_application_volume不支持移动端")
    return 0
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_GET_APPLICATION_VOLUME", {type = type})
  if ret then
    return ret.value or 0
  else
    return 0
  end
end

function M.set_application_mute(type, mute)
  log_mgr.call_api({}, TAG, "set_application_mute", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "set_application_mute不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_SET_APPLICATION_MUTE", {type = type, mute = mute})
end

function M.is_application_mute(type)
  log_mgr.call_api({}, TAG, "is_application_mute", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "is_application_mute不支持移动端")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_IS_APPLICATION_MUTE", {type = type})
  if ret then
    return ret.value or false
  else
    return false
  end
end

function M.enumerate_playback_devices()
  log_mgr.call_api({}, TAG, "enumerate_playback_devices", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "enumerate_playback_devices不支持移动端")
    return {}
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_ENUMERATE_PLAYBACK_DEVICES", {})
  if ret then
    return ret.value or {}
  else
    return {}
  end
end

function M.enumerate_recording_devices()
  log_mgr.call_api({}, TAG, "enumerate_recording_devices", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "enumerate_recording_devices不支持移动端")
    return {}
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_ENUMERATE_RECORDING_DEVICES", {})
  if ret then
    return ret.value or {}
  else
    return {}
  end
end

function M.follow_system_playback_device(enable)
  log_mgr.call_api({}, TAG, "follow_system_playback_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "follow_system_playback_device不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_FOLLOW_SYSTEM_PLAYBACK_DEVICE", {enable = enable})
end

function M.follow_system_recording_device(enable)
  log_mgr.call_api({}, TAG, "follow_system_recording_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "follow_system_recording_device不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_FOLLOW_SYSTEM_RECORDING_DEVICE", {enable = enable})
end

function M.set_playback_device(device_id)
  log_mgr.call_api({}, TAG, "set_playback_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "set_playback_device不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_SET_PLAYBACK_DEVICE", {device_id = device_id})
end

function M.get_playback_device()
  log_mgr.call_api({}, TAG, "get_playback_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_playback_device不支持移动端")
    return ""
  end
  local ret = UNI.sync_call(VENDOR_NAME, "CAST_GET_PLAYBACK_DEVICE", {})
  if ret then
    return ret.value or ""
  else
    return ""
  end
end

function M.get_playback_device_info()
  log_mgr.call_api({}, TAG, "get_playback_device_info", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_playback_device_info不支持移动端")
    return {}
  end
  local ret = UNI.sync_call(VENDOR_NAME, "CAST_GET_PLAYBACK_DEVICE_INFO", {})
  if ret then
    return ret.value or {}
  else
    return {}
  end
end

function M.set_recording_device(device_id)
  log_mgr.call_api({}, TAG, "set_recording_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "set_recording_device不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_SET_RECORDING_DEVICE", {device_id = device_id})
end

function M.get_recording_device()
  log_mgr.call_api({}, TAG, "get_recording_device", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_recording_device不支持移动端")
    return ""
  end
  local ret = UNI.sync_call(VENDOR_NAME, "CAST_GET_RECORDING_DEVICE", {})
  if ret then
    return ret.value or ""
  else
    return ""
  end
end

function M.is_start_echo_test_process()
  log_mgr.call_api({}, TAG, "is_start_echo_test_process", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "is_start_echo_test_process不支持移动端")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_IS_START_ECHO_TEST_PROCESS", {})
  if ret then
    return ret.value or false
  else
    return false
  end
end

function M.is_start_lastmile_probe_test_process()
  log_mgr.call_api({}, TAG, "is_start_lastmile_probe_test_process", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "is_start_lastmile_probe_test_process不支持移动端")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_IS_START_LASTMILE_PROBE_TEST_PROCESS", {})
  if ret then
    return ret.value or false
  else
    return false
  end
end

function M.is_start_playback_device_test_process()
  log_mgr.call_api({}, TAG, "is_start_playback_device_test_process", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "is_start_playback_device_test_process不支持移动端")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_IS_START_PLAYBACK_DEVICE_TEST_PROCESS", {})
  if ret then
    return ret.value or false
  else
    return false
  end
end

function M.is_start_recording_device_test_process()
  log_mgr.call_api({}, TAG, "is_start_recording_device_test_process", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "is_start_recording_device_test_process不支持移动端")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_IS_START_RECORDING_DEVICE_TEST_PROCESS", {})
  if ret then
    return ret.value or false
  else
    return false
  end
end

function M.is_start_audio_device_loopback_test_process()
  log_mgr.call_api({}, TAG, "is_start_audio_device_loopback_test_process", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "is_start_audio_device_loopback_test_process不支持移动端")
    return false
  end
  local ret = UNI.sync_call(VENDOR_NAME, "SYNC_IS_START_AUDIO_DEVICE_LOOPBACK_TEST_PROCESS", {})
  if ret then
    return ret.value or false
  else
    return false
  end
end

function M.get_recording_device_info()
  log_mgr.call_api({}, TAG, "get_recording_device_info", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "get_recording_device_info不支持移动端")
    return {}
  end
  local ret = UNI.sync_call(VENDOR_NAME, "CAST_GET_RECORDING_DEVICE_INFO", {})
  if ret then
    return ret.value or {}
  else
    return {}
  end
end

function M.set_recording_device_volume(volume)
  log_mgr.call_api({}, TAG, "set_recording_device_volume", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "set_recording_device_volume不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_SET_RECORDING_DEVICE_VOLUME", {volume = volume})
end

function M.start_playback_device_test(test_audio_file_path)
  log_mgr.call_api({}, TAG, "start_playback_device_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "start_playback_device_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_START_PLAYBACK_DEVICE_TEST", {test_audio_file_path = test_audio_file_path})
end

function M.stop_playback_device_test()
  log_mgr.call_api({}, TAG, "stop_playback_device_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "stop_playback_device_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_STOP_PLAYBACK_DEVICE_TEST", {})
end

function M.start_recording_device_test(interval)
  log_mgr.call_api({}, TAG, "start_recording_device_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "start_recording_device_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_START_RECORDING_DEVICE_TEST", {interval = interval})
end

function M.stop_recording_device_test()
  log_mgr.call_api({}, TAG, "stop_recording_device_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "stop_recording_device_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_STOP_RECORDING_DEVICE_TEST", {})
end

function M.start_audio_device_loopback_test(interval)
  log_mgr.call_api({}, TAG, "start_audio_device_loopback_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "start_audio_device_loopback_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_START_AUDIO_DEVICE_LOOPBACK_TEST", {interval = interval})
end

function M.stop_audio_device_loopback_test()
  log_mgr.call_api({}, TAG, "stop_audio_device_loopback_test", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "stop_audio_device_loopback_test不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_STOP_AUDIO_DEVICE_LOOPBACK_TEST", {})
end

function M.renew_token(token)
  log_mgr.call_api({}, TAG, "renew_token", log_mgr.LOG_LEVEL.LOW, {})
  if _ejoysdk.os() ~= "windows" then
    E.LOG.d(TAG, "renew_token不支持移动端")
    return
  end
  UNI.cast(VENDOR_NAME, "CAST_RENEW_TOKEN", {token = token})
end

function M.renew_token_with_params(params)
  M.renew_token(params.token)
end

local is_support_renewtoken

function M.is_support_token_refresh()
  if nil == is_support_renewtoken then
    if _ejoysdk.os() == "windows" then
      is_support_renewtoken = true
    else
      is_support_renewtoken = false
    end
  end
  return is_support_renewtoken
end

local voice_user_id_maps = {}
local player_id_maps = {}

function M.update_id_maps(t_channel_id, t_player_id, t_voice_user_id)
  if not t_channel_id or 0 == #t_channel_id then
    return
  end
  if not t_player_id or 0 == #t_player_id then
    return
  end
  if not t_voice_user_id then
    return
  end
  if not voice_user_id_maps[t_channel_id] then
    voice_user_id_maps[t_channel_id] = {}
  end
  voice_user_id_maps[t_channel_id][t_player_id] = t_voice_user_id
  player_id_maps[t_voice_user_id] = t_player_id
end

function M.get_cache_voice_user_id_with(t_channel_id, t_player_id)
  if voice_user_id_maps[t_channel_id] and voice_user_id_maps[t_channel_id][t_player_id] then
    return voice_user_id_maps[t_channel_id][t_player_id]
  end
  local target_voice_user_id
  local group_info = cache.get_group(t_channel_id)
  if group_info and group_info.voice_channel_users then
    if nil == voice_user_id_maps[t_channel_id] then
      voice_user_id_maps[t_channel_id] = {}
    end
    for _, user in pairs(group_info.voice_channel_users) do
      if user.user_id then
        voice_user_id_maps[t_channel_id][user.user_id] = user.voice_user_id
      end
      if user and user.user_id == t_player_id then
        target_voice_user_id = user.voice_user_id
      end
    end
  end
  return target_voice_user_id
end

function M.get_cache_player_id(t_voice_user_id)
  t_voice_user_id = tostring(t_voice_user_id)
  if player_id_maps[t_voice_user_id] then
    return player_id_maps[t_voice_user_id]
  end
  local target_id
  if last_join_suc_channel then
    local group_info = cache.get_group(last_join_suc_channel)
    if group_info and group_info.voice_channel_users then
      for _, user in pairs(group_info.voice_channel_users) do
        if user.voice_user_id then
          player_id_maps[user.voice_user_id] = user.user_id
        end
        if user and user.voice_user_id == t_voice_user_id then
          target_id = user.user_id
        end
      end
    end
  end
  return target_id
end

function M.set_last_join_suc_channel(new_channel)
  last_join_suc_channel = new_channel
end

function M.destroy()
  UNI.sync_call(VENDOR_NAME, SYNC_DESTROY_ENGINE, {})
end

local function replace_voice_user_id_to_player_id(body)
  local found_uid = true
  if body and body.voice_user_id and body.uid and body.uid == "" then
    found_uid = false
    local re_uid = M.get_cache_player_id(body.voice_user_id)
    if re_uid then
      body.uid = re_uid
      found_uid = true
    end
  end
  return found_uid
end

function M.execute_delay_uid_callbacks()
  if delay_callback_list and next(delay_callback_list) ~= nil then
    local new_list = {}
    for _, callback_info in ipairs(delay_callback_list) do
      if replace_voice_user_id_to_player_id(callback_info.body) then
        local body = callback_info.body
        E.LOG.d(TAG, "delay_uid_callbacks handler_name=" .. tostring(callback_info.handler_name))
        if callback_info.handler_name == voice_event.ON_USER_JOINED then
          callback(voice_event.ON_USER_JOINED, body.uid)
        elseif callback_info.handler_name == voice_event.ON_USER_MUTED then
          callback(voice_event.ON_USER_MUTED, body.uid, body.muted)
        end
      else
        table.insert(new_list, callback_info)
      end
    end
    delay_callback_list = new_list
  end
end

function M.enable_ai_denoise(_enable)
  local _sdk_enable = false
  if _ejoysdk.os() == "windows" then
    _sdk_enable = true
  else
    local version = E.Sdkinfo.getSDKVersionName("AGORA")
    local version_check = require("ejoysdk_lua.ejoysdk_version_check")
    local result = version_check.compare_versions(version, "3.0.0")
    if tonumber(result) >= 0 then
      _sdk_enable = true
    end
  end
  if _sdk_enable then
    E.log("call enable_ai_denoise")
    if _enable then
      M.set_parameters("{\"che.audio.ns.mode\":2,\"che.audio.enable.nsng\":true,\"che.audio.nsng.lowerBound\":10,\"che.audio.nsng.lowerMask\":10,\"che.audio.nsng.statisticalbound\":0,\"che.audio.nsng.finallowermask\":8,\"che.audio.nsng.enhfactorstastical\":200}")
    else
      M.set_parameters("{\"che.audio.ains_mode\":0}")
    end
  else
    E.log("2.x sdk did not supprt enable_ai_denoise")
  end
end

local HANDLERS = {}
HANDLERS[EVT_USER_JOINED] = function(body)
  local found_uid = replace_voice_user_id_to_player_id(body)
  if found_uid then
    callback(voice_event.ON_USER_JOINED, body.uid)
  else
    add_delay_uid_callback(voice_event.ON_USER_JOINED, body)
  end
end
HANDLERS[EVT_USER_OFFLINE] = function(body)
  replace_voice_user_id_to_player_id(body)
  if last_join_suc_channel and body and body.uid then
    cache.voice_channel_user_change_update_group(last_join_suc_channel, {
      [body.uid] = true
    }, nil)
  end
  callback(voice_event.ON_USER_LEAVE, body.uid, body.reason)
end
HANDLERS[EVT_USER_MUTED] = function(body)
  local found_uid = replace_voice_user_id_to_player_id(body)
  if found_uid then
    callback(voice_event.ON_USER_MUTED, body.uid, body.muted)
  else
    add_delay_uid_callback(voice_event.ON_USER_MUTED, body)
  end
end
local joined_channels = {
  channels = {}
}

function M.get_joined_channels()
  return joined_channels
end

HANDLERS[EVT_JOIN_CHANNEL_SUCC] = function(body)
  replace_voice_user_id_to_player_id(body)
  is_joining_channel = false
  last_join_suc_uid = body.uid
  last_join_suc_channel = body.channel
  if not joined_channels.channels then
    joined_channels.channels = {}
  end
  if body.channel then
    joined_channels.channels[body.channel] = {
      channel_id = body.channel,
      voice_user_id = body.voice_user_id
    }
    if not joined_channels.main_channel then
      joined_channels.main_channel = body.channel
    end
  end
  callback(voice_event.ON_JOIN_CHANNEL_SUCC, body.channel, body.uid, body.voice_user_id)
end
HANDLERS[EVT_JOIN_CHANNEL_FAIL] = function(body)
  is_joining_channel = false
  callback(voice_event.ON_JOIN_CHANNEL_FAIL, body.code, body.message)
end
HANDLERS[EVT_LEAVE_CHANNEL_SUCC] = function()
  last_join_suc_uid = nil
  local value = last_join_suc_channel
  if value and joined_channels.channels then
    joined_channels.channels[value] = nil
  end
  if joined_channels.channels and next(joined_channels.channels) then
    last_join_suc_channel = next(joined_channels.channels)
  else
    last_join_suc_channel = nil
    joined_channels = {}
  end
  callback(voice_event.ON_LEAVE_CHANNEL_SUCC, value)
  delay_callback_list = {}
end
HANDLERS[EVT_LEAVE_CHANNEL_FAIL] = function(body)
  is_leaveing_channel = false
  callback(voice_event.ON_LEAVE_CHANNEL_FAIL, body.code, body.message)
end
HANDLERS[EVT_REJOIN_CHANNEL_SUCC] = function(body)
  replace_voice_user_id_to_player_id(body)
  last_join_suc_uid = body.uid
  last_join_suc_channel = body.channel
  callback(voice_event.ON_REOIN_CHANNEL_SUCC, body.channel, body.uid)
end
HANDLERS[EVT_ERROR] = function(body)
  local error_code = body.code or -10000
  local error_msg = body.message or ""
  E.LOG.e(TAG, "EVT_ERROR, error_code=" .. tostring(error_code) .. ", error_msg=" .. error_msg)
  if is_joining_channel then
    if 18 == error_code then
      return
    elseif 17 == error_code then
      is_joining_channel = false
      E.LOG.debug(TAG, "agora already in channel")
      if last_join_suc_channel and last_join_suc_uid then
        callback(voice_event.ON_JOIN_CHANNEL_SUCC, last_join_suc_channel, last_join_suc_uid)
      else
        callback(voice_event.ON_JOIN_CHANNEL_FAIL, error_code, error_msg .. " (last channel status error, call leave channel first)")
      end
      return
    end
    is_joining_channel = false
    callback(voice_event.ON_JOIN_CHANNEL_FAIL, error_code, error_msg)
  elseif is_leaveing_channel then
    if 18 == error_code then
      is_leaveing_channel = false
      callback(voice_event.ON_LEAVE_CHANNEL_SUCC, nil)
      return
    end
    is_leaveing_channel = false
    callback(voice_event.ON_LEAVE_CHANNEL_FAIL, error_code, error_msg)
  else
    callback(voice_event.ON_ERROR, error_code, error_msg)
  end
end
HANDLERS[EVT_CONNECTION_INTERRUPT] = function()
  callback(voice_event.ON_CONNECTION_INTERRUPT)
end
HANDLERS[EVT_CONNECTION_BANNED] = function()
  callback(voice_event.ON_CONNECTION_BANNED)
end
HANDLERS[EVT_CONNECTION_LOST] = function()
  callback(voice_event.ON_CONNECTION_LOST)
end
HANDLERS[EVT_AUDIO_VOLUME_INDICATION] = function(body)
  if body and body.speakers then
    for _, user_info in pairs(body.speakers) do
      if user_info and user_info.uid ~= "0" then
        replace_voice_user_id_to_player_id(user_info)
      end
    end
  end
  callback(voice_event.ON_VOLUME_INDICATION, body.speakers, body.total_volume)
end
HANDLERS[EVT_LASTMILE_QUALITY] = function(body)
  callback(voice_event.ON_LASTMILE_QUALITY, body.quality)
end
HANDLERS[EVT_LASTMILE_PROBE_RESULT] = function(body)
  callback(voice_event.ON_LASTMILE_PROBE_RESULT, body)
end
HANDLERS[EVT_AUDIO_QUALITY] = function(body)
  replace_voice_user_id_to_player_id(body)
  callback(voice_event.ON_AUDIO_QUALITY, body)
end
HANDLERS[EVT_REMOTE_AUDIO_STATS] = function(body)
  replace_voice_user_id_to_player_id(body)
  callback(voice_event.ON_REMOTE_AUDIO_STATS, body)
end
HANDLERS[EVT_CONNECTION_STATE_CHANGED] = function(body)
  callback(voice_event.ON_CONNECTION_STATE_CHANGED, body.state, body.reason, last_join_suc_channel)
end
HANDLERS[EVT_REQUEST_TOKEN] = function()
  callback(voice_event.ON_REQUEST_TOKEN)
end
HANDLERS[EVT_TOKEN_PRIVILEGE_WILL_EXPIRE] = function(body)
  callback(voice_event.ON_TOKEN_PRIVILEGE_WILL_EXPIRE, body.token)
end
HANDLERS[EVT_LOCAL_AUDIO_STATE_CHANGED] = function(body)
  callback(voice_event.ON_LOCAL_AUDIO_STATE_CHANGED, body.state, body.error or body.reason)
end
HANDLERS[EVT_AUDIO_DEVICE_STATE_CHANGED] = function(body)
  callback(voice_event.ON_AUDIO_DEVICE_STATE_CHANGED, body.device_id, body.device_type, body.device_state)
end
HANDLERS[EVT_RTC_STATS] = function(body)
  callback(voice_event.ON_RTC_STATS, body)
end
if E.Sysinfo.os() == "windows" then
  _ejoysdk.register_cb("AGORA", function(_cbid, js_str, _chunk)
    local value = JSON.safe_decode(js_str)
    if not agora_listener then
      return
    end
    if not value or not value.type then
      return
    end
    local handler = HANDLERS[value.type]
    if handler then
      handler(value.body)
    end
  end)
elseif _ejoysdk.os() == "harmonyos" then
  local OSM = require("ejoysdk_lua.vendors.agora_harmonyos")
  M.is_compat_agora_api = OSM.is_compat_agora_api
  M.destroy = OSM.destroy
  M.enable_ai_denoise = OSM.enable_ai_denoise
  local CM = require("ejoysdk_lua.vm_channel.ejoy_vm_manager")
  local _hm_aogra = CM.cross_vm_require(CM.LUA_VM.EJOY, "ejoysdk_lua.harmonyos.ejoysdk_vm_func_agora")
  _hm_aogra.set_event_callback(HANDLERS)
else
  UNI.register_event_cb("AGORA", function(type, body)
    log_mgr.debug({}, TAG, "receive_agora_event", "chat_receive_agora_event", {type = type, body = body}, {})
    if not agora_listener then
      return
    end
    local handler = HANDLERS[type]
    if handler then
      handler(body)
    end
  end)
end
return M

local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.ejoysdk_json")
local jf = lunate.js_functions
local M = {}
local VENDOR_NAME = "AGORA"
local m_event_callbacks = {}
local cache_vd_instance, cache_RtcConnection, cache_ChannelMediaOptions
local TAG = "harmonyos#agora"

function M.cast(event, params, _chunk)
  if not event or type(event) ~= "string" then
    return
  end
  local map_func = M[event:lower()]
  if nil ~= cache_vd_instance then
    if map_func and type(map_func) == "function" then
      map_func(cache_vd_instance, params, _chunk)
    else
      E.LOG.warn(TAG, "cast " .. tostring(event) .. ", map_func is nil")
    end
    return
  end
  jf.import_path("@lingxigames/agora", function(succ, ret)
    if succ then
      local AGORA = ret.ns
      if AGORA and AGORA.VendorSDK then
        local VendorSDK = AGORA.VendorSDK
        cache_vd_instance = VendorSDK:getInstance()
        if map_func and type(map_func) == "function" then
          map_func(cache_vd_instance, params, _chunk)
        else
          E.LOG.warn(TAG, "cast " .. tostring(event) .. ", map_func is nil")
        end
        cache_RtcConnection = AGORA.RtcConnection
        cache_ChannelMediaOptions = AGORA.ChannelMediaOptions
        if not cache_RtcConnection or not cache_ChannelMediaOptions then
          E.LOG.d(TAG, "RtcConnection or ChannelMediaOptions is nil")
        end
      else
        E.LOG.warn(TAG, "AGORA.VendorSDK is nil")
      end
    end
    E.LOG.warn(TAG, "lingxigames/agora end: " .. tostring(succ))
  end)
end

function M.cast_set_parameters(v_instance, params, _chunk)
  if not params then
    return
  end
  local params_str = params and params.params
  local ret = v_instance.rtcEngine:setParameters(params_str)
  E.LOG.debug(TAG, "cast_set_parameters:" .. tostring(ret) .. ", args:" .. tostring(params_str))
end

function M.cast_set_audio_profile(v_instance, params, _chunk)
  if not params then
    return
  end
  local profile = params.profile
  local scenario = params.scenario
  local ret1 = v_instance.rtcEngine:setAudioProfile(profile)
  local ret2 = v_instance.rtcEngine:setAudioScenario(scenario)
  E.LOG.debug(TAG, "cast_set_audio_profile:" .. tostring(ret1) .. ", ret2:" .. tostring(ret2))
end

function M.cast_join_channel_with_token(v_instance, params, _chunk)
  if not params then
    return
  end
  M.cast_set_channel_profile(v_instance, 0)
  local token = params.token
  local voice_channel = params.voice_channel
  local voice_user_id = tonumber(params.voice_user_id)
  local ret = v_instance.rtcEngine:joinChannelWithOptions(token, voice_channel, voice_user_id, nil)
  E.LOG.debug(TAG, "cast_join_channel_with_token:" .. tostring(ret) .. ", args:" .. tostring(voice_channel))
end

function M.cast_set_channel_profile(v_instance, profile)
  local ret = v_instance.rtcEngine:setChannelProfile(profile)
  E.LOG.debug(TAG, "cast_set_channel_profile:" .. tostring(ret) .. ", args:" .. tostring(profile))
end

function M.cast_set_client_role(v_instance, role_num, options)
  local ret = v_instance.rtcEngine:setClientRole(role_num, options)
  E.LOG.debug(TAG, "cast_set_client_role:" .. tostring(ret) .. ", args:" .. tostring(role_num))
end

function M.cast_leave_channel(v_instance, _params, _chunk)
  local ret = v_instance.rtcEngine:leaveChannel(nil)
  E.LOG.debug(TAG, "cast_leave_channel:" .. tostring(ret))
end

function M.cast_enable_audio_volume_indication(v_instance, params, _chunk)
  if not params then
    return
  end
  local interval = params.interval
  local smooth = params.smooth or 3
  local ret = v_instance.rtcEngine:enableAudioVolumeIndication(interval, smooth, true)
  E.LOG.debug(TAG, "cast_enable_audio_volume_indication:" .. tostring(ret) .. ", args:" .. tostring(interval) .. ", " .. tostring(smooth))
end

function M.cast_set_enable_speaker(v_instance, params, _chunk)
  if not params then
    return
  end
  local enable = params.enable
  local ret = v_instance.rtcEngine:setEnableSpeakerphone(enable)
  E.LOG.debug(TAG, "cast_set_enable_speaker:" .. tostring(ret) .. ", args:" .. tostring(enable))
end

function M.cast_enable_local_audio(v_instance, params, _chunk)
  if not params then
    return
  end
  local enable = params.enable
  local ret = v_instance.rtcEngine:enableLocalAudio(enable)
  E.LOG.debug(TAG, "cast_enable_local_audio:" .. tostring(ret) .. ", args:" .. tostring(enable))
end

function M.cast_mute_local(v_instance, params, _chunk)
  if not params then
    return
  end
  local mute = params.mute
  local ret = v_instance.rtcEngine:muteLocalAudioStream(mute)
  E.LOG.debug(TAG, "cast_mute_local:" .. tostring(ret) .. ", args:" .. tostring(mute))
end

function M.cast_mute_remote(v_instance, params, _chunk)
  if not params then
    return
  end
  local mute = params.mute
  local voice_user_id = tonumber(params.voice_user_id)
  local ret
  if voice_user_id then
    ret = v_instance.rtcEngine:muteRemoteAudioStream(voice_user_id, mute)
  end
  E.LOG.debug(TAG, "cast_mute_remote:" .. tostring(ret) .. ", args:" .. tostring(voice_user_id) .. "," .. tostring(mute))
end

function M.cast_mute_remote_all(v_instance, params, _chunk)
  if not params then
    return
  end
  local mute = params.mute
  local ret = v_instance.rtcEngine:muteAllRemoteAudioStreams(mute)
  E.LOG.debug(TAG, "cast_mute_remote_all:" .. tostring(ret) .. ", args:" .. tostring(mute))
end

function M.cast_adjust_record_volume(v_instance, params, _chunk)
  if not params then
    return
  end
  local volume = params.volume
  local ret = v_instance.rtcEngine:adjustRecordingSignalVolume(volume)
  E.LOG.debug(TAG, "cast_adjust_record_volume:" .. tostring(ret) .. ", args:" .. tostring(volume))
end

function M.cast_adjust_playing_volume(v_instance, params, _chunk)
  if not params then
    return
  end
  local volume = params.volume
  local ret = v_instance.rtcEngine:adjustPlaybackSignalVolume(volume)
  E.LOG.debug(TAG, "cast_adjust_playing_volume:" .. tostring(ret) .. ", args:" .. tostring(volume))
end

function M.cast_set_audio_scenario(v_instance, params)
  if not params or not cache_RtcConnection then
    return
  end
  local scenario = tonumber(params.scenario)
  local ret = v_instance.rtcEngine:setAudioScenario(scenario)
  E.LOG.debug(TAG, "cast_set_audio_scenario:" .. tostring(ret) .. ", args:" .. tostring(scenario))
end

function M.cast_join_channel_ex(v_instance, params)
  if not params or not cache_RtcConnection then
    return
  end
  local token = params.token
  local voice_channel = params.voice_channel
  local voice_user_id = tonumber(params.voice_user_id)
  local connection = lunate.new_instance(cache_RtcConnection)
  connection.channelId = voice_channel
  connection.localUid = voice_user_id
  local media_options = lunate.new_instance(cache_ChannelMediaOptions)
  if params and params.options then
    local ops = params.options
    if ops.publishMicrophoneTrack ~= nil then
      media_options.publishMicrophoneTrack = ops.publishMicrophoneTrack
    else
      media_options.publishMicrophoneTrack = true
    end
    if nil ~= ops.autoSubscribeAudio then
      media_options.autoSubscribeAudio = ops.autoSubscribeAudio
    else
      media_options.autoSubscribeAudio = true
    end
    if nil ~= ops.enableAudioRecordingOrPlayout then
      media_options.enableAudioRecordingOrPlayout = ops.enableAudioRecordingOrPlayout
    else
      media_options.enableAudioRecordingOrPlayout = true
    end
    if nil ~= ops.channelProfile then
      media_options.channelProfile = ops.channelProfile
    else
      media_options.channelProfile = 0
    end
    if nil ~= ops.clientRoleType then
      media_options.clientRoleType = ops.clientRoleType
    else
      media_options.clientRoleType = 1
    end
  end
  local ev_handler = v_instance.config and v_instance.config.mEventHandler
  local ret = v_instance.rtcEngine:joinChannelEx(token, connection, media_options, ev_handler)
  E.LOG.debug(TAG, "cast_join_channel_ex:" .. tostring(ret) .. ", args:" .. tostring(voice_channel))
end

function M.cast_leave_channel_ex(v_instance, params)
  if not params or not cache_RtcConnection then
    return
  end
  local voice_channel = params.voice_channel
  local voice_user_id = tonumber(params.voice_user_id)
  local connection = lunate.new_instance(cache_RtcConnection)
  connection.channelId = voice_channel
  connection.localUid = voice_user_id
  local ret = v_instance.rtcEngine:leaveChannelEx(connection)
  E.LOG.debug(TAG, "cast_leave_channel_ex:" .. tostring(ret))
end

function M.cast_mute_remote_ex(v_instance, params)
  if not params or not cache_RtcConnection then
    return
  end
  local mute = params.mute
  local voice_channel = params.voice_channel
  local target_voice_user_id = tonumber(params.target_voice_user_id)
  local voice_user_id = tonumber(params.voice_user_id)
  local connection = lunate.new_instance(cache_RtcConnection)
  connection.channelId = voice_channel
  connection.localUid = voice_user_id
  local ret = v_instance.rtcEngine:muteRemoteAudioStreamEx(target_voice_user_id, mute, connection)
  E.LOG.debug(TAG, "cast_mute_remote_ex:" .. tostring(ret) .. ", args:" .. tostring(mute) .. "," .. tostring(voice_channel))
end

function M.cast_mute_remote_all_ex(v_instance, params)
  if not params or not cache_RtcConnection then
    return
  end
  local mute = params.mute
  local voice_channel = params.voice_channel
  local voice_user_id = tonumber(params.voice_user_id)
  local connection = lunate.new_instance(cache_RtcConnection)
  connection.channelId = voice_channel
  connection.localUid = voice_user_id
  local ret = v_instance.rtcEngine:muteAllRemoteAudioStreamsEx(mute, connection)
  E.LOG.debug(TAG, "cast_mute_remote_all_ex:" .. tostring(ret) .. ", args:" .. tostring(mute) .. "," .. tostring(voice_channel))
end

function M.cast_mute_local_ex(v_instance, params)
  if not params or not cache_RtcConnection then
    return
  end
  local mute = params.mute
  local voice_channel = params.voice_channel
  local voice_user_id = tonumber(params.voice_user_id)
  local connection = lunate.new_instance(cache_RtcConnection)
  connection.channelId = voice_channel
  connection.localUid = voice_user_id
  local ret = v_instance.rtcEngine:muteLocalAudioStreamEx(mute, connection)
  E.LOG.debug(TAG, "cast_mute_local_ex:" .. tostring(ret) .. ", args:" .. tostring(mute) .. "," .. tostring(voice_channel))
end

function M.set_event_callback(evt_handlers)
  if not evt_handlers then
    E.LOG.debug(TAG, "set_event_callback skip, evt_handlers is nil")
    return
  end
  m_event_callbacks = evt_handlers
  local ns_module = jf.EjoySDK():getProxy(VENDOR_NAME)
  ns_module.setVendorSDKListener({
    onEvent = function(_type, _body)
      if m_event_callbacks then
        local handler = m_event_callbacks[tostring(_type)]
        if handler then
          handler(JSON.decode(_body))
        else
          E.LOG.debug(TAG, "onEvent skip, no handler for event_id:" .. tostring(_type))
        end
      end
    end
  })
end

return M

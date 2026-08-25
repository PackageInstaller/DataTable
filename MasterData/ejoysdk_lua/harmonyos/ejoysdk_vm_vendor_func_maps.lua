local M = {}
local _CALL_API_FUNC_MAPS = {
  AGORA = {
    CAST_SET_PARAMETERS = "cast_set_parameters",
    CAST_SET_AUDIO_PROFILE = "cast_set_audio_profile",
    CAST_JOIN_CHANNEL_WITH_TOKEN = "cast_join_channel_with_token",
    CAST_LEAVE_CHANNEL = "cast_leave_channel",
    CAST_ENABLE_AUDIO_VOLUME_INDICATION = "cast_enable_audio_volume_indication",
    CAST_SET_ENABLE_SPEAKER = "cast_set_enable_speaker",
    CAST_ENABLE_LOCAL_AUDIO = "cast_enable_local_audio",
    CAST_MUTE_LOCAL = "cast_mute_local",
    CAST_MUTE_REMOTE = "cast_mute_remote",
    CAST_MUTE_REMOTE_ALL = "cast_mute_remote_all",
    CAST_ADJUST_RECORD_VOLUME = "cast_adjust_record_volume",
    CAST_ADJUST_PLAYING_VOLUME = "cast_adjust_playing_volume",
    CAST_SET_CLIENT_ROLE = "cast_set_client_role",
    CAST_SET_CHANNEL_PROFILE = "CAST_SET_CHANNEL_PROFILE",
    CAST_SET_AUDIO_SCENARIO = "CAST_SET_AUDIO_SCENARIO",
    CAST_JOIN_CHANNEL_EX = "CAST_JOIN_CHANNEL_EX",
    CAST_LEAVE_CHANNEL_EX = "CAST_LEAVE_CHANNEL_EX",
    CAST_MUTE_REMOTE_EX = "CAST_MUTE_REMOTE_EX",
    CAST_MUTE_REMOTE_ALL_EX = "CAST_MUTE_REMOTE_ALL_EX",
    CAST_MUTE_LOCAL_EX = "cast_mute_local_ex"
  }
}

function M.is_impl_in_lua(vendor_name, event)
  if _CALL_API_FUNC_MAPS[vendor_name] and nil ~= _CALL_API_FUNC_MAPS[vendor_name][event] then
    return true
  end
  return false
end

M.CALL_API_FUNC_MAPS = _CALL_API_FUNC_MAPS
return M

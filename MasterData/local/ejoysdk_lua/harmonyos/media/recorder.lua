local UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FSM = UTILS.fsm
local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local jf = lunate.js_functions
local EU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
local BitUtil = COMPAT.bitutil
local M = {}
local TAG = "recorder#"
M.SDK_AUDIO_FORMAT = {M4A = "m4a", AMR = "amr"}
local SUPPORT_AUDIO_CODECS = {
  [M.SDK_AUDIO_FORMAT.M4A] = true
}
local CODEC_VALUE_MAP = {
  [M.SDK_AUDIO_FORMAT.M4A] = "audio/mp4a-latm"
}
local M4A_SUPPORT_SAMPLE_RATE = {
  ["8000"] = true,
  ["11025"] = true,
  ["12000"] = true,
  ["16000"] = true,
  ["22050"] = true,
  ["24000"] = true,
  ["32000"] = true,
  ["44100"] = true,
  ["48000"] = true,
  ["64000"] = true,
  ["88200"] = true,
  ["96000"] = true
}
local DEFAULT_AUDIO_PROFILE = {
  [M.SDK_AUDIO_FORMAT.M4A] = {
    BITRATE = 100000,
    CHANNELS = 1,
    SAMPLE_RATE = 8000
  }
}
local DEFAULT_AUDIO_FORMAT = M.SDK_AUDIO_FORMAT.M4A
local recorder_fsm
local module_initted = false
local m_debug_enable = true
local m_recorder_instance
local m_current_recording_info = {
  filepath = nil,
  filename = nil,
  format = nil
}
local _STATES = {
  IDLE = "idle",
  RECORDING = "recording",
  PAUSED = "paused",
  STOPPED = "stopped"
}
local _EVENTS = {
  START_RECORD = "start_record",
  PAUSE_RECORD = "pause_record",
  RESUME_RECORD = "resume_record",
  STOP_RECORD = "stop_record",
  ON_ERROR = "on_error",
  RELEASE = "release"
}

local function _fsm_equeue_event_at_front(event_name, ...)
  if m_debug_enable then
    E.LOG.debug(TAG, "_fsm_send_event:" .. tostring(event_name))
  end
  recorder_fsm:enqueue_event(event_name, true, ...)
end

local function _fsm_on_async_event_finished(event_name)
  recorder_fsm:notify_async_finish(event_name)
end

local function _fsm_transition_to(from_state, to_state, ...)
  E.LOG.debug(TAG, "_fsm_transition_to, from:" .. tostring(from_state) .. ", to_state:" .. tostring(to_state))
  recorder_fsm:transition(from_state, to_state, ...)
end

local function _fsm_enqueue_event(event_name, ...)
  if m_debug_enable then
    E.LOG.debug(TAG, "_fsm_send_event:" .. tostring(event_name))
  end
  recorder_fsm:enqueue_event(event_name, false, ...)
end

local function check_recorder_permission(cb)
  local recorder_permissions = {
    ["ohos.permission.MICROPHONE"] = {}
  }
  local options = {permissions = recorder_permissions}
  E.Permission.check_permission_v3(options, function(succ, is_open_settings)
    E.LOG.debug(TAG, "check_recorder_permission result:" .. tostring(succ))
    if succ then
      E.LOG.debug(TAG, "recorder permission granted")
      cb(true)
    else
      E.LOG.warn(TAG, "recorder permission not granted")
      local err_code = EC.MEDIA_ERROR.CODE_RECORD_PERMISSION_NOT_GRANTED
      if is_open_settings then
        err_code = EC.MEDIA_ERROR.CODE_PERMISSION_REJECT_OPEN_SETTINGS
      end
      cb(false, err_code, "calendar permission reject")
    end
  end)
end

local function create_recorder(cb)
  local media = lunate.import("@ohos.multimedia.media")
  media.createAVRecorder():Then(function(_recorder)
    _recorder.on("stateChange", function(state, reason)
      E.LOG.debug(TAG, "recorder stateChange:" .. tostring(state) .. ", reason:" .. tostring(reason))
    end)
    _recorder.on("error", function(err)
      local _code = err.code
      local _msg = err.message
      E.LOG.warn(TAG, "recorder record err, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
      _fsm_enqueue_event(_EVENTS.ON_ERROR, _code, _msg)
    end)
    _recorder.on("audioCapturerChange", function(capturer_change_info)
      local stream_id = capturer_change_info.streamId
      local muted = capturer_change_info.muted
      E.LOG.debug(TAG, "recorder audioCapturerChange, stream_id:" .. tostring(stream_id) .. ", muted:" .. tostring(muted))
    end)
    cb(_recorder)
  end):catch(function(err)
    cb(false, err.code, err.message)
  end)
end

local function get_file_fd_for_name(filename, support_format)
  filename = filename or "noname"
  filename = filename .. "." .. support_format
  local app_private_dir = E.File.get_ext_file_dir()
  local records_dir = E.Path.join(app_private_dir, "records")
  if not E.File.exists_fullpath(records_dir) then
    E.File.make_dirs(records_dir)
  end
  local file_path = E.Path.join(records_dir, filename)
  E.LOG.debug(TAG, "current_recording_filepath:" .. tostring(m_current_recording_info.filepath))
  if E.File.exists_fullpath(file_path) then
    E.File.remove_fullpath(file_path)
  end
  local fs = jf.import("@ohos.file.fs")
  local err_msg
  local ret, file = COMPAT.xpcall(fs.openSync, function(err)
    err_msg = tostring(err)
  end, file_path, BitUtil.bor(fs.OpenMode.CREATE, fs.OpenMode.READ_WRITE))
  if ret then
    return "fd://" .. tostring(file.fd), filename, file_path
  else
    return nil, filename, file_path, EC.MEDIA_ERROR.CODE_FILE_CREATE_FAILED, "media file create failed:" .. tostring(err_msg)
  end
end

local function prepare_record(opts, recorder, cb)
  local format = opts.format or DEFAULT_AUDIO_FORMAT
  local support_format = SUPPORT_AUDIO_CODECS[format] and format or DEFAULT_AUDIO_FORMAT
  local _audio_codec = CODEC_VALUE_MAP[support_format]
  local _encoding_bit_rate = opts.encoding_bit_rate
  local _channels = opts.channel
  local _sampling_rate = opts.sampling_rate
  if support_format == M.SDK_AUDIO_FORMAT.M4A then
    if not _encoding_bit_rate or _encoding_bit_rate < 32000 or _encoding_bit_rate > 500000 then
      _encoding_bit_rate = DEFAULT_AUDIO_PROFILE[M.SDK_AUDIO_FORMAT.M4A].BITRATE
    end
    if not _channels or _channels < 1 or _channels > 8 then
      _channels = DEFAULT_AUDIO_PROFILE[M.SDK_AUDIO_FORMAT.M4A].CHANNELS
    end
    if not _sampling_rate or not M4A_SUPPORT_SAMPLE_RATE[tostring(_sampling_rate)] then
      _sampling_rate = DEFAULT_AUDIO_PROFILE[M.SDK_AUDIO_FORMAT.M4A].SAMPLE_RATE
    end
  end
  local av_profile = {
    audioBitrate = _encoding_bit_rate,
    audioChannels = _channels,
    audioCodec = _audio_codec,
    audioSampleRate = _sampling_rate,
    fileFormat = support_format
  }
  local fd_url, filename, file_path, _code, _msg = get_file_fd_for_name(opts.filename, support_format)
  if fd_url then
    m_current_recording_info.filepath = file_path
    m_current_recording_info.filename = filename
  end
  m_current_recording_info.format = support_format
  m_current_recording_info.sampling_rate = _sampling_rate
  if not fd_url then
    E.LOG.warn(TAG, "prepare media file fd failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    cb(false, _code, _msg)
    return
  end
  local av_config = {
    audioSourceType = 1,
    profile = av_profile,
    url = fd_url
  }
  recorder.prepare(av_config):Then(function()
    E.LOG.debug(TAG, "prepare media succ")
    cb(true)
  end):catch(function(err)
    E.LOG.warn(TAG, "prepare media failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
    cb(false, err.code, err.message)
  end)
end

function M.init()
  if module_initted then
    return
  end
  local fsm_callbacks = {
    ["on" .. _EVENTS.START_RECORD] = function(_f_self, from, ...)
      E.LOG.debug(TAG, "start_record from:" .. tostring(from))
      local opts, cb = ...
      
      local function cb_wrapper(succ, ...)
        E.LOG.debug(TAG, "callback start_record succ:" .. tostring(cb))
        if cb then
          cb(succ, ...)
        end
      end
      
      local function start_record_handler(_recorder, _cb)
        _recorder.start():Then(function()
          _fsm_on_async_event_finished(_EVENTS.START_RECORD)
          _cb(true)
        end):catch(function(err)
          E.LOG.warn(TAG, "prepare media failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
          _cb(false, err.code, err.message)
        end)
      end
      
      local function prepare_record_handler(_recorder, _cb)
        prepare_record(opts, _recorder, function(_succ, ...)
          if _succ then
            start_record_handler(_recorder, _cb)
          else
            _cb(false, ...)
          end
        end)
      end
      
      if from == _STATES.RECORDING then
        E.LOG.debug(TAG, "already initted, just return")
        cb_wrapper(true)
        return FSM.SYNC
      elseif from == _STATES.IDLE then
        local function create_recorder_handler()
          create_recorder(function(_recorder, ...)
            if _recorder then
              m_recorder_instance = _recorder
              
              prepare_record_handler(_recorder, function(_succ, ...)
                if _succ then
                  _fsm_transition_to(from, _STATES.RECORDING)
                end
                _fsm_on_async_event_finished(_EVENTS.START_RECORD)
                cb_wrapper(_succ, ...)
              end)
            else
              local _code, _msg = ...
              E.LOG.warn(TAG, "create recorder failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
              _fsm_on_async_event_finished(_EVENTS.START_RECORD)
              cb_wrapper(false, ...)
            end
          end)
        end
        
        check_recorder_permission(function(succ, ...)
          if succ then
            E.LOG.debug(TAG, "check recorder permission succ, now begin create_recorder_handler")
            create_recorder_handler()
          else
            local _code, _msg = ...
            E.LOG.warn(TAG, "init failed, for permission not granted, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
            _fsm_on_async_event_finished(_EVENTS.START_RECORD)
            cb_wrapper(false, ...)
          end
        end)
        return FSM.ASYNC
      elseif from == _STATES.PAUSED then
        E.LOG.warn(TAG, "not support pause")
      elseif from == _STATES.STOPPED then
        E.LOG.warn(TAG, "start record should not from stopped, because its released first")
      end
    end,
    ["on" .. _EVENTS.ON_ERROR] = function(_f_self, from, ...)
      local _code, _msg = ...
      m_recorder_instance.reset():Then(function()
        _fsm_transition_to(from, _STATES.STOPPED)
        _fsm_on_async_event_finished(_EVENTS.ON_ERROR)
      end):catch(function(err)
        E.LOG.warn(TAG, "prepare media failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
        _fsm_on_async_event_finished(_EVENTS.ON_ERROR)
      end)
      return FSM.ASYNC
    end,
    ["on" .. _EVENTS.STOP_RECORD] = function(_f_self, from, ...)
      local _cb = (...)
      
      local function cb_wrapper(succ, ...)
        local _was_recording = succ and from == _STATES.RECORDING
        local _filesize = 0
        local _filename, _format, _sampling_rate, _bytes
        if _was_recording and m_current_recording_info.filepath then
          _filesize = EU.is_file_exists(m_current_recording_info.filepath)
          _filename = m_current_recording_info.filename
          _format = m_current_recording_info.format
          _sampling_rate = m_current_recording_info.sampling_rate
          _bytes = _ejoysdk.lread(m_current_recording_info.filepath)
        end
        local stop_info = {
          was_recording = _was_recording,
          filesize = _filesize,
          filename = _filename,
          format = _format,
          sampling_rate = _sampling_rate,
          bytes = _bytes
        }
        E.LOG.debug(TAG, "record complete, was_recording:" .. tostring(_was_recording) .. ", filesize:" .. tostring(_filesize) .. ", filename:" .. tostring(_filename) .. ", format:" .. tostring(_format) .. ", sampling_rate:" .. tostring(_sampling_rate))
        if _cb then
          _cb(stop_info)
        end
      end
      
      if from == _STATES.PAUSED then
        E.LOG.debug(TAG, "receive stop from pause state")
        return FSM.SYNC
      elseif from == _STATES.RECORDING then
        E.LOG.debug(TAG, "receive stop from recording state")
        m_recorder_instance.stop():Then(function()
          E.LOG.debug(TAG, "stop record succ")
          _fsm_transition_to(from, _STATES.STOPPED)
          _fsm_equeue_event_at_front(_EVENTS.RELEASE, cb_wrapper)
          _fsm_on_async_event_finished(_EVENTS.STOP_RECORD)
        end):catch(function(err)
          E.LOG.warn(TAG, "stop record failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
          _fsm_on_async_event_finished(_EVENTS.STOP_RECORD)
          cb_wrapper(false, err.code, err.message)
        end)
        return FSM.ASYNC
      elseif from == _STATES.IDLE then
        cb_wrapper(true)
        return FSM.SYNC
      elseif from == _STATES.STOPPED then
        cb_wrapper(true)
        return FSM.SYNC
      end
    end,
    ["on" .. _EVENTS.RELEASE] = function(_f_self, from, ...)
      local _cb = (...)
      m_recorder_instance.release():Then(function()
        E.LOG.debug(TAG, "release succ")
        m_recorder_instance = nil
        _fsm_transition_to(from, _STATES.IDLE)
        _fsm_on_async_event_finished(_EVENTS.RELEASE)
        if _cb then
          _cb(true)
        end
      end):catch(function(err)
        E.LOG.warn(TAG, "prepare media failed, code:" .. tostring(err.code) .. ", msg:" .. tostring(err.message))
        _fsm_on_async_event_finished(_EVENTS.RELEASE)
        if _cb then
          _cb(false, err.code, err.message)
        end
      end)
      return FSM.ASYNC
    end,
    ["onenter" .. _STATES.RECORDING] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "onenter recording state")
    end,
    ["onenter" .. _STATES.STOPPED] = function(_fsm, _from, ...)
      E.LOG.debug(TAG, "onenter stopped state, recording filename:" .. tostring(m_current_recording_info.filepath))
    end
  }
  recorder_fsm = FSM.create({
    initial = _STATES.IDLE,
    events = {
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.IDLE,
        to = _STATES.RECORDING
      },
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.IDLE,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.RECORDING,
        to = _STATES.RECORDING
      },
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.PAUSED,
        to = _STATES.RECORDING
      },
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.PAUSED,
        to = _STATES.PAUSED
      },
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.STOPPED,
        to = _STATES.RECORDING
      },
      {
        name = _EVENTS.START_RECORD,
        from = _STATES.STOPPED,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.ON_ERROR,
        from = _STATES.RECORDING,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.ON_ERROR,
        from = _STATES.STOPPED,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.ON_ERROR,
        from = _STATES.PAUSED,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_RECORD,
        from = _STATES.IDLE,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.STOP_RECORD,
        from = _STATES.STOPPED,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_RECORD,
        from = _STATES.PAUSED,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_RECORD,
        from = _STATES.PAUSED,
        to = _STATES.PAUSED
      },
      {
        name = _EVENTS.STOP_RECORD,
        from = _STATES.RECORDING,
        to = _STATES.STOPPED
      },
      {
        name = _EVENTS.STOP_RECORD,
        from = _STATES.RECORDING,
        to = _STATES.RECORDING
      },
      {
        name = _EVENTS.RELEASE,
        from = _STATES.STOPPED,
        to = _STATES.IDLE
      },
      {
        name = _EVENTS.RELEASE,
        from = _STATES.STOPPED,
        to = _STATES.STOPPED
      }
    },
    callbacks = fsm_callbacks
  })
  module_initted = true
end

function M.start_record(opts, cb)
  if not module_initted then
    M.init()
  end
  _fsm_enqueue_event(_EVENTS.START_RECORD, opts, cb)
end

function M.stop_record(cb)
  if not module_initted then
    M.init()
  end
  _fsm_enqueue_event(_EVENTS.STOP_RECORD, cb)
end

return M

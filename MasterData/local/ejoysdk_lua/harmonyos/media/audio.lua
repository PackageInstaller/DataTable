local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local HRU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local M = {}
local TAG = "audio"
M.SDK_AUDIO_FORMAT = {M4A = "m4a", AMR = "amr"}
local SUPPORT_AUDIO_CODECS = {
  [M.SDK_AUDIO_FORMAT.AMR] = true
}
local Media = {
  DEFAULT_MAX_FILESIZE = 5242880,
  DEFAULT_MAX_DURATION_SEC = 60,
  DEFAULT_SAMPLING_RATE = 16000,
  DEFAULT_ENCODING_BIT_RATE = 16000,
  DEFAULT_BIT_DEPTH_RATE = 16,
  DEFAULT_CHANNEL = 1,
  DEFAULT_AMR_NB_ENCODING_BIT_RATE = 12200,
  DEFAULT_AMR_WB_ENCODING_BIT_RATE = 18250
}
local RECORD_STATE = {
  IDLE = "idle",
  RECORDING = "recording",
  FINISHING = "finishing",
  FINISHED = "finished"
}
local DEFAULT_AUDIO_FORMAT = M.SDK_AUDIO_FORMAT.AMR
local DEFAULT_FILE_NAME = "noname"
local m_record_state = RECORD_STATE.IDLE
local m_recording_params

local function check_recorder_permission(cb)
  E.Permission.detect_permission("ohos.permission.MICROPHONE", function(succ)
    E.LOG.debug(TAG, "check_recorder_permission result:" .. tostring(succ))
    if succ then
      E.LOG.debug(TAG, "recorder permission granted")
      cb(true)
    else
      E.LOG.warn(TAG, "recorder permission not granted")
      local err_code = EC.MEDIA_ERROR.CODE_RECORD_PERMISSION_NOT_GRANTED
      cb(false, err_code, "recorder permission reject")
    end
  end)
end

local function get_record_dir()
  do return E.Path.join, (E.File.get_ext_file_dir()) end
  return E.Path.join, E.File.get_ext_file_dir(), "records"
end

function M.get_record_dir()
  do return end
  return get_record_dir, nil
end

local function prepare_record(opts)
  opts = opts or {}
  local max_filesize = Media.DEFAULT_MAX_FILESIZE
  if opts.max_filesize and max_filesize >= opts.max_filesize then
    max_filesize = opts.max_filesize
  end
  local max_duration = opts.max_duration and opts.max_duration / 1000 or Media.DEFAULT_MAX_DURATION_SEC
  if max_duration > Media.DEFAULT_MAX_DURATION_SEC then
    E.LOG.warn(TAG, "max duration larger than " .. tostring(Media.DEFAULT_MAX_DURATION_SEC) .. ", use max duration instead")
    max_duration = Media.DEFAULT_MAX_DURATION_SEC
  end
  E.LOG.debug(TAG, "prepare_record max_duration:" .. tostring(max_duration))
  local format = opts.format or DEFAULT_AUDIO_FORMAT
  local support_format = SUPPORT_AUDIO_CODECS[format] and format or DEFAULT_AUDIO_FORMAT
  local filename = opts.filename or DEFAULT_FILE_NAME
  local audio_dir = get_record_dir()
  E.Path.ensure_dir(audio_dir)
  local params = {
    file_name = filename,
    file_dir = audio_dir,
    format = support_format,
    max_filesize = max_filesize,
    max_duration = max_duration,
    sampling_rate = opts.sampling_rate or Media.DEFAULT_SAMPLING_RATE,
    encoding_bit_rate = opts.encoding_bit_rate or Media.DEFAULT_ENCODING_BIT_RATE,
    bit_depth_rate = opts.bit_depth_rate or Media.DEFAULT_BIT_DEPTH_RATE,
    channel = opts.channel or Media.DEFAULT_CHANNEL,
    show_permission_request = opts.show_permission_request or true
  }
  if params.format == "amr" then
    if params.sampling_rate ~= 8000 and params.sampling_rate ~= 16000 then
      error("when format is amr, sampling_rate should be 8000 or 16000")
      return nil, EC.MEDIA_ERROR.CODE_MEDIA_SAMPLING_RATE_NOT_VALID, "sampling rate not valid:" .. tostring(params.sampling_rate)
    end
    if 16 ~= params.bit_depth_rate then
      error("when format is amr, bit_depth_rate should be 16")
      return nil, EC.MEDIA_ERROR.CODE_MEDIA_BIT_DEPTH_NOT_VALID, "bit depth not valid"
    end
    if 1 ~= params.channel then
      error("when format is amr, channel should be 1")
      return nil, EC.MEDIA_ERROR.CODE_MEDIA_CHANNEL_COUNT_NOT_VALID, "channel count not valid"
    end
    local constants = require("ejoysdk_lua.ejoysdk_constants")
    if params.sampling_rate == 8000 and not constants.AMR_NB_BIT_RATE[params.encoding_bit_rate] then
      params.encoding_bit_rate = Media.DEFAULT_AMR_NB_ENCODING_BIT_RATE
    end
    if params.sampling_rate == 16000 and not constants.AMR_WR_BIT_RATE[params.encoding_bit_rate] then
      params.encoding_bit_rate = Media.DEFAULT_AMR_WB_ENCODING_BIT_RATE
    end
  end
  return params
end

function M.start_record(_opts, cb)
  if not _ejoysdk_audio then
    if cb then
      cb(false, EC.MEDIA_ERROR.CODE_MEDIA_NOT_SUPPORT, "audio not support")
    end
    return
  end
  if m_record_state == RECORD_STATE.FINISHING or m_record_state == RECORD_STATE.RECORDING then
    E.LOG.debug(TAG, "start_record skip in finishing or recording state")
    if cb then
      cb(false, EC.MEDIA_ERROR.CODE_RECORD_ALREADY_START, "recording already started")
    end
    return
  end
  check_recorder_permission(function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "start_record permission succ, record begin")
      local record_params, _code, _msg = prepare_record(_opts)
      if not record_params then
        E.LOG.warn(TAG, "prepare_record failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
        if cb then
          cb(false, _code, _msg)
        end
        return
      end
      m_recording_params = record_params
      local ret, code, msg = _ejoysdk_audio.start_record(record_params)
      if ret then
        m_record_state = RECORD_STATE.RECORDING
        E.LOG.debug(TAG, "start_record succ")
        E.Timer.once(record_params.max_duration, function()
          E.LOG.debug(TAG, "record reached max duration:" .. tostring(record_params.max_duration) .. ", now begin stop")
          M.stop_record(function()
            E.LOG.debug(TAG, "record reached max duration stop complete")
          end)
        end)
      else
        m_record_state = RECORD_STATE.IDLE
        E.LOG.warn(TAG, "start_record faild, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      end
      if cb then
        cb(ret, code, msg)
      end
    else
      m_record_state = RECORD_STATE.IDLE
      local code, msg = ...
      E.LOG.warn(TAG, "start_record permission failed, code:" .. tostring(code) .. ", msg:" .. tostring(msg))
      if cb then
        cb(false, code, msg)
      end
    end
  end)
end

local function get_record_file_path(file_dir, file_name, format)
  local file_path = E.Path.join(file_dir, file_name)
  return file_path .. "." .. tostring(format)
end

function M.stop_record(cb)
  local function check_result_data()
    local result_data = {}
    
    local was_recording = false
    local file_size = 0
    if nil ~= m_recording_params then
      was_recording = true
      local file_dir = m_recording_params.file_dir
      local file_name = m_recording_params.file_name
      local record_file_path = get_record_file_path(file_dir, file_name, m_recording_params.format)
      local exists, size = HRU.is_file_exists(record_file_path)
      file_size = size or 0
      E.LOG.debug(TAG, "stop_record record_file_path:" .. tostring(record_file_path) .. ", exists:" .. tostring(exists) .. ", size:" .. tostring(size))
      result_data.filename = file_name
      result_data.format = m_recording_params.format
      result_data.sampling_rate = m_recording_params.sampling_rate
      result_data.bytes = _ejoysdk.lread(record_file_path)
    end
    result_data.was_recording = was_recording
    result_data.filesize = file_size
    return result_data
  end
  
  if m_record_state ~= RECORD_STATE.RECORDING then
    E.LOG.warn(TAG, "stop_record in not recording state, just skip, current state:" .. tostring(m_record_state))
    if cb then
      local result_data = check_result_data()
      cb(result_data)
    end
    return
  end
  m_record_state = RECORD_STATE.FINISHING
  local cbid = E.set_native_async_callback(function(msg)
    E.LOG.debug(TAG, "stop result received >>" .. tostring(msg))
    m_record_state = RECORD_STATE.FINISHED
    local result_data = check_result_data()
    if cb then
      cb(result_data)
    end
  end)
  local stop_ret, _code, _msg = _ejoysdk_audio.stop_record(cbid)
  E.LOG.debug(TAG, "stop_record begin, stop_ret:" .. tostring(stop_ret))
  if not stop_ret then
    local result_data = check_result_data()
    if _code == EC.MEDIA_ERROR.CODE_RECORD_NOT_START then
      E.LOG.warn(TAG, "stop record skip, already stopped")
      m_record_state = result_data.was_recording and RECORD_STATE.FINISHED or RECORD_STATE.IDLE
    else
      E.LOG.warn(TAG, "stop record failed, code:" .. tostring(_code) .. ", msg:" .. tostring(_msg))
    end
    if cb then
      cb(result_data)
    end
  end
end

function M.delete(params, cb)
  params = params or {}
  local ret_obj = {deleted_count = 0}
  local filename = params.filename or DEFAULT_FILE_NAME
  local filename_with_dot = filename .. "."
  local recordDir = get_record_dir()
  local delete_count = 0
  E.File.list_directory(recordDir, false, true, function(items)
    local items_size = items and #items or 0
    if 0 == items_size then
      E.LOG.debug(TAG, "directory is empty, skip delete")
      if cb then
        cb(ret_obj)
      end
    else
      for _, item in ipairs(items) do
        if not item.is_dir and ("*." == filename_with_dot or E.Utils.start_with(item.path, filename_with_dot)) then
          delete_count = delete_count + 1
          local item_full_path = E.Path.join(recordDir, item.path)
          local ret = E.File.remove_fullpath(item_full_path)
          E.LOG.debug(TAG, "delete record file, ret:" .. tostring(ret) .. ", path:" .. tostring(item_full_path))
        end
      end
      ret_obj.deleted_count = delete_count
      if cb then
        cb(ret_obj)
      end
    end
  end)
end

return M

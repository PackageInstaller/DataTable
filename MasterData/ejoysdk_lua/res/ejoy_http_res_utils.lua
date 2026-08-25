local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "ejoy_http_res_utils"

local function file_utf8_to_acp(file_name)
  local temp = file_name
  if file_name and type(file_name) == "string" and _ejoysdk.os() == "windows" and _ejoysdk.utf8_to_acp then
    temp = _ejoysdk.utf8_to_acp(file_name)
  end
  return temp
end

function M.os_remove(file_path)
  if not file_path or "" == file_path then
    return false, "file path nil"
  end
  if _ejoysdk.os() == "windows" and _ejoysdk.utf8_to_acp then
    local result, msg = os.remove(file_path)
    if not result then
      result, msg = os.remove(file_utf8_to_acp(file_path))
      if not result and _ejoysdk.removefile then
        result, msg = _ejoysdk.removefile(file_path)
      end
    end
    return result, msg
  else
    do return os.remove end
    return os.remove, file_path, result, msg, file_utf8_to_acp(file_path)
  end
end

function M.os_rename(origin_name, des_name)
  if not (origin_name and "" ~= origin_name and des_name) or "" == des_name then
    return false, "file path nil"
  end
  local dest_parent_dir = M.get_parent_folder(des_name)
  local result, msg
  if not M.file_exists(dest_parent_dir) and E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    E.File.make_dirs(dest_parent_dir)
  end
  if _ejoysdk.os() == "windows" then
    if _ejoysdk.renamefile then
      result, msg = _ejoysdk.renamefile(origin_name, des_name)
      E.log("os_rename1, -----" .. tostring(result) .. ", origin_name:" .. tostring(origin_name) .. ", msg:" .. tostring(msg))
    elseif _ejoysdk.utf8_to_acp then
      result, msg = os.rename(file_utf8_to_acp(origin_name), file_utf8_to_acp(des_name))
      E.log("os_rename2, -----" .. tostring(result) .. ", origin_name:" .. tostring(origin_name) .. ", msg:" .. tostring(msg))
    else
      result, msg = os.rename(origin_name, des_name)
      E.log("os_rename3, -----" .. tostring(result) .. ", origin_name:" .. tostring(origin_name) .. ", msg:" .. tostring(msg))
    end
    return result, msg
  else
    do return os.rename, origin_name end
    return os.rename, origin_name, des_name, ", origin_name:", tostring(origin_name), ", msg:", tostring(msg), msg
  end
end

function M.read_file(file_path)
  local list_content
  if E.Sysinfo.os() == "ios" then
    list_content = E.sync_call("read_file", file_path)
  else
    list_content = _ejoysdk.lread(file_path)
  end
  return list_content
end

local function do_copy(origin_name, des_name)
  local old_file = io.open(origin_name, "rb")
  local dest_parent_dir = M.get_parent_folder(des_name)
  local result
  if not M.file_exists(dest_parent_dir) and E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    result = E.File.make_dirs(dest_parent_dir)
    E.LOG.debug(TAG, "begin make_dirs:" .. tostring(dest_parent_dir) .. ", result:" .. tostring(result) .. ", exists:" .. tostring(M.file_exists(dest_parent_dir)))
  end
  if not old_file then
    _ejoysdk.log("open failed:" .. tostring(old_file))
    return false
  end
  local new_file = io.open(des_name, "wb")
  if not new_file then
    _ejoysdk.log("new_file:" .. tostring(new_file))
    M.os_remove(des_name)
    old_file:close()
    return false
  end
  while true do
    local block = old_file:read(1048576)
    if not block then
      break
    end
    new_file:write(block)
  end
  old_file:close()
  new_file:close()
  return true
end

function M.os_copy(origin_name, des_name)
  if _ejoysdk.os() == "windows" and _ejoysdk.utf8_to_acp then
    local result, msg = do_copy(origin_name, des_name)
    if not result then
      result, msg = do_copy(file_utf8_to_acp(origin_name), file_utf8_to_acp(des_name))
      if not result and _ejoysdk.copy_file then
        result = _ejoysdk.copy_file(origin_name, des_name)
      end
    end
    return result, msg
  else
    do return do_copy, origin_name end
    return do_copy, origin_name, des_name, msg, des_name, file_utf8_to_acp(des_name)
  end
end

function M.is_file_exists(path)
  local file = io.open(path, "rb")
  local file_exists = nil ~= file
  local real_size
  if file_exists then
    real_size = file:seek("end")
    real_size = real_size or -1
    file:close()
  else
    file = io.open(file_utf8_to_acp(path), "rb")
    file_exists = nil ~= file
    if file_exists then
      real_size = file:seek("end")
      real_size = real_size or -1
      file:close()
    elseif _ejoysdk.os() == "windows" and _ejoysdk.is_file_exists and _ejoysdk.file_length then
      file_exists = _ejoysdk.is_file_exists(path)
      if file_exists then
        real_size = _ejoysdk.file_length(path)
      end
    end
  end
  return file_exists, real_size
end

function M.get_file_size(path)
  local file_exists, real_size = M.is_file_exists(path)
  return file_exists and real_size or 0
end

function M.file_exists(path)
  local file = io.open(path, "rb")
  local file_exists = nil ~= file
  if not file_exists then
    file = io.open(file_utf8_to_acp(path), "rb")
    file_exists = nil ~= file
  end
  if not file_exists and _ejoysdk.os() == "windows" and _ejoysdk.is_file_exists then
    file_exists = _ejoysdk.is_file_exists(path)
  end
  if file then
    file:close()
  end
  return file_exists
end

function M.split_url(full_url)
  local temp = string.reverse(full_url)
  local _, i = string.find(temp, "/")
  if type(i) == "number" then
    local offset = string.len(full_url) - i + 1
    return string.sub(full_url, 1, offset), string.sub(full_url, offset + 1, string.len(full_url))
  else
    return "", full_url
  end
end

function M.get_parent_folder(path)
  if string.sub(path, string.len(path)) == "/" then
    path = string.sub(path, 1, string.len(path) - 1)
  end
  path = M.split_url(path)
  return path
end

function M.check_file_valid(path, file_size)
  local exists, real_size = M.is_file_exists(path)
  local is_valid = false
  if real_size then
    if file_size and file_size > 0 then
      is_valid = real_size == file_size
    else
      is_valid = true
    end
  end
  return is_valid, exists, real_size
end

function M.is_support_file_md5()
  return type(_ejoysdk_crypt.md5) == "table" and _ejoysdk_crypt.md5.start_md5c ~= nil
end

function M.check_file_md5(file_path)
  local file = io.open(file_path, "rb")
  local is_need_use_pc_new_md5 = false
  if not file then
    local temp_file_path = file_utf8_to_acp(file_path)
    file = io.open(temp_file_path, "rb")
    if not file then
      if _ejoysdk.os() == "windows" and _ejoysdk.readfile_offset_length and _ejoysdk.file_length and _ejoysdk.is_file_exists then
        is_need_use_pc_new_md5 = _ejoysdk.is_file_exists(file_path)
      end
      if not is_need_use_pc_new_md5 then
        _ejoysdk.log("file not exists:" .. tostring(file_path))
        return false, EC.EJOYSDK_ERROR_CODES.RES_FILE_NOT_EXISTS, "file not exists"
      end
    end
  end
  local real_size
  if is_need_use_pc_new_md5 and _ejoysdk.file_length then
    real_size = _ejoysdk.file_length(file_path)
  else
    real_size = file:seek("end")
    real_size = real_size or -1
  end
  local md5_hex_str
  if real_size and real_size > 0 then
    local md5_ud = _ejoysdk_crypt.md5.start_md5c()
    if not is_need_use_pc_new_md5 then
      file:seek("set")
    end
    local offset = 0
    local length = 204800
    repeat
      local str
      if is_need_use_pc_new_md5 and _ejoysdk.readfile_offset_length then
        str = _ejoysdk.readfile_offset_length(file_path, offset, length)
        offset = offset + length
      else
        str = file:read(204800)
      end
      if str then
        _ejoysdk_crypt.md5.update_md5c(md5_ud, str)
      end
    until not str or real_size <= offset
    local md5_data = _ejoysdk_crypt.md5.finish_md5c(md5_ud)
    if md5_data then
      md5_hex_str = _ejoysdk_crypt.hexencode(md5_data)
    else
      _ejoysdk.log("md5 data is empty for path:" .. tostring(file_path))
      md5_hex_str = nil
    end
  elseif real_size and 0 == real_size then
    md5_hex_str = "d41d8cd98f00b204e9800998ecf8427e"
  else
    _ejoysdk.log("get file size failed for path:" .. tostring(file_path))
    md5_hex_str = nil
  end
  _ejoysdk.log("read return :" .. tostring(md5_hex_str))
  if file then
    file:close()
  end
  return md5_hex_str
end

function M.guess_url_filename(url)
  if not url or "" == url then
    return ""
  end
  local query_index = string.find(url, "%?")
  local no_query_url = url
  if query_index and query_index > 1 then
    no_query_url = string.sub(url, 1, query_index - 1)
  end
  local file_name = no_query_url:match("([^/]+)$") or ""
  return file_name
end

local BACKGROUND_RUN_TIME_THRSHOLD_MILLS = 5000
M.BACKGROUND_RUN_TIME_THRSHOLD_MILLS = BACKGROUND_RUN_TIME_THRSHOLD_MILLS
local speed_cache = {}

local function create_taskid_cache(_biz_name, biz_data, task_id)
  local task_id_time_data = biz_data[task_id]
  if task_id_time_data then
    return task_id_time_data
  end
  task_id_time_data = {}
  
  local function add_task_cache()
    if not biz_data._cache_taskid_list then
      biz_data._cache_taskid_list = {}
    end
    table.insert(biz_data._cache_taskid_list, task_id)
    biz_data[task_id] = task_id_time_data
  end
  
  local function rm_task_cache()
    local rm_id = table.remove(biz_data._cache_taskid_list, 1)
    biz_data[rm_id] = nil
  end
  
  local function check_cache_avaialbe()
    local cache_len = biz_data._cache_taskid_list and #biz_data._cache_taskid_list or 0
    local DT = require("ejoysdk_lua.res.model.http_download_multi_task")
    local max_downloading_count = DT.MAX_DOWNLOADING_COUNT * 2
    return cache_len <= max_downloading_count
  end
  
  if not check_cache_avaialbe() then
    rm_task_cache()
  end
  add_task_cache()
  return task_id_time_data
end

local function check_download_speed(_biz_name, task_id, biz_data, downloading_size, event_time_mills, bandwidth_kbps)
  local speed = -1
  local cur_time_ms = E.system_ms()
  local task_id_time_data = create_taskid_cache(_biz_name, biz_data, task_id)
  local cache_len = biz_data._cache_taskid_list and #biz_data._cache_taskid_list or 0
  local DT = require("ejoysdk_lua.res.model.http_download_multi_task")
  if not (biz_data.last_downloading_size and 0 ~= biz_data.last_downloading_size and biz_data.last_downloading_size_time) or 0 == biz_data.last_downloading_size_time or nil ~= event_time_mills and cur_time_ms - event_time_mills > BACKGROUND_RUN_TIME_THRSHOLD_MILLS or nil == event_time_mills and not task_id_time_data.last_downloading_size_time and cache_len < DT.MAX_DOWNLOADING_COUNT then
    task_id_time_data.last_downloading_size_time = cur_time_ms
    biz_data.last_downloading_size = downloading_size
    biz_data.last_downloading_size_time = cur_time_ms
    return speed
  end
  local download_size_diff = downloading_size - biz_data.last_downloading_size
  if download_size_diff > 0 then
    local download_diff_time_ms = cur_time_ms - biz_data.last_downloading_size_time
    if download_diff_time_ms > BACKGROUND_RUN_TIME_THRSHOLD_MILLS then
      biz_data.last_downloading_size = downloading_size
      biz_data.last_downloading_size_time = cur_time_ms
    elseif download_diff_time_ms > 1000 then
      biz_data.last_downloading_size = downloading_size
      biz_data.last_downloading_size_time = cur_time_ms
      local download_size_diff_kb = download_size_diff / 1024
      local speed_val = math.floor(download_size_diff_kb / (download_diff_time_ms / 1000))
      local last_downloading_speed = biz_data.last_downloading_speed
      local is_limit_speed = type(bandwidth_kbps) == "number" and bandwidth_kbps > 0
      local exceed_bandwidth = is_limit_speed and speed_val >= bandwidth_kbps * 2
      local speed_instable_check_invalid = not is_limit_speed and last_downloading_speed and last_downloading_speed > 0 and speed_val / last_downloading_speed > 3
      local speed_valid_check_invalid = exceed_bandwidth or speed_instable_check_invalid
      biz_data.speed_instable_check_invalid_cnt = biz_data.speed_instable_check_invalid_cnt or 0
      if not speed_instable_check_invalid then
        if biz_data.speed_instable_check_invalid_cnt > 0 and biz_data.speed_instable_check_invalid_cnt < 3 then
          speed_valid_check_invalid = true
          biz_data.speed_instable_check_invalid_cnt = biz_data.speed_instable_check_invalid_cnt + 1
        else
          biz_data.speed_instable_check_invalid_cnt = 0
        end
      elseif speed_instable_check_invalid then
        biz_data.speed_instable_check_invalid_cnt = 1
      end
      biz_data.last_downloading_speed = speed_val
      if not speed_valid_check_invalid then
        speed = speed_val
      end
    end
  end
  task_id_time_data.last_downloading_size_time = cur_time_ms
  return speed
end

function M.check_download_speed(biz_name, task_id, downloading_size, total_size, event_time_mills, bandwidth_kbps)
  if not biz_name or "" == biz_name then
    E.LOG.warn(TAG, "check_download_speed skip, param is invalid")
    return 0
  end
  local biz_data = speed_cache[biz_name] or {}
  speed_cache[biz_name] = biz_data
  if type(downloading_size) ~= "number" then
    downloading_size = tonumber(downloading_size) or 0
  end
  if type(total_size) ~= "number" then
    total_size = tonumber(total_size) or 0
  end
  local speed = 0
  if downloading_size > 0 then
    speed = check_download_speed(biz_name, task_id, biz_data, downloading_size, event_time_mills, bandwidth_kbps)
  end
  if total_size > 0 and downloading_size == total_size then
    E.LOG.debug(TAG, "check_download_speed end, clear speed cache, biz_name:" .. tostring(biz_name))
    speed_cache[biz_name] = nil
  end
  return speed
end

function M.reset_download_speed(biz_name)
  speed_cache[biz_name] = nil
end

function M.set_max_downloading_count(_biz_name, _max_download_count)
end

return M

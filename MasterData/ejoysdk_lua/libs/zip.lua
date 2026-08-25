local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local EU = require("ejoysdk_lua.res.ejoy_http_res_utils")
local M = {}
local _zlib = _ejoysdk_crypt.zlib
local _libzip = _ejoysdk_zip
local TAG = "zip"
local MAXIMUM_WINDOWBITS = 15
local GZIP_WINDOWBITS = 16
M.LIBZIP_OPEN_FLAGS = {}
if _libzip then
  M.LIBZIP_OPEN_FLAGS.CREATE = _libzip.CREATE
  M.LIBZIP_OPEN_FLAGS.EXCL = _libzip.EXCL
  M.LIBZIP_OPEN_FLAGS.CHECKCONS = _libzip.CHECKCONS
end
M.LIBZIP_ENTRY_OPEN_FLAG = {}
if _libzip then
  M.LIBZIP_ENTRY_OPEN_FLAG.FL_COMPRESSED = _libzip.FL_COMPRESSED
  M.LIBZIP_ENTRY_OPEN_FLAG.FL_UNCHANGED = _libzip.FL_UNCHANGED
  M.LIBZIP_ENTRY_OPEN_FLAG.FL_NOCASE = _libzip.FL_NOCASE
  M.LIBZIP_ENTRY_OPEN_FLAG.FL_NODIR = _libzip.FL_NODIR
end
M.LIBZIP_ENTRY_ENCODING_FLAG = {ZIP_FL_ENC_RAW = 64, ZIP_FL_ENC_GUESS = 0}

function M.create_gzip_stream()
  if not M.is_support_gzip() then
    return nil, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "not support gzip"
  end
  local gzip_stream = M.deflate(nil, MAXIMUM_WINDOWBITS + GZIP_WINDOWBITS)
  return gzip_stream
end

function M.gzip_data(inflated_data)
  if not M.is_support_gzip() then
    return nil, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "not support gzip"
  end
  local gzip_stream = M.create_gzip_stream()
  local gzip_data = gzip_stream(inflated_data, "finish")
  return gzip_data
end

function M.gzip_file(inflated_data, file_path)
  if not M.is_support_gzip() then
    return false, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "not support gzip"
  end
  local parent_path = EU.get_parent_folder(file_path)
  if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    local succ = E.File.make_dirs(parent_path)
    E.LOG.debug(TAG, "gzip_file result:" .. tostring(succ))
  end
  local gzip_data = M.gzip_data(inflated_data)
  local gzip_file = io.open(file_path, "w")
  gzip_file:write(gzip_data)
  gzip_file:close()
  return true
end

function M.un_gzip_data(gzip_raw_bytes)
  if not M.is_support_gzip() then
    return nil, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "not support gzip"
  end
  local inflated_data = M.inflate()(gzip_raw_bytes)
  return inflated_data
end

function M.inflate(windowBits)
  if not M.is_support_zlib() then
    return nil, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "not support zlib"
  end
  do return _zlib.inflate end
  return _zlib.inflate, windowBits, "not support zlib"
end

function M.deflate(compression_level, window_size)
  if not M.is_support_zlib() then
    return nil, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "not support zlib"
  end
  do return _zlib.deflate, compression_level end
  return _zlib.deflate, compression_level, window_size
end

function M.is_support_gzip()
  return nil ~= _zlib
end

function M.is_support_zlib()
  return nil ~= _zlib
end

function M.is_support_zip()
  if E.Sysinfo.os() == "windows" then
    return nil ~= _libzip
  else
    do return end
    return E.File.is_support_handling_file_cache, nil
  end
end

function M.win_zip_open(zipfilename, flag1, flag2)
  local flags = 0
  if flag1 then
    flags = flag1
  end
  if flag2 then
    flags = _libzip.OR(flag1, flag2)
  end
  local zip_arc, err_msg = _libzip.open(zipfilename, flags)
  E.LOG.debug(TAG, "zip_open result:" .. ", zip_arc:" .. tostring(zip_arc) .. ", err_msg:" .. tostring(err_msg))
  return zip_arc, EC.EJOY_LIB_ERROR.ZIP_FILE_OPEN_FAILED, err_msg
end

local function is_zip_entry_dir(entry_name)
  do return E.Utils.end_with, entry_name end
  return E.Utils.end_with, entry_name, "/"
end

local function win_unzip(zip_file_path, dest_dir, cb)
  local origin_utf8_path = zip_file_path
  local dest_utf8_path = dest_dir
  if not EU.is_file_exists(zip_file_path) then
    E.log("zip origin file not exists:" .. tostring(zip_file_path))
    cb(false, EC.EJOY_LIB_ERROR.ZIP_FILE_NOT_EXISTS, "origin file not exists")
  end
  E.File.make_dirs(dest_utf8_path)
  local origin_zip_file = M.win_zip_open(origin_utf8_path)
  if origin_zip_file then
    local entry_num = #origin_zip_file
    for i = 1, entry_num do
      local entry_name = origin_zip_file:get_name(i, M.LIBZIP_ENTRY_ENCODING_FLAG.ZIP_FL_ENC_RAW)
      local entry_name_utf8 = entry_name
      if _ejoysdk.os() == "windows" and _ejoysdk.acp_to_utf8 then
        entry_name_utf8 = _ejoysdk.acp_to_utf8(entry_name)
      end
      local dest_target_file_path_utf8 = dest_utf8_path .. "/" .. entry_name_utf8
      if is_zip_entry_dir(entry_name) then
        E.File.make_dirs(dest_target_file_path_utf8)
      else
        local zip_entry_file = origin_zip_file:open(i, M.LIBZIP_ENTRY_OPEN_FLAG.FL_UNCHANGED)
        if not zip_entry_file then
          E.LOG.warn(TAG, "unzip failed for entry:" .. tostring(entry_name) .. ", read failed")
        else
          local file_stat_info = origin_zip_file:stat(i, M.LIBZIP_ENTRY_OPEN_FLAG.FL_UNCHANGED)
          if file_stat_info and file_stat_info.size > 0 then
            local content = zip_entry_file:read(file_stat_info.size)
            local succ, _code, msg = E.File.writefile_fullpath(dest_target_file_path_utf8, content, false)
            if not succ then
              E.LOG.warn(TAG, "unzip file failed, target file open failed:" .. tostring(dest_target_file_path_utf8) .. ", msg:" .. tostring(msg))
            end
          else
            E.LOG.warn(TAG, "unzip file failed, target file open failed:" .. tostring(dest_target_file_path_utf8))
          end
          zip_entry_file:close()
        end
      end
    end
    origin_zip_file:close()
    cb(true)
  else
    E.LOG.warn(TAG, "origin file not exists:" .. tostring(zip_file_path))
    cb(false, EC.EJOY_LIB_ERROR.ZIP_FILE_NOT_EXISTS, "zip file not exists:" .. tostring(zip_file_path))
  end
end

function M.unzip(zip_file_path, dest_dir, cb)
  if not M.is_support_zip() then
    cb(false, EC.EJOY_LIB_ERROR.ZIP_NOT_SUPPORT, "not support zip")
    return
  end
  if E.Sysinfo.os() == "windows" then
    win_unzip(zip_file_path, dest_dir, cb)
  else
    E.File.unzip_full_path(zip_file_path, dest_dir, function(ret)
      local succ
      if type(ret.succ) == "boolean" then
        succ = ret.succ
      else
        succ = 1 == ret.succ
      end
      local code, msg
      if not succ then
        code = EC.EJOY_LIB_ERROR.ZIP_FILE_UNZIP_FAILED
        msg = ret.msg
        E.LOG.warn(TAG, "upzip failed, succ:" .. tostring(ret.succ) .. "msg:" .. tostring(ret.msg))
        cb(false, code, msg)
      else
        E.LOG.debug(TAG, "unzip succ")
        cb(true)
      end
    end)
  end
end

function M.win_zip_flag_OR()
  return _libzip.OR
end

local function safe_rename(src, dst)
  local ok, msg = E.File.rename_fullpath(src, dst)
  if not ok and E.File.exists_fullpath(dst) then
    E.File.remove_fullpath(dst)
    ok, msg = E.File.rename_fullpath(src, dst)
  end
  return ok, msg
end

function M.win_gzip_file_full_path(src_path, dest_path)
  if not M.is_support_gzip() then
    return false, EC.EJOY_LIB_ERROR.ZLIB_NOT_SUPPORT, "zlib/gzip not available"
  end
  if not EU.is_file_exists(src_path) then
    return false, EC.EJOY_LIB_ERROR.FILE_NOT_EXISTS, "source file not exists: " .. tostring(src_path)
  end
  local real_size = _ejoysdk.file_length(src_path)
  if not real_size or real_size < 0 then
    return false, EC.EJOY_LIB_ERROR.FILE_SIZE_GET_FAILED, "get file size failed: " .. tostring(src_path)
  end
  local gzip_stream, err_code, err_msg = M.create_gzip_stream()
  if not gzip_stream then
    return false, err_code or EC.EJOY_LIB_ERROR.FILE_OPEN_FAILED, err_msg or "create gzip stream failed"
  end
  local temp_path = dest_path .. ".tmp"
  local chunk_size = 2097152
  local offset = 0
  local total_compressed_size = 0
  local zip_error = false
  local is_first_write = true
  repeat
    local chunk_data = _ejoysdk.readfile_offset_length(src_path, offset, chunk_size)
    if chunk_data and #chunk_data > 0 then
      local compressed_chunk = gzip_stream(chunk_data)
      if compressed_chunk and #compressed_chunk > 0 then
        local succ, code, msg = E.File.writefile_fullpath(temp_path, compressed_chunk, not is_first_write, false)
        if not succ then
          E.LOG.debug(TAG, string.format("writefile_fullpath failed: offset=%d, msg=%s", offset, tostring(msg)))
          zip_error = true
          break
        end
        total_compressed_size = total_compressed_size + #compressed_chunk
        is_first_write = false
      end
      offset = offset + #chunk_data
    else
      if real_size > offset then
        zip_error = true
        E.LOG.warn(TAG, string.format("gzip stream read incomplete: offset=%d, expected=%d", offset, real_size))
      end
      break
    end
  until real_size <= offset
  if not zip_error then
    local final_chunk = gzip_stream(nil, "finish")
    if final_chunk and #final_chunk > 0 then
      local succ, code, msg = E.File.writefile_fullpath(temp_path, final_chunk, true, false)
      if not succ then
        zip_error = true
        E.LOG.warn(TAG, "gzip stream finish write failed: " .. tostring(msg))
      else
        total_compressed_size = total_compressed_size + #final_chunk
      end
    end
  end
  if zip_error then
    if EU.is_file_exists(temp_path) and E.File and E.File.remove_fullpath then
      E.File.remove_fullpath(temp_path)
    end
    return false, EC.EJOY_LIB_ERROR.ZLIB_COMPRESS_FAILED, "gzip compression failed"
  end
  local succ, rename_err_msg = safe_rename(temp_path, dest_path)
  if not succ then
    E.LOG.debug(TAG, string.format("Rename failed: temp=%s -> dest=%s, msg=%s", tostring(temp_path), tostring(dest_path), tostring(rename_err_msg)))
    if E.File and E.File.remove_fullpath then
      E.File.remove_fullpath(temp_path)
    end
    return false, EC.EJOY_LIB_ERROR.FILE_WRITE_FILE_FAILED, "Failed to rename temp file"
  end
  if not EU.is_file_exists(dest_path) then
    return false, EC.EJOY_LIB_ERROR.FILE_WRITE_FILE_FAILED, "gz file not created"
  end
  E.LOG.debug(TAG, string.format("gzip_file_full_path succ: src=%s, src_size=%d, dest_size=%d", tostring(src_path), real_size, total_compressed_size))
  return true, 0, ""
end

return M

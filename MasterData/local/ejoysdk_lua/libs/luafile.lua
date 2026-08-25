local CC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}

local function map_size(map)
  if not map or next(map) == nil then
    return 0
  end
  local size = 0
  for _, _v in pairs(map) do
    size = size + 1
  end
  return size
end

local function lua_batch_file_op(map, opcode, cb, ext_params)
  _ejoysdk.log("lua_batch_file_op begin")
  local operation_handler
  if "rename" == opcode then
    operation_handler = M.rename
  elseif "copy" == opcode then
    operation_handler = M.copy
  end
  if operation_handler then
    M.batch_src_dst_operation(map, operation_handler, cb, ext_params)
  else
    _ejoysdk.log("lua_batch_file_op skip, not find operation handler with opcode:" .. tostring(opcode))
  end
end

function M.batch_src_dst_operation(map, operation_handler, cb, ext_params)
  _ejoysdk.log("batch_src_dst_operation begin")
  map = map or {}
  if next(map) == nil then
    if cb then
      cb(true)
    end
    return
  end
  local final_result, final_code, final_msg, result_ext
  local all_file_count = map_size(map)
  local finish_file_count = 0
  for src, dst in pairs(map) do
    local function ret_handler(_succ, ...)
      if not _succ then
        local _code, _msg = ...
        
        final_result = false
        final_code = _code
        final_msg = _msg
        result_ext = result_ext or {}
        result_ext[src] = {code = _code, msg = _msg}
      end
      finish_file_count = finish_file_count + 1
      if finish_file_count == all_file_count then
        if nil == result_ext or nil == next(result_ext) then
          final_result = true
        end
        _ejoysdk.log("lua_batch_file_op end, all_file_count:" .. tostring(all_file_count) .. ", result:" .. tostring(final_result) .. ", code:" .. tostring(final_code) .. ", msg:" .. tostring(final_msg))
        if cb then
          cb(final_result, final_code, final_msg, result_ext)
        end
      end
    end
    
    local ret, code, msg = operation_handler(src, dst, ext_params)
    ret_handler(ret, code, msg)
  end
end

function M.rename(src_fullpath, dst_fullpath)
  if src_fullpath == dst_fullpath then
    return false, CC.EJOY_LIB_ERROR.FILE_DST_PATH_SAME_WITH_SRC, "dst path same with src"
  end
  local Path = require("ejoysdk_lua.libs.path")
  Path.ensure_parent_dir(dst_fullpath)
  local ret, msg = os.rename(src_fullpath, dst_fullpath)
  if not ret then
    return false, CC.EJOY_LIB_ERROR.FILE_RENAME_FAILED, msg
  else
    return true
  end
end

function M.batch_rename(map, cb)
  lua_batch_file_op(map, "rename", cb)
end

function M.batch_copy(map, cb, override)
  lua_batch_file_op(map, "copy", cb, override)
end

function M.copy(src_fullpath, dst_fullpath, need_override)
  if src_fullpath == dst_fullpath then
    return false, CC.EJOY_LIB_ERROR.FILE_DST_PATH_SAME_WITH_SRC, "dst path same with src"
  end
  local old_file = io.open(src_fullpath, "rb")
  if not old_file then
    _ejoysdk.log("open failed:" .. tostring(old_file) .. ", path:" .. tostring(src_fullpath))
    return false, CC.EJOY_LIB_ERROR.FILE_OPEN_FAILED, "origin file open failed"
  end
  if type(need_override) == "nil" then
    need_override = true
  end
  if not need_override and M.exists(dst_fullpath) then
    _ejoysdk.log("copy with override enable, and dest already exists, return copy failed")
    old_file:close()
    return false, CC.EJOY_LIB_ERROR.FILE_ALREADY_EXISTS, "dest already exists"
  end
  local Path = require("ejoysdk_lua.libs.path")
  Path.ensure_parent_dir(dst_fullpath)
  local new_file = io.open(dst_fullpath, "wb")
  if not new_file then
    _ejoysdk.log("new_file:" .. tostring(new_file))
    old_file:close()
    return false, CC.EJOY_LIB_ERROR.FILE_OPEN_FAILED, "target file open failed"
  end
  while true do
    local block = old_file:read(65536)
    if not block then
      break
    end
    new_file:write(block)
  end
  old_file:close()
  new_file:close()
  return true
end

function M.remove(path)
  local ret, msg = os.remove(path)
  ret = ret or false
  local code
  if not ret then
    code = CC.EJOY_LIB_ERROR.FILE_REMOVE_FILE_FAILED
  end
  return ret, code, msg
end

function M.md5(file_path)
  local file = io.open(file_path, "rb")
  if not file then
    _ejoysdk.log("file not exists:" .. tostring(file_path))
    return nil, CC.EJOY_LIB_ERROR.ZIP_FILE_NOT_EXISTS, "file not exists"
  end
  local real_size = file:seek("end")
  real_size = real_size or -1
  local md5_hex_str, code, msg
  if real_size and real_size > 0 then
    local md5_ud = _ejoysdk_crypt.md5.start_md5c()
    file:seek("set")
    local length = 204800
    repeat
      local str
      str = file:read(length)
      if str then
        _ejoysdk_crypt.md5.update_md5c(md5_ud, str)
      end
    until not str
    local md5_data = _ejoysdk_crypt.md5.finish_md5c(md5_ud)
    if md5_data then
      md5_hex_str = _ejoysdk_crypt.hexencode(md5_data)
    else
      _ejoysdk.log("md5 data is empty for path:" .. tostring(file_path))
      md5_hex_str = nil
      code = CC.EJOY_LIB_ERROR.FILE_MD5_CHECK_FAILED
      msg = "md5 check nil"
    end
  elseif real_size and 0 == real_size then
    md5_hex_str = "d41d8cd98f00b204e9800998ecf8427e"
  else
    _ejoysdk.log("get file size failed for path:" .. tostring(file_path))
    md5_hex_str = nil
    code = CC.EJOY_LIB_ERROR.FILE_SIZE_GET_FAILED
    msg = "file size get failed"
  end
  if file then
    file:close()
  end
  return md5_hex_str, code, msg
end

function M.batch_md5(file_list, cb)
  file_list = file_list or {}
  local succ_data = {}
  local fail_data = {}
  local last_err_code, last_err_msg
  for _, f in ipairs(file_list) do
    local md5_val, _code, _msg = M.md5(f)
    if md5_val then
      succ_data[f] = md5_val
    else
      last_err_code = _code
      last_err_msg = _msg
      fail_data[f] = {code = last_err_code, msg = last_err_msg}
    end
  end
  if cb then
    if last_err_code then
      cb(false, last_err_code, last_err_msg, succ_data, fail_data)
    else
      cb(true, succ_data)
    end
  end
end

function M.batch_info_op(file_list, cb, opts, op_handler)
  file_list = file_list or {}
  _ejoysdk.log("lua batch_info, size:" .. tostring(#file_list))
  local succ_data = {}
  for _, f in ipairs(file_list) do
    local _exists, _size = op_handler(f, opts)
    succ_data[f] = {exists = _exists}
    if _exists then
      succ_data[f].size = _size
    end
  end
  if cb then
    cb(succ_data)
  end
end

function M.batch_info(file_list, cb, opts)
  M.batch_info_op(file_list, cb, opts, M.exists_status)
end

local function exists_v2(path)
  local ok, err, code = os.rename(path, path)
  if not ok and _ejoysdk.os() == "windows" and 13 == code then
    ok = true
  end
  return true == ok, err, code
end

function M.exists(path)
  local file, _code, _msg = io.open(path, "rb")
  if file then
    file:close()
  end
  if nil == file then
    local ok, err, code = exists_v2(path)
    return ok, code, err
  end
  return nil ~= file, _code, _msg
end

function M.exists_status(path, opts)
  opts = opts or {}
  local check_size = opts.check_size or false
  local base_path = opts.base_path
  if base_path then
    local E = require("ejoysdk_lua.ejoysdk")
    path = E.Path.join(base_path, path)
  end
  local file = io.open(path, "rb")
  local file_exists = nil ~= file
  local real_size
  if file_exists then
    if check_size then
      real_size = file:seek("end")
      real_size = real_size or -1
    end
    file:close()
  end
  return file_exists, real_size
end

function M._do_write_file(full_path, filedata, append, is_b64)
  if true == is_b64 then
    local succ, data = pcall(_ejoysdk_crypt.base64decode, filedata)
    if true == succ then
      filedata = data
    else
      filedata = nil
    end
  end
  if not filedata then
    _ejoysdk.log("writefile error!!! invalid data")
    return false
  end
  local file
  if true == append then
    file = io.open(full_path, "ab")
  else
    file = io.open(full_path, "wb")
  end
  if not file then
    _ejoysdk.log("writefile error!!! path = " .. tostring(full_path))
    return false
  end
  file:write(filedata)
  file:close()
  return true, full_path
end

function M.write_file(full_path, filedata, append, is_b64)
  if type(append) == "number" then
    if append > 0 then
      append = true
    else
      append = false
    end
  end
  if "" == full_path or nil == full_path then
    _ejoysdk.log("writefile failed, full_path is invalid,")
    return false
  end
  _ejoysdk.log("writefile path = " .. tostring(full_path))
  local E = require("ejoysdk_lua.ejoysdk")
  local parent_path = E.Path.parent_dir(full_path)
  if E.is_support_function(CC.NATIVE_SUPPORT_FUNCTION_NAMES.MAKE_DIRS) then
    E.File.make_dirs(parent_path)
  end
  do return M._do_write_file, full_path, filedata, append end
  return M._do_write_file, full_path, filedata, append, is_b64
end

return M

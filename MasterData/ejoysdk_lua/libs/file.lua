local CC = require("ejoysdk_lua.ejoysdk_constants")
local E = require("ejoysdk_lua.ejoysdk")
local TAG = "file#"
local M = {}

local function to_fullpath(path, base_path)
  local ext_file_dir = base_path
  ext_file_dir = ext_file_dir or E.File.get_ext_file_dir()
  local fullpath_result = E.Path.join(ext_file_dir, path)
  return fullpath_result
end

function M.rename(src, dst, opts)
  local src_full_path, dst_full_path
  opts = opts or {}
  local is_fullpath = opts.is_fullpath
  if not is_fullpath then
    src_full_path = to_fullpath(src)
    dst_full_path = to_fullpath(dst)
  else
    src_full_path = src
    dst_full_path = dst
  end
  do return M.rename_fullpath, src_full_path end
  return M.rename_fullpath, src_full_path, dst_full_path
end

function M.rename_fullpath(src_fullpath, dst_fullpath)
  if src_fullpath == dst_fullpath then
    return false, CC.EJOY_LIB_ERROR.FILE_DST_PATH_SAME_WITH_SRC, "dst path same with src"
  end
  do return E.File.process_rename, src_fullpath end
  return E.File.process_rename, src_fullpath, dst_fullpath
end

local function batch_result_ext_cb_wrapper(src_full_rela_map, dst_full_src_map, cb)
  local function _wrapper(succ, ...)
    if not succ and src_full_rela_map then
      local _rela_result_map = {}
      
      local code, msg, result_ext = ...
      for _full_path, val in pairs(result_ext) do
        local _src = src_full_rela_map[_full_path]
        if not _src and dst_full_src_map then
          _src = dst_full_src_map[_full_path]
        end
        _src = _src or _full_path
        _rela_result_map[_src] = val
      end
      cb(false, code, msg, _rela_result_map)
    else
      cb(succ, ...)
    end
  end
  
  return _wrapper
end

function M.batch_rename(map, cb, opts)
  map = map or {}
  if next(map) == nil then
    cb(true)
    return
  end
  opts = opts or {}
  local _path_map = map
  local is_fullpath = opts.is_fullpath
  local src_full_rela_map, dst_full_src_map
  if not is_fullpath then
    if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_FILE_BATCH_OPERATION_BASE_PATH) then
      E.LOG.debug(TAG, "batch_rename native support base_path")
      if not opts.src_base_path or opts.src_base_path == "" then
        opts.src_base_path = E.Path.get_ext_file_dir()
      end
      if not opts.dst_base_path or "" == opts.dst_base_path then
        opts.dst_base_path = E.Path.get_ext_file_dir()
      end
    else
      _path_map = {}
      src_full_rela_map = {}
      dst_full_src_map = {}
      for src, dst in pairs(map) do
        local src_full_path = to_fullpath(src, opts.src_base_path)
        local dst_full_path = to_fullpath(dst, opts.dst_base_path)
        _path_map[src_full_path] = dst_full_path
        src_full_rela_map[src_full_path] = src
        dst_full_src_map[dst_full_path] = src
      end
    end
  end
  E.File.process_batch_rename(_path_map, batch_result_ext_cb_wrapper(src_full_rela_map, dst_full_src_map, cb), opts)
end

function M.copy(src, dst, opts)
  local src_full_path, dst_full_path
  opts = opts or {}
  local is_fullpath = opts.is_fullpath
  if not is_fullpath then
    src_full_path = to_fullpath(src)
    dst_full_path = to_fullpath(dst)
  else
    src_full_path = src
    dst_full_path = dst
  end
  do return M.copy_fullpath, src_full_path, dst_full_path end
  return M.copy_fullpath, src_full_path, dst_full_path, opts
end

function M.copy_fullpath(src, dst, opts)
  if src == dst then
    return false, CC.EJOY_LIB_ERROR.FILE_DST_PATH_SAME_WITH_SRC, "dst path same with src"
  end
  do return E.File.process_copy, src, dst end
  return E.File.process_copy, src, dst, opts
end

function M.batch_copy(map, cb, opts)
  map = map or {}
  if next(map) == nil then
    cb(true)
    return
  end
  opts = opts or {}
  local _path_map_params = map
  local is_fullpath = opts.is_fullpath
  local src_full_rela_map, dst_full_src_map
  if not is_fullpath then
    if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_FILE_BATCH_OPERATION_BASE_PATH) then
      E.LOG.debug(TAG, "batch_copy native support base_path")
      if not opts.src_base_path or opts.src_base_path == "" then
        opts.src_base_path = E.Path.get_ext_file_dir()
      end
      if not opts.dst_base_path or "" == opts.dst_base_path then
        opts.dst_base_path = E.Path.get_ext_file_dir()
      end
    else
      E.LOG.debug(TAG, "batch_copy native NOT support base_path, modify relative path to full path")
      _path_map_params = {}
      src_full_rela_map = {}
      dst_full_src_map = {}
      for src, dst in pairs(map) do
        local src_full_path = to_fullpath(src, opts.src_base_path)
        local dst_full_path = to_fullpath(dst, opts.dst_base_path)
        _path_map_params[src_full_path] = dst_full_path
        src_full_rela_map[src_full_path] = src
        dst_full_src_map[dst_full_path] = src
      end
    end
  end
  E.File.process_batch_copy(_path_map_params, batch_result_ext_cb_wrapper(src_full_rela_map, dst_full_src_map, cb), opts)
end

function M.remove(path)
  if not path then
    return false, CC.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is empty"
  end
  local full_path = to_fullpath(path)
  do return M.remove_fullpath end
  return M.remove_fullpath, full_path
end

function M.remove_fullpath(path)
  if not path then
    return false, CC.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is empty"
  end
  do return E.File.process_remove end
  return E.File.process_remove, path, "path is empty"
end

function M.batch_remove(file_list, cb, opts)
  file_list = file_list or {}
  local size = #file_list
  if 0 == size then
    cb(true)
    return
  end
  opts = opts or {}
  local _file_list_params = file_list
  local is_fullpath = opts.is_fullpath
  local src_full_rela_map
  if not is_fullpath then
    if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_FILE_BATCH_OPERATION_BASE_PATH) then
      E.LOG.debug(TAG, "batch_remove native support base_path")
      if not opts.base_path or opts.base_path == "" then
        opts.base_path = E.Path.get_ext_file_dir()
      end
    else
      E.LOG.debug(TAG, "batch_remove native NOT support base_path, modify relative path to full path")
      _file_list_params = {}
      src_full_rela_map = {}
      for _, path in ipairs(file_list) do
        local full_path = to_fullpath(path, opts.base_path)
        table.insert(_file_list_params, full_path)
        src_full_rela_map[full_path] = path
      end
    end
  end
  E.File.process_batch_remove(_file_list_params, batch_result_ext_cb_wrapper(src_full_rela_map, nil, cb), opts)
end

function M.exists(path, is_full_path)
  if not path or "" == path then
    return false
  end
  local abs_path
  if not is_full_path then
    abs_path = to_fullpath(path)
  else
    abs_path = path
  end
  do return E.File.process_exists end
  return E.File.process_exists, abs_path
end

function M.exists_fullpath(path)
  if not path or "" == path then
    return false
  end
  do return E.File.process_exists end
  return E.File.process_exists, path
end

function M.make_dirs(path)
  do return E.File.process_make_dirs end
  return E.File.process_make_dirs, path
end

function M.md5(file_path, is_full_path)
  local abs_path
  if not is_full_path then
    abs_path = to_fullpath(file_path)
  else
    abs_path = file_path
  end
  do return E.File.process_md5 end
  return E.File.process_md5, abs_path
end

function M.md5_fullpath(file_path)
  do return E.File.process_md5 end
  return E.File.process_md5, file_path
end

function M.batch_md5(file_list, cb, is_full_path, base_path)
  file_list = file_list or {}
  local size = #file_list
  if 0 == size then
    cb(true, {})
    return
  end
  local _list = file_list
  local full_rela_path_map
  if not is_full_path then
    if E.is_support_function(E.NATIVE_SUPPORT_FUNCTION_NAMES.SUPPORT_FILE_BATCH_OPERATION_BASE_PATH) then
      E.LOG.debug(TAG, "batch_md5 native support base_path")
      if not base_path or "" == base_path then
        base_path = E.Path.get_ext_file_dir()
      end
    else
      _list = {}
      full_rela_path_map = {}
      for _, path in ipairs(file_list) do
        local full_path = to_fullpath(path, base_path)
        table.insert(_list, full_path)
        full_rela_path_map[full_path] = path
      end
    end
  end
  E.File.process_batch_md5(_list, function(succ, ...)
    if succ then
      local succ_data = (...)
      succ_data = succ_data or {}
      local result_data = succ_data
      if full_rela_path_map then
        result_data = {}
        for abs_path, md5 in pairs(succ_data) do
          local rela_path = full_rela_path_map[abs_path]
          result_data[rela_path] = md5
        end
      end
      if cb then
        cb(true, result_data)
      end
    else
      local code, msg, succ_data, fail_data = ...
      local result_succ_data = succ_data
      local result_fail_data = fail_data
      if full_rela_path_map then
        result_succ_data = {}
        result_fail_data = {}
        for p1, md5 in pairs(succ_data) do
          local rela_path = full_rela_path_map[p1]
          result_succ_data[rela_path] = md5
        end
        for p2, md5 in pairs(fail_data) do
          local rela_path = full_rela_path_map[p2]
          result_fail_data[rela_path] = md5
        end
      end
      if cb then
        cb(false, code, msg, result_succ_data, result_fail_data)
      end
    end
  end, base_path)
end

function M.batch_info(file_list, cb, opts)
  file_list = file_list or {}
  local size = #file_list
  if 0 == size then
    cb(true, {})
    return
  end
  opts = opts or {}
  local fullpath_list = file_list
  local is_full_path = opts.is_full_path
  if not is_full_path and (not opts.base_path or opts.base_path == "") then
    opts.base_path = E.Path.get_ext_file_dir()
  end
  E.File.process_batch_info(fullpath_list, function(succ_data)
    succ_data = succ_data or {}
    local result_data = succ_data
    if cb then
      cb(result_data)
    end
  end, opts)
end

function M.is_directory(file_path, is_full_path)
  if not file_path or "" == file_path then
    return false, CC.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is nil"
  end
  local abs_path
  if not is_full_path then
    abs_path = to_fullpath(file_path)
  else
    abs_path = file_path
  end
  do return E.File.process_is_directory end
  return E.File.process_is_directory, abs_path
end

function M.is_directory_fullpath(file_path)
  if not file_path or "" == file_path then
    return false, CC.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is nil"
  end
  do return E.File.process_is_directory end
  return E.File.process_is_directory, file_path, "path is nil"
end

function M.list_directory(dir_path, recursive, is_full_path, cb)
  if not dir_path or "" == dir_path then
    return nil, CC.EJOY_LIB_ERROR.PARAMETER_INVALID, "path is nil"
  end
  local abs_path
  if not is_full_path then
    abs_path = to_fullpath(dir_path)
  else
    abs_path = dir_path
  end
  E.File.process_list_directory(abs_path, recursive, cb)
end

function M.list_bundle(bundle_dir_path, recursive, cb)
  E.File.process_list_bundle(bundle_dir_path, recursive, cb)
end

return M

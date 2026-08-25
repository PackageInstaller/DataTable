local E = require("ejoysdk_lua.ejoysdk")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "harmonyos#utils"

function M.unzip(src_full_path, dst_dir_full_path, cb)
  local exists = E.File.exists_fullpath(dst_dir_full_path)
  local result = true
  if not exists then
    E.LOG.warn(TAG, "unzip dst dir not exists:" .. tostring(dst_dir_full_path))
    result = E.File.make_dirs(dst_dir_full_path)
  end
  if not result then
    E.LOG.warn(TAG, "unzip dst dir create failed:" .. tostring(dst_dir_full_path))
    cb(false, EC.BASE_API_COMMON_ERROR.CODE_INVALID_PARAMETER, "unzip dst dir create failed")
    return
  end
  local zip_exists = E.File.exists_fullpath(src_full_path)
  if not zip_exists then
    E.LOG.warn(TAG, "unzip zip file not exists:" .. tostring(src_full_path))
    cb(false, EC.EJOY_LIB_ERROR.FILE_NOT_EXISTS, "zip file not exists")
    return
  end
  local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
  local zlib = lunate.import("@ohos.zlib")
  local err_msg
  local succ, promise = COMPAT.xpcall(zlib.decompressFile, function(err)
    err_msg = tostring(err)
  end, src_full_path, dst_dir_full_path)
  if not succ then
    E.LOG.warn(TAG, "decompressFile failed")
    cb(false, EC.EJOY_LIB_ERROR.ZIP_FILE_UNZIP_FAILED, err_msg)
  else
    promise:Then(function()
      E.LOG.debug(TAG, "unzip succ, src:" .. tostring(src_full_path) .. ", dst:" .. tostring(dst_dir_full_path))
      cb(true)
    end)
  end
end

_ejoysdk.register_ejoysdk_vm_func("unzip", function(cb, src_full_path, dst_dir_full_path)
  E.open_log(true)
  E.LOG.debug(TAG, "unzip received, src:" .. tostring(src_full_path) .. ", dst:" .. tostring(dst_dir_full_path))
  M.unzip(src_full_path, dst_dir_full_path, cb)
end)
return M

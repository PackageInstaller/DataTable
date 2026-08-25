local E = require("ejoysdk_lua.ejoysdk")
local CONSTANTS = require("ejoysdk_lua.ejoysdk_constants")
local M = {}
local TAG = "#windows_launcher#updater_lua#"
local surfix = ".ejoyold"
if not _ejoysdk.restart_process and _ejoysdk.restart_self then
  _ejoysdk.restart_process = _ejoysdk.restart_self
end

function M.get_backup_dirs()
  local pdir = E.File.get_sys_dirs().program_dir
  do return E.File.join end
  return E.File.join, {pdir, surfix}, pdir, surfix
end

function M.update(file_list, no_need_restart)
  E.LOG.debug(TAG, "this is test from hufeng ,for test if lua new file ni update right")
  local succ, code, msg = M.install_update(file_list)
  if succ then
    if not no_need_restart then
      E.LOG.debug(TAG, "install_update finish, restart_process")
      if _ejoysdk.restart_process then
        _ejoysdk.restart_process()
      else
        E.LOG.debug(TAG, "restart_process is nil")
      end
    else
      E.LOG.debug(TAG, "no_need_restart is true, do not restart this process")
    end
  end
  return succ, code, msg
end

function M.install_update(file_list)
  if _ejoysdk.os() ~= "windows" then
    return false, CONSTANTS.WINDOWS_UPDATER.CODE_NOT_SUPPORT, "os is not support(not windows)"
  end
  E.LOG.debug(TAG, "install_update file_list=")
  E.LOG.debug(TAG, file_list)
  for from, _to in pairs(file_list) do
    if not _ejoysdk.is_file_exists(from) then
      local msg = "update file not found: " .. from
      E.LOG.debug(TAG, msg)
      return false, CONSTANTS.WINDOWS_UPDATER.CODE_NOT_EXISTS, tostring(msg)
    end
  end
  local pdir = E.File.get_sys_dirs().program_dir
  local backup = M.get_backup_dirs()
  E.File.make_dirs(backup)
  for from, to in pairs(file_list) do
    local abs_to = E.File.join({pdir, to})
    if _ejoysdk.is_file_exists(abs_to) then
      local new_name = to:gsub("\\", "_")
      local path = E.File.join({backup, new_name})
      if _ejoysdk.is_file_exists(path) then
        E.LOG.debug(TAG, "remove file first:" .. tostring(path))
        E.File.remove_fullpath(path)
      end
      E.LOG.debug(TAG, "install_update is_file_exists rename=" .. path)
      local succ, msg = E.File.rename_fullpath(abs_to, path)
      if not succ then
        local error_msg = "[backup]install_update false, msg = " .. tostring(msg) .. ", from = " .. tostring(abs_to) .. ", to = " .. tostring(path)
        _ejoysdk.log(error_msg)
        E.LOG.error(TAG, error_msg)
        return false, CONSTANTS.WINDOWS_UPDATER.CODE_RENAME_FAIL, tostring(msg)
      end
    end
    E.LOG.debug(TAG, "rename from " .. tostring(from) .. ", to = " .. tostring(abs_to))
    local dir = E.File.dirname(abs_to)
    E.File.make_dirs(dir)
    local succ, msg = E.File.rename_fullpath(from, abs_to)
    if not succ then
      local error_msg = "install_update false, msg = " .. tostring(msg) .. ", from = " .. tostring(from) .. ", to = " .. tostring(abs_to)
      _ejoysdk.log(error_msg)
      E.LOG.error(TAG, error_msg)
      return false, CONSTANTS.WINDOWS_UPDATER.CODE_RENAME_FAIL, tostring(msg)
    end
  end
  return true
end

function M.update_iterator(file_list, batch)
  if _ejoysdk.os() ~= "windows" then
    E.LOG.e("windows_updater", "os is not support(not windows)")
    return function()
    end
  end
  if _ejoysdk.restart_process == nil then
    return false, CONSTANTS.WINDOWS_UPDATER.CODE_NOT_SUPPORT, "windows sdk is lower"
  end
  local itr, v
  return function()
    local batch_file_list = {}
    local count = 0
    for _i = 1, batch do
      itr, v = next(file_list, itr)
      if nil == itr then
        local succ, code, msg = M.install_update(batch_file_list)
        if succ then
          E.log("install_update finish, restart_process")
          if _ejoysdk.restart_process then
            _ejoysdk.restart_process()
          end
          return succ, count
        end
        return succ, code, msg
      end
      batch_file_list[itr] = v
      count = count + 1
    end
    local succ, code, msg = M.install_update(batch_file_list)
    if succ then
      return succ, count
    end
    return succ, code, msg
  end
end

function M.cleanup()
  if _ejoysdk.os() ~= "windows" then
    return false, CONSTANTS.WINDOWS_UPDATER.CODE_NOT_SUPPORT, "os is not support(not windows)"
  end
  if _ejoysdk.listdir == nil or nil == _ejoysdk.restart_process then
    return false, CONSTANTS.WINDOWS_UPDATER.CODE_NOT_SUPPORT, "windows sdk is lower, ignore"
  end
  local dir = M.get_backup_dirs()
  local files = _ejoysdk.listdir(dir .. E.File.sep .. "*")
  E.LOG.debug(TAG, "[begin]cleanup dir" .. dir .. "files=")
  E.LOG.debug(TAG, files)
  for _, v in ipairs(files) do
    local abs_path = E.File.join({dir, v})
    E.LOG.debug(TAG, "remove_fullpath, path = " .. abs_path)
    E.File.remove_fullpath(abs_path)
  end
  E.LOG.debug(TAG, "[end]cleanup dir" .. dir)
  return true
end

function M.cleanup_backup_dir()
  local backupPath = M.get_backup_dirs()
  E.LOG.debug(TAG, "ready to remove .ejoyold directory!!!")
  E.LOG.debug(TAG, {backupPath = backupPath})
  E.File.process_remove(backupPath)
  return true
end

return M

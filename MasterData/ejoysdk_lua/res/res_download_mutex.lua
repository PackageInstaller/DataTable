local E = require("ejoysdk_lua.ejoysdk")
local winmutex = require("ejoysdk_lua.windows_launcher.winmutex_simple")
local M = {}
local TAG = "ResDownloadMutex"
M.MUTEX_NAME = "EJOYSDK_RES_DOWNLOAD_MUTEX"
local mutex_handle
local lock_ref_count = 0

function M.clean()
  mutex_handle = nil
  lock_ref_count = 0
end

function M.is_holding_lock()
  return nil ~= mutex_handle and lock_ref_count > 0
end

function M.get_lock_ref_count()
  return lock_ref_count
end

function M.try_acquire_download_lock()
  if _ejoysdk.os() ~= "windows" or not winmutex.is_support() then
    return true, nil
  end
  if mutex_handle then
    lock_ref_count = lock_ref_count + 1
    E.LOG.debug(TAG, "already holding the download lock, ref_count: " .. lock_ref_count)
    return true, "already_holding"
  end
  local handle, status = winmutex.create(M.MUTEX_NAME, true)
  if not handle then
    E.LOG.error(TAG, "create mutex failed: " .. tostring(status))
    return false, "error"
  end
  if "opened" == status then
    E.LOG.debug(TAG, "mutex already exists, trying to acquire lock")
    local lock_ok, lock_status = handle:lock(0)
    if not lock_ok or "timeout" == lock_status then
      E.LOG.debug(TAG, "failed to acquire lock, another process is downloading")
      return false, "locked"
    end
    if "abandoned" == lock_status then
      E.LOG.warn(TAG, "acquired abandoned mutex, previous process may have crashed, releasing lock")
      winmutex.unlock(handle)
      return false, "locked"
    end
    E.LOG.debug(TAG, "acquired existing mutex, lock_status: " .. tostring(lock_status))
  end
  mutex_handle = handle
  lock_ref_count = 1
  E.LOG.debug(TAG, "download lock acquired, ref_count: " .. lock_ref_count)
  return true, nil
end

function M.release_download_lock()
  if not mutex_handle then
    E.LOG.warn(TAG, "release lock failed: not holding any lock")
    return
  end
  lock_ref_count = lock_ref_count - 1
  if lock_ref_count > 0 then
    E.LOG.debug(TAG, "lock ref_count decreased to " .. lock_ref_count .. ", not releasing yet")
    return
  end
  if winmutex then
    local ok, err = winmutex.unlock(mutex_handle)
    if ok then
      E.LOG.debug(TAG, "download lock released (ref_count=0)")
    else
      E.LOG.error(TAG, "release lock failed: " .. tostring(err))
    end
  end
  mutex_handle = nil
  lock_ref_count = 0
end

return M

local E = require("ejoysdk_lua.ejoysdk")
local EVM = require("ejoysdk_lua.harmonyos.ejoysdk_vm_func")
local jf = lunate.js_functions
local TAG = "harmonyos#hpatchz"
local M = {}
local _cb_id = math.random(1000, 9999)
local VENDOR_NAME = "HPATCHZ"
local ACTION_TYPES = {
  PATCH_DIR = "PATCH_DIR",
  PATCH_FILES = "PATCH_FILES"
}
local m_hpatchz_vendor

local function register_patch_listener(cbid, progress_cb)
  if not m_hpatchz_vendor then
    m_hpatchz_vendor = jf.EjoySDK():getProxy(VENDOR_NAME)
  end
  m_hpatchz_vendor.registerPatchListener(cbid, {
    on_progress_changed = function(completeCount, total_count)
      E.LOG.debug(TAG, "on_progress_changed completeCount:" .. tostring(completeCount) .. ", total_count:" .. tostring(total_count) .. ", cbid:" .. tostring(cbid))
      if progress_cb then
        progress_cb(completeCount, total_count)
      end
    end
  })
end

local function unregister_patch_listener(cbid)
  if not m_hpatchz_vendor then
    m_hpatchz_vendor = jf.EjoySDK():getProxy(VENDOR_NAME)
  end
  m_hpatchz_vendor.unRegisterPatchListener(cbid)
end

local function async_call(type, params, cb, progress_cb)
  local id = _cb_id
  _cb_id = _cb_id + 1
  register_patch_listener(id, progress_cb)
  params = params or {}
  params._cbid = id
  EVM.async_call(VENDOR_NAME, type, params, nil, function(succ, ...)
    unregister_patch_listener(id)
    if succ then
      local resp = (...)
      E.LOG.debug(TAG, "patch succ")
      cb(true, resp)
    else
      local code, resp = ...
      E.LOG.warn(TAG, "patch failed, code:" .. tostring(code))
      cb(false, code, "patch failed", resp)
    end
  end)
end

function M.patch_dir(params, cb, progress_cb)
  E.LOG.debug(TAG, "patch_dir received in ejoy vm")
  async_call(ACTION_TYPES.PATCH_DIR, params, cb, progress_cb)
end

function M.patch_files(params, cb, progress_cb)
  async_call(ACTION_TYPES.PATCH_FILES, params, function(succ, ...)
    if succ then
      E.LOG.debug(TAG, "patch_files succ")
      cb(true)
    else
      local code, _msg, resp = ...
      E.LOG.warn(TAG, "patch_files failed, ret:" .. tostring(code))
      cb(false, code, resp.patch_succ_files, resp.patch_fail_files)
    end
  end, progress_cb)
end

return M

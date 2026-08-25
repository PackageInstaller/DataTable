local E = require("ejoysdk_lua.ejoysdk")
local ODR = require("ejoysdk_lua.vendors.odr")
local STATE = require("ejoysdk_lua.odr.state_util")
local SPEED = require("ejoysdk_lua.odr.speed_util")
local STAT = require("ejoysdk_lua.odr.demand_stat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.ODR .. "odr_manager"
local M = {}
local request_progress_observers = {}
local request_error_handlers = {}
local request_succ_handlers = {}

local function res_loaded_cb(tag)
  STAT.stat_action(STAT.EVENT.ODR_REQUEST_TAG_SUCCESS, tag)
  STATE.set_state(tag, STATE.TAG_STATE.AVAILABLE)
  for id, cb in ipairs(request_progress_observers) do
    if id == tag then
      cb(tag, 1)
    end
  end
  for id, handler in pairs(request_succ_handlers) do
    if id == tag then
      E.LOG.debug(TAG, "call back success >> " .. tostring(tag))
      handler(tag)
      request_succ_handlers[id] = nil
      request_progress_observers[id] = nil
      break
    end
  end
end

local function load_progress_cb(tag, progress, timestamp)
  E.LOG.debug(TAG, "on progress callback >> tag " .. tostring(tag))
  SPEED.load_progress(tag, progress, timestamp)
  STAT.stat_download_progress(tag, progress)
  for _, cb in ipairs(request_progress_observers) do
    cb(tag, progress)
  end
end

local function error_handler(...)
  local tag, code, message = ...
  STAT.stat_error(STAT.EVENT.ODR_REQUEST_TAG_ERROR, tag, code, message)
  for _, handler in ipairs(request_error_handlers) do
    handler(...)
  end
end

local function register_callbacks()
  ODR.register_loaded_cb(res_loaded_cb)
  ODR.register_progress_cb(load_progress_cb)
  ODR.register_error_handler(error_handler)
end

function M.init()
  register_callbacks()
end

function M.request_res(tag, size, cb)
  E.LOG.debug(TAG, "request tag >> " .. tostring(tag))
  ODR.load_res(tag)
  STAT.stat_action(STAT.EVENT.ODR_START_REQUEST_TAG, tag)
  request_succ_handlers[tag] = cb
  STATE.set_state(tag, STATE.TAG_STATE.DOWNLOADING)
  if size and 0 ~= size then
    SPEED.add_request(tag, size)
  end
end

function M.set_load_priority(tag, priority)
  STAT.stat_action(STAT.EVENT.ODR_SET_DOWNLOAD_PRIORITY, tag, priority)
  ODR.set_priority(tag, priority)
end

function M.register_progress_observer(observer)
  for _, ob in ipairs(request_progress_observers) do
    if ob == observer then
      return
    end
  end
  table.insert(request_progress_observers, observer)
end

function M.register_error_handler(handler)
  for _, h in ipairs(request_error_handlers) do
    if h == handler then
      return
    end
  end
  table.insert(request_error_handlers, handler)
end

function M.register_download_speed_changed(listener)
  SPEED.register_download_speed_listener(listener)
end

function M.check_res_available(tags, cb)
  ODR.check_whether_tags_available(tags, function(available)
    if cb then
      cb(available)
    end
  end)
end

function M.access_res(tag, cb)
  STAT.stat_action(STAT.EVENT.ODR_ACCESS_TAG_RES, tag)
  ODR.access(tag, function(success, data)
    if success then
      E.LOG.debug(TAG, "access tag success")
    else
      local code = data.code
      local msg = data.msg
      STAT.stat_error(STAT.EVENT.ODR_ACCESS_TAG_ERROR, tag, code, msg)
      E.LOG.warn(TAG, "access tag failed, code >> " .. tostring(code) .. ", msg >> " .. tostring(msg))
    end
    if cb then
      cb(success, data)
    end
  end)
end

function M.end_access_res(tag)
  ODR.end_access(tag)
  STAT.stat_action(STAT.EVENT.ODR_END_ACCESS_TAG_RES, tag)
end

function M.pause_download(tag)
  ODR.pause_download(tag)
  STAT.stat_action(STAT.EVENT.ODR_PAUSE_REQUEST_TAG, tag)
end

function M.cancel_download(tag)
  ODR.cancel_download(tag)
  STAT.stat_action(STAT.EVENT.ODR_CANCEL_REQUEST_TAG, tag)
  SPEED.remove_request(tag)
end

function M.resume_download(tag)
  ODR.resume_download(tag)
  STAT.stat_action(STAT.EVENT.ODR_RESUME_REQUEST_TAG, tag)
end

function M.test_check_res(file, type)
  ODR.test_check_res(file, type)
end

return M

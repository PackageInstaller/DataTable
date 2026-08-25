local E = require("ejoysdk_lua.ejoysdk")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local EM = require("ejoysdk_lua.ejoysdk_module")
local VENDOR_NAME = "EJOY_ODR"
local M = Vendor:Inherit(VENDOR_NAME)
local TAG = EM.MODULE.VENDORS.ODR
local ASYNC_ODR_TAGS_AVAILABLE = "ASYNC_ODR_TAGS_AVAILABLE"
local ASYNC_ODR_ACCESS_TAG = "ASYNC_ODR_ACCESS_TAG"
local SYNC_ODR_REQUEST_TAGS = "SYNC_ODR_REQUEST_TAGS"
local SYNC_ODR_SET_PRIORITY = "SYNC_ODR_SET_PRIORITY"
local SYNC_ODR_OPERATE_REQUEST = "SYNC_ODR_OPERATE_REQUEST"
local SYNC_ODR_CHECK_RES = "SYNC_ODR_CHECK_RES"
local ODR_EVENT = {
  EVT_ON_NOTIFY_LOAD_PROGRESS = "EVT_ON_NOTIFY_LOAD_PROGRESS",
  EVT_ON_NOTIFY_LOAD_SUCC = "EVT_ON_NOTIFY_LOAD_SUCC",
  EVT_ON_NOTIFY_LOW_SPACE = "EVT_ON_NOTIFY_LOW_SPACE",
  EVT_ON_NOTIFY_ERROR = "EVT_ON_NOTIFY_ERROR"
}
M.OPERATE = {
  OPERATE_END_ACCESS = "END_ACCESS",
  OPERATE_PAUSE_DOWNLOAD = "PAUSE_DOWNLOAD",
  OPERATE_RESUME_DOWNLOAD = "RESUME_DOWNLOAD",
  OPERATE_CANCEL_DOWNLOAD = "CANCEL_DOWNLOAD"
}
local request_loaded_cb = {}
local request_progress_cb = {}
local error_handlers = {}
local odr_inited = false

local function notify_wrap(tag, progress, timeStamp)
  for _, cb in ipairs(request_progress_cb) do
    cb(tag, progress, timeStamp)
  end
end

local EVT_HANDLERS = {}
EVT_HANDLERS[ODR_EVENT.EVT_ON_NOTIFY_LOAD_PROGRESS] = function(body)
  E.LOG.debug(TAG, "receive load progress msg")
  if body then
    local tag = body.tag
    local progress = body.progress
    local timeStamp = body.timestamp
    E.LOG.debug(TAG, "tag >> " .. tostring(tag) .. " and progress >> " .. tostring(progress) .. ", timeStamp >> " .. tostring(timeStamp))
    if 1 == progress then
      local tags = {tag}
      M.check_whether_tags_available(tags, function(available)
        E.LOG.debug(TAG, "tag >> " .. tostring(tag) .. " available >> " .. tostring(available))
        if available then
          notify_wrap(tag, progress, timeStamp)
        end
      end)
    else
      notify_wrap(tag, progress, timeStamp)
    end
  end
end
EVT_HANDLERS[ODR_EVENT.EVT_ON_NOTIFY_LOAD_SUCC] = function(body)
  E.LOG.debug(TAG, "receive load success msg")
  if body then
    local tag = body.tag
    E.LOG.debug(TAG, "tag >> " .. tostring(tag))
    for _, cb in ipairs(request_loaded_cb) do
      cb(tag)
    end
  end
end
EVT_HANDLERS[ODR_EVENT.EVT_ON_NOTIFY_LOW_SPACE] = function(_body)
  E.LOG.debug(TAG, "low space warn!")
  local tag
  local code = -1
  local message = "设备存储空间不足"
  if error_handlers then
    for _, handler in ipairs(error_handlers) do
      handler(tag, code, message)
    end
  end
end
EVT_HANDLERS[ODR_EVENT.EVT_ON_NOTIFY_ERROR] = function(body)
  E.LOG.debug(TAG, "notify error >> " .. tostring(body))
  if body then
    local tag = body.tag
    local code = body.code
    local message = body.message
    E.LOG.debug(TAG, "tag >> " .. tostring(tag) .. ", code >> " .. tostring(code) .. ", message >> " .. tostring(message))
    if error_handlers then
      for _, handler in ipairs(error_handlers) do
        handler(tag, code, message)
      end
    end
  end
end

local function generate_operate_params(tag, operate)
  return {tag = tag, operate = operate}
end

function M.init(_opt, cb)
  E.LOG.debug(TAG, "odr init method invoke is_inited >> " .. tostring(odr_inited))
  if odr_inited then
    return
  end
  odr_inited = true
  UNI.register_event_cb(VENDOR_NAME, function(type, body_data)
    if not type or "" == type then
      E.LOG.debug(TAG, "type is invalid")
      return
    end
    local handler = EVT_HANDLERS[type]
    if handler then
      E.LOG.debug(TAG, "handled event with type:" .. (type or "nil"))
      handler(body_data)
    end
  end)
  if cb then
    cb(true)
  end
end

function M.load_res(tag)
  E.LOG.debug(TAG, "start load res >> " .. tostring(tag))
  local data = {tag = tag}
  local ret = UNI.sync_call(VENDOR_NAME, SYNC_ODR_REQUEST_TAGS, data, nil)
  if ret and ret.value then
    E.LOG.debug(TAG, "request tag, ret >> " .. tostring(ret))
  end
end

function M.set_priority(tag, priority)
  if priority > 1 then
    priority = 1
  end
  if priority < 0 then
    priority = 0
  end
  local params = {tag = tag, priority = priority}
  UNI.sync_call(VENDOR_NAME, SYNC_ODR_SET_PRIORITY, params, nil)
end

function M.check_whether_tags_available(tags, cb)
  E.LOG.debug(TAG, "check whether tags available >> ")
  E.LOG.debug(TAG, tags)
  UNI.async_call(VENDOR_NAME, ASYNC_ODR_TAGS_AVAILABLE, tags, nil, function(succ, data)
    if succ and data then
      E.LOG.debug(TAG, "check whether tags available, ret >> ")
      E.LOG.debug(TAG, data)
      local available = data.available
      if cb then
        cb(available)
      end
    else
      cb(false)
    end
  end)
end

function M.register_progress_cb(callback)
  for _, cb in ipairs(request_progress_cb) do
    if cb == callback then
      return
    end
  end
  table.insert(request_progress_cb, callback)
end

function M.register_loaded_cb(callback)
  for _, cb in ipairs(request_loaded_cb) do
    if cb == callback then
      return
    end
  end
  table.insert(request_loaded_cb, callback)
end

function M.register_error_handler(handler)
  for _, h in ipairs(error_handlers) do
    if h == handler then
      return
    end
  end
  table.insert(error_handlers, handler)
end

function M.pause_download(tag)
  local params = generate_operate_params(tag, M.OPERATE.OPERATE_PAUSE_DOWNLOAD)
  UNI.sync_call(VENDOR_NAME, SYNC_ODR_OPERATE_REQUEST, params, nil)
end

function M.resume_download(tag)
  local params = generate_operate_params(tag, M.OPERATE.OPERATE_RESUME_DOWNLOAD)
  UNI.sync_call(VENDOR_NAME, SYNC_ODR_OPERATE_REQUEST, params, nil)
end

function M.cancel_download(tag)
  local params = generate_operate_params(tag, M.OPERATE.OPERATE_CANCEL_DOWNLOAD)
  UNI.sync_call(VENDOR_NAME, SYNC_ODR_OPERATE_REQUEST, params, nil)
end

function M.end_access(tag)
  local params = generate_operate_params(tag, M.OPERATE.OPERATE_END_ACCESS)
  UNI.sync_call(VENDOR_NAME, SYNC_ODR_OPERATE_REQUEST, params, nil)
end

function M.access(tag, cb)
  if tag then
    E.LOG.debug(TAG, "access tag >> " .. tostring(tag))
    local params = {tag = tag}
    UNI.async_call(VENDOR_NAME, ASYNC_ODR_ACCESS_TAG, params, nil, function(succ, data)
      if succ then
        E.LOG.debug(TAG, "tag access success >> " .. tostring(tag))
        if cb then
          cb(succ)
        end
      else
        cb(false, data)
      end
    end)
  else
    E.LOG.debug(TAG, "tag is nil, do nothing")
  end
end

function M.test_check_res(file, type)
  E.LOG.debug(TAG, "test check res, file >> " .. tostring(file) .. ", type >> " .. tostring(type))
  local params = {file = file, type = type}
  UNI.sync_call(VENDOR_NAME, SYNC_ODR_CHECK_RES, params, nil)
end

return M

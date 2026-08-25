local E = require("ejoysdk_lua.ejoysdk")
local LOGGER = "apm_store"
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local EjoysdkUtils = require("ejoysdk_lua.apm-sdk-lua.common.ejoysdk_utils")
local store = require("ejoysdk_lua.apm-sdk-lua.store.store_mem")
local CollectFilter = require("ejoysdk_lua.apm-sdk-lua.common.collect_filter")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local has_initialized = false
local M = {}
M.__index = M
local __store_type = Global.StoreTypeEnum.FILE

local function init_store()
  if EjoysdkUtils.use_file_store() then
    store = require("ejoysdk_lua.apm-sdk-lua.store.store_file")
    __store_type = Global.StoreTypeEnum.FILE
    E.LOG.debug(LOGGER, "use file store...")
  else
    store = require("ejoysdk_lua.apm-sdk-lua.store.store_mem")
    __store_type = Global.StoreTypeEnum.MEM
    E.LOG.debug(LOGGER, "use mem store...")
  end
  store.init()
  E.LOG.debug(LOGGER, "store init done, store_type:" .. tostring(__store_type))
end

local function handle_config_update(key, value)
  if "store_type" == key then
    E.LOG.debug(LOGGER, "re-initializing store with new config, value: " .. tostring(value))
    init_store()
  end
end

function M.init()
  init_store()
  has_initialized = true
  Cfg.set_update_callback(Cfg.CATEGORY_STORE, handle_config_update)
end

function M.set_report_by_bufsize_fn(report_by_bufsize_fn)
  store.set_report_by_bufsize_fn(report_by_bufsize_fn)
end

function M.retrieve_data(dtype)
  do return store.retrieve_data end
  return store.retrieve_data, dtype
end

function M.submit_stats(stats)
  assert(type(stats) == "table", "params#1 stats should be a table")
  do return store.submit_stats end
  return store.submit_stats, stats, "params#1 stats should be a table"
end

function M.submit_event(event)
  assert(type(event) == "table", "params#1 event should be a table")
  if not has_initialized then
    return
  end
  if CollectFilter.is_in_event_blacklist(event.event_name) then
    return
  end
  do return store.submit_event end
  return store.submit_event, event, "params#1 event should be a table"
end

function M.submit_log(log)
  assert(type(log) == "table", "params#1 log should be a table")
  do return store.submit_log end
  return store.submit_log, log, "params#1 log should be a table"
end

function M.submit_trace(span)
  assert(type(span) == "table", "params#1 span should be a table")
  if not has_initialized then
    return
  end
  do return store.submit_trace end
  return store.submit_trace, span, "params#1 span should be a table"
end

function M.get_store_type()
  return __store_type
end

return M

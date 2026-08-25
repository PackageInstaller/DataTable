local E = require("ejoysdk_lua.ejoysdk")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local JSON = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local LOGGER = "apm_store_file"
local _prefix_stat = "S"
local _prefix_trace = "T"
local _prefix_event_stats = "Q"
local _prefix_event_logs = "P"
local M = {}
M.__index = M

function M.init()
  E.LOG.debug(LOGGER, "file store init...")
end

local nano_time_counter = 0

local function cvt_to_time_unix_nano(timeMill)
  nano_time_counter = nano_time_counter + 1
  if nano_time_counter >= 1.0E7 then
    nano_time_counter = 1
  end
  do return string.format, "%s%06d", (tostring(timeMill)) end
  return string.format, "%s%06d", tostring(timeMill), nano_time_counter
end

local function save_to_file(dtype, data, attr, prefix)
  local obj = {
    name = dtype,
    body = data,
    attributes = attr,
    timeUnixNano = cvt_to_time_unix_nano(Time.now_ms())
  }
  local msg = JSON.encode(obj)
  E.LOG.debug(LOGGER, "save_to_file:" .. msg)
  E.LOG.debug(LOGGER, "dtype:" .. tostring(dtype))
  local log = {
    e = dtype,
    m = msg,
    ti = Time.now_ms(),
    tn = obj.timeUnixNano,
    lv = "error"
  }
  E.LOG.save_with_prefix(log, prefix)
end

function M.set_report_by_bufsize_fn(report_by_bufsize_fn)
  E.LOG.debug(LOGGER, "file store set_report_by_bufsize_fn..." .. tostring(report_by_bufsize_fn))
end

function M.retrieve_data(dtype)
  E.LOG.debug(LOGGER, "retrieve_data" .. tostring(dtype))
end

function M.submit_stats(stats)
  E.LOG.debug(LOGGER, "submit_stats..." .. Utils.table_tostring(stats))
  save_to_file(Global.DataCgrEnum.APM_STATS, stats, Labeler.get_attributes(), _prefix_stat)
end

function M.submit_event(event)
  local attr = Labeler.get_attributes()
  if event.labels then
    attr = Utils.merge_table(attr, event.labels, false)
  end
  attr.event_name = event.event_name
  save_to_file(Global.DataCgrEnum.APM_EVENT_STATS, event.stats, attr, _prefix_event_stats)
  if event.msg ~= nil then
    local log = {
      event_name = event.event_name,
      trace_id = event.trace_id,
      message = event.msg,
      stats = event.stats
    }
    save_to_file(Global.DataCgrEnum.APM_EVENT_LOG, log, attr, _prefix_event_logs)
  end
end

local log_to_file_fns = {
  [Global.LogLevelEnum.DEBUG] = E.LOG.debugt,
  [Global.LogLevelEnum.INFO] = E.LOG.infot,
  [Global.LogLevelEnum.WARNING] = E.LOG.warnt,
  [Global.LogLevelEnum.ERROR] = E.LOG.errort,
  [Global.LogLevelEnum.CRITICAL] = E.LOG.errort
}

function M.submit_log(log)
  if log.level == nil then
    save_to_file(Global.DataCgrEnum.APM_EVENT_LOG, log, Labeler.get_attributes(), _prefix_event_logs)
    return
  end
  local ti = Time.now_ms()
  if log.o_timestamp then
    ti = log.o_timestamp * 1000
  end
  local _log = {
    e = log.event_name,
    m = log.message,
    ln = log.line,
    ti = math.floor(ti),
    tn = cvt_to_time_unix_nano(ti),
    mo = log.module,
    tags = log.tags,
    args = log.args,
    lv = log.level
  }
  E.LOG.debug(LOGGER, "submit_log..." .. Utils.table_tostring(log))
  E.LOG.debug(LOGGER, "submit_log..." .. Utils.table_tostring(_log))
  local log_to_file_fn = log_to_file_fns[log.o_level] or E.LOG.debugt
  if type(E.LOG.ignore_level) == "function" then
    log_to_file_fn = E.LOG.ignore_level
  end
  log_to_file_fn(_log)
end

function M.submit_trace(span)
  save_to_file(Global.DataCgrEnum.APM_SPAN, span, Labeler.get_attributes(), _prefix_trace)
end

return M

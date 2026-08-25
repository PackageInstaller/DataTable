local E = require("ejoysdk_lua.ejoysdk")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local apm_stats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local Store = require("ejoysdk_lua.apm-sdk-lua.store.store")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local ErrUtils = require("ejoysdk_lua.apm-sdk-lua.common.err_utils")
local ELOG = require("ejoysdk_lua.ejoysdk_log_file")
local CFG_INTERVAL = "report_interval"
local CFG_SERVER = "ingester_server"
local CFG_SERVER_FORMAL_DOMAIN = "formal_domain"
local CFG_SERVER_TEST_DOMAIN = "test_domain"
local CFG_SERVER_IS_FORMAL_ENV = "is_formal_env"
local CFG_SKIP_AUTH = "skip_auth"
local CFG_TRANSPORT = "transport"
local STATS_TYPE = Global.DataTypeEnum.STATS_TYPE
local EVENT_TYPE = Global.DataTypeEnum.EVENT_TYPE
local LOG_TYPE = Global.DataTypeEnum.LOG_TYPE
local TRACE_TYPE = Global.DataTypeEnum.TRACE_TYPE
local FILE_TYPE = Global.DataTypeEnum.FILE_TYPE
local stopping = true
local skip_auth = false
local reporter_cost = apm_stats:new_counter("reporter_cost_ms")
local report_times = apm_stats:new_counter("report_times")
local encapsulate_cost = apm_stats:new_counter("encapsulate_cost_ms")
local http_post_cost = apm_stats:new_counter("http_post_cost_ms")
local file_reort_cost = apm_stats:new_counter("file_reort_cost_ms")
local LOGGER = "apm_reporter"
local Reporter = {
  __name = "Reporter",
  data_type = 0,
  ingester_url = "",
  type_name = "",
  api_name = "",
  report_size_counter = nil,
  report_failure_counter = nil,
  encapsulate_func = nil
}
Reporter.__index = Reporter
local reporter_full_list = {}

function Reporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  if nil ~= reporter_full_list[data_type] then
    E.LOG.error(LOGGER, "data_type already exists: " .. data_type)
    return nil
  end
  local obj = {
    data_type = data_type,
    type_name = type_name,
    api_name = api_name,
    report_size_counter = report_size_counter,
    report_failure_counter = report_failure_counter,
    encapsulate_func = nil
  }
  local result = setmetatable(obj, Reporter)
  reporter_full_list[data_type] = result
  return result
end

function Reporter:set_encapsulate_func(encapsulate_func)
  self.encapsulate_func = encapsulate_func
end

function Reporter:set_ingester_url(ingester_server, env)
  self.ingester_url = string.format("%s/%s%s", ingester_server, env, self.api_name)
end

local function should_send()
  local token = Labeler.get_resource("token") or ""
  if "" == token and not skip_auth then
    return false
  end
  return true
end

function Reporter:send(data, cb)
  if not should_send() then
    E.LOG.error(LOGGER, "token unset,won't send")
    return
  end
  if not data then
    E.LOG.error(LOGGER, "data is nil,won't send")
    return
  end
  local url = self.ingester_url
  local log_module = LOGGER .. "," .. self.type_name
  if nil == cb then
    function cb(resp)
      if not resp then
        self.report_failure_counter:inc(1)
        
        return
      end
      local status = tostring(resp.status)
      E.LOG.debug(log_module, "url=" .. url .. ", status=" .. status)
      if resp.status ~= 200 then
        self.report_failure_counter:inc(1)
        E.LOG.error(log_module, "error sending " .. self.type_name .. ",status:" .. status)
        E.LOG.error(log_module, resp.body)
      end
    end
  end
  E.HTTP.post(url, {use_gzip = true}, E.HTTP.CT_JSON, data, cb)
  self.report_size_counter:inc(#data)
end

function Reporter:report(resource)
  local data = Store.retrieve_data(self.data_type) or {}
  if #data > 0 then
    local start = Time.system_clock()
    local output = Utils.exec(self.encapsulate_func, {resource, data})
    local elapsed_encapsulate = Time.system_clock() - start
    if elapsed_encapsulate > 0 then
      encapsulate_cost:inc(elapsed_encapsulate)
    end
    self:send(output)
    local elapsed_send = Time.system_clock() - start - elapsed_encapsulate
    if elapsed_send > 0 then
      http_post_cost:inc(elapsed_send)
    end
  end
end

local StatsReporter = {
  __name = "StatsReporter"
}
setmetatable(StatsReporter, Reporter)
StatsReporter.__index = StatsReporter

function StatsReporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  local obj = Reporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, StatsReporter, report_size_counter, report_failure_counter
end

local EventReporter = {
  __name = "EventReporter"
}
setmetatable(EventReporter, Reporter)
EventReporter.__index = EventReporter

function EventReporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  local obj = Reporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, EventReporter, report_size_counter, report_failure_counter
end

local LogReporter = {
  __name = "LogReporter"
}
setmetatable(LogReporter, Reporter)
LogReporter.__index = LogReporter

function LogReporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  local obj = Reporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, LogReporter, report_size_counter, report_failure_counter
end

local TraceReporter = {
  __name = "TraceReporter"
}
setmetatable(TraceReporter, Reporter)
TraceReporter.__index = TraceReporter

function TraceReporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  local obj = Reporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, TraceReporter, report_size_counter, report_failure_counter
end

local FileReporter = {
  __name = "FileReporter",
  upload_to_server_fail_counter = 0,
  reupload_to_server_ticker = 0
}
setmetatable(FileReporter, Reporter)
FileReporter.__index = FileReporter

function FileReporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  local obj = Reporter.New(data_type, type_name, api_name, report_size_counter, report_failure_counter)
  if nil == obj then
    return nil
  end
  do return setmetatable, obj end
  return setmetatable, obj, FileReporter, report_size_counter, report_failure_counter
end

local MAX_UPLOAD_TO_SERVER_FAIL_COUNTER = 8
local MAX_REUPLOAD_TO_SERVER_TICKER = 5

local function is_file_list_valid(file_list)
  if nil == file_list then
    return false
  end
  if not file_list.data then
    return false
  end
  return true
end

local default_params = {}

function FileReporter:report(resource)
  if Store.get_store_type() ~= Global.StoreTypeEnum.FILE then
    E.LOG.debug(LOGGER, "use_file_store:false, skip file report")
    return
  end
  E.LOG.debug(LOGGER, "upload_to_server_fail_counter:" .. tostring(self.upload_to_server_fail_counter) .. ",reupload_to_server_ticker:" .. tostring(self.reupload_to_server_ticker))
  if self.upload_to_server_fail_counter >= MAX_UPLOAD_TO_SERVER_FAIL_COUNTER then
    self.reupload_to_server_ticker = self.reupload_to_server_ticker + 1
  end
  local start = Time.system_clock()
  E.get_log_file_infos(default_params, function(...)
    local file_list = (...)
    if not is_file_list_valid(file_list) then
      return
    end
    E.LOG.debug(LOGGER, "get_log_file_infos ... len:" .. tostring(#file_list.data))
    for i, file in ipairs(file_list.data) do
      E.LOG.debug(LOGGER, "get_log_file_infos ... " .. tostring(i))
      if i > 5 then
        E.LOG.debug(LOGGER, "upload max 5 files each time")
        return
      end
      local file_size = tonumber(file.sizes or 0)
      E.LOG.debug(LOGGER, "upload file_name:" .. file.file_name .. " file_path:" .. tostring(file.file_path) .. " file_size:" .. tostring(file_size))
      if file and file.file_path and file.file_name then
        self.report_size_counter:inc(file_size)
        self:upload_log_file(resource, file.file_path, file.file_name, file_size)
      else
        E.LOG.debug(LOGGER, "upload invalid params")
        self.report_failure_counter:inc(1)
      end
    end
    local elapsed = Time.system_clock() - start
    if file_reort_cost then
      file_reort_cost:inc(elapsed)
    end
  end)
end

local function file_expired(file_name)
  local file_time = tonumber(file_name)
  local elapsed = Time.now_ms() - file_time
  if file_time > 1704038400000 and elapsed > 43200000 then
    return true
  end
  return false
end

local log_dir = "ejoysdklogv1"

local function delete_file(file_name)
  local dir_file_name = string.format("%s/%s", log_dir, file_name)
  E.File.remove(dir_file_name)
end

local reported_log_files = {}
local default_opts = {delete_after_upload = true}

function FileReporter:upload_log_file(resource, file_path, file_name, file_size)
  if not file_path or not file_name then
    return
  end
  if file_expired(file_name) then
    E.LOG.warn(LOGGER, "fileExpired, ready to delete,file_name:" .. file_name)
    delete_file(file_name)
    return
  end
  if 0 == file_size then
    E.LOG.warn(LOGGER, "file_size is zero, ready to delete,file_name:" .. file_name)
    delete_file(file_name)
    return
  end
  local minimised_resource = Labeler.minimise_resource(resource)
  minimised_resource.fn = file_name
  local cached_key = file_path .. file_name
  if reported_log_files[cached_key] then
    E.LOG.warn(LOGGER, "file already successfully reported,ignore,cached_key:" .. cached_key)
    return
  end
  if self.upload_to_server_fail_counter >= MAX_UPLOAD_TO_SERVER_FAIL_COUNTER and self.reupload_to_server_ticker <= MAX_REUPLOAD_TO_SERVER_TICKER then
    E.LOG.warn(LOGGER, "upload file to server failed too frequently, ignore upload...")
    return
  end
  ELOG.upload_log_to_apus(self.ingester_url, {form_header = minimised_resource}, file_path, file_name, default_opts, function(succ, ...)
    if succ then
      reported_log_files[cached_key] = true
      E.LOG.debug(LOGGER, "upload_file_to_apus:" .. tostring(succ) .. " file_name:" .. tostring(file_name))
      self.upload_to_server_fail_counter = 0
      self.reupload_to_server_ticker = 0
    else
      local code, msg = ...
      E.LOG.warn(LOGGER, "upload_file_to_apus:" .. tostring(succ) .. ",code:" .. tostring(code) .. tostring(msg))
      self.report_failure_counter:inc(1)
      self.upload_to_server_fail_counter = self.upload_to_server_fail_counter + 1
      self.reupload_to_server_ticker = 0
    end
  end)
end

local M = {
  stats_reporter = StatsReporter.New(STATS_TYPE, "stats", "/v1/stats", apm_stats:new_counter("size_stats", true), apm_stats:new_counter("failure_stats", true)),
  event_reporter = EventReporter.New(EVENT_TYPE, "event", "/v1/events"),
  log_reporter = LogReporter.New(LOG_TYPE, "log", "/v1/logs", apm_stats:new_counter("size_log", true), apm_stats:new_counter("failure_log", true)),
  trace_reporter = TraceReporter.New(TRACE_TYPE, "trace", "/v1/traces", apm_stats:new_counter("size_trace", true), apm_stats:new_counter("failure_trace", true)),
  file_reporter = FileReporter.New(FILE_TYPE, "file", "/v1/files", apm_stats:new_counter("size_file", true), apm_stats:new_counter("failure_file", true))
}
M.__index = M

local function run()
  if not stopping then
    E.Timer.once(M.interval, run)
  end
  xpcall(M.report, ErrUtils.handle_err)
end

local handler_fns = {
  [Cfg.KEY_ENABLED] = function(value)
    if true == value and true == stopping then
      M.start()
    elseif false == value and false == stopping then
      M.stop()
    end
  end,
  [CFG_INTERVAL] = function(value)
    if type(value) == "number" then
      E.LOG.debug(LOGGER, string.format("report interval is changed from %d to %d seconds", M.interval, value))
      M.interval = value
    end
  end,
  [CFG_SERVER] = function(value)
    E.LOG.debug(LOGGER, "ingester server is changed to " .. tostring(value))
    M.set_ingester_server(value)
  end,
  [CFG_SKIP_AUTH] = function(value)
    if type(value) == "boolean" then
      E.LOG.debug(LOGGER, "skip_auth is changed to " .. tostring(value))
      skip_auth = value
    end
  end
}

local function handle_config_update(key, value)
  local handler_fn = handler_fns[key]
  if nil ~= handler_fn then
    handler_fn(value)
  else
    E.LOG.error(LOGGER, "invalid config change of report: " .. key)
  end
end

function M.init()
  ErrUtils.set_report_stopper(M.stop)
  M.set_ingester_server(Cfg.get(Cfg.CATEGORY_REPORT, CFG_SERVER))
  local interval = Cfg.get(Cfg.CATEGORY_REPORT, CFG_INTERVAL, 60)
  local transport = Cfg.get(Cfg.CATEGORY_REPORT, CFG_TRANSPORT, "http")
  M.set_encapsulator(transport)
  skip_auth = Cfg.get(Cfg.CATEGORY_REPORT, CFG_SKIP_AUTH, false)
  local enabled = Cfg.get(Cfg.CATEGORY_REPORT, Cfg.KEY_ENABLED, true)
  if enabled then
    M.start(interval)
    E.LOG.debug(LOGGER, "Reporter initialized with interval " .. tostring(M.interval))
  end
  Cfg.set_update_callback(Cfg.CATEGORY_REPORT, handle_config_update)
  Store.set_report_by_bufsize_fn(M.report_by_bufsize)
end

local function get_env()
  local env = Labeler.get_resource("env")
  if type(env) == "string" and "" ~= env then
    return env
  end
  env = E.CONFIG and E.CONFIG.get_config("product") or ""
  if nil == env or "" == env then
    env = "default"
  end
  return env
end

local function update_ingester_url(ingester_server, env)
  for _, reporter in ipairs(reporter_full_list) do
    reporter:set_ingester_url(ingester_server, env)
  end
end

function M.set_ingester_server(server_cfg)
  local env = get_env()
  if type(server_cfg) == "string" then
    update_ingester_url(server_cfg, env)
  elseif type(server_cfg) == "table" then
    local server = server_cfg[CFG_SERVER_FORMAL_DOMAIN]
    local is_formal_env = server_cfg[CFG_SERVER_IS_FORMAL_ENV]
    if not is_formal_env then
      server = server_cfg[CFG_SERVER_TEST_DOMAIN]
    end
    update_ingester_url(server, env)
  else
    E.LOG.error(LOGGER, "Error getting ingester from config:" .. tostring(server_cfg))
  end
end

function M.set_encapsulator(transport)
  if "http" == transport then
    M.encapsulator = require("ejoysdk_lua.apm-sdk-lua.reporter.otlp_http")
  else
    E.LOG.error(LOGGER, "unsupported transport " .. transport)
    return
  end
  M.stats_reporter:set_encapsulate_func(M.encapsulator.build_otlp_logs_v2)
  M.log_reporter:set_encapsulate_func(M.encapsulator.build_otlp_logs_v2)
  M.trace_reporter:set_encapsulate_func(M.encapsulator.build_otlp_spans_v2)
end

function M.start(interval)
  if nil ~= interval then
    M.interval = interval
  end
  if true == stopping then
    stopping = false
    E.Timer.once(M.interval + 1, run)
    E.LOG.debug(LOGGER, "reporter started")
  end
end

function M.stop()
  stopping = true
  E.LOG.debug(LOGGER, "reporter is stopping")
end

function M.set_interval(v)
  M.interval = v
end

function M.report_by_bufsize(dtype)
  E.LOG.debug(LOGGER, "reporter is invoked.triggered by bufsize")
  local reporter = reporter_full_list[dtype]
  if not reporter then
    E.LOG.error(LOGGER, "could not retrieve reporter,dtype:" .. tostring(dtype))
    return
  end
  local start = Time.system_clock()
  local resource = Labeler.get_resource()
  reporter:report(resource)
  local elapsed = Time.system_clock() - start
  if elapsed > 0 then
    reporter_cost:inc(elapsed)
    report_times:inc(1)
  end
end

function M.report()
  E.LOG.debug(LOGGER, "reporter is invoked.triggered by timer")
  local start = Time.system_clock()
  local resource = Labeler.get_resource()
  for _, reporter in ipairs(reporter_full_list) do
    reporter:report(resource)
  end
  local elapsed = Time.system_clock() - start
  if elapsed > 0 then
    reporter_cost:inc(elapsed)
    report_times:inc(1)
  end
end

function M.trigger_report()
  E.LOG.debug(LOGGER, "reporter is invoked.triggered by custom_call")
  xpcall(M.report, ErrUtils.handle_err)
end

return M

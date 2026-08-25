local E = require("ejoysdk_lua.ejoysdk")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local FgCfg = require("ejoysdk_lua.apm-sdk-lua.config.flamegraph_config")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local EU = require("ejoysdk_lua.apm-sdk-lua.common.ejoysdk_utils")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local HTTPUtils = require("ejoysdk_lua.apm-sdk-lua.common.http_utils")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Event = require("ejoysdk_lua.apm-sdk-lua.event.event")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local FastEvent = require("ejoysdk_lua.apm-sdk-lua.fast-event.event")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local LOGGER = "apm_flamegraph"
local M = {
  flamegraph_fn = nil,
  remove_file_fn = nil,
  enabled = true,
  max_duration = 300,
  ttl = 300000,
  max_concurrent_tasks = 10,
  ratelimiter = nil,
  retry_opts = {},
  fast_eventer = nil
}
M.__index = M
M.TaskActionModeEnum = {IMMEDIATE = 0, DEFERRED = 1}
M.FlamegraphTaskActionEnum = {
  RECEIVED = "apm.flamegraph.received",
  RENDER_BEGIN = "apm.flamegraph.render_begin",
  RENDER_END = "apm.flamegraph.render_end",
  REPORT_BEGIN = "apm.flamegraph.report_begin",
  REPORT_END = "apm.flamegraph.report_end"
}
M.StatusCodeEnum = {
  UNKOWN = -1,
  SUCC = 0,
  BAD_REQUST = 7000400,
  TOO_MANY_REQUEST = 7000429,
  INTERNAL_ERR = 7000500,
  GATEWAY_TIMEOUT = 7000504
}
local DEFAULT_MAX_DURATION = 300
local DEFAULT_SAMPLE_COUNT = 2000
local DEFAULT_MAX_SAMPLE_COUNT = 5000
local CFG_TASKS = "tasks"
local CFG_ENABLED = "enabled"
local CFG_MAX_DURATION = "max_duration"
local CFG_MAX_CONCURRENT_TASKS = "max_concurrent_tasks"
local CFG_TTL = "ttl"
local CFG_RETRY_BUDGET = "retry_budget"
local CFG_RETRY_CODE_LIST = "retry_code_list"
local task_constraint = {
  duration = {type = "number"},
  createTime = {type = "number"},
  actionMode = {type = "number"},
  actionTimestamp = {type = "number"},
  id = {type = "string"}
}
local is_running_flamegraph = false
local __event_name = "apus_flamegraph"
local trace_id = ""

local function submit_event(code, err_msg, task)
  local labels = {code = code}
  labels = Utils.merge_table(labels, task, true)
  E.LOG.debug(LOGGER, "recv an event,code:" .. tostring(code) .. " err_msg:" .. tostring(err_msg))
  Event.post(__event_name, labels, trace_id, err_msg)
end

local function get_file_server_url(extra_labels)
  local domain = Cfg.get_ingester_server()
  local env = Labeler.get_resource("env")
  if not domain or not env then
    return nil
  end
  local has_trace_type = false
  if extra_labels and type(extra_labels) == "table" and type(extra_labels.traceType) == "string" and extra_labels.traceType ~= "" then
    has_trace_type = true
  end
  if not has_trace_type then
    return tostring(domain) .. "/" .. tostring(env) .. "/v1/files/flamegraph"
  end
  return tostring(domain) .. "/" .. tostring(env) .. "/v1/files/oss"
end

local function remove_file(file_full_path)
  if file_full_path and M.remove_file_fn then
    E.LOG.debug(LOGGER, "ready to rm file:" .. file_full_path)
    M.remove_file_fn(file_full_path)
  end
end

local function generate_flamegraph_cb(task_id, is_succ, file_path, extra_labels)
  is_running_flamegraph = false
  E.LOG.debug(LOGGER, "generate_flamegraph_cb is called,is_succ:" .. tostring(is_succ))
  local task = {id = task_id}
  if not is_succ then
    local msg = "generate flamegraph file failed"
    M.report_event(task, M.FlamegraphTaskActionEnum.RENDER_END, M.StatusCodeEnum.INTERNAL_ERR, msg)
    return
  end
  local resource = Utils.merge_table(Labeler.get_resource(), extra_labels)
  resource.task_id = task_id
  
  local function upload_file_cb(succ, ...)
    if succ then
      local resp = (...)
      local resp_body = resp and resp.resp_body or ""
      E.LOG.debug(LOGGER, "resp.body:" .. tostring(resp_body))
      local oss_access_url = HTTPUtils.cal_oss_access_url(resp_body)
      E.LOG.debug(LOGGER, "upload_file succ, oss_access_url:" .. tostring(oss_access_url))
      local msg = "upload flamegraph succ"
      if nil ~= oss_access_url then
        task.url = oss_access_url
        msg = msg .. ",oss_access_url:" .. tostring(oss_access_url)
      end
      M.report_event(task, M.FlamegraphTaskActionEnum.REPORT_END, M.StatusCodeEnum.SUCC, msg)
    else
      local code, msg = ...
      M.report_event(task, M.FlamegraphTaskActionEnum.REPORT_END, code, msg)
    end
    remove_file(file_path)
  end
  
  local file_server_url = get_file_server_url(extra_labels)
  local retry_opts = E_UTILS.deepcopy(M.retry_opts)
  E.LOG.debug(LOGGER, "ready to call upload_file_to_apus,url:" .. tostring(file_server_url))
  resource.__file_name = file_path
  M.report_event(task, M.FlamegraphTaskActionEnum.REPORT_BEGIN, M.StatusCodeEnum.SUCC, "report_begin")
  EU.upload_file_to_apus(file_server_url, {form_header = resource}, file_path, retry_opts, upload_file_cb)
end

local function get_max_duration()
  local max_duration = M.max_duration
  if M.max_duration > DEFAULT_MAX_DURATION then
    max_duration = DEFAULT_MAX_DURATION
  end
  return max_duration
end

local function is_task_fields_valid(task)
  if type(task) ~= "table" or next(task) == nil then
    return false
  end
  for k, v in pairs(task_constraint) do
    local field = task[k]
    if nil == field then
      E.LOG.error(LOGGER, k .. " missed, ignore!")
      return false
    end
    if type(field) ~= v.type then
      E.LOG.error(LOGGER, k .. " mismatch type, ignore! field:" .. tostring(field))
      return false
    end
  end
  if task.duration < 0 or task.duration > get_max_duration() then
    E.LOG.error(LOGGER, "duration:" .. task.duration .. " is invalid, ignore!")
    return false
  end
  return true
end

local function exec_task_immediately(task)
  if is_running_flamegraph then
    local msg = "another flamegraph task is still running, drop this task."
    M.report_event(task, M.FlamegraphTaskActionEnum.RENDER_BEGIN, M.StatusCodeEnum.TOO_MANY_REQUEST, msg)
    return
  end
  is_running_flamegraph = true
  E.LOG.debug(LOGGER, "ready to call flamegraph generate function,taskID:" .. task.id)
  M.report_event(task, M.FlamegraphTaskActionEnum.RENDER_BEGIN, M.StatusCodeEnum.SUCC, "render_begin")
  local file_name = string.format("%s.txt", task.id)
  local ok
  if "string" == type(task.traceType) and type(task.traceType) ~= "" then
    if type(task.sampleCount) ~= "number" or task.sampleCount <= 0 then
      task.sampleCount = DEFAULT_SAMPLE_COUNT
    end
    if task.sampleCount > DEFAULT_MAX_SAMPLE_COUNT then
      task.sampleCount = DEFAULT_MAX_SAMPLE_COUNT
    end
    E.LOG.debug(LOGGER, "generate flamegraph with traceType:" .. task.traceType)
    E.LOG.debug(LOGGER, "sampleCount:" .. tostring(task.sampleCount))
    ok = M.generate_flamegraph_with_trace_type(task.id, task.duration, file_name, generate_flamegraph_cb, task.traceType, task.sampleCount)
  else
    ok = M.generate_flamegraph(task.id, task.duration, file_name, generate_flamegraph_cb)
  end
  if not ok then
    local msg = "generate flamegraph failed"
    M.report_event(task, M.FlamegraphTaskActionEnum.RENDER_END, M.StatusCodeEnum.INTERNAL_ERR, msg)
  else
    M.report_event(task, M.FlamegraphTaskActionEnum.RENDER_END, M.StatusCodeEnum.SUCC, "render_end")
  end
  
  local function update_running_flamegraph_status()
    is_running_flamegraph = false
  end
  
  E.Timer.once(task.duration, update_running_flamegraph_status)
end

local function exec_deferred_task(task)
  local function exec_task_func()
    do return exec_task_immediately end
    
    return exec_task_immediately, task
  end
  
  local interval = task.actionTimestamp - Time.now_utc()
  E.LOG.debug(LOGGER, "launch a timer to exec deferred task. interval:" .. interval .. " taskID:" .. task.id)
  E.Timer.once(interval, exec_task_func)
end

local function exec_task(task)
  E.LOG.debug(LOGGER, "ready to exec task")
  E.LOG.debug(LOGGER, task)
  if task.actionMode == M.TaskActionModeEnum.IMMEDIATE then
    do return exec_task_immediately end
    return exec_task_immediately, task, task
  end
  do return exec_deferred_task end
  return exec_deferred_task, task, task
end

local executed_tasks = {}

local function should_exec_task(task)
  if not is_task_fields_valid(task) then
    return false, "task fields is invalid"
  end
  local inflight_time = Time.now_ms() - task.createTime
  if inflight_time > M.ttl then
    return false, "task exceeds ttl"
  end
  if task.actionMode ~= M.TaskActionModeEnum.DEFERRED and task.actionMode ~= M.TaskActionModeEnum.IMMEDIATE then
    return false, "unsupported actionMode :" .. tostring(task.actionMode)
  end
  if task.actionMode == M.TaskActionModeEnum.DEFERRED and task.actionTimestamp < Time.now_utc() then
    return false, "actionTimestamp is is too early"
  end
  if executed_tasks[task.id] then
    return false, "task is already executed"
  end
  return true, ""
end

local function handle_tasks_update(cfg)
  E.LOG.debug(LOGGER, "handle_tasks_update")
  E.LOG.debug(LOGGER, cfg)
  if type(cfg) ~= "table" or next(cfg) == nil then
    local msg = "flamegraph tasks is empty"
    M.report_event({}, M.FlamegraphTaskActionEnum.RECEIVED, M.StatusCodeEnum.BAD_REQUST, msg)
    return
  end
  if #cfg > M.max_concurrent_tasks then
    local err_msg = string.format("the number[%d] of tasks exceed max_concurrent_tasks[%s]", #cfg, M.max_concurrent_tasks)
    M.report_event({}, M.FlamegraphTaskActionEnum.RECEIVED, M.StatusCodeEnum.TOO_MANY_REQUEST, err_msg)
    return
  end
  for _, task in ipairs(cfg) do
    local ok, reason = should_exec_task(task)
    if ok then
      M.report_event(task, M.FlamegraphTaskActionEnum.RECEIVED, M.StatusCodeEnum.SUCC, "received tasks")
      executed_tasks[task.id] = true
      exec_task(task)
    else
      M.report_event(task, M.FlamegraphTaskActionEnum.RECEIVED, M.StatusCodeEnum.BAD_REQUST, reason)
    end
  end
end

local function assert_greater_than(value, key, boundary)
  if type(value) == "number" and type(boundary) == "number" and boundary < value then
    E.LOG.debug(LOGGER, string.format("flamegraph_tasks.%s is changed to %.2f", key, value))
    return true
  end
  E.LOG.error(LOGGER, string.format("invalid %s ,type:%s,value:%s", key, type(value), tostring(value)))
  return false
end

local key_changes_handlers = {
  [CFG_ENABLED] = function(value)
    M.enabled = value
    E.LOG.debug(LOGGER, "flamegraph collector is " .. (value and "enabled" or "disabled"))
  end,
  [CFG_MAX_DURATION] = function(value)
    if assert_greater_than(value, CFG_MAX_DURATION, 0) then
      M.max_duration = value
    end
  end,
  [CFG_MAX_CONCURRENT_TASKS] = function(value)
    if assert_greater_than(value, CFG_MAX_CONCURRENT_TASKS, 0) then
      M.max_concurrent_tasks = value
    end
  end,
  [CFG_TTL] = function(value)
    if assert_greater_than(value, CFG_TTL, 0) then
      M.ttl = value
    end
  end,
  [CFG_TASKS] = function(value)
    if not M.enabled then
      E.LOG.warn(LOGGER, "flamegraph collector is disabled, ignore cfg update")
      return
    end
    handle_tasks_update(value)
  end,
  [CFG_RETRY_BUDGET] = function(value)
    if assert_greater_than(value, CFG_RETRY_BUDGET, 0) then
      M.retry_opts.retry_budget = value
    end
  end,
  [CFG_RETRY_CODE_LIST] = function(value)
    if type(value) == "table" then
      M.retry_opts.retry_code_list = value
    end
  end
}

local function handle_config_update(key, value)
  if type(key) ~= "string" or "" == key then
    return
  end
  local handler = key_changes_handlers[key]
  if nil ~= handler then
    handler(value)
  else
    E.LOG.warn(LOGGER, key .. " has not registered hanlder, ignored! ")
  end
end

function M.init()
  local cat = FgCfg.CATEGORY_FRAMRGRAPH_TASKS
  M.enabled = FgCfg.get(cat, CFG_ENABLED, true)
  M.max_duration = FgCfg.get(cat, CFG_MAX_DURATION, 300)
  M.max_concurrent_tasks = FgCfg.get(cat, CFG_MAX_CONCURRENT_TASKS, 10)
  M.ttl = FgCfg.get(cat, CFG_TTL, 300000)
  M.retry_opts = {
    retry_budget = FgCfg.get(cat, CFG_RETRY_BUDGET, 3),
    retry_code_list = FgCfg.get(cat, CFG_RETRY_CODE_LIST, {})
  }
  local ingester_url = Cfg.get_ingester_server()
  local err_msg
  M.fast_eventer, err_msg = FastEvent.new_eventer(ingester_url, Labeler.get_resource(), 100, 100, Global.DataCgrEnum.APM_EVENT_LOG)
  if nil ~= err_msg then
    E.LOG.error(LOGGER, "new fast_eventer err:" .. err_msg)
  else
    E.LOG.debug(LOGGER, "new fast_eventer succ")
  end
  FgCfg.set_update_callback(cat, handle_config_update)
end

function M.report_event(task, action, code, msg)
  if type(task) ~= "table" then
    task = {}
  end
  if code ~= M.StatusCodeEnum.SUCC then
    E.LOG.error(LOGGER, "report_event with error,code:" .. tostring(code) .. ",msg:" .. tostring(msg))
  else
    E.LOG.debug(LOGGER, "report_event with code:" .. tostring(code) .. ",msg:" .. tostring(msg))
  end
  if not M.fast_eventer then
    E.LOG.debug(LOGGER, "fast_eventer is nil, use default report_channel")
    task.action = action
    submit_event(code, msg, task)
    return
  end
  local labels = {code = code, action = action}
  labels = Utils.merge_table(labels, task, true)
  M.fast_eventer:post(__event_name, labels, msg)
  return
end

M.handle_config_update = handle_config_update

function M.register_flamegraph_fns(flamegraph_fn, remove_file_fn)
  local param_type = type(flamegraph_fn)
  if "function" ~= param_type then
    E.LOG.error(LOGGER, "register_flamegraph_fns failed,flamegraph_fn expects a param of function, but got a param of " .. param_type)
    return
  end
  param_type = type(remove_file_fn)
  if "function" ~= param_type then
    E.LOG.error(LOGGER, "register_flamegraph_fns failed,remove_file_fn expects a param of function, but got a param of " .. param_type)
    return
  end
  M.flamegraph_fn = flamegraph_fn
  M.remove_file_fn = remove_file_fn
end

local default_file_name = "apus_flamegraph%d.txt"
local file_name_counter = 1

local function gen_file_name(file_name)
  if type(file_name) ~= "string" or "" == file_name then
    file_name = string.format(default_file_name, file_name_counter)
    file_name_counter = file_name_counter + 1
  end
  return file_name
end

function M.check_params(task_id, duration, callback)
  if M.flamegraph_fn == nil then
    E.LOG.error(LOGGER, "generate flamegraph failed,flamegraph_fn is nil, need to register flamegraph_fns first ")
    return false
  end
  if nil == M.remove_file_fn then
    E.LOG.error(LOGGER, "generate flamegraph failed,remove_file_fn is nil, need to register flamegraph_fns first ")
    return false
  end
  if type(callback) ~= "function" then
    E.LOG.error(LOGGER, "generate flamegraph failed,callback is not a funtion ,unexpected! ")
    return false
  end
  if type(duration) ~= "number" then
    E.LOG.error(LOGGER, "generate flamegraph failed,duration is not a number ,unexpected! ")
    return false
  end
  if type(task_id) ~= "string" or "" == task_id then
    E.LOG.error(LOGGER, "task_id is invalid!")
    return false
  end
  if duration < 0 or duration > get_max_duration() then
    E.LOG.error(LOGGER, "generate flamegraph failed,duration:" .. duration .. " is unacceptable!")
    return false
  end
  return true
end

function M.generate_flamegraph(task_id, duration, file_name, callback)
  if not M.check_params(task_id, duration, callback) then
    return false
  end
  M.flamegraph_fn(task_id, duration, gen_file_name(file_name), callback)
  return true
end

function M.generate_flamegraph_with_trace_type(task_id, duration, file_name, callback, trace_type, sample_count)
  if not M.check_params(task_id, duration, callback) then
    return false
  end
  M.flamegraph_fn(task_id, duration, gen_file_name(file_name), callback, trace_type, sample_count)
  return true
end

return M

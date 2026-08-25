local M = {}
M.MetricTypeEnum = {
  NoneType = 0,
  CounterType = 1,
  GaugeType = 2,
  AggregateType = 3
}
M.LogLevelEnum = {
  DEBUG = 5,
  INFO = 4,
  WARNING = 3,
  ERROR = 2,
  CRITICAL = 1
}
M.DataTypeEnum = {
  STATS_TYPE = 1,
  EVENT_TYPE = 2,
  LOG_TYPE = 3,
  TRACE_TYPE = 4,
  FILE_TYPE = 5
}
M.DataCgrEnum = {
  APM_STATS = "apm_stats",
  API_STATS = "api_stats",
  RPC_STATS = "rpc_stats",
  UI_STATS = "ui_stats",
  COMMON_STATS = "common_stats",
  APM_EVENT_STATS = "apm_event_stats",
  APM_EVENT_LOG = "apm_event_log",
  APM_LOG = "apm_log",
  APM_SPAN = "apm_span"
}
M.AbnormalMetricNameEnum = {
  DRAW_CALL = "draw_call",
  FPS = "fps",
  JANK = "jank",
  TRI_COUNT = "tri_count",
  APP_MEM = "app_mem",
  LUA_MEM = "app_lua_mem",
  OTHER = "other"
}
M.StoreTypeEnum = {MEM = "mem", FILE = "file"}
M.OpEnum = {
  GE = 0,
  GT = 1,
  LE = 2,
  LT = 3,
  EQ = 4,
  NE = 5
}
M.HTTPStatusCodeEnum = {
  UNKOWN = -1,
  SUCC = 200,
  BAD_REQUST = 400,
  TOO_MANY_REQUEST = 429,
  INTERNAL_ERR = 500,
  BAD_GATEWAY = 502,
  SERVICE_UNAVAILABLE = 503,
  GATEWAY_TIMEOUT = 504
}
M.namespace_api_stats = "api"
M.namespace_apm_stats = "apm"
M.namespace_app_stats = "app"
M.namespace_eng_stats = "eng"
M.namespace_rpc_stats = "rpc"
M.namespace_ui_stats = "ui"
M.namespace_common_stats = "common"
M.labels_kv_concate_str = "#$#"
M.labels_kvpair_concate_str = "|"
local _is_old_unity_project = false

function M.set_is_old_unity_project(is_old_unity_project)
  if type(is_old_unity_project) == "boolean" then
    _is_old_unity_project = is_old_unity_project
  end
end

function M.is_old_unity_project()
  return _is_old_unity_project
end

local has_apus_sdk_initialized = false

function M.set_apus_sdk_initialized(apus_sdk_initialized)
  if type(apus_sdk_initialized) == "boolean" then
    has_apus_sdk_initialized = apus_sdk_initialized
  end
end

function M.is_apus_sdk_initialized()
  return has_apus_sdk_initialized
end

local _disable_debug_stack = false

function M.set_disable_debug_stack(disable_debug_stack)
  if type(disable_debug_stack) == "boolean" then
    _disable_debug_stack = disable_debug_stack
  end
end

function M.disable_debug_stack()
  return _disable_debug_stack
end

return M

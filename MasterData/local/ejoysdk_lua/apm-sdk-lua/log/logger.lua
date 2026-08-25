local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Bucket = require("ejoysdk_lua.apm-sdk-lua.log.bucket.init")
local Vconfig = require("ejoysdk_lua.apm-sdk-lua.log.vconfig")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local StringUtils = require("ejoysdk_lua.apm-sdk-lua.common.string_utils")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local assert = _ENV.assert
local error = _ENV.error
local type = _ENV.type
local pairs = _ENV.pairs
local tostring = _ENV.tostring
local getmetatable = _ENV.getmetatable
local select = _ENV.select
local setmetatable = _ENV.setmetatable
local next = _ENV.next
local sformat = string.format
local sgsub = string.gsub
local smatch = string.match
local srep = string.rep
local tconcat = table.concat
local tunpack = table.unpack or unpack
local appname = SERVICE_NAME or "app"
local DEBUG = Global.LogLevelEnum.DEBUG
local INFO = Global.LogLevelEnum.INFO
local WARNING = Global.LogLevelEnum.WARNING
local ERROR = Global.LogLevelEnum.ERROR
local CRITICAL = Global.LogLevelEnum.CRITICAL
local LOG_LEVEL = {
  DEBUG = DEBUG,
  INFO = INFO,
  WARNING = WARNING,
  ERROR = ERROR,
  CRITICAL = CRITICAL
}
local VERBOSE = {}
for i = 0, Vconfig.max_level do
  VERBOSE[i] = i
end
local stats = {
  level = {},
  traceback_cnt = 0
}
for _, l in pairs(LOG_LEVEL) do
  stats.level[l] = 0
end
local prefered_bucket, default_bucket

local function get_bucket()
  prefered_bucket = prefered_bucket or Bucket.new("cloud", "?format=text&color=false")
  if prefered_bucket then
    return prefered_bucket
  end
  default_bucket = default_bucket or Bucket.get_default()
  return default_bucket
end

local function set_bucket(bucket)
  local old = get_bucket()
  prefered_bucket = bucket
  return old
end

local supported_bucket = {
  console = true,
  file = true,
  cloud = true
}

local function get_default_bucket_list()
  default_bucket = default_bucket or Bucket.get_default()
  return {default_bucket}
end

local used_bucket_list

local function get_bucket_list()
  if used_bucket_list and next(used_bucket_list) then
    return used_bucket_list
  end
  local bucket_list_str = Cfg.get_log_bucket()
  local bucket_list = StringUtils.split(bucket_list_str, "|")
  if not next(bucket_list) then
    do return end
    return get_default_bucket_list, bucket_list, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  local custom_bucket_num = 0
  used_bucket_list = {}
  local bucket_conf = Cfg.get_log_bucket_conf()
  for _, bucket_name in ipairs(bucket_list) do
    if supported_bucket[bucket_name] then
      custom_bucket_num = custom_bucket_num + 1
      local params = bucket_conf and bucket_conf[bucket_name] or nil
      table.insert(used_bucket_list, Bucket.new(bucket_name, params))
    end
  end
  if 0 == custom_bucket_num then
    do return end
    return get_default_bucket_list, ipairs(bucket_list)
  end
  return used_bucket_list
end

local MAX_LOG_SRC_LEN = 256
local g_record = {}

local function save_to_buckets(catalog, modname, level, timestamp, src, tags, msg, values)
  local bucket_list = get_bucket_list()
  g_record.module = modname
  g_record.level = level
  g_record.timestamp = timestamp
  g_record.line = StringUtils.truncate(src, MAX_LOG_SRC_LEN)
  g_record.tags = tags
  g_record.msg = msg
  g_record.values = values
  for _, bucket in ipairs(bucket_list) do
    bucket:put(catalog, g_record)
  end
  return g_record
end

local function is_source_come_from_file(src)
  local len = #src
  if len > 1 and string.sub(src, 1, 2) == "@" then
    return true
  end
  if #src > 4 and string.sub(src, len - 4 + 1, len) == ".lua" then
    return true
  end
  return false
end

local function get_log_src(level)
  if not Cfg.should_collect_line_info() then
    return nil
  end
  local info = debug.getinfo(level + 1, "Sl")
  if nil == info then
    return nil
  end
  local src = info.source
  if not is_source_come_from_file(src) then
    return nil
  end
  do return sformat, "%s:%s", src end
  return sformat, "%s:%s", src, info.currentline
end

local function table_serialize(root)
  local cache = {}
  
  local function _dump(t, space, name)
    if cache[t] then
      return cache[t]
    end
    if "table" ~= type(t) then
      do return sformat, " [%s]", tostring(t) end
      return sformat, " [%s]", tostring(t)
    end
    local mt = getmetatable(t)
    if mt and mt.__tostring then
      do return sformat, " {%s}", tostring(t) end
      return sformat, " {%s}", tostring(t)
    end
    cache[t] = sformat(" {%s}", t == root and "." or name)
    local temp = {}
    for k, v in pairs(t) do
      local key = tostring(k)
      local next_space = sformat("%s|%s", space, srep(" ", #key))
      local next_name = sformat("%s.%s", name, key)
      temp[#temp + 1] = sformat("+%s%s", key, _dump(v, next_space, next_name))
    end
    do return tconcat, temp, sformat([[

%s]], space) end
    return tconcat, temp, sformat([[

%s]], space)
  end
  
  do return _dump, root, "" end
  return _dump, root, "", ""
end

local function simple_serialize(_, s)
  do return tostring end
  return tostring, s
end

local function strict_serialize(_, s)
  if "table" == type(s) then
    do return table_serialize end
    return table_serialize, s
  else
    do return tostring end
    return tostring, s
  end
end

local function serialize(level, s)
  if level < INFO and "table" == type(s) then
    do return table_serialize end
    return table_serialize, s
  end
  do return tostring end
  return tostring, s
end

local function simple_string_format(_, _, format, ...)
  do return sformat, format, ... end
  return sformat, format, ...
end

local function strict_string_format(seri, level, format, ...)
  local n = select("#", ...)
  local t = {
    ...
  }
  for i = 1, n do
    t[i] = seri(level, t[i])
  end
  do return sformat, format, tunpack(t, 1, n) end
  return sformat, format, tunpack(t, 1, n)
end

local function string_format(seri, level, format, ...)
  if level < INFO then
    do return strict_string_format, seri, level, format, ... end
    return strict_string_format, seri, level, format, ...
  else
    do return sformat, format, ... end
    return sformat, format, ...
  end
end

local logger = {}
logger.__index = logger
logger.DEBUG = DEBUG
logger.INFO = INFO
logger.WARNING = WARNING
logger.ERROR = ERROR
logger.CRITICAL = CRITICAL
local concat_buffer = {}

function logger:stats()
  return stats
end

local function readonly(record)
  do return setmetatable, {} end
  return setmetatable, {}, {
    __index = record,
    __newindex = error,
    __pairs = function(_)
      do return pairs end
      return pairs, record
    end
  }, function(_)
    do return pairs end
    return pairs, record
  end
end

function logger:ilog(level, ...)
  local seri = self.serialize
  local n = select("#", ...)
  for i = 1, n do
    concat_buffer[i] = seri(level, select(i, ...))
  end
  do return tconcat, concat_buffer, " ", 1 end
  return tconcat, concat_buffer, " ", 1, n, seri(level, select(i, ...)), level, select(i, ...)
end

function logger:flog(level, format, ...)
  do return self.string_format, self.serialize, level, format, ... end
  return self.string_format, self.serialize, level, format, ...
end

function logger:slog(level, structure, ...)
  local n = select("#", ...)
  local values = {
    ...
  }
  local seri = self.serialize
  for i = 1, n do
    values[i] = seri(level, values[i])
  end
  return structure, values
end

function logger:log(level, format_type, stack_depth, ...)
  if level > self.log_level then
    return
  end
  if not Global.is_apus_sdk_initialized() then
    return
  end
  stats.level[level] = stats.level[level] + 1
  local timestamp = Time.now()
  local src = self.log_src and get_log_src(self.stack_level + stack_depth)
  local modname = self.module_name or appname
  local tags = self:get_tag()
  local record = save_to_buckets("log", modname, level, timestamp, src, tags, self[format_type](self, level, ...))
  if self.callback and level <= self.callback_level then
    do return self.callback, "log" end
    return self.callback, "log", record, timestamp, src, tags, self[format_type](self, level, ...)
  end
end

function logger:manual_log(level, log_src, log_time, format_type, stack_depth, ...)
  if level > self.log_level then
    return
  end
  if not Global.is_apus_sdk_initialized() then
    return
  end
  stats.level[level] = stats.level[level] + 1
  local timestamp = log_time or Time.now()
  local src
  if self.log_src then
    src = log_src or get_log_src(self.stack_level + stack_depth)
  end
  local modname = self.module_name or appname
  local tags = self:get_tag()
  local record = save_to_buckets("log", modname, level, timestamp, src, tags, self[format_type](self, level, ...))
  if self.callback and level <= self.callback_level then
    do return self.callback, "log" end
    return self.callback, "log", record, timestamp, src, tags, self[format_type](self, level, ...)
  end
end

local ExtStackDepth = 1

function logger:ManualLog(level, log_src, log_time, ...)
  do return self.manual_log, self, level, log_src, log_time, "ilog", ExtStackDepth, ... end
  return self.manual_log, self, level, log_src, log_time, "ilog", ExtStackDepth, ...
end

function logger:ManualLogS(level, log_src, log_time, ...)
  do return self.manual_log, self, level, log_src, log_time, "slog", ExtStackDepth, ... end
  return self.manual_log, self, level, log_src, log_time, "slog", ExtStackDepth, ...
end

function logger:ManualLogf(level, log_src, log_time, ...)
  do return self.manual_log, self, level, log_src, log_time, "flog", ExtStackDepth, ... end
  return self.manual_log, self, level, log_src, log_time, "flog", ExtStackDepth, ...
end

function logger:Debug(...)
  do return self.log, self, DEBUG, "ilog", ExtStackDepth, ... end
  return self.log, self, DEBUG, "ilog", ExtStackDepth, ...
end

function logger:Debugf(...)
  do return self.log, self, DEBUG, "flog", ExtStackDepth, ... end
  return self.log, self, DEBUG, "flog", ExtStackDepth, ...
end

function logger:DebugS(...)
  do return self.log, self, DEBUG, "slog", ExtStackDepth, ... end
  return self.log, self, DEBUG, "slog", ExtStackDepth, ...
end

function logger:Info(...)
  do return self.log, self, INFO, "ilog", ExtStackDepth, ... end
  return self.log, self, INFO, "ilog", ExtStackDepth, ...
end

function logger:Infof(...)
  do return self.log, self, INFO, "flog", ExtStackDepth, ... end
  return self.log, self, INFO, "flog", ExtStackDepth, ...
end

function logger:InfoS(...)
  do return self.log, self, INFO, "slog", ExtStackDepth, ... end
  return self.log, self, INFO, "slog", ExtStackDepth, ...
end

function logger:Warning(...)
  do return self.log, self, WARNING, "ilog", ExtStackDepth, ... end
  return self.log, self, WARNING, "ilog", ExtStackDepth, ...
end

function logger:Warningf(...)
  do return self.log, self, WARNING, "flog", ExtStackDepth, ... end
  return self.log, self, WARNING, "flog", ExtStackDepth, ...
end

function logger:WarningS(...)
  do return self.log, self, WARNING, "slog", ExtStackDepth, ... end
  return self.log, self, WARNING, "slog", ExtStackDepth, ...
end

function logger:Error(...)
  do return self.log, self, ERROR, "ilog", ExtStackDepth, ... end
  return self.log, self, ERROR, "ilog", ExtStackDepth, ...
end

function logger:Errorf(...)
  do return self.log, self, ERROR, "flog", ExtStackDepth, ... end
  return self.log, self, ERROR, "flog", ExtStackDepth, ...
end

function logger:ErrorS(...)
  do return self.log, self, ERROR, "slog", ExtStackDepth, ... end
  return self.log, self, ERROR, "slog", ExtStackDepth, ...
end

function logger:Critical(...)
  do return self.log, self, CRITICAL, "ilog", ExtStackDepth, ... end
  return self.log, self, CRITICAL, "ilog", ExtStackDepth, ...
end

function logger:Criticalf(...)
  do return self.log, self, CRITICAL, "flog", ExtStackDepth, ... end
  return self.log, self, CRITICAL, "flog", ExtStackDepth, ...
end

function logger:CriticalS(...)
  do return self.log, self, CRITICAL, "slog", ExtStackDepth, ... end
  return self.log, self, CRITICAL, "slog", ExtStackDepth, ...
end

function logger:set_module(module_name)
  self.module_name = module_name
end

function logger:set_log_level(log_level)
  self.log_level = log_level
end

function logger:disable_dedup()
  local bucket_list = get_bucket_list()
  for _, bucket in ipairs(bucket_list) do
    if bucket.close_deduper ~= nil then
      bucket:close_deduper()
    end
  end
end

function logger:set_deduper(deduper)
  local bucket_list = get_bucket_list()
  for _, bucket in ipairs(bucket_list) do
    if bucket.set_deduper ~= nil then
      bucket:set_deduper(deduper)
    end
  end
end

local function get_perror_level(self, level)
  local pcalls = self.pcalls
  if next(pcalls) then
    while true do
      level = level + 1
      local info = debug.getinfo(level, "f")
      if not info then
        break
      end
      local func = info.func
      if pcalls[func] then
        return pcalls[func]
      end
    end
  end
  return CRITICAL
end

local function slog_unescape(msg)
  do return sgsub, msg, "([{}])" end
  return sgsub, msg, "([{}])", "%0%0"
end

local function separate_traceback(msg, tcb)
  local msg_message, msg_stack = smatch(msg, [[
^([^
]*)
?(stack traceback:
.*)$]])
  if msg_stack then
    msg = msg_message
    tcb = sformat([[
%s
%s]], msg_stack, tcb)
  end
  return msg, tcb
end

local function log_traceback(self, log_lv, err_type, err_msg, stack_depth)
  local msg, tcb = separate_traceback(slog_unescape(tostring(err_msg)), debug.traceback(nil, stack_depth + 1))
  do return self.log, self, log_lv, "slog", stack_depth, (sformat("<%s> %s {traceback}", err_type, msg)) end
  return self.log, self, log_lv, "slog", stack_depth, sformat("<%s> %s {traceback}", err_type, msg), tcb, err_type, msg
end

local DoErrorStackDepth = 2

local function do_error(self, err_type, err_msg, err_lv)
  stats.traceback_cnt = stats.traceback_cnt + 1
  local log_lv = get_perror_level(self, DoErrorStackDepth)
  log_traceback(self, log_lv, err_type, err_msg, DoErrorStackDepth)
  do return error, err_msg end
  return error, err_msg, err_lv, err_type, err_msg, DoErrorStackDepth
end

local DefAssertMsg = "assertion failed!"
local AssertErrLv = 2

function logger:Assert(v, ...)
  if v then
    return v, ...
  end
  local message = select("#", ...) > 0 and (...) or DefAssertMsg
  do return do_error, self, "assert", message end
  return do_error, self, "assert", message, AssertErrLv
end

function logger:SError(message, level)
  level = level or 1
  if level > 0 then
    level = level + 1
  end
  do return do_error, self, "error", message end
  return do_error, self, "error", message, level
end

local XpcallMsghStackDepth = 1

function logger:xpcall_msgh(msg)
  do return log_traceback, self, CRITICAL, "error", msg end
  return log_traceback, self, CRITICAL, "error", msg, XpcallMsghStackDepth
end

local tags = {}

function logger:get_tag()
  local del = next(tags)
  while del do
    tags[del] = nil
    del = next(tags)
  end
  local static_tags = self.static_tags
  local dynamic_tags = self.dynamic_tags
  if static_tags then
    for k, v in pairs(static_tags) do
      tags[k] = v
    end
  end
  if dynamic_tags then
    for k, v in pairs(dynamic_tags) do
      local tv = v()
      if tv then
        tags[k] = tostring(tv)
      end
    end
  end
  if static_tags or dynamic_tags then
    return tags
  else
    return nil
  end
end

function logger:tag(key, value)
  if "function" == type(value) then
    if not self.dynamic_tags then
      self.dynamic_tags = {}
    end
    self.dynamic_tags[key] = value
  else
    if not self.static_tags then
      self.static_tags = {}
    end
    self.static_tags[key] = tostring(value)
  end
end

function logger:untag(key)
  local dynamic_tags = self.dynamic_tags
  if dynamic_tags and dynamic_tags[key] then
    dynamic_tags[key] = nil
    if nil == next(dynamic_tags) then
      self.dynamic_tags = nil
    end
  end
  local static_tags = self.static_tags
  if static_tags and static_tags[key] then
    static_tags[key] = nil
    if nil == next(static_tags) then
      self.static_tags = nil
    end
  end
end

local config_constraint = {
  product = {type = "boolean"},
  use_simple_serialize = {type = "boolean"},
  name = {
    type = "string",
    field = "module_name"
  },
  level = {type = LOG_LEVEL, field = "log_level"},
  verbose = {type = VERBOSE},
  log_src = {type = "boolean"},
  log_table = {type = "boolean"},
  stack_level = {type = "number"},
  callback_level = {type = LOG_LEVEL},
  callback = {type = "function"}
}

function logger:config(t)
  for f, v in pairs(t) do
    local c = assert(config_constraint[f], f)
    local ct = c.type
    if "table" == type(ct) then
      v = assert(ct[v], v)
    elseif type(v) ~= ct then
      error("type mismatch for field: " .. f)
    end
    self[c.field or f] = v
  end
  if self.use_simple_serialize then
    self.serialize = simple_serialize
    self.string_format = simple_string_format
  elseif not self.product or self.log_table then
    self.serialize = strict_serialize
    self.string_format = strict_string_format
  else
    self.serialize = serialize
    self.string_format = string_format
  end
end

function logger:add_pcall(pcall, level)
  assert("function" == type(pcall), pcall)
  assert(stats.level[level], sformat("log level not found:%s", level))
  self.pcalls[pcall] = level
end

function logger.new(module_name)
  local obj = {}
  obj.module_name = module_name
  obj.log_level = Cfg.get(Cfg.CATEGORY_LOG, "level", ERROR)
  obj.verbose = Vconfig.max_level
  obj.log_src = true
  obj.stack_level = 1
  obj.static_tags = nil
  obj.dynamic_tags = nil
  obj.tags = ""
  obj.callback_level = ERROR
  obj.callback = nil
  obj.serialize = strict_serialize
  obj.string_format = strict_string_format
  obj.pcalls = {}
  do return setmetatable, obj end
  return setmetatable, obj, logger, ERROR
end

logger.set_bucket = set_bucket
logger.get_bucket = get_bucket
return logger

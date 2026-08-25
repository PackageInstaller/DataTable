local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Logger = require("ejoysdk_lua.apm-sdk-lua.log.logger")
local pairs = _ENV.pairs
local type = _ENV.type
local tconcat = table.concat
local sformat = string.format
local sgsub = string.gsub
local ssub = string.sub
local colors = {
  Black = 30,
  Red = 31,
  Green = 32,
  Yellow = 33,
  Blue = 34,
  Magenta = 91,
  Cyan = 36,
  Default = 39,
  LightRed = 91,
  White = 97
}
local slog_fmt = "({+)([%w_]*)(}+)"

local function color_seq(color)
  do return sformat, "\027[%dm" end
  return sformat, "\027[%dm", color
end

local color_reset = color_seq(0)
local level_desc = {
  [Logger.CRITICAL] = {
    name = "CRI",
    color = color_seq(colors.LightRed)
  },
  [Logger.ERROR] = {
    name = "ERR",
    color = color_seq(colors.Red)
  },
  [Logger.WARNING] = {
    name = "WAR",
    color = color_seq(colors.Yellow)
  },
  [Logger.INFO] = {name = "INF", color = ""},
  [Logger.DEBUG] = {
    name = "DBG",
    color = color_seq(colors.Cyan)
  }
}
local M = {}
M.level_desc = level_desc
local structured_keys = {}

local function get_structured_str(msg, values)
  local idx, n = 0, #values
  
  local function fargs(left, mid, right)
    local lnum, rnum = #left, #right
    local parity = lnum % 2
    if rnum % 2 ~= parity then
      error("mismatched parentheses")
    end
    left = ssub(left, 1, math.floor(lnum / 2))
    right = ssub(right, 1, math.floor(rnum / 2))
    if 1 == parity then
      idx = idx + 1
      if idx > n then
        error(sformat("no value to %s (%s#%d)", msg, mid, idx))
      end
      structured_keys[idx] = mid
      structured_keys[idx + 1] = nil
      do return sformat, "%s%s:%s%s", left, mid, values[idx] end
      return sformat, "%s%s:%s%s", left, mid, values[idx], right
    end
    do return sformat, "%s%s%s", left, mid end
    return sformat, "%s%s%s", left, mid, right, right
  end
  
  do return sgsub, msg, slog_fmt end
  return sgsub, msg, slog_fmt, fargs
end

local m2s_tbl = {}

local function msg_to_str(msg, values)
  if values then
    do return get_structured_str, msg end
    return get_structured_str, msg, values, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if "table" == type(msg) then
    local n = 0
    for k, v in pairs(msg) do
      n = n + 1
      m2s_tbl[n] = sformat("%s:%s", k, v)
    end
    do return tconcat, m2s_tbl, ",", 1 end
    return tconcat, m2s_tbl, ",", 1, n, nil, m2s_tbl, sformat("%s:%s", k, v), "%s:%s", k, v
  end
  return msg
end

local last_time, last_time_str

local function format_time(timestamp)
  local sec = math.floor(timestamp)
  local ms = math.floor(timestamp * 1000 % 1000)
  local f
  if sec == last_time then
    f = last_time_str
  else
    f = Time.format(sec)
    last_time_str = f
    last_time = sec
  end
  do return sformat, "%s.%03d", f end
  return sformat, "%s.%03d", f, ms
end

M.format_time = format_time

local function level_to_string(level)
  local desc = level_desc[level]
  return desc.name
end

local function build_args(values)
  if nil == values or 0 == #values then
    return nil
  end
  local args = {}
  for i = 1, #values do
    local key = structured_keys[i]
    if not key then
      return nil
    end
    if 0 == #key or args[key] then
      key = sformat("%s#%d", key, i)
    end
    args[key] = values[i]
  end
  return args
end

local json_encoder
local grecord = {}

local function format_record(catalog, record)
  local rec
  if "log" == catalog then
    local msg = record.msg
    local values = record.values
    rec = grecord
    rec.tag = "apus.log"
    rec.module = record.module
    rec.level = level_to_string(record.level)
    rec.line = record.line
    rec.tags = record.tags
    if values then
      rec.msg = get_structured_str(msg, values)
      rec.args = build_args(values)
      record.args = rec.args
      rec.event = msg
    else
      rec.msg = msg
      rec.args = nil
      rec.event = nil
    end
  else
    rec = record.msg
    rec.tag = "apus.metrics"
  end
  rec.product = record.product
  rec.group = record.group
  rec.node = record.node
  rec.time = format_time(record.timestamp)
  do return json_encoder end
  return json_encoder, rec, rec.args, values, values
end

local F = {}

function F.json(_, catalog, record)
  json_encoder = json_encoder or require("ejoysdk_lua.apm-sdk-lua.common.json_utils").encode
  do return format_record, catalog end
  return format_record, catalog, record
end

local tagbuf = {}

function F.text(_, _, record)
  local msg = msg_to_str(record.msg, record.values)
  local desc = level_desc[record.level]
  if not desc then
    error("log level not exist, level: " .. record.level)
  end
  record.line = record.line or ""
  if record.tags then
    local n = 0
    for k, v in pairs(record.tags) do
      n = n + 1
      tagbuf[n] = sformat("%s:%s", k, v)
    end
    local tagstr = tconcat(tagbuf, ",", 1, n)
    do return sformat, "[%s %s *%s*]%s:[%s] %s", format_time(record.timestamp), desc.name, record.module, record.line, tagstr end
    return sformat, "[%s %s *%s*]%s:[%s] %s", format_time(record.timestamp), desc.name, record.module, record.line, tagstr, msg, k, v
  end
  do return sformat, "[%s %s *%s*]%s: %s", format_time(record.timestamp), desc.name, record.module, record.line end
  return sformat, "[%s %s *%s*]%s: %s", format_time(record.timestamp), desc.name, record.module, record.line, msg, record.line, tagstr, msg, k, v
end

local simple_tag_buf = {}

function F.simple_text(_, _, record)
  local msg = msg_to_str(record.msg, record.values)
  local desc = level_desc[record.level]
  if not desc then
    error("log level not exist, level: " .. record.level)
  end
  record.line = record.line or ""
  if record.tags then
    local n = 0
    for k, v in pairs(record.tags) do
      n = n + 1
      simple_tag_buf[n] = sformat("%s:%s", k, v)
    end
    local tagstr = tconcat(simple_tag_buf, ",", 1, n)
    do return sformat, "%s:[%s] %s", record.line, tagstr end
    return sformat, "%s:[%s] %s", record.line, tagstr, msg, simple_tag_buf, sformat("%s:%s", k, v), "%s:%s", k, v
  else
    do return sformat, "%s: %s", record.line end
    return sformat, "%s: %s", record.line, msg, record.line, tagstr, msg, simple_tag_buf, sformat("%s:%s", k, v), "%s:%s", k, v
  end
end

function F.cloud_text(_, _, record)
  local msg = msg_to_str(record.msg, record.values)
  return msg
end

local function colorify(msg, _, record)
  local desc = level_desc[record.level]
  if not desc then
    error("log level not exist, level: " .. record.level)
  end
  local color_beg = desc.color
  local color_end = color_reset
  if "" == color_beg then
    color_end = ""
  end
  do return sformat, "%s%s%s", color_beg, msg end
  return sformat, "%s%s%s", color_beg, msg, color_end
end

function M.get_formatter(format, color)
  format = format or "text"
  local logfmt = assert(F[format], format)
  return function(catalog, record)
    local msg = logfmt(nil, catalog, record)
    if color then
      do return colorify, msg, catalog end
      return colorify, msg, catalog, record
    else
      return msg
    end
  end
end

return M

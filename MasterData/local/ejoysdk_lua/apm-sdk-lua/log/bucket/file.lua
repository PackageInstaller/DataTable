local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local Formatter = require("ejoysdk_lua.apm-sdk-lua.log.formatter")
local Logger = require("ejoysdk_lua.apm-sdk-lua.log.logger")
local assert = _ENV.assert
local tonumber = _ENV.tonumber
local sfind = string.find
local sformat = string.format
local smatch = string.match
local supper = string.upper
local file_mt = {}
file_mt.__index = file_mt
local line_mt = {}
line_mt.__index = line_mt
local hour_mt = {}
hour_mt.__index = hour_mt
local size_mt = {}
size_mt.__index = size_mt
local M = {}

function line_mt:need_split()
  self.linecount = self.linecount + 1
  if self.linecount > self.maxline then
    self.linecount = 0
    return true
  end
  return false
end

function hour_mt:need_split()
  local cur_sec = Time.now()
  local cur_hour = math.floor(cur_sec / 3600)
  if cur_hour > self.last_hour then
    self.last_hour = cur_hour
    return true
  end
  return false
end

function size_mt:need_split(str)
  local delta = #str + 1
  local size = self.size + delta
  if delta < size and size > self.maxsize then
    self.size = delta
    return true
  end
  self.size = size
  return false
end

local function get_file_handle(filename)
  local handle, msg = io.open(filename, "a+")
  if not handle then
    return nil, msg
  end
  handle:setvbuf("line")
  return handle, handle:seek("end")
end

function file_mt:reload()
  self:close()
  local handle, msg = get_file_handle(self.path)
  self.handle = assert(handle, msg)
  self.size = msg
end

local function substitute(s)
  local tt = Time.localdate(math.floor(Time.now() / 1))
  local env = {
    Y = sformat("%4d", tt.year),
    m = sformat("%02d", tt.month),
    d = sformat("%02d", tt.day),
    H = sformat("%02d", tt.hour),
    M = sformat("%02d", tt.min),
    S = sformat("%02d", tt.sec)
  }
  do return s.gsub, s, "$(.)" end
  return s.gsub, s, "$(.)", function(v)
    do return assert, env[v] end
    return assert, env[v], "invalid file flag: $" .. v, v
  end
end

local function get_filename(path, suffix, count)
  do return sformat, "%s.%s.%s", path, (substitute(suffix)) end
  return sformat, "%s.%s.%s", path, substitute(suffix), count
end

function file_mt:split()
  local split_mgr = self.split_mgr
  local path = self.path
  local suffix = split_mgr.suffix
  local count = split_mgr.count
  local filename
  repeat
    count = count + 1
    filename = get_filename(path, suffix, count)
    local handle = io.open(filename)
  until not handle
  os.rename(path, filename)
  split_mgr.count = count
  self:reload()
  if split_mgr.size then
    split_mgr.size = split_mgr.size + self.size
  end
end

function file_mt:init()
  self:reload()
  if self.split_mgr and self.size > 0 then
    self:split()
  end
end

function file_mt:put(catalog, record)
  local level = self.level
  if level and (record.level < level.lower or record.level > level.upper) then
    return false
  end
  local str = self.formatter(catalog, record)
  local split_mgr = self.split_mgr
  if split_mgr and split_mgr:need_split(str) then
    self:split()
  end
  self.handle:write(str, "\n")
  return true
end

function file_mt:close()
  local handle = self.handle
  if handle then
    handle:flush()
    handle:close()
    self.handle = nil
  end
end

function file_mt:__tostring()
  do return sformat, "file+%s" end
  return sformat, "file+%s", self.path
end

local function parse_level(input)
  if not input then
    return
  end
  local upper, lower = smatch(input, "^(%a*)-?(%a*)$")
  upper = assert(Logger[#upper > 0 and supper(upper) or "DEBUG"], upper)
  lower = assert(Logger[#lower > 0 and supper(lower) or "EMERG"], lower)
  assert(upper >= lower, "invalid log level setting")
  return {lower = lower, upper = upper}
end

local byte_units = "KMGTP"

local function parse_bytes(u)
  local num, unit = smatch(u:upper(), sformat("^([%%d.]+)([%s]?)B?$", byte_units))
  num = assert(unit and tonumber(num), "invalid format")
  local index = (sfind(byte_units, unit) or 0) * 10
  return num * (1 * 2 ^ index)
end

local function new_split_mgr(params)
  if not params.split then
    return
  end
  local mgr = {
    count = 0,
    suffix = params.suffix
  }
  if params.split == "line" then
    mgr.maxline = params.maxline
    mgr.linecount = 0
    do return setmetatable, mgr end
    return setmetatable, mgr, line_mt
  end
  if params.split == "hour" then
    mgr.last_hour = math.floor(Time.now() / 3600)
    do return setmetatable, mgr end
    return setmetatable, mgr, hour_mt
  end
  if params.split == "size" then
    mgr.maxsize = parse_bytes(params.maxsize)
    mgr.size = 0
    do return setmetatable, mgr end
    return setmetatable, mgr, size_mt
  end
end

M.default_params = {
  format = "text",
  color = false,
  split = false,
  maxline = 1000000.0,
  maxsize = "100M",
  suffix = "$Y$m$d-$H"
}

function M.new(file_pattern, params)
  assert("" ~= file_pattern, "please specify a file pattern")
  local path = substitute(file_pattern)
  local formatter = Formatter.get_formatter(params.format, params.color)
  local level = parse_level(params.level)
  local split_mgr = new_split_mgr(params)
  local bucket = setmetatable({
    file_pattern = file_pattern,
    path = path,
    formatter = formatter,
    level = level,
    split_mgr = split_mgr
  }, file_mt)
  bucket:init()
  return bucket
end

return M

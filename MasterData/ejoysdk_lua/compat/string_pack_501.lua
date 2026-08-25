local unpack = table.unpack or _ENV.unpack
local struct = _ejoysdk_struct
local M = {}
local format_param_len = {
  [">"] = 0,
  ["<"] = 0,
  B = 1,
  b = 1,
  x = 1,
  H = 1,
  h = 1,
  L = 1,
  l = 1,
  T = 1,
  i = 1,
  I = 1,
  f = 1,
  d = 1,
  c = 1,
  s = 1
}
local pack_format_filter = {
  c = function(fmt_item)
    if type(fmt_item.p) ~= "string" then
      return false, "option 's' param is not string!"
    end
    if fmt_item.n and fmt_item.n > #fmt_item.p then
      local diff = fmt_item.n - #fmt_item.p
      for _i = 1, diff do
        fmt_item.p = fmt_item.p .. string.char(0)
      end
    end
    if fmt_item.n then
      fmt_item.fmt = "c" .. tostring(fmt_item.n)
    end
    return true
  end,
  s = function(fmt_item)
    if type(fmt_item.p) ~= "string" then
      return false, "option 's' param is not string!"
    end
    if fmt_item.n == nil then
      fmt_item.n = 4
    elseif 0 == fmt_item.n then
      return false, "option 's' 0 length"
    end
    fmt_item.fmt = "I" .. tostring(fmt_item.n) .. "c0"
    local p = {}
    table.insert(p, #fmt_item.p)
    table.insert(p, fmt_item.p)
    fmt_item.p = p
    return true
  end
}
local unpack_format_filter = {
  s = function(fmt_item)
    if fmt_item.n == nil then
      fmt_item.n = 4
    elseif 0 == fmt_item.n then
      return false, "option 's' 0 length"
    end
    fmt_item.fmt = "I" .. tostring(fmt_item.n) .. "c0"
    return true
  end
}

local function filter_pack_fmt_item(fmt_item)
  local filter = pack_format_filter[fmt_item.fmt]
  if not filter then
    if fmt_item.n then
      fmt_item.fmt = fmt_item.fmt .. tostring(fmt_item.n)
    end
    return true
  else
    do return filter end
    return filter, fmt_item, fmt_item.n
  end
end

local function filter_unpack_fmt_item(fmt_item)
  local filter = unpack_format_filter[fmt_item.fmt]
  if not filter then
    if fmt_item.n then
      fmt_item.fmt = fmt_item.fmt .. tostring(fmt_item.n)
    end
    return true
  else
    do return filter end
    return filter, fmt_item, fmt_item.n
  end
end

local function pack_format(format, ...)
  assert(format, "pack format is nil!")
  assert(type(format) == "string", "pack format is not a string!")
  local len = #format
  local fmts = {
    string.byte(format, 1, len)
  }
  local need_filter = false
  for i = 1, len do
    fmts[i] = string.char(fmts[i])
    if nil ~= pack_format_filter[fmts[i]] then
      need_filter = true
    end
  end
  if not need_filter then
    do return struct.pack, format, ... end
    return struct.pack, format, ...
  end
  local params = {
    ...
  }
  local fmt_items = {}
  local n = 0
  local idx = 1
  local param_idx = 1
  local fmt_item
  while len >= idx do
    local fmt = fmts[idx]
    if fmt >= "0" and fmt < "9" then
      n = n * 10 + tonumber(fmt)
      if nil == fmt_item then
        error("wrong number berfore string option!")
      end
      fmt_item.n = n
    else
      local val = format_param_len[fmt]
      if nil == val then
        error("invalid format option '" .. tostring(fmt) .. "'")
      end
      n = 0
      fmt_item = {fmt = fmt}
      if 1 == val then
        local param = params[param_idx]
        if nil == param then
          error("format longer than params")
        end
        fmt_item.p = param
        param_idx = param_idx + 1
      end
      table.insert(fmt_items, fmt_item)
    end
    idx = idx + 1
  end
  local new_format = ""
  local new_params = {}
  for _, _fmt_item in ipairs(fmt_items) do
    local succ, msg = filter_pack_fmt_item(_fmt_item)
    if not succ then
      error(msg or "filiter failed, format option ' " .. tostring(_fmt_item.fmt) .. " '")
    end
    new_format = new_format .. _fmt_item.fmt
    if nil ~= _fmt_item.p then
      if type(_fmt_item.p) == "table" then
        for _, p in ipairs(_fmt_item.p) do
          table.insert(new_params, p)
        end
      else
        table.insert(new_params, _fmt_item.p)
      end
    end
  end
  do return struct.pack, new_format, unpack(new_params) end
  return struct.pack, new_format, unpack(new_params)
end

local function unpack_format(format, ...)
  assert(format, "unpack format is nil!")
  assert(type(format) == "string", "unpack format is not a string!")
  local len = #format
  local fmts = {
    string.byte(format, 1, len)
  }
  local need_filter = false
  for i = 1, len do
    fmts[i] = string.char(fmts[i])
    if nil ~= pack_format_filter[fmts[i]] then
      need_filter = true
    end
  end
  if not need_filter then
    do return struct.unpack, format, ... end
    return struct.unpack, format, ...
  end
  local fmt_items = {}
  local n = 0
  local idx = 1
  local fmt_item
  while len >= idx do
    local fmt = fmts[idx]
    if fmt >= "0" and fmt < "9" then
      n = n * 10 + tonumber(fmt)
      if nil == fmt_item then
        error("wrong number berfore string option!")
      end
      fmt_item.n = n
    else
      local val = format_param_len[fmt]
      if nil == val then
        error("invalid format option '" .. tostring(fmt) .. "'")
      end
      n = 0
      fmt_item = {fmt = fmt}
      table.insert(fmt_items, fmt_item)
    end
    idx = idx + 1
  end
  local new_format = ""
  for _, _fmt_item in ipairs(fmt_items) do
    local succ, msg = filter_unpack_fmt_item(_fmt_item)
    if not succ then
      error("filiter failed, format option ' " .. tostring(_fmt_item.fmt) .. " ' ,msg: " .. tostring(msg))
    end
    new_format = new_format .. _fmt_item.fmt
  end
  do return struct.unpack, new_format, ... end
  return struct.unpack, new_format, ...
end

function M.pack(format, ...)
  if struct then
    do return pack_format, format, ... end
    return pack_format, format, ...
  else
    error("struct not implemented")
  end
end

function M.unpack(format, ...)
  if struct then
    do return unpack_format, format, ... end
    return unpack_format, format, ...
  else
    error("struct not implemented")
  end
end

return M

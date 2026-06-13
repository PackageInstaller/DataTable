local always_try_using_lpeg = true
local register_global_module_table = false
local global_module_name = "json"
local pairs, type, tostring, tonumber, getmetatable, setmetatable, rawset = pairs, type, tostring, tonumber, getmetatable, setmetatable, _ENV.rawset
local error, require, pcall, select = error, require, pcall, _ENV.select
local floor = math.floor
local huge = math.huge
local strrep = string.rep
local gsub = string.gsub
local strsub = string.sub
local strbyte = string.byte
local strchar = string.char
local strfind = string.find
local strlen = string.len
local strformat = string.format
local strmatch = string.match
local concat = table.concat
local json = {version = "dkjson 2.4"}
if register_global_module_table then
  _G[global_module_name] = json
end
local _ENV
pcall(function()
  local debmeta = require("debug").getmetatable
  if debmeta then
    getmetatable = debmeta
  end
end)
json.null = setmetatable({}, {
  __tojson = function()
    return "null"
  end
})

local function isarray(tbl)
  local max, n, arraylen = 0, 0, 0
  for k, v in pairs(tbl) do
    if "n" == k and "number" == type(v) then
      arraylen = v
      if v > max then
        max = v
      end
    else
      if "number" ~= type(k) or k < 1 or floor(k) ~= k then
        return false
      end
      if k > max then
        max = k
      end
      n = n + 1
    end
  end
  if max > 10 and arraylen < max and max > n * 2 then
    return false
  end
  return true, max
end

local escapecodes = {
  ["\""] = "\\\"",
  ["\\"] = "\\\\",
  ["\b"] = "\\b",
  ["\f"] = "\\f",
  ["\n"] = "\\n",
  ["\r"] = "\\r",
  ["\t"] = "\\t"
}

local function escapeutf8(uchar)
  local value = escapecodes[uchar]
  if value then
    return value
  end
  local a, b, c, d = strbyte(uchar, 1, 4)
  a, b, c, d = a or 0, b or 0, c or 0, d or 0
  if a <= 127 then
    value = a
  elseif a >= 192 and a <= 223 and b >= 128 then
    value = (a - 192) * 64 + b - 128
  elseif a >= 224 and a <= 239 and b >= 128 and c >= 128 then
    value = ((a - 224) * 64 + b - 128) * 64 + c - 128
  elseif a >= 240 and a <= 247 and b >= 128 and c >= 128 and d >= 128 then
    value = (((a - 240) * 64 + b - 128) * 64 + c - 128) * 64 + d - 128
  else
    return ""
  end
  if value <= 65535 then
    return strformat("\\u%.4x", value)
  elseif value <= 1114111 then
    value = value - 65536
    local highsur, lowsur = 55296 + floor(value / 1024), 56320 + value % 1024
    return strformat("\\u%.4x\\u%.4x", highsur, lowsur)
  else
    return ""
  end
end

local function fsub(str, pattern, repl)
  if strfind(str, pattern) then
    return gsub(str, pattern, repl)
  else
    return str
  end
end

local function quotestring(value)
  value = fsub(value, "[%z\001-\031\"\\\127]", escapeutf8)
  if strfind(value, "[ÂØÜáâï]") then
    value = fsub(value, "Â[€-Ÿ­]", escapeutf8)
    value = fsub(value, "Ø[€-„]", escapeutf8)
    value = fsub(value, "Ü", escapeutf8)
    value = fsub(value, "áž[´µ]", escapeutf8)
    value = fsub(value, "â€[Œ-¨-¯]", escapeutf8)
    value = fsub(value, "â[ -¯]", escapeutf8)
    value = fsub(value, "ï»¿", escapeutf8)
    value = fsub(value, "ï¿[°-¿]", escapeutf8)
  end
  return "\"" .. value .. "\""
end

json.quotestring = quotestring

local function replace(str, o, n)
  local i, j = strfind(str, o, 1, true)
  if i then
    return strsub(str, 1, i - 1) .. n .. strsub(str, j + 1, -1)
  else
    return str
  end
end

local decpoint, numfilter

local function updatedecpoint()
  decpoint = strmatch(tostring(0.5), "([^05+])")
  numfilter = "[^0-9%-%+eE" .. gsub(decpoint, "[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0") .. "]+"
end

updatedecpoint()

local function num2str(num)
  return replace(fsub(tostring(num), numfilter, ""), decpoint, ".")
end

local function str2num(str)
  local num = tonumber(replace(str, ".", decpoint))
  if not num then
    updatedecpoint()
    num = tonumber(replace(str, ".", decpoint))
  end
  return num
end

local function addnewline2(level, buffer, buflen)
  buffer[buflen + 1] = "\n"
  buffer[buflen + 2] = strrep("  ", level)
  buflen = buflen + 2
  return buflen
end

function json.addnewline(state)
  if state.indent then
    state.bufferlen = addnewline2(state.level or 0, state.buffer, state.bufferlen or #state.buffer)
  end
end

local encode2

local function addpair(key, value, prev, indent, level, buffer, buflen, tables, globalorder)
  local kt = type(key)
  if "string" ~= kt and "number" ~= kt then
    return nil, "type '" .. kt .. "' is not supported as a key by JSON."
  end
  if prev then
    buflen = buflen + 1
    buffer[buflen] = ","
  end
  if indent then
    buflen = addnewline2(level, buffer, buflen)
  end
  buffer[buflen + 1] = quotestring(key)
  buffer[buflen + 2] = ":"
  return encode2(value, indent, level, buffer, buflen + 2, tables, globalorder)
end

function encode2(value, indent, level, buffer, buflen, tables, globalorder)
  local valtype = type(value)
  local valmeta = getmetatable(value)
  valmeta = "table" == type(valmeta) and valmeta
  local valtojson = valmeta and valmeta.__tojson
  if valtojson then
    if tables[value] then
      return nil, "reference cycle"
    end
    tables[value] = true
    local state = {
      indent = indent,
      level = level,
      buffer = buffer,
      bufferlen = buflen,
      tables = tables,
      keyorder = globalorder
    }
    local ret, msg = valtojson(value, state)
    if not ret then
      return nil, msg
    end
    tables[value] = nil
    buflen = state.bufferlen
    if "string" == type(ret) then
      buflen = buflen + 1
      buffer[buflen] = ret
    end
  elseif nil == value then
    buflen = buflen + 1
    buffer[buflen] = "null"
  elseif "number" == valtype then
    local s
    if value ~= value or value >= huge or -value >= huge then
      s = "null"
    else
      s = num2str(value)
    end
    buflen = buflen + 1
    buffer[buflen] = s
  elseif "boolean" == valtype then
    buflen = buflen + 1
    buffer[buflen] = value and "true" or "false"
  elseif "string" == valtype then
    buflen = buflen + 1
    buffer[buflen] = quotestring(value)
  elseif "table" == valtype then
    if tables[value] then
      return nil, "reference cycle"
    end
    tables[value] = true
    level = level + 1
    local isa, n = isarray(value)
    if 0 == n and valmeta and valmeta.__jsontype == "object" then
      isa = false
    end
    local msg
    if isa then
      buflen = buflen + 1
      buffer[buflen] = "["
      for i = 1, n do
        buflen, msg = encode2(value[i], indent, level, buffer, buflen, tables, globalorder)
        if not buflen then
          return nil, msg
        end
        if i < n then
          buflen = buflen + 1
          buffer[buflen] = ","
        end
      end
      buflen = buflen + 1
      buffer[buflen] = "]"
    else
      local prev = false
      buflen = buflen + 1
      buffer[buflen] = "{"
      local order = valmeta and valmeta.__jsonorder or globalorder
      if order then
        local used = {}
        n = #order
        for i = 1, n do
          local k = order[i]
          local v = value[k]
          if v then
            used[k] = true
            buflen, msg = addpair(k, v, prev, indent, level, buffer, buflen, tables, globalorder)
            prev = true
          end
        end
        for k, v in pairs(value) do
          if not used[k] then
            buflen, msg = addpair(k, v, prev, indent, level, buffer, buflen, tables, globalorder)
            if not buflen then
              return nil, msg
            end
            prev = true
          end
        end
      else
        for k, v in pairs(value) do
          buflen, msg = addpair(k, v, prev, indent, level, buffer, buflen, tables, globalorder)
          if not buflen then
            return nil, msg
          end
          prev = true
        end
      end
      if indent then
        buflen = addnewline2(level - 1, buffer, buflen)
      end
      buflen = buflen + 1
      buffer[buflen] = "}"
    end
    tables[value] = nil
  else
    return nil, "type '" .. valtype .. "' is not supported by JSON."
  end
  return buflen
end

function json.encode(value, state)
  state = state or {}
  local oldbuffer = state.buffer
  local buffer = oldbuffer or {}
  updatedecpoint()
  local ret, msg = encode2(value, state.indent, state.level or 0, buffer, state.bufferlen or 0, state.tables or {}, state.keyorder)
  if not ret then
    error(msg, 2)
  elseif oldbuffer then
    state.bufferlen = ret
    return true
  else
    return concat(buffer)
  end
end

local function loc(str, where)
  local line, pos, linepos = 1, 1, 0
  while true do
    pos = strfind(str, "\n", pos, true)
    if pos and where > pos then
      line = line + 1
      linepos = pos
      pos = pos + 1
    else
      break
    end
  end
  return "line " .. line .. ", column " .. where - linepos
end

local function unterminated(str, what, where)
  return nil, strlen(str) + 1, "unterminated " .. what .. " at " .. loc(str, where)
end

local function scanwhite(str, pos)
  while true do
    pos = strfind(str, "%S", pos)
    if not pos then
      return nil
    end
    if "ï»¿" == strsub(str, pos, pos + 2) then
      pos = pos + 3
    else
      return pos
    end
  end
end

local escapechars = {
  ["\""] = "\"",
  ["\\"] = "\\",
  ["/"] = "/",
  b = "\b",
  f = "\f",
  n = "\n",
  r = "\r",
  t = "\t"
}

local function unichar(value)
  if value < 0 then
    return nil
  elseif value <= 127 then
    return strchar(value)
  elseif value <= 2047 then
    return strchar(192 + floor(value / 64), 128 + floor(value) % 64)
  elseif value <= 65535 then
    return strchar(224 + floor(value / 4096), 128 + floor(value / 64) % 64, 128 + floor(value) % 64)
  elseif value <= 1114111 then
    return strchar(240 + floor(value / 262144), 128 + floor(value / 4096) % 64, 128 + floor(value / 64) % 64, 128 + floor(value) % 64)
  else
    return nil
  end
end

local function scanstring(str, pos)
  local lastpos = pos + 1
  local buffer, n = {}, 0
  while true do
    local nextpos = strfind(str, "[\"\\]", lastpos)
    if not nextpos then
      return unterminated(str, "string", pos)
    end
    if lastpos < nextpos then
      n = n + 1
      buffer[n] = strsub(str, lastpos, nextpos - 1)
    end
    if "\"" == strsub(str, nextpos, nextpos) then
      lastpos = nextpos + 1
      break
    else
      local escchar = strsub(str, nextpos + 1, nextpos + 1)
      local value
      if "u" == escchar then
        value = tonumber(strsub(str, nextpos + 2, nextpos + 5), 16)
        if value then
          local value2
          if value >= 55296 and value <= 56319 and "\\u" == strsub(str, nextpos + 6, nextpos + 7) then
            value2 = tonumber(strsub(str, nextpos + 8, nextpos + 11), 16)
            if value2 and value2 >= 56320 and value2 <= 57343 then
              value = (value - 55296) * 1024 + (value2 - 56320) + 65536
            else
              value2 = nil
            end
          end
          value = value and unichar(value)
          if value then
            if value2 then
              lastpos = nextpos + 12
            else
              lastpos = nextpos + 6
            end
          end
        end
      end
      if not value then
        value = escapechars[escchar] or escchar
        lastpos = nextpos + 2
      end
      n = n + 1
      buffer[n] = value
    end
  end
  if 1 == n then
    return buffer[1], lastpos
  elseif n > 1 then
    return concat(buffer), lastpos
  else
    return "", lastpos
  end
end

local scanvalue

local function scantable(what, closechar, str, startpos, nullval, objectmeta, arraymeta)
  local len = strlen(str)
  local tbl, n = {}, 0
  local pos = startpos + 1
  if "object" == what then
    setmetatable(tbl, objectmeta)
  else
    setmetatable(tbl, arraymeta)
  end
  while true do
    pos = scanwhite(str, pos)
    if not pos then
      return unterminated(str, what, startpos)
    end
    local char = strsub(str, pos, pos)
    if char == closechar then
      return tbl, pos + 1
    end
    local val1, err
    val1, pos, err = scanvalue(str, pos, nullval, objectmeta, arraymeta)
    if err then
      return nil, pos, err
    end
    pos = scanwhite(str, pos)
    if not pos then
      return unterminated(str, what, startpos)
    end
    char = strsub(str, pos, pos)
    if ":" == char then
      if nil == val1 then
        return nil, pos, "cannot use nil as table index (at " .. loc(str, pos) .. ")"
      end
      pos = scanwhite(str, pos + 1)
      if not pos then
        return unterminated(str, what, startpos)
      end
      local val2
      val2, pos, err = scanvalue(str, pos, nullval, objectmeta, arraymeta)
      if err then
        return nil, pos, err
      end
      tbl[val1] = val2
      pos = scanwhite(str, pos)
      if not pos then
        return unterminated(str, what, startpos)
      end
      char = strsub(str, pos, pos)
    else
      n = n + 1
      tbl[n] = val1
    end
    if "," == char then
      pos = pos + 1
    end
  end
end

function scanvalue(str, pos, nullval, objectmeta, arraymeta)
  pos = pos or 1
  pos = scanwhite(str, pos)
  if not pos then
    return nil, strlen(str) + 1, "no valid JSON value (reached the end)"
  end
  local char = strsub(str, pos, pos)
  if "{" == char then
    return scantable("object", "}", str, pos, nullval, objectmeta, arraymeta)
  elseif "[" == char then
    return scantable("array", "]", str, pos, nullval, objectmeta, arraymeta)
  elseif "\"" == char then
    return scanstring(str, pos)
  else
    local pstart, pend = strfind(str, "^%-?[%d%.]+[eE]?[%+%-]?%d*", pos)
    if pstart then
      local number = str2num(strsub(str, pstart, pend))
      if number then
        return number, pend + 1
      end
    end
    pstart, pend = strfind(str, "^%a%w*", pos)
    if pstart then
      local name = strsub(str, pstart, pend)
      if "true" == name then
        return true, pend + 1
      elseif "false" == name then
        return false, pend + 1
      elseif "null" == name then
        return nullval, pend + 1
      end
    end
    return nil, pos, "no valid JSON value at " .. loc(str, pos)
  end
end

local function optionalmetatables(...)
  if select("#", ...) > 0 then
    return ...
  else
    return {__jsontype = "object"}, {__jsontype = "array"}
  end
end

function json.decode(str, pos, nullval, ...)
  local objectmeta, arraymeta = optionalmetatables(...)
  return scanvalue(str, pos, nullval, objectmeta, arraymeta)
end

function json.use_lpeg()
  local g = require("lpeg")
  if g.version() == "0.11" then
    error("due to a bug in LPeg 0.11, it cannot be used for JSON matching")
  end
  local pegmatch = g.match
  local P, S, R = g.P, g.S, g.R
  
  local function ErrorCall(str, pos, msg, state)
    if not state.msg then
      state.msg = msg .. " at " .. loc(str, pos)
      state.pos = pos
    end
    return false
  end
  
  local function Err(msg)
    return g.Cmt(g.Cc(msg) * g.Carg(2), ErrorCall)
  end
  
  local Space = (S(" \n\r\t") + P("ï»¿")) ^ 0
  local PlainChar = 1 - S("\"\\\n\r")
  local EscapeSequence = P("\\") * g.C(S("\"\\/bfnrt") + Err("unsupported escape sequence")) / escapechars
  local HexDigit = R("09", "af", "AF")
  
  local function UTF16Surrogate(match, pos, high, low)
    high, low = tonumber(high, 16), tonumber(low, 16)
    if high >= 55296 and high <= 56319 and low >= 56320 and low <= 57343 then
      return true, unichar((high - 55296) * 1024 + (low - 56320) + 65536)
    else
      return false
    end
  end
  
  local function UTF16BMP(hex)
    return unichar(tonumber(hex, 16))
  end
  
  local U16Sequence = P("\\u") * g.C(HexDigit * HexDigit * HexDigit * HexDigit)
  local UnicodeEscape = g.Cmt(U16Sequence * U16Sequence, UTF16Surrogate) + U16Sequence / UTF16BMP
  local Char = UnicodeEscape + EscapeSequence + PlainChar
  local String = P("\"") * g.Cs(Char ^ 0) * (P("\"") + Err("unterminated string"))
  local Integer = P("-") ^ (-1) * (P("0") + R("19") * R("09") ^ 0)
  local Fractal = P(".") * R("09") ^ 0
  local Exponent = S("eE") * S("+-") ^ (-1) * R("09") ^ 1
  local Number = Integer * Fractal ^ (-1) * Exponent ^ (-1) / str2num
  local Constant = P("true") * g.Cc(true) + P("false") * g.Cc(false) + P("null") * g.Carg(1)
  local SimpleValue = Number + String + Constant
  local ArrayContent, ObjectContent
  
  local function parsearray(str, pos, nullval, state)
    local obj, cont, npos
    local t, nt = {}, 0
    repeat
      obj, cont, npos = pegmatch(ArrayContent, str, pos, nullval, state)
      if not npos then
        break
      end
      pos = npos
      nt = nt + 1
      t[nt] = obj
    until "last" == cont
    return pos, setmetatable(t, state.arraymeta)
  end
  
  local function parseobject(str, pos, nullval, state)
    local obj, key, cont, npos
    local t = {}
    repeat
      key, obj, cont, npos = pegmatch(ObjectContent, str, pos, nullval, state)
      if not npos then
        break
      end
      pos = npos
      t[key] = obj
    until "last" == cont
    return pos, setmetatable(t, state.objectmeta)
  end
  
  local Array = P("[") * g.Cmt(g.Carg(1) * g.Carg(2), parsearray) * Space * (P("]") + Err("']' expected"))
  local Object = P("{") * g.Cmt(g.Carg(1) * g.Carg(2), parseobject) * Space * (P("}") + Err("'}' expected"))
  local Value = Space * (Array + Object + SimpleValue)
  local ExpectedValue = Value + Space * Err("value expected")
  ArrayContent = Value * Space * (P(",") * g.Cc("cont") + g.Cc("last")) * g.Cp()
  local Pair = g.Cg(Space * String * Space * (P(":") + Err("colon expected")) * ExpectedValue)
  ObjectContent = Pair * Space * (P(",") * g.Cc("cont") + g.Cc("last")) * g.Cp()
  local DecodeValue = ExpectedValue * g.Cp()
  
  function json.decode(str, pos, nullval, ...)
    local state = {}
    state.objectmeta, state.arraymeta = optionalmetatables(...)
    local obj, retpos = pegmatch(DecodeValue, str, pos, nullval, state)
    if state.msg then
      return nil, state.pos, state.msg
    else
      return obj, retpos
    end
  end
  
  function json.use_lpeg()
    return json
  end
  
  json.using_lpeg = true
  return json
end

if always_try_using_lpeg then
  pcall(json.use_lpeg)
end
return json

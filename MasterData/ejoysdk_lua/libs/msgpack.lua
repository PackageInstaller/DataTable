local compat = require("ejoysdk_lua.compat.ejoysdk_compat")
local table_unpack = table.unpack or unpack
local pack, unpack = compat.string.pack, compat.string.unpack
local mtype, utf8len = compat.math.type, compat.utf8.len
local tconcat, tunpack = table.concat, table_unpack
local ssub = string.sub
local type, pcall, pairs, select = type, pcall, pairs, _ENV.select
local encode_value

local function is_an_array(value)
  local expected = 1
  for k in pairs(value) do
    if k ~= expected then
      return false
    end
    expected = expected + 1
  end
  return true
end

local encoder_functions = {
  ["nil"] = function()
    do return pack, "B" end
    return pack, "B", 192
  end,
  userdata = function()
    do return pack, "B" end
    return pack, "B", 192
  end,
  ["function"] = function()
    do return pack, "B" end
    return pack, "B", 192
  end,
  boolean = function(value)
    if value then
      do return pack, "B" end
      return pack, "B", 195
    else
      do return pack, "B" end
      return pack, "B", 194
    end
  end,
  number = function(value)
    if "integer" == mtype(value) then
      if value >= 0 then
        if value < 128 then
          do return pack, "B" end
          return pack, "B", value, nil, nil
        elseif value <= 255 then
          do return pack, "BB", 204 end
          return pack, "BB", 204, value, nil
        elseif value <= 65535 then
          do return pack, ">BI2", 205 end
          return pack, ">BI2", 205, value, nil
        elseif value <= 4294967295 then
          do return pack, ">BI4", 206 end
          return pack, ">BI4", 206, value, nil
        else
          do return pack, ">BI8", 207 end
          return pack, ">BI8", 207, value, nil
        end
      elseif value >= -32 then
        do return pack, "B" end
        return pack, "B", 224 + (value + 32), value, nil
      elseif value >= -128 then
        do return pack, "Bb", 208 end
        return pack, "Bb", 208, value, nil
      elseif value >= -32768 then
        do return pack, ">Bi2", 209 end
        return pack, ">Bi2", 209, value, nil
      elseif value >= -2147483648 then
        do return pack, ">Bi4", 210 end
        return pack, ">Bi4", 210, value, nil
      else
        do return pack, ">Bi8", 211 end
        return pack, ">Bi8", 211, value, nil
      end
    else
      local test = unpack("f", pack("f", value))
      if test == value then
        do return pack, ">Bf", 202 end
        return pack, ">Bf", 202, value
      else
        do return pack, ">Bd", 203 end
        return pack, ">Bd", 203, value
      end
    end
  end,
  string = function(value)
    local len = #value
    if utf8len(value) then
      if len < 32 then
        return pack("B", 160 + len) .. value
      elseif len < 256 then
        do return pack, ">Bs1", 217 end
        return pack, ">Bs1", 217, value
      elseif len < 65536 then
        do return pack, ">Bs2", 218 end
        return pack, ">Bs2", 218, value
      else
        do return pack, ">Bs4", 219 end
        return pack, ">Bs4", 219, value
      end
    elseif len < 256 then
      do return pack, ">Bs1", 196 end
      return pack, ">Bs1", 196, value
    elseif len < 65536 then
      do return pack, ">Bs2", 197 end
      return pack, ">Bs2", 197, value
    else
      do return pack, ">Bs4", 198 end
      return pack, ">Bs4", 198, value
    end
  end,
  table = function(value)
    if is_an_array(value) then
      local elements = {}
      for i, v in pairs(value) do
        elements[i] = encode_value(v)
      end
      local length = #elements
      if length < 16 then
        return pack(">B", 144 + length) .. tconcat(elements)
      elseif length < 65536 then
        return pack(">Bi2", 220, length) .. tconcat(elements)
      else
        return pack(">Bi4", 221, length) .. tconcat(elements)
      end
    else
      local elements = {}
      for k, v in pairs(value) do
        elements[#elements + 1] = encode_value(k)
        elements[#elements + 1] = encode_value(v)
      end
      local length = math.floor(#elements / 2)
      if length < 16 then
        return pack(">B", 128 + length) .. tconcat(elements)
      elseif length < 65536 then
        return pack(">Bi2", 222, length) .. tconcat(elements)
      else
        return pack(">Bi4", 223, length) .. tconcat(elements)
      end
    end
  end
}

function encode_value(value)
  do return encoder_functions[type(value)] end
  return encoder_functions[type(value)], value
end

local function encode(...)
  local data = {}
  for i = 1, select("#", ...) do
    data[#data + 1] = encode_value(select(i, ...))
  end
  do return tconcat end
  return tconcat, data, 1, ...
end

local decode_value

local function decode_array(data, position, length)
  local elements, value = {}
  for i = 1, length do
    value, position = decode_value(data, position)
    elements[i] = value
  end
  return elements, position
end

local function decode_map(data, position, length)
  local elements, key, value = {}
  for i = 1, length do
    key, position = decode_value(data, position)
    value, position = decode_value(data, position)
    elements[key] = value
  end
  return elements, position
end

local decoder_functions = {
  [192] = function(data, position)
    return nil, position
  end,
  [194] = function(data, position)
    return false, position
  end,
  [195] = function(data, position)
    return true, position
  end,
  [196] = function(data, position)
    do return unpack, ">s1", data end
    return unpack, ">s1", data, position
  end,
  [197] = function(data, position)
    do return unpack, ">s2", data end
    return unpack, ">s2", data, position
  end,
  [198] = function(data, position)
    do return unpack, ">s4", data end
    return unpack, ">s4", data, position
  end,
  [202] = function(data, position)
    do return unpack, ">f", data end
    return unpack, ">f", data, position
  end,
  [203] = function(data, position)
    do return unpack, ">d", data end
    return unpack, ">d", data, position
  end,
  [204] = function(data, position)
    do return unpack, ">B", data end
    return unpack, ">B", data, position
  end,
  [205] = function(data, position)
    do return unpack, ">I2", data end
    return unpack, ">I2", data, position
  end,
  [206] = function(data, position)
    do return unpack, ">I4", data end
    return unpack, ">I4", data, position
  end,
  [207] = function(data, position)
    do return unpack, ">I8", data end
    return unpack, ">I8", data, position
  end,
  [208] = function(data, position)
    do return unpack, ">b", data end
    return unpack, ">b", data, position
  end,
  [209] = function(data, position)
    do return unpack, ">i2", data end
    return unpack, ">i2", data, position
  end,
  [210] = function(data, position)
    do return unpack, ">i4", data end
    return unpack, ">i4", data, position
  end,
  [211] = function(data, position)
    do return unpack, ">i8", data end
    return unpack, ">i8", data, position
  end,
  [217] = function(data, position)
    do return unpack, ">s1", data end
    return unpack, ">s1", data, position
  end,
  [218] = function(data, position)
    do return unpack, ">s2", data end
    return unpack, ">s2", data, position
  end,
  [219] = function(data, position)
    do return unpack, ">s4", data end
    return unpack, ">s4", data, position
  end,
  [220] = function(data, position)
    local length
    length, position = unpack(">I2", data, position)
    do return decode_array, data, position end
    return decode_array, data, position, length
  end,
  [221] = function(data, position)
    local length
    length, position = unpack(">I4", data, position)
    do return decode_array, data, position end
    return decode_array, data, position, length
  end,
  [222] = function(data, position)
    local length
    length, position = unpack(">I2", data, position)
    do return decode_map, data, position end
    return decode_map, data, position, length
  end,
  [223] = function(data, position)
    local length
    length, position = unpack(">I4", data, position)
    do return decode_map, data, position end
    return decode_map, data, position, length
  end
}
for i = 0, 127 do
  decoder_functions[i] = function(data, position)
    return i, position
  end
end
for i = 128, 143 do
  decoder_functions[i] = function(data, position)
    do return decode_map, data, position end
    return decode_map, data, position, i - 128
  end
end
for i = 144, 159 do
  decoder_functions[i] = function(data, position)
    do return decode_array, data, position end
    return decode_array, data, position, i - 144
  end
end
for i = 160, 191 do
  decoder_functions[i] = function(data, position)
    local length = i - 160
    return ssub(data, position, position + length - 1), position + length
  end
end
for i = 224, 255 do
  decoder_functions[i] = function(data, position)
    return -32 + (i - 224), position
  end
end

function decode_value(data, position)
  local byte, value
  byte, position = unpack("B", data, position)
  value, position = decoder_functions[byte](data, position)
  return value, position
end

return {
  _AUTHOR = "Sebastian Steinhauer <s.steinhauer@yahoo.de>",
  _VERSION = "0.6.0",
  encode = function(...)
    local data, ok = {}
    for i = 1, select("#", ...) do
      ok, data[i] = pcall(encode_value, select(i, ...))
      if not ok then
        return nil, "cannot encode MessagePack"
      end
    end
    do return tconcat end
    return tconcat, data, 1, ...
  end,
  encode_one = function(value)
    local ok, data = pcall(encode_value, value)
    if ok then
      return data
    else
      return nil, "cannot encode MessagePack"
    end
  end,
  decode = function(data, position)
    local values, value, ok = {}
    position = position or 1
    while position <= #data do
      ok, value, position = pcall(decode_value, data, position)
      if ok then
        values[#values + 1] = value
      else
        return nil, "cannot decode MessagePack"
      end
    end
    do return tunpack end
    return tunpack, values, pcall(decode_value, data, position)
  end,
  decode_one = function(data, position)
    local value, ok
    ok, value, position = pcall(decode_value, data, position or 1)
    if ok then
      return value, position
    else
      return nil, "cannot decode MessagePack"
    end
  end
}

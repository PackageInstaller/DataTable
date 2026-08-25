local M = {}
M.__index = M
local string_buffer = {}
string_buffer.__index = string_buffer

function string_buffer.new()
  local obj = {
    buf = {}
  }
  do return setmetatable, obj end
  return setmetatable, obj, string_buffer
end

function string_buffer:append(rune)
  table.insert(self.buf, rune)
end

function string_buffer:to_string()
  do return table.concat, self.buf end
  return table.concat, self.buf, ""
end

function M.new_string_buffer()
  do return end
  return string_buffer.new, nil
end

local magic_chars = "^$()%.[]*+-?"
local magic_chars_pattern = "[" .. string.gsub(magic_chars, ".", "%%%1") .. "]"

function M.split(str, sep)
  if not sep or "" == sep then
    sep = "%s"
  else
    sep = string.gsub(sep, magic_chars_pattern, "%%%1")
  end
  local result = {}
  for i in string.gmatch(str, string.format("([^%s]*)", sep)) do
    table.insert(result, i)
  end
  return result
end

function M.truncate(str, max_length)
  if type(max_length) ~= "number" or max_length < 0 then
    return str
  end
  local fixed_max_length = math.ceil(max_length)
  if type(str) == "string" and fixed_max_length < #str then
    do return string.sub, str, 1 end
    return string.sub, str, 1, fixed_max_length
  end
  return str
end

return M

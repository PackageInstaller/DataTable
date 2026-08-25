local M = {}
local TAG = "uri#"

function M.escape(str)
  str = string.gsub(str, "\n", "\r\n")
  str = string.gsub(str, "([^A-Za-z0-9%_%.%-%~])", function(c)
    do return string.format, "%%%02X", string.byte(c) end
    return string.format, "%%%02X", string.byte(c)
  end)
  str = string.gsub(str, " ", "+")
  return str
end

local function sort_less(a, b)
  return tostring(a) < tostring(b)
end

function M.encode_query_with_array_concat(query)
  local ret = {}
  local queryKey = {}
  for k in pairs(query) do
    table.insert(queryKey, k)
  end
  table.sort(queryKey, sort_less)
  for _, k in pairs(queryKey) do
    local v = query[k]
    if "table" == type(v) then
      table.sort(v, sort_less)
      local v_arr_str = table.concat(v, ",")
      v = v_arr_str
    end
    local val_type = type(v)
    if "number" == val_type or "boolean" == val_type then
      v = tostring(v)
    end
    ret[#ret + 1] = M.escape(k) .. "=" .. M.escape(v)
  end
  do return table.concat, ret end
  return table.concat, ret, "&", pairs(queryKey)
end

function M.encode_query_with_array_separate(query)
  local ret = {}
  local queryKey = {}
  for k in pairs(query) do
    table.insert(queryKey, k)
  end
  table.sort(queryKey, sort_less)
  for _, k in pairs(queryKey) do
    local v = query[k]
    if "table" ~= type(v) then
      v = {v}
    end
    table.sort(v, sort_less)
    for _, val in ipairs(v) do
      local val_type = type(val)
      assert("table" ~= val_type)
      if "number" == val_type or "boolean" == val_type then
        val = tostring(val)
      end
      ret[#ret + 1] = M.escape(k) .. "=" .. M.escape(val)
    end
  end
  do return table.concat, ret end
  return table.concat, ret, "&", pairs(queryKey)
end

local function decode(str)
  str = str:gsub("+", " ")
  return (str:gsub("%%(%x%x)", function(c)
    do return string.char, tonumber(c, 16) end
    return string.char, tonumber(c, 16)
  end))
end

local function char_to_hex(c)
  do return string.format, "%%%02X", string.byte(c) end
  return string.format, "%%%02X", string.byte(c)
end

local function hex_to_char(x)
  do return string.char, tonumber(x, 16) end
  return string.char, tonumber(x, 16)
end

function M.encode_uri(uri)
  if nil == uri then
    return nil
  end
  uri = uri:gsub("([^%w%-%.%_%~%!%*%'%(%)%;%/%?%:%@%&%=%+%$%,%#])", char_to_hex)
  uri = uri:gsub(" ", "+")
  return uri
end

function M.decode_uri(uri)
  if nil == uri then
    return nil
  end
  uri = uri:gsub("+", " ")
  uri = uri:gsub("%%(%x%x)", hex_to_char)
  return uri
end

function M.parse_query(str, sep)
  sep = sep or "&"
  local values = {}
  for key_str, val in str:gmatch(string.format("([^%q=]+)(=*[^%q=]*)", sep, sep)) do
    local key = decode(key_str)
    local keys = {}
    key = key:gsub("%[([^%]]*)%]", function(v)
      if string.find(v, "^-?%d+$") then
        v = tonumber(v)
      else
        v = decode(v)
      end
      table.insert(keys, v)
      return "="
    end)
    key = key:gsub("=+.*$", "")
    key = key:gsub("%s", "_")
    val = val:gsub("^=+", "")
    if not values[key] then
      values[key] = {}
    end
    if #keys > 0 and type(values[key]) ~= "table" then
      values[key] = {}
    elseif 0 == #keys and type(values[key]) == "table" then
      values[key] = decode(val)
    end
    local t = values[key]
    for i, k in ipairs(keys) do
      if type(t) ~= "table" then
        t = {}
      end
      if "" == k then
        k = #t + 1
      end
      if not t[k] then
        t[k] = {}
      end
      if i == #keys then
        t[k] = decode(val)
      end
      t = t[k]
    end
  end
  setmetatable(values, {
    __tostring = M.encode_query_with_array_separate
  })
  return values
end

local function setAuthority(comp, authority)
  comp.authority = authority
  comp.port = nil
  comp.host = nil
  comp.userinfo = nil
  comp.user = nil
  comp.password = nil
  authority = authority:gsub("^([^@]*)@", function(v)
    comp.userinfo = v
    return ""
  end)
  authority = authority:gsub("^%[[^%]]+%]", function(v)
    comp.host = v
    return ""
  end)
  authority = authority:gsub(":([^:]*)$", function(v)
    comp.port = tonumber(v)
    return ""
  end)
  if "" ~= authority and not comp.host then
    comp.host = authority:lower()
  end
  if comp.userinfo then
    local userinfo = comp.userinfo
    userinfo = userinfo:gsub(":([^:]*)$", function(v)
      comp.password = v
      return ""
    end)
    comp.user = userinfo
  end
  return authority
end

local function setQuery(comp, query)
  comp.query = M.parse_query(query)
  comp.query_ori_str = query or ""
  return query
end

function M.parse(url)
  local comp = {}
  setAuthority(comp, "")
  setQuery(comp, "")
  url = tostring(url or "")
  url = url:gsub("#(.*)$", function(v)
    comp.fragment = v
    return ""
  end)
  url = url:gsub("^([%w][%w%+%-%.]*)%:", function(v)
    comp.scheme = v:lower()
    return ""
  end)
  url = url:gsub("%?(.*)", function(v)
    setQuery(comp, v)
    return ""
  end)
  url = url:gsub("^//([^/]*)", function(v)
    setAuthority(comp, v)
    return ""
  end)
  comp.path = decode(url)
  return comp
end

function M.url_query(url, query)
  return url .. "?" .. M.encode_query_with_array_separate(query)
end

local function trim_uri_separators(path)
  if nil == path or "" == path then
    return path
  end
  local pattern = "^[/]*(.-)[/]*$"
  do return path.gsub, path, pattern end
  return path.gsub, path, pattern, "%1"
end

function M.uri_join(...)
  local all_parts = {
    ...
  }
  local trimed_parts = {}
  for _, p in ipairs(all_parts) do
    p = trim_uri_separators(p)
    table.insert(trimed_parts, p)
  end
  do return table.concat, trimed_parts end
  return table.concat, trimed_parts, "/", ipairs(all_parts)
end

function M.get_location(uri)
  if not uri then
    return nil
  end
  local temp = uri
  local ej = require("ejoysdk_lua.ejoysdk")
  if ej.Utils.start_with(uri, "http://") or ej.Utils.start_with(uri, "file://") then
    temp = string.sub(uri, 8)
  elseif ej.Utils.start_with(uri, "https://") then
    temp = string.sub(uri, 9)
  end
  _ejoysdk.log(TAG .. " origin url = " .. uri)
  _ejoysdk.log(TAG .. "  temp = " .. temp)
  local query_index = string.find(temp, "?")
  if query_index and query_index > 0 then
    temp = string.sub(temp, 1, query_index - 1)
  end
  local fragment_index = string.find(temp, "#")
  if fragment_index and fragment_index > 0 then
    temp = string.sub(temp, 1, fragment_index - 1)
  end
  _ejoysdk.log(TAG .. " origin url = " .. uri .. ", code = " .. temp)
  return temp
end

function M.append_param(uri, key, value)
  local append_params = "?"
  if string.find(uri, "?") then
    append_params = "&"
  end
  append_params = append_params .. M.escape(key) .. "=" .. M.escape(value)
  local shell_pos = string.find(uri, "#")
  local ej = require("ejoysdk_lua.ejoysdk")
  do return ej.Utils.string_insert, uri, append_params end
  return ej.Utils.string_insert, uri, append_params, shell_pos
end

return M

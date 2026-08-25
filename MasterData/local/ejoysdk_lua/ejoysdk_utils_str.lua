local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "utils_str"
local STR = {}

function STR.endswith(str, substr)
  if nil == str or nil == substr then
    return nil, "the string or the sub-string parameter is nil"
  end
  local str_tmp = string.reverse(str)
  local substr_tmp = string.reverse(substr)
  if 1 ~= string.find(str_tmp, substr_tmp) then
    return false
  else
    return true
  end
end

function STR.is_empty(str)
  return not str or type(str) ~= "string" or "" == str
end

function STR.append_url_path(url, path)
  local E = require("ejoysdk_lua.ejoysdk")
  if STR.is_empty(path) then
    E.LOG.warn(TAG, "appendUrlPath path is nil")
    return url
  end
  local query_index = string.find(url, "?", 1, true)
  local url_base = url
  local url_query
  if query_index and query_index > 1 then
    url_base = string.sub(url, 1, query_index - 1)
    url_query = string.sub(url, query_index)
  end
  if STR.endswith(url_base, "/") then
    local url_len = string.len(url_base)
    url_base = string.sub(url_base, 1, url_len - 1)
  end
  local url_with_path = url_base .. path
  local result = url_with_path
  if url_query then
    result = url_with_path .. url_query
  end
  E.LOG.debug(TAG, "append_url_path result:" .. result)
  return result
end

function STR.get_url_parts(url)
  local parts = {}
  local query_index = string.find(url, "?", 1, true)
  local fragment_index = string.find(url, "#", 1, true)
  parts.url_base = url
  parts.url_query = nil
  parts.url_fragment = nil
  if query_index and query_index > 1 then
    if fragment_index and fragment_index > 1 then
      parts.url_base = string.sub(url, 1, math.min(query_index, fragment_index) - 1)
      if query_index < fragment_index then
        parts.url_fragment = string.sub(url, fragment_index)
        parts.url_query = string.sub(url, query_index, fragment_index - 1)
      else
        parts.url_fragment = string.sub(url, fragment_index, query_index - 1)
        parts.url_query = string.sub(url, query_index)
      end
    else
      parts.url_base = string.sub(url, 1, query_index - 1)
      parts.url_query = string.sub(url, query_index)
    end
  end
  if STR.endswith(parts.url_base, "/") then
    local url_len = string.len(parts.url_base)
    parts.url_base = string.sub(parts.url_base, 1, url_len - 1)
  end
  return parts
end

function STR.append_query_params(url, params)
  local E = require("ejoysdk_lua.ejoysdk")
  if not params then
    E.LOG.debug(TAG, "appendUrlPath params is nil")
    return url
  end
  local parts = STR.get_url_parts(url)
  local url_query_params = {}
  if parts.url_query then
    local query_str = string.sub(parts.url_query, 2)
    url_query_params = E.HTTP.parse_query(query_str)
  end
  for k, v in pairs(params) do
    local origin_val = url_query_params[k]
    if origin_val ~= v then
      E.LOG.debug(TAG, "append_query_params, overide url param, k:" .. tostring(k) .. ", override v:" .. tostring(v) .. ", origin v:" .. tostring(origin_val))
      url_query_params[k] = v
    end
  end
  local append_query_params_str = ""
  for k, v in pairs(url_query_params) do
    append_query_params_str = append_query_params_str .. E.HTTP.escape(tostring(k)) .. "=" .. E.HTTP.escape(tostring(v))
    append_query_params_str = append_query_params_str .. "&"
  end
  local query_params_str_len = string.len(append_query_params_str)
  append_query_params_str = string.sub(append_query_params_str, 1, query_params_str_len - 1)
  parts.url_query = "?" .. append_query_params_str
  local result = parts.url_base .. parts.url_query
  if parts.url_fragment then
    result = result .. parts.url_fragment
  end
  return result
end

function STR.get_query_parameter(url, key)
  local parts = STR.get_url_parts(url)
  local url_query_params = {}
  if parts.url_query then
    local E = require("ejoysdk_lua.ejoysdk")
    local query_str = string.sub(parts.url_query, 2)
    url_query_params = E.HTTP.parse_query(query_str)
  end
  return url_query_params[key]
end

function STR.get_root_host_from_host(origin_host)
  local function split_host(host)
    local parts = {}
    
    for part in host:gmatch("[^%.]+") do
      table.insert(parts, part)
    end
    return parts
  end
  
  local function get_root_domain(host)
    local parts = split_host(host)
    if #parts < 2 then
      return host
    end
    local second_level_suffix = {
      co = true,
      com = true,
      org = true,
      gov = true,
      edu = true,
      net = true,
      ac = true,
      ne = true
    }
    local last = parts[#parts]
    if 2 == #last and #parts >= 2 then
      local second_last = parts[#parts - 1]
      if second_level_suffix[second_last] then
        if #parts >= 3 then
          do return table.concat, parts, ".", #parts - 2 end
          return table.concat, parts, ".", #parts - 2, #parts
        else
          return host
        end
      end
    end
    do return table.concat, parts, ".", #parts - 1 end
    return table.concat, parts, ".", #parts - 1, #parts, #parts
  end
  
  local host = origin_host
  if not host or "" == host then
    return nil
  end
  local succ, data = pcall(get_root_domain, host)
  if succ then
    return data
  end
  return nil
end

return STR

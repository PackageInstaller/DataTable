local E = require("ejoysdk_lua.ejoysdk")
local JSON = require("ejoysdk_lua.apm-sdk-lua.common.json_utils")
local Utils = require("ejoysdk_lua.apm-sdk-lua.common.utils")
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local Labeler = require("ejoysdk_lua.apm-sdk-lua.label.labeler")
local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local M = {}
local data_type_map = {
  boolean = "boolValue",
  number = "doubleValue",
  string = "stringValue",
  table = "kvlistValue"
}
local LOGGER = "apm_otlp_http"
local resource_cache = {
  [Global.DataCgrEnum.APM_STATS] = {},
  [Global.DataCgrEnum.API_STATS] = {},
  [Global.DataCgrEnum.RPC_STATS] = {},
  [Global.DataCgrEnum.APM_EVENT_STATS] = {},
  [Global.DataCgrEnum.APM_EVENT_LOG] = {},
  [Global.DataCgrEnum.APM_LOG] = {},
  [Global.DataCgrEnum.APM_SPAN] = {}
}
local MAX_LUA_STACK = 10
local log_output_format = "{\"resourceLogs\":[{\"resource\":{\"attributes\":%s},\"instrumentationLibraryLogs\":[{\"logs\":%s,\"instrumentationLibrary\":{}}]}]}"
local span_output_format = "{\"resourceSpans\":[{\"resource\":{\"attributes\":%s},\"instrumentationLibrarySpans\":[{\"spans\":%s}]}]}"

local function convert_kv_list(data, recursively_call_time, key)
  recursively_call_time = recursively_call_time or 0
  if nil == data then
    return nil
  end
  if recursively_call_time >= MAX_LUA_STACK then
    E.LOG.error(LOGGER, "recursively_call_time exceeds MAX_LUA_STACK:" .. MAX_LUA_STACK .. " key:" .. tostring(key))
    return nil
  end
  local kvlist = {}
  for k, v in pairs(data) do
    local t = type(v)
    if "table" == t then
      if 0 == #v then
        recursively_call_time = recursively_call_time + 1
        v = {
          values = convert_kv_list(v, recursively_call_time, k)
        }
      else
        v = nil
      end
    end
    if nil ~= v and nil ~= data_type_map[t] then
      table.insert(kvlist, {
        key = k,
        value = {
          [data_type_map[t]] = v
        }
      })
    end
  end
  if 0 == #kvlist then
    return nil
  end
  return kvlist
end

local nano_time_counter = 0

local function cvt_to_time_unix_nano(timeMill)
  nano_time_counter = nano_time_counter + 1
  if nano_time_counter >= 1.0E7 then
    nano_time_counter = 1
  end
  do return string.format, "%s%06d", (tostring(timeMill)) end
  return string.format, "%s%06d", tostring(timeMill), nano_time_counter
end

local function add_service_name(resource)
  local key = "service.name"
  local value = "ejoysdk"
  if nil ~= resource then
    if nil == resource[key] then
      resource[key] = value
    end
  else
    resource = {
      [key] = value
    }
  end
  return resource
end

local function get_static_resource_json(resource, rtype, is_span)
  local cache = resource_cache[rtype]
  if cache.obj == nil or not Utils:is_table_equals(cache.obj, resource) then
    E.LOG.debug(LOGGER, "cache updated......rtype:" .. tostring(rtype))
    cache.obj = E_UTILS.deepcopy(resource)
    if is_span then
      local tmp_obj = E_UTILS.deepcopy(resource)
      tmp_obj = add_service_name(tmp_obj)
      cache.json = JSON.encode(convert_kv_list(tmp_obj))
    else
      cache.json = JSON.encode(convert_kv_list(cache.obj))
    end
    return cache.json
  end
  E.LOG.debug(LOGGER, "use cache......" .. ",rtype:" .. rtype)
  return cache.json
end

function M.build_otlp_logs_v2(resource, data)
  local logs = {}
  local rtype = ""
  for i, record in ipairs(data) do
    if 1 == i then
      rtype = record.type
    end
    table.insert(logs, {
      name = record.type,
      timeUnixNano = cvt_to_time_unix_nano(record.timestamp),
      attributes = convert_kv_list(record.attributes),
      body = {
        kvlistValue = {
          values = convert_kv_list(record.body)
        }
      }
    })
  end
  local minimised_resource = resource
  if rtype == Global.DataCgrEnum.APM_LOG and Global.is_apus_sdk_initialized() then
    minimised_resource = Labeler.minimise_resource(resource)
  end
  do return string.format, log_output_format, get_static_resource_json(minimised_resource, rtype, false), JSON.encode(logs) end
  return string.format, log_output_format, get_static_resource_json(minimised_resource, rtype, false), JSON.encode(logs)
end

function M.build_otlp_spans_v2(resource, data)
  local spans = {}
  local rtype = Global.DataCgrEnum.APM_SPAN
  for _, record in ipairs(data) do
    if record.attributes ~= nil then
      record.attributes = convert_kv_list(record.attributes)
    end
    table.insert(spans, record)
  end
  do return string.format, span_output_format, get_static_resource_json(resource, rtype, true), JSON.encode(spans) end
  return string.format, span_output_format, get_static_resource_json(resource, rtype, true), JSON.encode(spans)
end

M.convert_kv_list = convert_kv_list
return M

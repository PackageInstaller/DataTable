local Global = require("ejoysdk_lua.apm-sdk-lua.global")
local Cfg = require("ejoysdk_lua.apm-sdk-lua.config.configurator")
local StringUtils = require("ejoysdk_lua.apm-sdk-lua.common.string_utils")
local SLS_FIELD_MAX_SIZE = 16384
local M = {}

local function jsonify(k)
  k = k:gsub(Global.labels_kv_concate_str, "\":\"")
  k = k:gsub(Global.labels_kvpair_concate_str, "\",\"")
  k = "{\"" .. k .. "\""
  return k
end

local metric_template = ",\"c1\":%.2f,\"c3\":%.2f,\"c2\":%.2f,\"qps\":%.2f,\"cnt\":%.0f}"

local function get_vector_size(vector)
  local vector_size = 0
  for k, v in pairs(vector) do
    if #k > 1 and v.count > 0 then
      vector_size = vector_size + 1
    end
  end
  return vector_size
end

local function nearly_reach_sls_field_size_limit(stats_content_size)
  return stats_content_size + 1024 > SLS_FIELD_MAX_SIZE
end

local function complete_json(stats_content)
  if string.sub(stats_content, #stats_content) == "," then
    stats_content = string.sub(stats_content, 1, #stats_content - 1)
  end
  return stats_content .. "]"
end

function M.get_stats(agg_group)
  if nil == agg_group then
    return nil
  end
  local vector = agg_group:get_all()
  local vector_size = get_vector_size(vector)
  if 0 == vector_size then
    agg_group:clear()
    return nil
  end
  local output = {}
  local interval = Cfg.get(Cfg.CATEGORY_STATS, "collect_interval", 60)
  local counter = 0
  local sb = StringUtils.new_string_buffer()
  sb:append("[")
  local stats_content_size = 1
  for k, v in pairs(vector) do
    if #k > 1 and v.count > 0 then
      counter = counter + 1
      k = jsonify(k)
      stats_content_size = stats_content_size + #k
      sb:append(k)
      local qps = v:get_count() / interval
      local metric_str = string.format(metric_template, v:get_min(), v:get_max(), v:get_avg(), qps, v:get_count())
      sb:append(metric_str)
      stats_content_size = stats_content_size + #metric_str
      if vector_size > counter then
        sb:append(",")
        stats_content_size = stats_content_size + 1
      end
      if nearly_reach_sls_field_size_limit(stats_content_size) and vector_size > counter then
        table.insert(output, complete_json(sb:to_string()))
        sb = StringUtils.new_string_buffer()
        sb:append("[")
        stats_content_size = 1
      end
    end
  end
  table.insert(output, complete_json(sb:to_string()))
  local result = {metric_group = output}
  agg_group:clear()
  return result
end

function M.apply_pattern(api)
  local index = string.find(api, "?", 1)
  if 1 == index then
    return api, "invalid api, api begins with '?'"
  end
  if index and index > 1 then
    api = string.sub(api, 1, index - 1)
  end
  local patterns = Cfg.get_api_pattern()
  if nil == patterns then
    return api, nil
  end
  for _, pattern in ipairs(patterns) do
    for k, v in pairs(pattern) do
      if string.match(api, k) then
        return v, nil
      end
    end
  end
  return api, nil
end

M.get_vector_size = get_vector_size
return M

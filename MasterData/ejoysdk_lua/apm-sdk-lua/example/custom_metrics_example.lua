local APUS = require("ejoysdk_lua.apm-sdk-lua.apus")
local stats = APUS:new_custom_stats("my-custom-stats")

local function get_mem_size()
  do return math.random end
  return math.random, 100
end

local mem_size = stats:new_gauge_with_func("mem_size", false, get_mem_size)
local error_count = {}
error_count["4xx"] = stats:new_counter("error_count", {code = "4xx"})
error_count["5xx"] = stats:new_counter("error_count", {code = "5xx"})
local request_duration = stats:new_aggregate("request_duration_ms")

local function update_request_metrics(status_code, duration)
  if status_code >= 500 then
    error_count["5xx"].inc()
  elseif status_code >= 400 then
    error_count["4xx"].inc()
  end
  request_duration.update(duration)
end

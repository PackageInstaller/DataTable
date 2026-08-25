local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.time")
local E = require("ejoysdk_lua.ejoysdk")
local get_now = os.time

function Time.now()
  do return end
  return get_now, nil
end

function Time.now_utc()
  local utc_ms = E.system_ms()
  if utc_ms and utc_ms > 0 then
    do return math.floor end
    return math.floor, utc_ms / 1000
  end
  do return end
  return get_now, utc_ms / 1000
end

function Time.now_ms()
  return E.system_ms() or os.time() * 1000
end

function Time.system_clock()
  do return end
  return E.system_clock, nil
end

return Time

local E = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local CAL_SPEED_INTERVAL = 1
local DEFAULT_PRIORITY = 0.5
local TAG = EM.MODULE.ODR .. "odr_manager"
local request_and_size = {}
local total_tag_size = 0
local total_loaded_size = 0
local tag_and_loaded_size = {}
local last_cal_loaded_size = 0
local last_cal_time = 0
local current_speed = 0
local cul_speed_tag = false
local download_speed_listener
local current_priority = DEFAULT_PRIORITY
local current_expect_speed = 0

function M.load_progress(tag, progress, timestamp)
  if nil == tag or nil == progress then
    return
  end
  for id, size in pairs(request_and_size) do
    if id == tag then
      local loaded_size = size * progress
      tag_and_loaded_size[tag] = loaded_size
      total_loaded_size = M._cul_total_size(tag_and_loaded_size)
      M._cal_speed(timestamp)
    end
  end
end

function M.add_request(tag, size)
  if size and 0 ~= size and nil ~= tag then
    request_and_size[tag] = size
    total_tag_size = M._cul_total_size(request_and_size)
    E.LOG.debug(TAG, "total tag size >> " .. tostring(total_tag_size))
  end
end

function M.remove_request(tag)
  if nil ~= tag then
    request_and_size[tag] = nil
    total_tag_size = M._cul_total_size(request_and_size)
    E.LOG.debug(TAG, "total tag size >> " .. tostring(total_tag_size))
  end
end

function M._start_cal_speed_loop()
  if not cul_speed_tag then
    cul_speed_tag = true
    local loop_func
    
    function loop_func()
      if cul_speed_tag then
        M._cal_speed()
        E.Timer.once(1, loop_func)
      end
    end
    
    loop_func()
  end
end

function M.stop_cal_speed_loop()
  cul_speed_tag = false
end

function M._cul_total_size(tag_and_size)
  local total_size = 0
  if tag_and_size then
    for _, size in pairs(tag_and_loaded_size) do
      total_size = total_size + size
    end
  end
  return total_size
end

function M._cal_speed(timestamp)
  local cur_time = timestamp / 1000
  E.LOG.debug(TAG, "current time in lua >> " .. tostring(cur_time))
  if 0 == last_cal_time then
    last_cal_time = cur_time
  end
  local diff_time = cur_time - last_cal_time
  if 0 ~= diff_time and diff_time >= CAL_SPEED_INTERVAL then
    E.LOG.debug(TAG, "diff time  >> " .. tostring(diff_time))
    local diff_size = total_loaded_size - last_cal_loaded_size
    local speed = math.floor(diff_size / diff_time)
    current_speed = speed
    if speed > 0 and download_speed_listener then
      last_cal_time = cur_time
      last_cal_loaded_size = total_loaded_size
      local format_speed = speed / 1000
      E.LOG.debug(TAG, "new odr download speed >> " .. tostring(format_speed) .. ", expect speed >>   " .. tostring(current_expect_speed))
      download_speed_listener(speed)
    end
  end
end

function M.speed_to_priority(expect_speed)
  current_expect_speed = expect_speed * 8
  local ret = current_priority
  local expect_speed_bit = expect_speed * 8 * 1000
  E.LOG.debug(TAG, "expect speed bit >> " .. tostring(expect_speed_bit))
  E.LOG.debug(TAG, "current priority >> " .. tostring(current_priority) .. ", and current speed >> " .. tostring(current_speed))
  if 0 == current_priority then
    if expect_speed_bit > current_speed * 1.1 then
      E.LOG.debug(TAG, "expect speed bit > current speed * 1.1, set priority 0.1")
      ret = 0.1
    end
    E.LOG.debug(TAG, "expect speed bit < current speed * 1.1, return 0")
    return ret
  end
  local max_speed = current_speed / current_priority
  E.LOG.debug(TAG, "max speed >> " .. tostring(max_speed))
  if expect_speed_bit > max_speed then
    ret = 1
  elseif expect_speed_bit < max_speed then
    E.LOG.debug(TAG, "expect speed < max_speed")
    ret = expect_speed_bit / max_speed
    ret = tonumber(string.format("%0.1f", ret))
  end
  E.LOG.debug(TAG, "speed exchange priority result >> " .. tostring(ret))
  return ret
end

function M.set_new_priority(priority)
  current_priority = priority
end

function M.get_current_speed()
  return current_speed
end

function M.register_download_speed_listener(listener)
  download_speed_listener = listener
end

return M

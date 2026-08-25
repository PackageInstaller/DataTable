local E = require("ejoysdk_lua.ejoysdk")
local M = {}
local TAG = "cloud_time_pass_ticker"
local last_remain_time, current_remain_time_tick, pass_time
local is_time_pass_loop_run = false
local local_next_interval = 0
local current_refresh_time

local function time_pass_loop()
  if is_time_pass_loop_run then
    return
  end
  is_time_pass_loop_run = true
  local loop
  
  function loop()
    E.Timer.once(1, function()
      if not is_time_pass_loop_run then
        E.LOG.debug(TAG, "is_time_pass_loop_run is false")
        return
      end
      if pass_time > local_next_interval then
        is_time_pass_loop_run = false
        E.LOG.debug(TAG, "pass_time > local_next_interval, stop loop >> " .. tostring(pass_time) .. ", " .. tostring(local_next_interval))
        return
      end
      pass_time = pass_time + 1
      local time_now = os.time()
      if time_now > current_refresh_time then
        local interval = time_now - current_refresh_time
        if interval < local_next_interval then
          local offset = interval - pass_time
          if offset > 5 then
            E.LOG.debug(TAG, "offset > 5 seconds, update pass time to " .. tostring(interval))
            pass_time = interval
          end
        else
          E.LOG.debug(TAG, "time now is later than next interval >> " .. tostring(local_next_interval))
          pass_time = local_next_interval
        end
      end
      E.LOG.debug(TAG, "pass_time >> " .. tostring(pass_time) .. ", " .. tostring(local_next_interval))
      loop()
    end)
  end
  
  loop()
end

function M.tick_remain_time(remain_time, next_interval, refresh_time)
  if local_next_interval ~= next_interval then
    E.LOG.debug(TAG, "update next interval >> " .. tostring(next_interval))
    local_next_interval = next_interval
  end
  if current_refresh_time ~= refresh_time then
    E.LOG.debug(TAG, "update refresh time >> " .. tostring(refresh_time))
    current_refresh_time = refresh_time
  end
  if remain_time <= 0 then
    E.LOG.debug(TAG, "remain time <= 0, stop loop")
    current_remain_time_tick = 0
    is_time_pass_loop_run = false
    return 0
  end
  if not is_time_pass_loop_run then
    E.LOG.debug(TAG, "is_time_pass_loop_run = false, start loop")
    time_pass_loop()
  end
  if remain_time ~= last_remain_time then
    last_remain_time = remain_time
    pass_time = 0
    current_remain_time_tick = remain_time
    return remain_time
  else
    current_remain_time_tick = remain_time - pass_time
    return current_remain_time_tick
  end
end

return M

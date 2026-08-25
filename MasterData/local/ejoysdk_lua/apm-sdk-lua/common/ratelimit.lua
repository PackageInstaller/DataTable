local apm_stats = require("ejoysdk_lua.apm-sdk-lua.stats.apm_stats")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local M = {}
local limiter = {
  scene = "",
  rate = 0,
  burst = 0,
  remain_tokens = 0,
  last = 0,
  token_exceed_counter = nil
}
limiter.__index = limiter
local scene_list = {}

function limiter.new(rate, burst, scene)
  if type(rate) ~= "number" or type(burst) ~= "number" then
    return nil, "illegal param,expect numbers"
  end
  if burst < 0 then
    return nil, "illegal param,expect positive burst"
  end
  if type(scene) ~= "string" or "" == scene then
    return nil, "illegal param,scene expect a not nil string"
  end
  if nil ~= scene_list[scene] then
    return nil, "scene:" .. scene .. " has already registered"
  end
  scene_list[scene] = 0
  local obj = {
    burst = burst,
    rate = rate,
    token_exceed_counter = apm_stats:new_counter(scene .. "_throttled", true)
  }
  return setmetatable(obj, limiter), nil
end

function limiter:allow()
  do return self.allow_n, self, (Time.now_ms()) end
  return self.allow_n, self, Time.now_ms(), 1
end

function limiter:allow_n(now, n)
  if self.rate < 0 then
    return true
  end
  local last, tokens
  last, tokens = self:advance(now)
  local ok = n <= tokens
  tokens = tokens - n
  if ok then
    self.last = now
    self.remain_tokens = tokens
  else
    self.last = last
    self.token_exceed_counter:inc(n)
  end
  return ok
end

function limiter:advance(now)
  local last = self.last
  if now < last then
    last = now
  end
  local elapsed = now - last
  local delta = elapsed * self.rate / 1000
  local tokens = self.remain_tokens + delta
  if tokens > self.burst then
    tokens = self.burst
  end
  return last, tokens
end

function limiter:set_burst(burst)
  if burst > 0 then
    self.burst = burst
  end
end

function limiter:set_rate(rate)
  if rate >= -1 then
    self.rate = rate
  end
end

function M.new_limiter(limit, burst, scene)
  do return limiter.new, limit, burst end
  return limiter.new, limit, burst, scene
end

return M

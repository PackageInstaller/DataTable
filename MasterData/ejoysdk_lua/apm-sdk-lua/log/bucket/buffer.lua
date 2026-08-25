local Formatter = require("ejoysdk_lua.apm-sdk-lua.log.formatter")
local Queue = require("ejoysdk_lua.apm-sdk-lua.common.container.queue")
local buffer = {}
buffer.__index = buffer

function buffer:flush()
  while self.buffer:qsize() > 0 do
    local t = self.buffer:dequeue()
    if self.target then
      self.target:put(t.catalog, t.record)
    end
  end
end

function buffer:should_flush(_, record)
  return record.level <= self.flush_level or self.buffer:qsize() >= self.capacity
end

function buffer:put(catalog, record)
  local msg = self.formatter(catalog, record)
  self.buffer:enqueue({
    msg = msg,
    catalog = catalog,
    record = record
  })
  if self:should_flush(catalog, record) then
    self:flush()
    return true
  end
end

function buffer:set_target(target)
  self.target = target
end

buffer.default_params = {
  format = "text",
  color = false,
  capacity = 1,
  flush_level = 3
}

local function default_target(params)
  local mod = require("ejoysdk_lua.apm-sdk-lua.log.bucket.cloud")
  local target_params = {}
  if mod.default_params then
    setmetatable(target_params, {
      __index = mod.default_params
    })
  end
  do return mod.new, "log" end
  return mod.new, "log", {
    format = params.format,
    color = params.color
  }, params.color
end

function buffer.new(_, params)
  local obj = {}
  obj.capacity = params.capacity
  obj.formatter = Formatter.get_formatter(params.format, params.color)
  obj.buffer = Queue.create()
  obj.flush_level = params.flush_level
  obj.target = default_target(params)
  do return setmetatable, obj end
  return setmetatable, obj, buffer
end

return buffer

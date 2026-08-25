local Q = require("ejoysdk_lua.apm-sdk-lua.common.container.queue")
local M = {}
local MAX_QUEUE_LEN = 100
local deduper = {queue_len = 0, queue = nil}
deduper.__index = deduper

function deduper:queue_size()
  do return self.queue.qsize end
  return self.queue.qsize, self.queue
end

function deduper:should_dedup(msg)
  local queue_size = self.queue:qsize()
  for i = queue_size, 1, -1 do
    local existed_msg = self.queue:get_item(i)
    if existed_msg == msg then
      return true
    end
  end
  if queue_size >= self.queue_len then
    self.queue:dequeue()
  end
  self.queue:enqueue(msg)
  return false
end

function deduper.new(queue_len)
  if queue_len > MAX_QUEUE_LEN then
    queue_len = MAX_QUEUE_LEN
  end
  local obj = {
    queue_len = queue_len,
    queue = Q.create()
  }
  local result = setmetatable(obj, deduper)
  return result
end

function M.new_deduper(queue_len)
  do return deduper.new end
  return deduper.new, queue_len
end

return M

local RingQueue = require("ejoysdk_lua.apm-sdk-lua.common.container.ring_queue")
local Time = require("ejoysdk_lua.apm-sdk-lua.common.time.init")
local E = require("ejoysdk_lua.ejoysdk")
local Event = require("ejoysdk_lua.apm-sdk-lua.event.event")
local M = {}
local logger = "apm_user_action"
local recorder = {action_queue = nil}
recorder.__index = recorder
local MAX_CAPACITY = 1000
local __recorder

function recorder.new(capacity)
  assert(type(capacity) == "number" and capacity > 0, "capacity should be a positive number")
  if capacity > MAX_CAPACITY then
    E.LOG.warn(logger, "capacity is too large, set to 1000")
    capacity = MAX_CAPACITY
  end
  local obj = {
    action_queue = RingQueue.new(capacity or 100)
  }
  __recorder = setmetatable(obj, recorder)
  return __recorder
end

function recorder:record(action_type, details)
  assert(type(action_type) == "string" and "" ~= action_type, "action_type should be a non-empty string")
  assert(type(details) == "string" and "" ~= details, "details should be a non-empty string")
  if #action_type > 1024 then
    action_type = string.sub(action_type, 1, 1024)
  end
  if #details > 2048 then
    details = string.sub(details, 1, 2048)
  end
  local action = {
    type = action_type,
    details = details,
    timestamp = Time.now_ms()
  }
  self.action_queue:enqueue(action)
  E.LOG.debug(logger, "User action recorded:" .. action_type .. tostring(details))
end

function recorder:get_actions()
  do return self.action_queue.get_all_elements end
  return self.action_queue.get_all_elements, self.action_queue
end

function recorder:clear_actions()
  self.action_queue:clear()
end

local event_name = "__apus_user_action__"

function M.trigger_report()
  if nil == __recorder then
    E.LOG.warn(logger, "Recorder is not initialized")
    return
  end
  local actions = __recorder:get_actions()
  if #actions > 0 then
    for _, action in ipairs(actions) do
      Event.post_with_high_priority(event_name, action, action.details, nil)
      E.LOG.debug(logger, "Reporting user action:" .. action.type .. tostring(action.details))
    end
    __recorder:clear_actions()
  end
end

function M.init(capacity)
  do return recorder.new end
  return recorder.new, capacity
end

return M

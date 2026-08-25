local E = require("ejoysdk_lua.ejoysdk")
local ESP_I = require("ejoysdk_lua.opentracing.api.span")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = ESP_I:Inherit("EjoySpan")
local TAG = EM.MODULE.OPENTRACING .. "EjoySpan"

function M:_init(tracer, operation_name, span_context, start_timestamp, tags, references)
  self.tracer = tracer
  self.operation_name = operation_name
  self.span_context = span_context
  self.start_timestamp = math.floor(start_timestamp)
  self.start_clock = E.system_clock()
  if nil ~= tags then
    self.tags = tags
  else
    self.tags = {}
  end
  if nil ~= references then
    self.references = references
  end
  self.duration_milliseconds = 0
  self.finished = false
  self.logs = {}
end

function M:context()
  return self.span_context
end

function M:tracer()
  return self.tracer
end

function M:get_operation_name()
  return self.operation_name
end

function M:set_operation_name(operation_name)
  self.operation_name = operation_name
end

function M:get_start()
  return self.start_timestamp
end

function M:get_end()
  return self.end_timestamp
end

function M:get_duration()
  return self.duration_milliseconds
end

function M:finish(finish_timestamp)
  self.end_timestamp = finish_timestamp
  if 0 == self.end_timestamp then
    self.end_timestamp = E.system_ms()
    self.start_timestamp = math.floor(self.end_timestamp - (E.system_clock() - self.start_clock))
    self.tags["span.local_time"] = "1"
  end
  if 0 == self.start_timestamp then
    self.start_timestamp = math.floor(self.end_timestamp - (E.system_clock() - self.start_clock))
  end
  self:finish_with_duration(self.end_timestamp - self.start_timestamp)
end

function M:finish_now()
  local current_time = E.time_ms()
  self:finish(current_time)
end

function M:finish_with_duration(duration_millis)
  if self.finished then
    E.LOG.warn(TAG, "Span has already been finished; will not be reported again.")
  end
  self.finished = true
  self.duration_milliseconds = duration_millis
  self.tracer:report_span(self)
end

function M:is_finish()
  return self.finished
end

function M:set_tag(key, value)
  if nil == key or nil == value then
    return
  end
  self.tags[key] = value
end

function M:get_tags()
  return self.tags
end

function M:get_refrences()
  if self.references == nil then
    return {}
  end
  return self.references
end

function M:log_kv(key_values, timestamp, message)
  local log_data = {
    time = timestamp,
    message = message,
    fields = key_values
  }
  table.insert(self.logs, log_data)
end

function M:get_logs()
  return self.logs
end

function M:set_baggage_item(key, value)
  if nil == key or nil == value then
    return
  end
  self.tracer.set_baggage_item(self, key, value)
end

function M:get_baggage_item(key)
  do return self.span_context.get_baggage_item end
  return self.span_context.get_baggage_item, key
end

function M:each_baggage_item()
end

function M:get_service_name()
  return self.tracer.service_name
end

function M:to_string()
  return ""
end

return M

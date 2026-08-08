local function log_message_impl(level, tag, message, context)
  local stack = table.slice(debug.traceback():split("\n"), 4)
  
  message = tostring(message) .. "\n" .. table.join(stack, "\n")
  CS.GameDebug.LogImpl("LUA", level, tag, message, context)
end

function print(tag, message, context)
end

function info(tag, message, context)
  log_message_impl(CS.GameDebug.LogLevel.Info, tag, message, context)
end

function warning(tag, message, context)
  log_message_impl(CS.GameDebug.LogLevel.Warning, tag, message, context)
end

function error(tag, message, context)
  log_message_impl(CS.GameDebug.LogLevel.Error, tag, message, context)
end

function assert(condition, tag, message, context)
  if not condition then
    error(tag, message, context)
  end
  return condition
end

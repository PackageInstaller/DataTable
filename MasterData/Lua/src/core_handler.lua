function handler(this, callback)
  local dict = setmetatable({}, table.weakMetatable)
  
  dict[1] = this
  if IS_EDITOR or IS_DEV_BUILD then
    dict[2] = this.__cname or tostring(this)
  end
  return function(...)
    local target = dict[1]
    if target then
      return callback(target, ...)
    elseif IS_EDITOR or IS_DEV_BUILD then
      errorf(string.format("The binder \"%s\" has been destroyed!", dict[2]))
    end
  end
end

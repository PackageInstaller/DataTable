local BackManager = {}
local stack = List:create()

function BackManager:firstPush(callback)
  stack:clear()
  self:push(callback)
end

function BackManager:push(callback)
  local function func()
    if callback then
      callback()
    end
  end
  
  stack:push(func)
end

function BackManager:pop()
  local func = stack:pop()
  if func then
    func()
  end
end

function BackManager:count()
  return stack:count()
end

function BackManager:empty()
  return stack:empty()
end

function BackManager:front()
  return stack:front()
end

function BackManager:clear()
  stack:clear()
end

return BackManager

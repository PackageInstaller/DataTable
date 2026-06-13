local setmetatable = _ENV.setmetatable
local FindTransformRecursively = CSHelper.FindTransformRecursively
local metatable = {
  __index = function(pool, name)
    local node = FindTransformRecursively(pool.__Transform, name, true)
    if node and not node:IsNull() then
      pool[name] = node
    end
    return node
  end
}
local checkMetatable = {
  __index = function(pool, name)
    local node = FindTransformRecursively(pool.__Transform, name, true)
    if node and not node:IsNull() then
      pool[name] = node
      return node
    else
      Log.Info(pool.__Transform.name .. "child node not exist " .. name)
    end
  end
}
return function(transform, noCheck)
  assert(transform)
  local pool = {__Transform = transform}
  return setmetatable(pool, noCheck and metatable or checkMetatable)
end

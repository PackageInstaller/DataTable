local S = {
  __storage = setmetatable({}, {__mode = "v"})
}

function S:Register(env, name)
  assert(self.__storage[name] == nil, "Singleton of " .. name .. " already registered")
  self.__storage[name] = env
  return self
end

function S:Unregister(name)
  self.__storage[name] = nil
end

function S:Get(name)
  return self.__storage[name]
end

return S

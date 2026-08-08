local makeRef
local gasket = {
  __len = function(this)
    local trans = this:getTrans()
    if trans ~= nil then
      return trans.childCount
    end
  end
}
gasket.__index = table.makeLookup(gasket, function(this, key)
  local result = this:getCache(key)
  if result == nil then
    local isstring = type(key) == "string"
    if isstring and key:sub(1, 1) == "$" then
      result = this:queryFunction(key:sub(2))
      this:setCache(key, result)
    else
      result = this:rawQuery(key)
      if result == nil then
        result = this:query(key)
        if isstring then
          this:setCache(key, result)
        end
      end
    end
  end
  return result
end)

function gasket:getEnv()
  local env = rawget(self, "__env")
  if env == nil then
    local injector = self:query(typeof(CS.LuaInjector))
    if injector ~= nil then
      env = injector.Sandbox
      rawset(self, "__env", env)
    end
  end
  return env
end

function gasket:getUserData(key)
  return self.__userdata[key]
end

function gasket:setUserData(key, value)
  self.__userdata[key] = value
end

function gasket:getTrans()
  local trans = self.transform
  if trans ~= nil and not trans:IsNull() then
    return trans
  end
end

function gasket:queryFunction(key)
  local env = self:getEnv()
  if assert(env ~= nil, "Calling a non lua binded object.") then
    __strict_suspend = true
    local func = env[key]
    __strict_suspend = false
    return func
  end
end

function gasket:rawQuery(key)
  local result = rawget(self, key)
  if result == nil then
    local trans = self:getTrans()
    if trans ~= nil then
      result = trans[key]
    end
  else
    warning("RefInject", "Should not be here")
  end
  return result
end

function gasket:doQuery(key, predicate, direction)
  direction = direction or "down"
  local result
  local trans = self:getTrans()
  if trans ~= nil then
    local key_type = type(key)
    if key_type == "number" then
      result = makeRef(trans:GetChild(key))
    else
      local comps
      if key_type == "userdata" then
        if direction == "down" then
          comps = table.linq(trans:GetComponents(key))
        else
          comps = table.linq(trans:GetComponentsInParent(key))
        end
      else
        if direction == "down" then
          comps = table.linq(trans:GetComponents(typeof(CS.UnityEngine.Component)))
        else
          comps = table.linq(trans:GetComponentsInParent(typeof(CS.UnityEngine.Component)))
        end
        comps = comps:where(function(_, comp)
          return comp:GetType().Name == key
        end):toarray()
      end
      local _
      _, result = comps:find(function(_, comp)
        return predicate == nil or predicate(comp)
      end)
    end
  end
  return result
end

function gasket:query(key, predicate)
  return self:doQuery(key, predicate)
end

function gasket:queryParent(key, predicate)
  return self:doQuery(key, predicate, "up")
end

function gasket:fetchChild(index)
  local trans = self:getTrans()
  if trans ~= nil then
    return trans:GetChild(index)
  end
end

function gasket:setCache(key, value)
  self.__cache[key] = value
end

function gasket:getCache(key)
  local result = self.__cache[key]
  if result ~= nil then
    if type(result) == "userdata" then
      if result:IsNull() then
        result = nil
      end
    elseif type(result) == "table" and result.root.transform:IsNull() then
      result = nil
    end
    if result == nil then
      self.__cache[key] = nil
      info("RefInject", "Cache hit for key but value is invalid: " .. tostring(key))
    end
  end
  return result
end

function gasket:resetCache()
  self.__cache = setmetatable({}, {__mode = "v"})
end

function gasket:new(trans)
  return setmetatable({
    __userdata = {},
    __cache = setmetatable({}, {__mode = "v"}),
    transform = trans,
    gameObject = trans.gameObject
  }, self)
end

local ref = {
  __newindex = function(this, key, value)
    if key:sub(1, 1) == "@" then
      this.root:setUserData(key, value)
    end
  end,
  __pool = setmetatable({}, {__mode = "k"})
}
ref.__index = table.makeLookup(ref, function(this, key)
  local prefix = key:sub(1, 1)
  if prefix == "@" then
    return this.root:getUserData(key)
  elseif prefix == "$" then
    local sub_key = key:sub(2)
    if sub_key:len() > 0 then
      return this.root[sub_key]
    else
      return this.root
    end
  elseif this.nilnodes[key] ~= nil then
    return nil
  else
    local gasketInstance = rawget(this, key)
    if not gasketInstance then
      local trans = this:queryTransform(key)
      if trans ~= nil then
        gasketInstance = this:createGasket(trans, key)
      else
        this.nilnodes[key] = 0
      end
    end
    return gasketInstance
  end
end)

function ref:createGasket(trans, key)
  local gasketInstance = gasket:new(trans)
  rawset(self, key, gasketInstance)
  return gasketInstance
end

function ref:queryTransformImpl(trans, key)
  local result
  if trans:GetComponent(typeof(CS.UIHtmlLabel)) == nil then
    for i = 0, trans.childCount - 1 do
      local trans = trans:GetChild(i)
      if trans.name == key then
        result = trans
      else
        result = ref:queryTransformImpl(trans, key)
      end
      if result ~= nil then
        break
      end
    end
  end
  return result
end

function ref:queryTransform(key)
  return ref:queryTransformImpl(self.root.transform, key)
end

function ref:initCache()
  if type(self.target) == "userdata" then
    local injections = self.target.Injections
    if injections ~= nil and injections.Length > 0 then
      for i = 0, injections.Length - 1 do
        local injection = injections[i]
        local component = injection.target
        if component ~= nil then
          local gasketName = injection.gasketName
          local gasketInstance = rawget(self, gasketName)
          if gasketInstance == nil then
            gasketInstance = self:createGasket(component.transform, gasketName)
          end
          gasketInstance:setCache(injection.componentName, component)
        end
      end
    end
  end
end

function ref:new(trans, target)
  local instance = setmetatable({
    root = gasket:new(trans),
    target = target,
    userdata = {},
    nilnodes = {}
  }, self)
  instance:initCache()
  return instance
end

function makeRef(target)
  local instance
  if target ~= nil then
    local trans = target.transform
    if trans ~= nil then
      instance = ref.__pool[trans:GetInstanceID()]
      if instance == nil then
        instance = ref:new(trans, target)
        ref.__pool[trans:GetInstanceID()] = instance
      end
    end
  end
  return instance
end

function unRef(target)
  if target ~= nil then
    local trans = target.transform
    if trans ~= nil then
      ref.__pool[trans:GetInstanceID()] = nil
    end
  end
end

function reRef(target)
  unRef(target)
  return makeRef(target)
end

_ENV["$"] = makeRef
return makeRef

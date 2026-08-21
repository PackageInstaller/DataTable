_G.Classes = {}
_G.Enums = {}
monitorObjs = setmetatable({}, {__mode = "k"})

function _class(child, base, ...)
  if Classes[child] then
    error("duplicate class : " .. child)
  end
  local c = _G[child]
  assert(not c, child)
  c = {}
  _G[child] = c
  if base then
    for k, v in pairs(base) do
      if nil == c[k] and v ~= "_proto" then
        c[k] = v
      end
    end
    setmetatable(c, base)
  elseif child ~= "Object" then
    assert(base ~= nil, "base is nil: " .. child)
  end
  if not c then
    Log.sys(child .. " ", Log.traceback())
  end
  c.__index = c
  c._className = child
  c.super = base
  c.nrec = -1
  
  function c:New(...)
    local instance = -1 == c.nrec and {} or table.create(0, c.nrec)
    setmetatable(instance, c)
    instance._className = c._className
    if App.Profiler then
      monitorObjs[instance] = instance._className .. "~~\n" .. Log.traceback()
    end
    do
      local create
      
      function create(c, ...)
        if c.super then
          create(c.super, ...)
        end
        if c.Constructor and (not c.super or c.super.Constructor ~= c.Constructor) then
          c.Constructor(instance, ...)
        end
      end
      
      create(c, ...)
    end
    if -1 == c.nrec then
      c.nrec = table.gethsize(instance)
    end
    return instance
  end
  
  function c:GetType()
    return getmetatable(self)
  end
  
  function c:IsBaseOf(child)
    local base = self
    repeat
      child = getmetatable(child)
      if child == base then
        return true
      end
    until child == nil
    return false
  end
  
  function c:IsChildOf(obj)
    if type(obj) ~= "string" then
      Log.fatal("IsChildOf, param Error")
      return
    end
    obj = _G[obj]
    local father = self
    repeat
      father = getmetatable(father)
      if father == obj then
        return true
      end
    until father == nil
    return false
  end
  
  function c:__call(t)
    local typeT = t
    repeat
      typeT = getmetatable(typeT)
      if typeT == self then
        return t
      end
    until typeT == nil
    return nil
  end
  
  function c:IsInstanceOfType(t)
    return getmetatable(t) == self
  end
  
  Classes[child] = c
  if LuaAppEvent and LuaAppEvent:IsBaseOf(c) then
    local cname = "CLSID_" .. child
    c.clsid = MessageDef[cname]
    if c.clsid == nil or c.clsid == 0 then
      if c == CPushEvent or c == CCallEvent or c == CCallRequestEvent or c == CCallReplyEvent or c == CSvrPushEvent or c == CCliPushEvent or c == CMatchPushEvent then
        return
      end
      Log.warn("can not find " .. cname .. " in MessageDef")
      return
    end
    NetMessageFactory:GetInstance():RegisterMessage(c)
  end
end

_class("Object", nil)
Object = Object

function Object:ToObject(obj)
  setmetatable(obj, self)
  return obj
end

function _enum(name, t)
  rawset(_G, name, t)
  Enums[name] = t
end

function _autoEnum(name, array)
  local t = {}
  for k, v in ipairs(array) do
    t[v] = k
  end
  rawset(_G, name, t)
end

function GetEnumKey(name, v)
  local nName = name .. "Rev"
  if not _G[nName] then
    rawset(_G, nName, table.reverse(_G[name]))
  end
  return _G[nName][v]
end

function _vvEnum(name, array)
  local t = {}
  for k, v in ipairs(array) do
    t[v] = v
  end
  rawset(_G, name, t)
end

function _staticClass(name)
  local t = {}
  rawset(_G, name, t)
  return t
end

function _createInstance(className, ...)
  local class = _G[className]
  if class then
    return class:New(...)
  end
  return nil
end

function dynamic_cast(type, t)
  if getmetatable(t) == type then
    return t
  else
    Log.error("dynamic_cast failed! :")
    return nil
  end
end

function IsSubClassOf(className, superClassName)
  if type(className) ~= "string" or type(superClassName) ~= "string" then
    Log.fatal("IsSubClassOf, param Error")
    return
  end
  local father = _G[className]
  repeat
    if father._className == superClassName then
      return true
    end
    father = getmetatable(father)
  until father == nil
  return false
end

function _removeClass(className)
  _G[className] = nil
  _G.Classes[className] = nil
end

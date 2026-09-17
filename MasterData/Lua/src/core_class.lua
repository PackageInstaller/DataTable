local function _multiIndex(cls, key)
  for _, super in ipairs(cls.__supers) do
    local v = super[key]
    
    if v ~= nil then
      return v
    end
  end
end

local function emptyCtor(self)
end

local function _noInjection(t, k, v)
  errorf("禁止向 class 定义中注入字段，静态变量需要提前定义")
end

local function getName(cls)
  return cls.__cname
end

local function isSubclassOf(selfCls, cls)
  if selfCls == cls then
    return false
  end
  while selfCls ~= nil do
    if selfCls == cls then
      return true
    end
    selfCls = selfCls.super
  end
  return false
end

local function isInstanceOf(self, cls)
  local scls = self.class
  if scls == nil then
    return false
  end
  if scls == cls then
    return true
  end
  return scls:isSubclassOf(cls)
end

local function importPartialClass(selfCls, partCls)
  table.merge(selfCls, partCls)
  partCls.super = selfCls.super
end

function class(classname, ...)
  local cls = {__cname = classname}
  local superCount = select("#", ...)
  for i = 1, superCount do
    local super = select(i, ...)
    if type(super) == "table" then
      if i == 1 then
        cls.super = super
      else
        cls.__supers = cls.__supers or {
          cls.super
        }
        table.insert(cls.__supers, super)
      end
      if super._mt then
        super._mt.__newindex = _noInjection
      end
    else
      return
    end
  end
  cls.__index = cls
  cls._mt = {
    __index = cls.__supers and _multiIndex or cls.super
  }
  setmetatable(cls, cls._mt)
  if not cls.ctor then
    cls.ctor = emptyCtor
  end
  
  function cls.new(...)
    cls._mt.__newindex = _noInjection
    local instance = {}
    setmetatable(instance, cls)
    instance.class = cls
    instance:ctor(...)
    return instance
  end
  
  cls.getName = getName
  cls.isSubclassOf = isSubclassOf
  cls.isInstanceOf = isInstanceOf
  cls.importPartialClass = importPartialClass
  return cls
end

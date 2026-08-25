local function newInstance(cls, ...)
  local instance = {}
  
  setmetatable(instance, cls)
  if instance.ctor then
    instance:ctor(...)
  end
  return instance
end

function class(classname, ...)
  local cls = {}
  local supers = {
    ...
  }
  local superCls
  for _, super in ipairs(supers) do
    if super then
      local superType = type(super)
      assert("table" == superType, string.format("class() - create class \"%s\" with invalid super class type \"%s\"", classname, superType))
      cls.__supers = cls.__supers or {}
      cls.__supers[#cls.__supers + 1] = super
      if not cls.__super then
        cls.__super = super
        superCls = super
      end
    end
  end
  if not cls.__supers or 1 == #cls.__supers then
    if cls.__super then
      setmetatable(cls, {
        __index = cls.__super
      })
    else
      setmetatable(cls, {})
    end
  else
    setmetatable(cls, {
      __index = function(_, key)
        local supers = cls.__supers
        for i = 1, #supers do
          local super = supers[i]
          if super[key] then
            return super[key]
          end
        end
      end
    })
  end
  local metatable = getmetatable(cls)
  rawset(metatable, "__call", newInstance)
  cls.__cname = classname
  cls.__index = cls
  cls.__isClass = true
  cls.__name = classname
  cls.__fullname = classname
  cls.__super = superCls
  cls.__kind = "C"
  cls.__call = newInstance
  return cls, superCls
end

local _IsKindof

function _IsKindof(cls, name)
  local __index = rawget(cls, "__index")
  if type(__index) == "table" and rawget(__index, "__cname") == name then
    return true
  end
  if rawget(cls, "__cname") == name then
    return true
  end
  local __supers = rawget(cls, "__supers")
  if not __supers then
    return false
  end
  for _, super in ipairs(__supers) do
    if _IsKindof(super, name) then
      return true
    end
  end
  return false
end

function IsClassOf(cls, classname)
  if not cls then
    return false
  end
  do return _IsKindof, cls end
  return _IsKindof, cls, classname
end

function IsKindOf(obj, classname)
  local t = type(obj)
  local mt
  if "table" == t then
    mt = getmetatable(obj)
  end
  do return IsClassOf, mt end
  return IsClassOf, mt, classname
end

function IsClass(t)
  return type(t) == "table" and t.__isClass == true
end

ClassType = {class = 1, instance = 2}
local _class = {}

function class(classname, super)
  assert(type(classname) == "string" and 0 < #classname)
  local class_type = {}
  class_type.ctor = false
  class_type.__cname = classname
  class_type.__ctype = ClassType.class
  class_type.super = super
  
  function class_type.New(...)
    local obj = {}
    obj.__class_type = class_type
    obj.__ctype = ClassType.instance
    setmetatable(obj, {
      __index = _class[class_type]
    })
    local create
    
    function create(c, ...)
      if c.super then
        create(c.super, ...)
      end
      if c.ctor then
        c.ctor(obj, ...)
      end
    end
    
    create(class_type, ...)
    return obj
  end
  
  local vtbl = {}
  _class[class_type] = vtbl
  setmetatable(class_type, {
    __newindex = function(t, k, v)
      vtbl[k] = v
    end,
    __index = vtbl
  })
  if super then
    setmetatable(vtbl, {
      __index = function(t, k)
        local ret = _class[super][k]
        return ret
      end
    })
  end
  return class_type
end

function IsInstanceOfClass(obj, class)
  if obj == nil or class == nil then
    error("obj or class is nil")
    return nil
  end
  if obj.__ctype ~= ClassType.instance or class.__ctype ~= ClassType.class then
    error("can't judge without an instance and class")
    return nil
  end
  local objClass = obj.__class_type
  while objClass ~= nil do
    if objClass.__cname == class.__cname then
      return true
    else
      objClass = objClass.super
    end
  end
  return false
end

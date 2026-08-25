local System = {}
local rpc_collection = require("Foundation.System.rpc_define.rpc_collection")
local rpc_dispatch = require("Foundation.System.rpc_define.rpc_dispatch")
local param_types = require("Foundation.System.rpc_define.param_types")
require("Foundation.System.String")
require("Foundation.System.Table")
System.RPC = rpc_collection.rpc_function
System.RpcCollection = rpc_collection
System.RpcDispatch = rpc_dispatch
System.ParamTypes = param_types
local string = _ENV.string
local type = _ENV.type
local getmetatable = _ENV.getmetatable
local setmetatable = _ENV.setmetatable
local rawget = _ENV.rawget
local next = _ENV.next
local assert = _ENV.assert
local pairs = _ENV.pairs
local select = _ENV.select
local error = _ENV.error
local tostring = _ENV.tostring
System.RequirePaths = {}

function System.emptyFn()
end

function System.baseType(this)
  return this.__super
end

function System.is(this, type)
  local mt = getmetatable(this)
  if mt then
    local inherits = rawget(mt, "__inherits")
    if inherits then
      return inherits[type] == type
    end
  end
  return false
end

function System.readonly(mt)
  local obj = {}
  setmetatable(obj, {
    __index = function(table, key)
      local v = mt[key]
      if nil == v then
        local mkt = getmetatable(table)
        if nil ~= mkt.__name then
          local ret = true
          if not key then
            ret = false
          end
          if "number" == type(key) and 0 == key then
            ret = false
          end
          if "string" == type(key) then
            ret = false
          end
          if ret then
          end
        end
      end
      return v
    end,
    __len = function(t)
      return #mt
    end,
    __pairs = function()
      local key, valueStore
      return function()
        key, valueStore = next(mt, key)
        if valueStore then
          return key, valueStore
        end
      end
    end,
    __ipairs = function()
      local index = 0
      local v
      return function()
        index = index + 1
        v = mt[index]
        if v then
          return index, v
        end
      end
    end,
    __newindex = function()
      assert(false, "can't change readonly table")
    end,
    __next = function(old_next, _, index)
      do return old_next, mt end
      return old_next, mt, index
    end
  })
  return obj
end

function System.GetLanguageValue(v)
  if not System.LanguageFunc then
    return v
  end
  do return System.LanguageFunc end
  return System.LanguageFunc, v
end

function System.SetLanguageFunc(func)
  System.LanguageFunc = func
end

function System.ReadonlyWithDefault(mt, default, language)
  if nil == default and nil == language then
    do return System.readonly end
    return System.readonly, mt, nil, nil, nil
  end
  local obj = {}
  setmetatable(obj, {
    __index = function(t, k)
      local v = mt[k]
      if nil == v then
        v = default[k]
      end
      if language and language[k] and v and "" ~= v then
        v = System.GetLanguageValue(v)
      end
      return v
    end,
    __len = function(t)
      return #mt
    end,
    __pairs = function()
      return next, mt, nil
    end,
    __newindex = function()
      assert(false, "can't change readonly table")
    end
  })
  return obj
end

function System.DataTableWithDefault(mt, default)
  setmetatable(mt, {__index = default})
  return mt
end

function System.isDerivedFrom(baseType, derivedType)
  return derivedType.__inherits[baseType] ~= nil
end

function System.as(this, type)
  if System.is(this, type) then
    return this
  else
    return nil
  end
end

function System.cast(this, type)
  if not System.is(this, type) then
    error(string.format("转换失败：%s,%s", tostring(this:GetTypeFullName()), tostring(type.__name)))
  end
  return this
end

local function checkInterface(classType)
  local inherits = classType.__inherits
  for super in pairs(inherits) do
    if super.__kind == "I" then
      for funcName, func in pairs(super) do
        if "function" == type(func) then
          assert(classType[funcName], string.format("没有实现接口 %s.%s", super.__name, funcName))
        end
      end
    end
  end
end

local function newInstance(type, ...)
  if rawget(type, "__abstract") then
    assert(false, "can't instance abstract class " .. tostring(type.__name) .. "" .. debug.traceback())
  end
  checkInterface(type)
  local instance = {}
  setmetatable(instance, type)
  if instance.ctor then
    instance:ctor(...)
  end
  return instance
end

local poolObjStateFree = 0
local poolObjStateUsing = 1
local poolInstances = {}

local function newPoolInstance(type, ...)
  if rawget(type, "__abstract") then
    assert(false, "can't instance abstract class " .. tostring(type.__name) .. "" .. debug.traceback())
  end
  checkInterface(type)
  local fullname = type.__fullname
  poolInstances[fullname] = poolInstances[fullname] or {}
  local objs = poolInstances[fullname]
  local instance = table.remove(objs, 1)
  while nil ~= instance and instance.poolObjState == poolObjStateUsing do
    error("[newPoolInstance Error] instance is using!!!")
    instance = table.remove(objs, 1)
  end
  instance = instance or {}
  setmetatable(instance, type)
  if instance.ctor then
    instance:ctor(...)
  end
  instance.poolObjState = poolObjStateUsing
  return instance
end

local function recyclePoolInstance(instance)
  if not instance then
    return
  end
  local fullname = instance.__fullname
  if not fullname then
    return
  end
  local mt = getmetatable(instance)
  if not mt then
    return
  end
  poolInstances[fullname] = poolInstances[fullname] or {}
  table.insert(poolInstances[fullname], instance)
  instance:OnRecycle()
  setmetatable(instance, nil)
end

local function NewType(kind, fullname, ...)
  local inType = {__kind = kind}
  local superCount = select("#", ...)
  local superClass
  local inherits = {}
  if superCount > 0 then
    for i = 1, superCount do
      local super = select(i, ...)
      if nil == super or "table" ~= type(super) then
        error("新建类" .. fullname .. "时必须传入正确的基类")
      end
      if super.__kind == "C" then
        if nil == superClass then
          superClass = super
        else
          error("新建类" .. fullname .. "时不能拥有多个基类")
        end
      end
      inherits[super] = super
    end
  end
  if nil == superClass then
    if inType.__kind == "C" then
      superClass = System.BaseObject
    elseif inType.__kind == "S" then
      superClass = System.BaseStruct
    end
  end
  inType.__name = fullname
  inType.__fullname = fullname
  inType.__index = inType
  inType.__super = superClass
  inType.__inherits = inherits
  if inType.__kind == "C" or inType.__kind == "S" then
    inType.__call = newInstance
  end
  setmetatable(inType, superClass)
  inherits[inType] = inType
  if superClass then
    local bases = rawget(superClass, "__inherits")
    if bases then
      for i, v in pairs(bases) do
        inherits[i] = v
      end
    end
  end
  return inType, superClass
end

local function NewPoolType(kind, fullname, ...)
  local inType = {__kind = kind}
  local superCount = select("#", ...)
  local superClass
  local inherits = {}
  if superCount > 0 then
    for i = 1, superCount do
      local super = select(i, ...)
      if nil == super or "table" ~= type(super) then
        error("新建类" .. fullname .. "时必须传入正确的基类")
      end
      if super.__kind == "C" then
        if nil == superClass then
          superClass = super
        else
          error("新建类" .. fullname .. "时不能拥有多个基类")
        end
      end
      inherits[super] = super
    end
  end
  if nil == superClass then
    if inType.__kind == "C" then
      superClass = System.BasePoolObject
    elseif inType.__kind == "S" then
      superClass = System.BaseStruct
    end
  end
  inType.__name = fullname
  inType.__fullname = fullname
  inType.__index = inType
  inType.__super = superClass
  inType.__inherits = inherits
  if inType.__kind == "C" or inType.__kind == "S" then
    inType.__call = newPoolInstance
  end
  setmetatable(inType, superClass)
  inherits[inType] = inType
  if superClass then
    local bases = rawget(superClass, "__inherits")
    if bases then
      for i, v in pairs(bases) do
        inherits[i] = v
      end
    end
  end
  return inType, superClass
end

function System.NewClass(name, ...)
  do return NewType, "C", name, ... end
  return NewType, "C", name, ...
end

function System.NewPoolClass(name, ...)
  do return NewPoolType, "C", name, ... end
  return NewPoolType, "C", name, ...
end

function System.NewComponent(name, super, ...)
  if super then
    do return System.NewClass, name, super, ... end
    return System.NewClass, name, super, ...
  else
    do return System.NewClass, name, UIMvvmComponent, ... end
    return System.NewClass, name, UIMvvmComponent, ...
  end
end

local function errorNewInstance(type, ...)
  assert(false, "can't instance abstract class " .. tostring(type.__name) .. "" .. debug.traceback())
end

function System.NewAbstractClass(name, ...)
  local inType, superClass = NewType("C", name, ...)
  rawset(inType, "__abstract", true)
  return inType, superClass
end

function System.NewStruct(name, ...)
  do return NewType, "S", name, ... end
  return NewType, "S", name, ...
end

function System.NewInterface(name, ...)
  do return NewType, "I", name, ... end
  return NewType, "I", name, ...
end

function System.NewEnum(t)
  t.__kind = "E"
  return t
end

function System.IsClass(t)
  return "table" == type(t) and t.__kind == "C"
end

function System.IsStruct(t)
  return "table" == type(t) and t.__kind == "S"
end

function System.IsEnum(t)
  return "table" == type(t) and t.__kind == "E"
end

function System.Register(fullpath, path, mod)
  rpc_collection.rpc_register_mod(path, mod)
  rpc_dispatch.add_comp_path(path, fullpath)
end

function System.ImportRpcModule(requirePath, modName)
  local module = require(requirePath)
  if not System.IsClass(module) then
    error(requirePath .. "不是rpc模块")
    return module
  end
  System.Register(GetLuaModulePath(requirePath), modName or module.__name, module)
  return module
end

function System.fn(target, method)
  assert(method)
  if nil == target then
    error("ArgumentNullException")
  end
  local f = target[method]
  if nil == f then
    function f(...)
      do return method, target, ... end
      
      return method, target, ...
    end
    
    target[method] = f
  end
  return f
end

function System.bind(method, ...)
  local args = {
    ...
  }
  
  local function f(...)
    local temp = {}
    table.append(temp, args)
    table.append(temp, {
      ...
    })
    do return method, table.unpack(temp) end
    return method, table.unpack(temp)
  end
  
  return f
end

local BaseType = {__name = "BaseType", __kind = "C"}

function BaseType:GetType()
  do return getmetatable end
  return getmetatable, self
end

function BaseType:GetReflectionType()
  return self.__type
end

function BaseType:GetTypeFullName()
  return self.__fullname
end

function BaseType:GetTypeName(type)
  return self.__name
end

BaseType.isDerivedFrom = System.isDerivedFrom

function BaseType:cast(type)
  do return System.cast, self end
  return System.cast, self, type
end

function BaseType:as(type)
  do return System.as, self end
  return System.as, self, type
end

function BaseType:is(type)
  do return System.is, self end
  return System.is, self, type
end

BaseType.__index = BaseType
System.BaseType = BaseType
local BaseObject = System.NewClass("BaseObject", BaseType)
BaseObject.ctor = System.emptyFn
BaseObject.__call = newInstance
System.BaseObject = BaseObject
local BaseStruct = {}
BaseStruct.ctor = System.emptyFn
BaseStruct.__call = newInstance
local BasePoolObject = System.NewClass("BasePoolObject", BaseType)
BasePoolObject.ctor = System.emptyFn
BasePoolObject.__call = newPoolInstance
BasePoolObject.OnRecycle = System.emptyFn

function BasePoolObject:Release()
  if self.poolObjState ~= poolObjStateUsing then
    return
  end
  self.poolObjState = poolObjStateFree
  recyclePoolInstance(self)
end

System.BasePoolObject = BasePoolObject

function BaseStruct:Clone()
  local newInstance = newInstance(getmetatable(self))
  for i, v in pairs(self) do
    rawset(newInstance, i, v)
  end
  return newInstance
end

System.BaseStruct = System.NewStruct("BaseStruct", BaseStruct, BaseType)

function System.ErrorCode(code, msg)
  if "table" == type(code) then
    return code
  else
    return msg and {code = code, msg = msg} or code
  end
end

function System.ToBool(value, nilDefault)
  if nil == value then
    return nilDefault
  end
  return not not value
end

return System

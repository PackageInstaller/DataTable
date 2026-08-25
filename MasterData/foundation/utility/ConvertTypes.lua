local xlua = _ENV.xlua
local CS = _ENV.CS
local ConvertTypes = {}

local function ConvertVector2()
  local get_x, set_x = xlua.genaccessor(0, 8)
  local get_y, set_y = xlua.genaccessor(4, 8)
  local fields_getters = {x = get_x, y = get_y}
  local fields_setters = {x = set_x, y = set_y}
  local ins_methods = {
    Set = function(o, x, y)
      set_x(o, x)
      set_y(o, y)
    end
  }
  local originMt = xlua.getmetatable(CS.UnityEngine.Vector2)
  local mt = {
    __index = function(o, k)
      if ins_methods[k] then
        return ins_methods[k]
      end
      local getter = fields_getters[k]
      if nil ~= getter then
        do return getter end
        return getter, o, nil
      end
      do return originMt.__index, o end
      return originMt.__index, o, k
    end,
    __newindex = function(o, k, v)
      local setter = fields_setters[k]
      if nil == setter then
        error("no such field " .. k)
      else
        setter(o, v)
      end
    end,
    __tostring = function(o)
      do return string.format, "vector2 { %f, %f }", o.x end
      return string.format, "vector2 { %f, %f }", o.x, o.y
    end,
    __add = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      do return CS.UnityEngine.Vector2, a.x + b.x end
      return CS.UnityEngine.Vector2, a.x + b.x, a.y + b.y, b.y
    end,
    __sub = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      do return CS.UnityEngine.Vector2, a.x - b.x end
      return CS.UnityEngine.Vector2, a.x - b.x, a.y - b.y, b.y
    end,
    __div = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      if type(b) ~= "number" then
        Logger.Error("attempt to divides a vector by a value which is not number(type)")
        return
      end
      do return CS.UnityEngine.Vector2, a.x / b end
      return CS.UnityEngine.Vector2, a.x / b, a.y / b
    end
  }
  xlua.setmetatable(CS.UnityEngine.Vector2, mt)
end

local function ConvertVector3()
  local get_x, set_x = xlua.genaccessor(0, 8)
  local get_y, set_y = xlua.genaccessor(4, 8)
  local get_z, set_z = xlua.genaccessor(8, 8)
  local fields_getters = {
    x = get_x,
    y = get_y,
    z = get_z
  }
  local fields_setters = {
    x = set_x,
    y = set_y,
    z = set_z
  }
  local ins_methods = {
    Set = function(o, x, y, z)
      set_x(o, x)
      set_y(o, y)
      set_z(o, z)
    end
  }
  local originMt = xlua.getmetatable(CS.UnityEngine.Vector3)
  local mt = {
    __index = function(o, k)
      if ins_methods[k] then
        return ins_methods[k]
      end
      local getter = fields_getters[k]
      if nil ~= getter then
        do return getter end
        return getter, o, nil
      end
      do return originMt.__index, o end
      return originMt.__index, o, k
    end,
    __newindex = function(o, k, v)
      local setter = fields_setters[k]
      if nil == setter then
        error("no such field " .. k)
      else
        setter(o, v)
      end
    end,
    __tostring = function(o)
      do return string.format, "vector3 { %f, %f, %f }", o.x, o.y end
      return string.format, "vector3 { %f, %f, %f }", o.x, o.y, o.z
    end,
    __add = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      do return CS.UnityEngine.Vector3, a.x + b.x, a.y + b.y end
      return CS.UnityEngine.Vector3, a.x + b.x, a.y + b.y, a.z + b.z, b.z
    end,
    __sub = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      do return CS.UnityEngine.Vector3, a.x - b.x, a.y - b.y end
      return CS.UnityEngine.Vector3, a.x - b.x, a.y - b.y, a.z - b.z, b.z
    end,
    __div = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      if type(b) ~= "number" then
        Logger.Error("attempt to divides a vector by a value which is not number(type)")
        return
      end
      do return CS.UnityEngine.Vector3, a.x / b, a.y / b end
      return CS.UnityEngine.Vector3, a.x / b, a.y / b, a.z / b
    end,
    __mul = function(a, b)
      if not a or not b then
        Logger.Error("attempt to perform arithmetic on a nil value")
        return
      end
      if type(b) ~= "number" then
        Logger.Error("attempt to divides a vector by a value which is not number(type)")
        return
      end
      do return CS.UnityEngine.Vector3, a.x * b, a.y * b end
      return CS.UnityEngine.Vector3, a.x * b, a.y * b, a.z * b
    end
  }
  xlua.setmetatable(CS.UnityEngine.Vector3, mt)
end

local function ConvertQuaternion()
  local get_x, set_x = xlua.genaccessor(0, 8)
  local get_y, set_y = xlua.genaccessor(4, 8)
  local get_z, set_z = xlua.genaccessor(8, 8)
  local get_w, set_w = xlua.genaccessor(12, 8)
  local fields_getters = {
    x = get_x,
    y = get_y,
    z = get_z,
    w = get_w
  }
  local fields_setters = {
    x = set_x,
    y = set_y,
    z = set_z,
    w = set_w
  }
  local ins_methods = {
    Set = function(o, x, y, z, w)
      set_x(o, x)
      set_y(o, y)
      set_z(o, z)
      set_w(o, w)
    end
  }
  local originMt = xlua.getmetatable(CS.UnityEngine.Quaternion)
  local mt = {
    __index = function(o, k)
      if ins_methods[k] then
        return ins_methods[k]
      end
      local getter = fields_getters[k]
      if nil ~= getter then
        do return getter end
        return getter, o, nil
      end
      do return originMt.__index, o end
      return originMt.__index, o, k
    end,
    __newindex = function(o, k, v)
      local setter = fields_setters[k]
      if nil == setter then
        error("no such field " .. k)
      else
        setter(o, v)
      end
    end,
    __tostring = function(o)
      do return string.format, "Quaternion { %f, %f, %f, %f }", o.x, o.y, o.z end
      return string.format, "Quaternion { %f, %f, %f, %f }", o.x, o.y, o.z, o.w
    end,
    __mul = function(a, b)
      do return originMt.__mul, a end
      return originMt.__mul, a, b
    end
  }
  xlua.setmetatable(CS.UnityEngine.Quaternion, mt)
end

function ConvertTypes.Exec()
  ConvertVector2()
  ConvertVector3()
  ConvertQuaternion()
end

return ConvertTypes

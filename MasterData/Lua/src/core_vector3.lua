local get_x, set_x = xlua.genaccessor(0, 8)
local get_y, set_y = xlua.genaccessor(4, 8)
local get_z, set_z = xlua.genaccessor(8, 8)

local function get_magnitude(o)
  return math.sqrt(o.x * o.x + o.y * o.y + o.z * o.z)
end

local function get_sqrmagnitude(o)
  return o.x * o.x + o.y * o.y + o.z * o.z
end

local function get_normalized(o)
  return C_Vector3.Normalize(o)
end

local fields_getters = {
  x = get_x,
  y = get_y,
  z = get_z,
  normalized = get_normalized,
  magnitude = get_magnitude,
  sqrMagnitude = get_sqrmagnitude
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
local mt = {
  __index = function(o, k)
    if ins_methods[k] then
      return ins_methods[k]
    end
    return fields_getters[k] and fields_getters[k](o)
  end,
  __newindex = function(o, k, v)
    if fields_setters[k] then
      return fields_setters[k](o, v)
    else
      error("no such field " .. k)
    end
  end,
  __tostring = function(o)
    return string.format("vector3 { %f, %f, %f}", o.x, o.y, o.z)
  end,
  __add = function(a, b)
    return CS.UnityEngine.Vector3(a.x + b.x, a.y + b.y, a.z + b.z)
  end,
  __sub = function(a, b)
    return CS.UnityEngine.Vector3(a.x - b.x, a.y - b.y, a.z - b.z)
  end,
  __div = function(a, value)
    return CS.UnityEngine.Vector3(a.x / value, a.y / value, a.z / value)
  end,
  __mul = function(a, value)
    return CS.UnityEngine.Vector3(a.x * value, a.y * value, a.z * value)
  end,
  __eq = function(a, b)
    return a.x == b.x and a.y == b.y and a.z == b.z
  end
}
xlua.setmetatable(CS.UnityEngine.Vector3, mt)

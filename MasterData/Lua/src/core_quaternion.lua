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
local mt = {
  __index = function(o, k)
    if ins_methods[k] then
      return ins_methods[k]
    end
    return fields_getters[k] and fields_getters[k](o)
  end,
  __newindex = function(o, k, v)
    return fields_setters[k] and fields_setters[k](o, v) or error("no such field " .. k)
  end,
  __tostring = function(o)
    return string.format("vector3 { %f, %f, %f, %f}", o.x, o.y, o.z, o.w)
  end,
  __add = function(a, b)
    return CS.UnityEngine.Quaternion(a.x + b.x, a.y + b.y, a.z + b.z, a.w + b.w)
  end
}
xlua.setmetatable(CS.UnityEngine.Quaternion, mt)

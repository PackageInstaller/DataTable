local get_x, set_x = xlua.genaccessor(0, 4)
local get_y, set_y = xlua.genaccessor(4, 4)
local fields_getters = {x = get_x, y = get_y}
local fields_setters = {x = set_x, y = set_y}
local ins_methods = {
  Set = function(o, x, y)
    set_x(o, x)
    set_y(o, y)
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
    return string.format("vector3 { %f, %f, %f}", o.x, o.y)
  end,
  __add = function(a, b)
    return CS.UnityEngine.Vector3(a.x + b.x, a.y + b.y)
  end,
  __sub = function(a, b)
    return CS.UnityEngine.Vector3(a.x - b.x, a.y - b.y)
  end
}
xlua.setmetatable(CS.UnityEngine.Vector2, mt)

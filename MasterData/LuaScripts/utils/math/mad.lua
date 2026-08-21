--[[
****************************************************************************
Brief  :数学库通用封装
Author :龙二
Date   :2019-9-5 11:53:51
Copyright (c) 2019 雷焰网络. All rights reserved
****************************************************************************
]]
local ffi = nil--type(jit) == 'table' and jit.status() and require 'ffi'
local vec2, vec3, color, quat
local forward
local v2tmp1
local vtmp1
local vtmp2
local qtmp1
local M_EPSILON = 0.000001

vec2 = {
__call = function(_, x, y)
    return setmetatable({ x = x or 0, y = y or 0}, vec2)
end,
__tostring = function(v)
    return string.format("(%f, %f)",v.x,v.y)
end,
__add = function(v, u) return v:add(u, vec2()) end,
__sub = function(v, u) return v:sub(u, vec2()) end,
__mul = function(v, u)
    if vec2.isvec2(u) then 
        return v:mul(u, vec2())
    elseif type(u) == 'number' then 
        return v:scale(u, vec2())
    else 
        error('vec2 can only be multiplied by vec2 and numbers') 
    end
end,
__div = function(v, u)
    if vec2.isvec2(u) then 
        return v:div(u, vec2())
    elseif type(u) == 'number' then 
        return v:scale(1 / u, vec2())
    else 
        error('vec2 can only be divided by vec2 and numbers') 
    end
  end,
__unm = function(v) 
    return v:scale(-1) 
end,
__len = function(v) 
    return v:length() 
end,

__index = {
    isvec2 = function(x)
      return ffi and ffi.istype('vec2', x) or getmetatable(x) == vec2
    end,

    clone = function(v)
      return vec2(v.x, v.y)
    end,
    copy = function(v)
      return vec2(v.x, v.y)
    end,

    unpack = function(v)
      return v.x, v.y
    end,

    set = function(v, x, y)
      if vec2.isvec2(x) then x, y = x.x, x.y end
      v.x = x
      v.y = y
      return v
    end,

    add = function(v, u, out)
      out = out or v
      out.x = v.x + u.x
      out.y = v.y + u.y
      return out
    end,

    sub = function(v, u, out)
      out = out or v
      out.x = v.x - u.x
      out.y = v.y - u.y
      return out
    end,

    mul = function(v, u, out)
      out = out or v
      out.x = v.x * u.x
      out.y = v.y * u.y
      return out
    end,

    div = function(v, u, out)
      out = out or v
      out.x = v.x / u.x
      out.y = v.y / u.y
      return out
    end,

    scale = function(v, s, out)
      out = out or v
      out.x = v.x * s
      out.y = v.y * s
      return out
    end,

    length = function(v)
      return math.sqrt(v.x * v.x + v.y * v.y)
    end,

    normalize = function(v, out)
      out = out or v
      local len = v:length()
      return len == 0 and v or v:scale(1 / len, out)
    end,
    normalise = function(v, out)
      out = out or v
      local len = v:length()
      return len == 0 and v or v:scale(1 / len, out)
    end,

    distance = function(v, u)
      return vec2.sub(v, u, v2tmp1):length()
    end,

    angle = function(v, u)
      return math.acos(v:dot(u) / (v:length() * u:length()))
    end,

    dot = function(v, u)
      return v.x * u.x + v.y * u.y
    end,

    cross = function(v, u, out)
      out = out or v
      local a, b = v.x, v.y
      out.x = a * u.y - b * u.x
      out.y = b * u.x - a * u.y
      return out
    end,

    lerp = function(v, u, t, out)
      out = out or v
      out.x = v.x + (u.x - v.x) * t
      out.y = v.y + (u.y - v.y) * t
      return out
    end,
  }
}
vec3 = {
__call = function(_, x, y, z)
    return setmetatable({ x = x or 0, y = y or 0, z = z or 0 }, vec3)
end,
__tostring = function(v)
    return string.format('(%f, %f, %f)', v.x, v.y, v.z)
end,
__add = function(v, u) return v:add(u, vec3()) end,
__sub = function(v, u) return v:sub(u, vec3()) end,
__mul = function(v, u)
    if vec3.isvec3(u) then 
        return v:mul(u, vec3())
    elseif type(u) == 'number' then 
        return v:scale(u, vec3())
    else 
        error('vec3s can only be multiplied by vec3s and numbers') 
    end
end,
__div = function(v, u)
    if vec3.isvec3(u) then 
        return v:div(u, vec3())
    elseif type(u) == 'number' then 
        return v:scale(1 / u, vec3())
    else 
        error('vec3s can only be divided by vec3s and numbers') 
    end
end,
__unm = function(v) return v:scale(-1) end,
__len = function(v) return v:length() end,

__index = {
    isvec3 = function(x)
      return ffi and ffi.istype('vec3', x) or getmetatable(x) == vec3
    end,

    clone = function(v)
      return vec3(v.x, v.y, v.z)
    end,
    copy = function(v,v2)
      v.x = v2.x;
      v.y = v2.y;
      v.z = v2.z;
    end,

    unpack = function(v)
      return v.x, v.y, v.z
    end,

    set = function(v, x, y, z)
      if vec3.isvec3(x) then x, y, z = x.x, x.y, x.z end
      v.x = x
      v.y = y
      v.z = z
      return v
    end,

    add = function(v, u, out)
      out = out or v
      out.x = v.x + u.x
      out.y = v.y + u.y
      out.z = v.z + u.z
      return out
    end,

    sub = function(v, u, out)
      out = out or v
      out.x = v.x - u.x
      out.y = v.y - u.y
      out.z = v.z - u.z
      return out
    end,

    mul = function(v, u, out)
      out = out or v
      out.x = v.x * u.x
      out.y = v.y * u.y
      out.z = v.z * u.z
      return out
    end,

    div = function(v, u, out)
      out = out or v
      out.x = v.x / u.x
      out.y = v.y / u.y
      out.z = v.z / u.z
      return out
    end,

    scale = function(v, s, out)
      out = out or v
      out.x = v.x * s
      out.y = v.y * s
      out.z = v.z * s
      return out
    end,

    length = function(v)
      return math.sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
    end,

    normalize = function(v, out)
      out = out or v
      local len = v:length()
      return len == 0 and v or v:scale(1 / len, out)
    end,
    normalise = function(v, out)
      out = out or v
      local len = v:length()
      return len == 0 and v or v:scale(1 / len, out)
    end,

    distance = function(v, u)
      return vec3.sub(v, u, vtmp1):length()
    end,

    angle = function(v, u)
      return math.acos(v:dot(u) / (v:length() * u:length()))
    end,

    dot = function(v, u)
      return v.x * u.x + v.y * u.y + v.z * u.z
    end,

    cross = function(v, u, out)
      out = out or v
      local a, b, c = v.x, v.y, v.z
      out.x = b * u.z - c * u.y
      out.y = c * u.x - a * u.z
      out.z = a * u.y - b * u.x
      return out
    end,

    lerp = function(v, u, t, out)
      out = out or v
      out.x = v.x + (u.x - v.x) * t
      out.y = v.y + (u.y - v.y) * t
      out.z = v.z + (u.z - v.z) * t
      return out
    end,

    project = function(v, u, out)
      out = out or v
      local unorm = vtmp1
      u:normalize(unorm)
      local dot = v:dot(unorm)
      out.x = unorm.x * dot
      out.y = unorm.y * dot
      out.z = unorm.z * dot
      return out
    end,

    rotate = function(v, q, out)
      out = out or v
      local u, c, o = vtmp1, vtmp2, out
      u.x, u.y, u.z = q.x, q.y, q.z
      o.x, o.y, o.z = v.x, v.y, v.z
      u:cross(v, c)
      local uu = u:dot(u)
      local uv = u:dot(v)
      o:scale(q.w * q.w - uu)
      u:scale(2 * uv)
      c:scale(2 * q.w)
      return o:add(u:add(c))
    end,

    equals = function(v,v2)
      return v.x == v2.x and v.y == v2.y and v.z == v2.z
    end,

    toUnityVector3 = function( v )
      return gs.Vector3(v.x,v.y,v.z) ;
    end
    },
}
color = {
__call = function(_, r, g, b, a)
    return setmetatable({ r = r or 0, g = g or 0, b = b or 0, a = a or 0 }, color)
end,
__tostring = function(v)
    return string.format('(%f, %f, %f, %f)', v.r, v.g, v.b, v.a)
end,
__add = function(v, u) return v:add(u, color()) end,
__sub = function(v, u) return v:sub(u, color()) end,
__mul = function(v, u)
    if color.iscolor(u) then 
        return v:mul(u, color())
    elseif type(u) == 'number' then 
        return v:scale(u, color())
    else 
        error('vec3s can only be multiplied by vec3s and numbers') 
    end
end,
__div = function(v, u)
    if color.iscolor(u) then 
        return v:div(u, color())
    elseif type(u) == 'number' then 
        return v:scale(1 / u, color())
    else 
        error('vec3s can only be divided by vec3s and numbers') 
    end
end,

__index = {
    iscolor = function(x)
      return ffi and ffi.istype('color', x) or getmetatable(x) == color
    end,

    clone = function(v)
      return color(v.r, v.g, v.b, v.a)
    end,
    copy = function(v)
      return color(v.r, v.g, v.b, v.a)
    end,

    unpack = function(v)
      return v.r, v.g, v.b, v.a
    end,

    set = function(v, r, g, b, a)
      if color.iscolor(r) then r, g, b, a = r.r, r.g, r.b, r.a end
      v.r = r
      v.g = g
      v.b = b
      v.a = a
      return v
    end,

    add = function(v, u, out)
      out = out or v
      out.r = v.r + u.r
      out.g = v.g + u.g
      out.b = v.b + u.b
      out.a = v.a + u.a
      return out
    end,

    sub = function(v, u, out)
      out = out or v
      out.r = v.r - u.r
      out.g = v.g - u.g
      out.b = v.b - u.b
      out.a = v.a - u.a
      return out
    end,

    mul = function(v, u, out)
      out = out or v
      out.r = v.r * u.r
      out.g = v.g * u.g
      out.b = v.b * u.b
      out.a = v.a * u.a
      return out
    end,

    div = function(v, u, out)
      out = out or v
      out.r = v.r / u.r
      out.g = v.g / u.g
      out.b = v.b / u.b
      out.a = v.a / u.a
      return out
    end,

    scale = function(v, s, out)
      out = out or v
      out.r = v.r * s
      out.g = v.g * s
      out.b = v.b * s
      out.a = v.a * s
      return out
    end,

    lerp = function(v, u, t, out)
      out = out or v
      out.r = v.r + (u.r - v.r) * t
      out.g = v.g + (u.g - v.g) * t
      out.b = v.b + (u.b - v.b) * t
      out.a = v.a + (u.a - v.a) * t
      return out
    end,
    }
}
quat = {
__call = function(_, w, x, y, z)
    return setmetatable({ w = w, x = x, y = y, z = z}, quat)
end,

__tostring = function(q)
    return string.format('(%f, %f, %f, %f)', q.w, q.x, q.y, q.z)
end,

__add = function(q, r) return q:add(r, quat()) end,
__sub = function(q, r) return q:sub(r, quat()) end,
__mul = function(q, r)
    if quat.isquat(r) then 
        return q:mul(r, quat())
    elseif vec3.isvec3(r) then 
        return r:rotate(q, vec3())
    else 
        error('quats can only be multiplied by quats and vec3s') 
    end
end,
__unm = function(q) return q:scale(-1) end,
__len = function(q) return q:length() end,

__index = {
    isquat = function(x)
      return ffi and ffi.istype('quat', x) or getmetatable(x) == quat
    end,

    clone = function(q)
      return quat(q.w, q.x, q.y, q.z)
    end,
    copy = function(q)
      return quat(q.w, q.x, q.y, q.z)
    end,

    unpack = function(q)
      return q.w, q.x, q.y, q.z
    end,

    set = function(q, w, x, y, z)
      if quat.isquat(x) then x, y, z, w = x.x, x.y, x.z, x.w end
      q.x = x
      q.y = y
      q.z = z
      q.w = w
      return q
    end,

    fromAngleAxis = function(q, angle, x, y, z)
      return q:setAngleAxis(angle, x, y, z)
    end,
    fromRotationTo = function(q,a,b)
      local normStart = a:normalize()
      local normEnd = b:normalize()

      local d = normStart:dot(normEnd)

      if d > -1.0 + M_EPSILON then
          local c = normStart:cross(normEnd)
          local s = math.sqrt((1.0 + d) * 2.0)
          local invS = 1.0 / s

          q.x = c.x * invS
          q.y = c.y * invS
          q.z = c.z * invS
          q.w = 0.5 * s
      else
          local axis = vec3(1,0,0):cross(normStart)
          if axis:length() < M_EPSILON then
              axis = vec3(0,1,0):cross(normStart)
          end
          q:fromAngleAxis(180, axis.x, axis.y, axis.z)
      end
    end,
    setAngleAxis = function(q, angle, x, y, z)
      if vec3.isvec3(x) then x, y, z = x.x, x.y, x.z end
      local s = math.sin(angle * .5)
      local c = math.cos(angle * .5)
      q.x = x * s
      q.y = y * s
      q.z = z * s
      q.w = c
      return q
    end,

    getAngleAxis = function(q)
      if q.w > 1 or q.w < -1 then q:normalize() end
      local s = math.sqrt(1 - q.w * q.w)
      s = s < .0001 and 1 or 1 / s
      return 2 * math.acos(q.w), q.x * s, q.y * s, q.z * s
    end,

    between = function(u, v)
      return quat():setBetween(u, v)
    end,

    setBetween = function(q, u, v)
      local dot = u:dot(v)
      if dot > .99999 then
        q.x, q.y, q.z, q.w = 0, 0, 0, 1
        return q
      elseif dot < -.99999 then
        vtmp1.x, vtmp1.y, vtmp1.z = 1, 0, 0
        vtmp1:cross(u)
        if #vtmp1 < .00001 then
          vtmp1.x, vtmp1.y, vtmp1.z = 0, 1, 0
          vtmp1:cross(u)
        end
        vtmp1:normalize()
        return q:setAngleAxis(math.pi, vtmp1)
      end

      q.x, q.y, q.z = u.x, u.y, u.z
      vec3.cross(q, v)
      q.w = 1 + dot
      return q:normalize()
    end,

    fromDirection = function(x, y, z)
      return quat():setDirection(x, y, z)
    end,

    setDirection = function(q, x, y, z)
      if vec3.isvec3(x) then x, y, z = x.x, x.y, x.z end
      vtmp2.x, vtmp2.y, vtmp2.z = x, y, z
      return q:setBetween(forward, vtmp2)
    end,

    add = function(q, r, out)
      out = out or q
      out.x = q.x + r.x
      out.y = q.y + r.y
      out.z = q.z + r.z
      out.w = q.w + r.w
      return out
    end,

    sub = function(q, r, out)
      out = out or q
      out.x = q.x - r.x
      out.y = q.y - r.y
      out.z = q.z - r.z
      out.w = q.w - r.w
      return out
    end,

    mul = function(q, r, out)
      out = out or q
      local qx, qy, qz, qw = q:unpack()
      local rx, ry, rz, rw = r:unpack()
      out.x = qx * rw + qw * rx + qy * rz - qz * ry
      out.y = qy * rw + qw * ry + qz * rx - qx * rz
      out.z = qz * rw + qw * rz + qx * ry - qy * rx
      out.w = qw * rw - qx * rx - qy * ry - qz * rz
      return out
    end,

    scale = function(q, s, out)
      out = out or q
      out.x = q.x * s
      out.y = q.y * s
      out.z = q.z * s
      out.w = q.w * s
      return out
    end,

    length = function(q)
      return math.sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
    end,

    normalize = function(q, out)
      out = out or q
      local len = q:length()
      return len == 0 and q or q:scale(1 / len, out)
    end,

    lerp = function(q, r, t, out)
      out = out or q
      r:scale(t, qtmp1)
      q:scale(1 - t, out)
      return out:add(qtmp1)
    end,

    slerp = function(q, r, t, out)
      out = out or q

      local dot = q.x * r.x + q.y * r.y + q.z * r.z + q.w * r.w
      if dot < 0 then
        dot = -dot
        r:scale(-1)
      end

      if 1 - dot < .0001 then
        return q:lerp(r, t, out)
      end

      local theta = math.acos(dot)
      q:scale(math.sin((1 - t) * theta), out)
      r:scale(math.sin(t * theta), qtmp1)
      return out:add(qtmp1):scale(1 / math.sin(theta))
    end
    }
}

if ffi then
  ffi.cdef [[
    typedef struct { double x, y; } vec2;
    typedef struct { double x, y, z; } vec3;
    typedef struct { double r, g, b, a; } color;
    typedef struct { double x, y, z, w; } quat;
  ]]

  vec2 = ffi.metatype('vec2', vec2)
  vec3 = ffi.metatype('vec3', vec3)
  color = ffi.metatype('color', color)
  quat = ffi.metatype('quat', quat)
else
  setmetatable(vec2, vec2)
  setmetatable(vec3, vec3)
  setmetatable(color, color)
  setmetatable(quat, quat)
end

forward = vec3(0, 0, -1)
v2tmp1 = vec2()
vtmp1 = vec3()
vtmp2 = vec3()
qtmp1 = quat()

vec3.LEFT = vec3(-1.0, 0.0, 0.0)
vec3.RIGHT = vec3(1.0, 0.0, 0.0)
vec3.UP = vec3(0.0, 1.0, 0.0)
vec3.DOWN = vec3(0.0, -1.0, 0.0)
vec3.FORWARD = vec3(0.0, 0.0, 1.0)
vec3.BACK = vec3(0.0, 0.0, -1.0)
vec3.ONE = vec3(1.0, 1.0, 1.0)

vec3.UNIT_X = vec3(1, 0, 0)
vec3.UNIT_Y = vec3(0, 1, 0)
vec3.UNIT_Z = vec3(0, 0, 1)
vec3.NEGATIVE_UNIT_X = vec3(-1,  0,  0)
vec3.NEGATIVE_UNIT_Y = vec3(0, -1,  0)
vec3.NEGATIVE_UNIT_Z = vec3(0,  0, -1)
vec3.UNIT_SCALE = vec3(1, 1, 1)

return {
  vec2 = vec2,
  vec3 = vec3,
  color = color,
  quat = quat,

  Vector2 = vec2,
  Vector3 = vec3,
  Color = color,
  Quaternion = quat,
}
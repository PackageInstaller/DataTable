local Math = require("base.mathx")
local clamp = Math.Clamp
local acos = math.acos
local sqrt = math.sqrt
local _cos = math.cos
local _sin = math.sin
local setmetatable = _ENV.setmetatable
local rawset = _ENV.rawset
local rawget = _ENV.rawget
local vec2 = {}
vec2.__index = vec2

function vec2.__call(t, x, y)
  return vec2.New(x, y)
end

function vec2.New(x, y)
  local v = {
    x = x or 0,
    y = y or 0
  }
  setmetatable(v, vec2)
  return v
end

function vec2.Distance(va, vb)
  return sqrt((va.x - vb.x) ^ 2 + (va.y - vb.y) ^ 2)
end

function vec2.MidPoint(va, vb, temp)
  temp = temp or vec2.New()
  temp.x = (va.x + vb.x) / 2
  temp.y = (va.y + vb.y) / 2
  return temp
end

function vec2:Set(x, y)
  self.x = x or 0
  self.y = y or 0
end

function vec2:SetA(vec)
  self.x = vec.x or 0
  self.y = vec.y or 0
end

function vec2:Get()
  return self.x, self.y
end

function vec2:GetArray()
  return {
    self.x,
    self.y
  }
end

function vec2:SqrMagnitude()
  return self.x * self.x + self.y * self.y
end

function vec2:Clone()
  return vec2.New(self.x, self.y)
end

function vec2:Normalize()
  local v = self:Clone()
  return v:SetNormalize()
end

function vec2:SetNormalize()
  local num = self:Magnitude()
  if 1 == num then
    return self
  elseif num > 1.0E-5 then
    self:Div(num)
  else
    self:Set(0, 0)
  end
  return self
end

function vec2.Dot(lhs, rhs)
  return lhs.x * rhs.x + lhs.y * rhs.y
end

function vec2:Rotate(radian)
  local cos = _cos(radian)
  local sin = _sin(radian)
  local x = self.x * cos + self.y * sin
  local y = self.y * cos + self.x * sin
  return vec2.New(x, y)
end

function vec2:SetRotate(radian)
  local cos = _cos(radian)
  local sin = _sin(radian)
  local x = self.x * cos - self.y * sin
  local y = self.y * cos + self.x * sin
  self.x = x
  self.y = y
end

function vec2.Cross(lhs, rhs)
  return lhs.x * rhs.y - lhs.y * rhs.x
end

function vec2.CrossA(x1, y1, x2, y2)
  return x1 * y2 - y1 * x2
end

function vec2.Angle(from, to)
  return acos(clamp(vec2.Dot(from:Normalize(), to:Normalize()), -1, 1)) * 57.29578
end

function vec2.SignedAngle(from, to)
  local signed = from.x * to.y - from.y * to.x
  signed = signed >= 0 and 1 or -1
  return acos(clamp(vec2.Dot(from:Normalize(), to:Normalize()), -1, 1)) * 57.29578 * signed
end

function vec2.SignedAngleRaw(from, to)
  local signed = from.x * to.y - from.y * to.x
  signed = signed >= 0 and 1 or -1
  return acos(clamp(vec2.Dot(from, to), -1, 1)) * 57.29578 * signed
end

function vec2.Magnitude(v2)
  return sqrt(v2.x * v2.x + v2.y * v2.y)
end

function vec2.CloneXZ(vec3)
  return vec2.New(vec3.x, vec3.z)
end

function vec2:Div(d)
  self.x = self.x / d
  self.y = self.y / d
  return self
end

function vec2:Mul(d)
  self.x = self.x * d
  self.y = self.y * d
  return self
end

function vec2:Add(b)
  self.x = self.x + b.x
  self.y = self.y + b.y
  return self
end

function vec2:Sub(b)
  self.x = self.x - b.x
  self.y = self.y - b.y
  return
end

function vec2:__tostring()
  return string.format("[%f,%f]", self.x, self.y)
end

function vec2.__div(va, d)
  return vec2.New(va.x / d, va.y / d)
end

function vec2.__mul(va, d)
  return vec2.New(va.x * d, va.y * d)
end

function vec2.__add(va, vb)
  return vec2.New(va.x + vb.x, va.y + vb.y)
end

function vec2.__sub(va, vb)
  return vec2.New(va.x - vb.x, va.y - vb.y)
end

function vec2.__unm(va)
  return vec2.New(-va.x, -va.y)
end

function vec2.__eq(va, vb)
  return va.x == vb.x and va.y == vb.y
end

vec2.up = vec2.New(0, 1)
vec2.right = vec2.New(1, 0)
vec2.zero = vec2.New(0, 0)
vec2.one = vec2.New(1, 1)
vec2.center = vec2.New(0.5, 0.5)
vec2.magnitude = vec2.Magnitude
vec2.normalized = vec2.Normalize
vec2.sqrMagnitude = vec2.SqrMagnitude
return vec2

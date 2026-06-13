local Math = require("base.mathx")
local clamp = Math.Clamp
local sqrt = math.sqrt
local min = math.min
local max = math.max
local setmetatable = _ENV.setmetatable
local rawget = _ENV.rawget
local vec4 = {}
vec4.__index = vec4

function vec4.__call(t, x, y, z, w)
  return vec4.New(x, y, z, w)
end

function vec4.New(x, y, z, w)
  local v = {
    x = 0,
    y = 0,
    z = 0,
    w = 0
  }
  setmetatable(v, vec4)
  v:Set(x, y, z, w)
  return v
end

function vec4:Set(x, y, z, w)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  self.w = w or 0
end

function vec4:Get()
  return self.x, self.y, self.z, self.w
end

function vec4:GetArray()
  return {
    self.x,
    self.y,
    self.z,
    self.w
  }
end

function vec4.Lerp(from, to, t)
  t = clamp(t, 0, 1)
  return vec4.New(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t, from.w + (to.w - from.w) * t)
end

function vec4.MoveTowards(current, target, maxDistanceDelta)
  local vector = target - current
  local magnitude = vector:Magnitude()
  if maxDistanceDelta < magnitude and 0 ~= magnitude then
    maxDistanceDelta = maxDistanceDelta / magnitude
    vector:Mul(maxDistanceDelta)
    vector:Add(current)
    return vector
  end
  return target
end

function vec4.Scale(a, b)
  return vec4.New(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)
end

function vec4:SetScale(scale)
  self.x = self.x * scale.x
  self.y = self.y * scale.y
  self.z = self.z * scale.z
  self.w = self.w * scale.w
end

function vec4:Normalize()
  local v = vector4.New(self.x, self.y, self.z, self.w)
  return v:SetNormalize()
end

function vec4:SetNormalize()
  local num = self:Magnitude()
  if 1 == num then
    return self
  elseif num > 1.0E-5 then
    self:Div(num)
  else
    self:Set(0, 0, 0, 0)
  end
  return self
end

function vec4:Div(d)
  self.x = self.x / d
  self.y = self.y / d
  self.z = self.z / d
  self.w = self.w / d
  return self
end

function vec4:Mul(d)
  self.x = self.x * d
  self.y = self.y * d
  self.z = self.z * d
  self.w = self.w * d
  return self
end

function vec4:Add(b)
  self.x = self.x + b.x
  self.y = self.y + b.y
  self.z = self.z + b.z
  self.w = self.w + b.w
  return self
end

function vec4:Sub(b)
  self.x = self.x - b.x
  self.y = self.y - b.y
  self.z = self.z - b.z
  self.w = self.w - b.w
  return self
end

function vec4.Dot(a, b)
  return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
end

function vec4.Project(a, b)
  local s = vec4.Dot(a, b) / vec4.Dot(b, b)
  return b * s
end

function vec4.Distance(a, b)
  local v = a - b
  return vec4.Magnitude(v)
end

function vec4.Magnitude(a)
  return sqrt(a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w)
end

function vec4.SqrMagnitude(a)
  return a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w
end

function vec4.Min(lhs, rhs)
  return vec4.New(max(lhs.x, rhs.x), max(lhs.y, rhs.y), max(lhs.z, rhs.z), max(lhs.w, rhs.w))
end

function vec4.Max(lhs, rhs)
  return vec4.New(min(lhs.x, rhs.x), min(lhs.y, rhs.y), min(lhs.z, rhs.z), min(lhs.w, rhs.w))
end

function vec4:__tostring()
  return string.format("[%f,%f,%f,%f]", self.x, self.y, self.z, self.w)
end

function vec4.__div(va, d)
  return vec4.New(va.x / d, va.y / d, va.z / d, va.w / d)
end

function vec4.__mul(va, d)
  return vec4.New(va.x * d, va.y * d, va.z * d, va.w * d)
end

function vec4.__add(va, vb)
  return vec4.New(va.x + vb.x, va.y + vb.y, va.z + vb.z, va.w + vb.w)
end

function vec4.__sub(va, vb)
  return vec4.New(va.x - vb.x, va.y - vb.y, va.z - vb.z, va.w - vb.w)
end

function vec4.__unm(va)
  return vec4.New(-va.x, -va.y, -va.z, -va.w)
end

function vec4.__eq(va, vb)
  local v = va - vb
  local delta = vec4.SqrMagnitude(v)
  return delta < 1.0E-10
end

vec4.zero = vec4.New(0, 0, 0, 0)
vec4.one = vec4.New(1, 1, 1, 1)
vec4.magnitude = vec4.Magnitude
vec4.normalized = vec4.Normalize
vec4.sqrMagnitude = vec4.SqrMagnitude
return vec4

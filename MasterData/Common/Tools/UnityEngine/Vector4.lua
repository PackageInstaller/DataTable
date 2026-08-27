local clamp = Mathf.Clamp
local sqrt = Mathf.Sqrt
local min = Mathf.Min
local max = Mathf.Max
local setmetatable = _ENV.setmetatable
local rawget = _ENV.rawget
local Vector4 = {}
local _getter = {}
local unity_vector4 = CS.UnityEngine.Vector4

function Vector4.__index(t, k)
  local var = rawget(Vector4, k)
  if var ~= nil then
    return var
  end
  var = rawget(_getter, k)
  if var ~= nil then
    return var(t)
  end
  return rawget(unity_vector4, k)
end

function Vector4.__call(t, x, y, z, w)
  return setmetatable({
    x = x or 0,
    y = y or 0,
    z = z or 0,
    w = w or 0
  }, Vector4)
end

function Vector4.New(x, y, z, w)
  return setmetatable({
    x = x or 0,
    y = y or 0,
    z = z or 0,
    w = w or 0
  }, Vector4)
end

function Vector4:Set(x, y, z, w)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  self.w = w or 0
end

function Vector4:Get()
  return self.x, self.y, self.z, self.w
end

function Vector4.Lerp(from, to, t)
  t = clamp(t, 0, 1)
  return Vector4.New(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t, from.w + (to.w - from.w) * t)
end

function Vector4.MoveTowards(current, target, maxDistanceDelta)
  local vector = target - current
  local magnitude = vector:Magnitude()
  if maxDistanceDelta < magnitude and magnitude ~= 0 then
    maxDistanceDelta = maxDistanceDelta / magnitude
    vector:Mul(maxDistanceDelta)
    vector:Add(current)
    return vector
  end
  return target
end

function Vector4.Scale(a, b)
  return Vector4.New(a.x * b.x, a.y * b.y, a.z * b.z, a.w * b.w)
end

function Vector4:SetScale(scale)
  self.x = self.x * scale.x
  self.y = self.y * scale.y
  self.z = self.z * scale.z
  self.w = self.w * scale.w
end

function Vector4:Normalize()
  local v = Vector4.New(self.x, self.y, self.z, self.w)
  return v:SetNormalize()
end

function Vector4:SetNormalize()
  local num = self:Magnitude()
  if num == 1 then
    return self
  elseif 1.0E-5 < num then
    self:Div(num)
  else
    self:Set(0, 0, 0, 0)
  end
  return self
end

function Vector4:Div(d)
  self.x = self.x / d
  self.y = self.y / d
  self.z = self.z / d
  self.w = self.w / d
  return self
end

function Vector4:Mul(d)
  self.x = self.x * d
  self.y = self.y * d
  self.z = self.z * d
  self.w = self.w * d
  return self
end

function Vector4:Add(b)
  self.x = self.x + b.x
  self.y = self.y + b.y
  self.z = self.z + b.z
  self.w = self.w + b.w
  return self
end

function Vector4:Sub(b)
  self.x = self.x - b.x
  self.y = self.y - b.y
  self.z = self.z - b.z
  self.w = self.w - b.w
  return self
end

function Vector4.Dot(a, b)
  return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
end

function Vector4.Project(a, b)
  local s = Vector4.Dot(a, b) / Vector4.Dot(b, b)
  return b * s
end

function Vector4.Distance(a, b)
  local v = a - b
  return Vector4.Magnitude(v)
end

function Vector4.Magnitude(a)
  return sqrt(a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w)
end

function Vector4.SqrMagnitude(a)
  return a.x * a.x + a.y * a.y + a.z * a.z + a.w * a.w
end

function Vector4.Min(lhs, rhs)
  return Vector4.New(max(lhs.x, rhs.x), max(lhs.y, rhs.y), max(lhs.z, rhs.z), max(lhs.w, rhs.w))
end

function Vector4.Max(lhs, rhs)
  return Vector4.New(min(lhs.x, rhs.x), min(lhs.y, rhs.y), min(lhs.z, rhs.z), min(lhs.w, rhs.w))
end

function Vector4:__tostring()
  return string.format("[%f,%f,%f,%f]", self.x, self.y, self.z, self.w)
end

function Vector4.__div(va, d)
  return Vector4.New(va.x / d, va.y / d, va.z / d, va.w / d)
end

function Vector4.__mul(va, d)
  return Vector4.New(va.x * d, va.y * d, va.z * d, va.w * d)
end

function Vector4.__add(va, vb)
  return Vector4.New(va.x + vb.x, va.y + vb.y, va.z + vb.z, va.w + vb.w)
end

function Vector4.__sub(va, vb)
  return Vector4.New(va.x - vb.x, va.y - vb.y, va.z - vb.z, va.w - vb.w)
end

function Vector4.__unm(va)
  return Vector4.New(-va.x, -va.y, -va.z, -va.w)
end

function Vector4.__eq(va, vb)
  local v = va - vb
  local delta = Vector4.SqrMagnitude(v)
  return delta < 1.0E-10
end

function _getter.zero()
  return Vector4.New(0, 0, 0, 0)
end

function _getter.one()
  return Vector4.New(1, 1, 1, 1)
end

_getter.magnitude = Vector4.Magnitude
_getter.normalized = Vector4.Normalize
_getter.sqrMagnitude = Vector4.SqrMagnitude
Vector4.unity_vector4 = CS.UnityEngine.Vector4
CS.UnityEngine.Vector4 = Vector4
setmetatable(Vector4, Vector4)
return Vector4

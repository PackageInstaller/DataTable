local Math = require("base.mathx")
local math = _ENV.math
local acos = math.acos
local sqrt = math.sqrt
local max = math.max
local min = math.min
local clamp = Math.Clamp
local cos = math.cos
local sin = math.sin
local abs = math.abs
local sign = Math.Sign
local setmetatable = _ENV.setmetatable
local rawset = _ENV.rawset
local rawget = _ENV.rawget
local type = _ENV.type
local _cos = math.cos
local _sin = math.sin
local rad2Deg = Math.Rad2Deg
local deg2Rad = Math.Deg2Rad
local vec3 = {}

function vec3.ConstNew(x, y, z)
  local ret = {
    __const = {
      x = x or 0,
      y = y or 0,
      z = z or 0
    }
  }
  setmetatable(ret, vec3)
  return ret
end

local _constNew = vec3.ConstNew

function vec3.New(x, y, z)
  local v = {
    x = x or 0,
    y = y or 0,
    z = z or 0
  }
  setmetatable(v, vec3)
  return v
end

local _new = vec3.New

function vec3.__call(t, x, y, z)
  return _new(x, y, z)
end

local temp_vec3_00 = vec3.New()
local temp_vec3_01 = vec3.New()
local temp_vec3_02 = vec3.New()

function vec3:Set(x, y, z)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
end

function vec3:Set1(x, y, z)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  return self
end

function vec3:SetA(vec)
  self.x = vec.x or 0
  self.y = vec.y or 0
  self.z = vec.z or 0
end

function vec3:SetB(vec)
  self.x = vec.x or 0
  self.y = vec.y or 0
  self.z = vec.z or 0
  return self
end

function vec3:SetNegation()
  self:Mul(-1)
  return self
end

function vec3:Get()
  return self.x, self.y, self.z
end

function vec3:GetArray()
  return {
    self.x,
    self.y,
    self.z
  }
end

function vec3:Clone()
  return _new(self.x, self.y, self.z)
end

function vec3:ToRight()
  return _new(self.z, self.y, -self.x)
end

function vec3.Distance(va, vb)
  return sqrt((va.x - vb.x) ^ 2 + (va.y - vb.y) ^ 2 + (va.z - vb.z) ^ 2)
end

function vec3.DistanceA(x1, y1, z1, x2, y2, z2)
  return sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2)
end

function vec3.SquareDistance(a, b)
  return (a.x - b.x) ^ 2 + (a.y - b.y) ^ 2 + (a.z - b.z) ^ 2
end

function vec3.SquareDistanceA(x1, y1, z1, x2, y2, z2)
  return (x1 - x2) ^ 2 + (y1 - y2) ^ 2 + (z1 - z2) ^ 2
end

function vec3.Dot(lhs, rhs)
  return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
end

function vec3.DotA(x1, y1, z1, x2, y2, z2)
  return x1 * x2 + y1 * y2 + z1 * z2
end

function vec3.Lerp(from, to, t)
  t = clamp(t, 0, 1)
  return _new(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t)
end

function vec3.LerpB(from, to, t)
  t = clamp(t, 0, 1)
  return from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t
end

function vec3.LerpA(from, to, t, out)
  t = clamp(t, 0, 1)
  out:Set(from.x + (to.x - from.x) * t, from.y + (to.y - from.y) * t, from.z + (to.z - from.z) * t)
end

function vec3.LerpC(from_x, from_y, from_z, to_x, to_y, to_z, t)
  t = clamp(t, 0, 1)
  return from_x + (to_x - from_x) * t, from_y + (to_y - from_y) * t, from_z + (to_z - from_z) * t
end

function vec3.LerpD(from_x, from_y, from_z, to_x, to_y, to_z, t)
  return from_x + (to_x - from_x) * t, from_y + (to_y - from_y) * t, from_z + (to_z - from_z) * t
end

function vec3:Magnitude()
  return sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function vec3.Max(lhs, rhs)
  return _new(max(lhs.x, rhs.x), max(lhs.y, rhs.y), max(lhs.z, rhs.z))
end

function vec3.Min(lhs, rhs)
  return _new(min(lhs.x, rhs.x), min(lhs.y, rhs.y), min(lhs.z, rhs.z))
end

function vec3.Normalize(v)
  local x, y, z = v.x, v.y, v.z
  local num = sqrt(x * x + y * y + z * z)
  if num > 1.0E-5 then
    return _new(x / num, y / num, z / num)
  end
  return _new(0, 0, 0)
end

function vec3.NormalizeA(x, y, z)
  local num = sqrt(x * x + y * y + z * z)
  if num > 1.0E-5 then
    x = x / num
    y = y / num
    z = z / num
  else
    x = 0
    y = 0
    z = 0
  end
  return x, y, z
end

function vec3:SetNormalize()
  local num = sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
  if num > 1.0E-5 then
    self.x = self.x / num
    self.y = self.y / num
    self.z = self.z / num
  else
    self.x = 0
    self.y = 0
    self.z = 0
  end
  return self
end

function vec3:SqrMagnitude()
  return self.x * self.x + self.y * self.y + self.z * self.z
end

local dot = vec3.Dot

function vec3.Angle(from, to)
  return acos(clamp(dot(from:Normalize(), to:Normalize()), -1, 1)) * rad2Deg
end

function vec3.AngleRaw(from, to)
  return acos(clamp(dot(from, to), -1, 1)) * rad2Deg
end

function vec3.AngleRawA(fx, fy, fz, tx, ty, tz)
  return acos(clamp(vec3.DotA(fx, fy, fz, tx, ty, tz), -1, 1)) * rad2Deg
end

function vec3:ClampMagnitude(maxLength)
  if self:SqrMagnitude() > maxLength * maxLength then
    self:SetNormalize()
    self:Mul(maxLength)
  end
  return self
end

function vec3.OrthoNormalize(va, vb, vc)
  va:SetNormalize()
  vb:Sub(vb:Project(va))
  vb:SetNormalize()
  if nil == vc then
    return va, vb
  end
  vc:Sub(vc:Project(va))
  vc:Sub(vc:Project(vb))
  vc:SetNormalize()
  return va, vb, vc
end

function vec3.MoveTowards(current, target, maxDistanceDelta)
  local delta = target - current
  local sqrDelta = delta:SqrMagnitude()
  local sqrDistance = maxDistanceDelta * maxDistanceDelta
  if sqrDelta > sqrDistance then
    local magnitude = sqrt(sqrDelta)
    if magnitude > 1.0E-6 then
      delta:Mul(maxDistanceDelta / magnitude)
      delta:Add(current)
      return delta
    else
      return current:Clone()
    end
  end
  return target:Clone()
end

function vec3:AlmostZero()
  local len = self:SqrMagnitude()
  return len <= 0.1
end

function vec3:Rotate2(radian)
  local cos = _cos(radian)
  local sin = _sin(radian)
  local x = self.x * cos + self.z * sin
  local z = self.z * cos + self.x * sin
  return vec3.New(x, 0, z)
end

function vec3:Rotate2_NoneAlloc(radian, out_vec3)
  local cos = _cos(radian)
  local sin = _sin(radian)
  local x = self.x * cos - self.z * sin
  local z = self.z * cos + self.x * sin
  out_vec3:Set(x, 0, z)
end

function ClampedMove(lhs, rhs, clampedDelta)
  local delta = rhs - lhs
  if delta > 0 then
    return lhs + min(delta, clampedDelta)
  else
    return lhs - min(-delta, clampedDelta)
  end
end

local overSqrt2 = 0.7071067811865476

local function OrthoNormalVector(vec)
  local res = _new()
  if abs(vec.z) > overSqrt2 then
    local a = vec.y * vec.y + vec.z * vec.z
    local k = 1 / sqrt(a)
    res.x = 0
    res.y = -vec.z * k
    res.z = vec.y * k
  else
    local a = vec.x * vec.x + vec.y * vec.y
    local k = 1 / sqrt(a)
    res.x = -vec.y * k
    res.y = vec.x * k
    res.z = 0
  end
  return res
end

function vec3.RotateTowards(current, target, maxRadiansDelta, maxMagnitudeDelta)
  local len1 = current:Magnitude()
  local len2 = target:Magnitude()
  if len1 > 1.0E-6 and len2 > 1.0E-6 then
    local from = current / len1
    local to = target / len2
    local cosom = dot(from, to)
    if cosom > 0.999999 then
      return vec3.MoveTowards(current, target, maxMagnitudeDelta)
    elseif cosom < -0.999999 then
      local axis = OrthoNormalVector(from)
      local q = Quaternion.AngleAxis(maxRadiansDelta * rad2Deg, axis)
      local rotated = q:MulVec3(from)
      local delta = ClampedMove(len1, len2, maxMagnitudeDelta)
      rotated:Mul(delta)
      return rotated
    else
      local angle = acos(cosom)
      local axis = vec3.Cross(from, to)
      axis:SetNormalize()
      local q = Quaternion.AngleAxis(min(maxRadiansDelta, angle) * rad2Deg, axis)
      local rotated = q:MulVec3(from)
      local delta = ClampedMove(len1, len2, maxMagnitudeDelta)
      rotated:Mul(delta)
      return rotated
    end
  end
  return vec3.MoveTowards(current, target, maxMagnitudeDelta)
end

function vec3.SmoothDamp(current, target, currentVelocity, smoothTime)
  local maxSpeed = math.huge
  local deltaTime = Global.elapsed
  smoothTime = max(1.0E-4, smoothTime)
  local num = 2 / smoothTime
  local num2 = num * deltaTime
  local num3 = 1 / (1 + num2 + 0.48 * num2 * num2 + 0.235 * num2 * num2 * num2)
  local vector2 = target:Clone()
  local maxLength = maxSpeed * smoothTime
  local vector = current - target
  vector:ClampMagnitude(maxLength)
  target = current - vector
  local vec3 = (currentVelocity + vector * num) * deltaTime
  currentVelocity = (currentVelocity - vec3 * num) * num3
  local vector4 = target + (vector + vec3) * num3
  if vec3.Dot(vector2 - current, vector4 - vector2) > 0 then
    vector4 = vector2
    currentVelocity:Set(0, 0, 0)
  end
  return vector4, currentVelocity
end

function vec3.Scale(a, b)
  local x = a.x * b.x
  local y = a.y * b.y
  local z = a.z * b.z
  return _new(x, y, z)
end

function vec3.ScaleA(a, b, out)
  local x = a.x * b.x
  local y = a.y * b.y
  local z = a.z * b.z
  out:Set(x, y, z)
end

function vec3.Cross(lhs, rhs)
  local x = lhs.y * rhs.z - lhs.z * rhs.y
  local y = lhs.z * rhs.x - lhs.x * rhs.z
  local z = lhs.x * rhs.y - lhs.y * rhs.x
  return _new(x, y, z)
end

function vec3.CrossA(v1, v2, out)
  local x = v1.y * v2.z - v1.z * v2.y
  local y = v1.z * v2.x - v1.x * v2.z
  local z = v1.x * v2.y - v1.y * v2.x
  out:Set(x, y, z)
  return out
end

function vec3.CrossB(x1, y1, z1, x2, y2, z3, out)
  local x = y1 * z3 - z1 * y2
  local y = z1 * x2 - x1 * z3
  local z = x1 * y2 - y1 * x2
  out:Set(x, y, z)
  return out
end

function vec3:Equals(other)
  return self.x == other.x and self.y == other.y and self.z == other.z
end

function vec3.Reflect(inDirection, inNormal)
  local num = -2 * dot(inNormal, inDirection)
  inNormal = inNormal * num
  inNormal:Add(inDirection)
  return inNormal
end

function vec3.Project(vector, onNormal)
  local num = onNormal:SqrMagnitude()
  if num < 1.175494E-38 then
    return _new(0, 0, 0)
  end
  local num2 = dot(vector, onNormal)
  local v3 = onNormal:Clone()
  v3:Mul(num2 / num)
  return v3
end

function vec3.ProjectEx(vector, onNormal, out)
  local num = onNormal:SqrMagnitude()
  if num < 1.175494E-38 then
    out:Set(0, 0, 0)
    return out
  end
  local num2 = dot(vector, onNormal)
  out:SetA(onNormal)
  out:Mul(num2 / num)
  return out
end

function vec3.ProjectOnPlane(vector, planeNormal)
  local v3 = vec3.Project(vector, planeNormal)
  v3:Mul(-1)
  v3:Add(vector)
  return v3
end

function vec3.Slerp(from, to, t)
  local omega, sinom, scale0, scale1
  if t <= 0 then
    return from:Clone()
  elseif t >= 1 then
    return to:Clone()
  end
  local v2 = to:Clone()
  local v1 = from:Clone()
  local len2 = to:Magnitude()
  local len1 = from:Magnitude()
  v2:Div(len2)
  v1:Div(len1)
  local len = (len2 - len1) * t + len1
  local cosom = dot(v1, v2)
  if 1 - cosom > 1.0E-6 then
    omega = acos(cosom)
    sinom = sin(omega)
    scale0 = sin((1 - t) * omega) / sinom
    scale1 = sin(t * omega) / sinom
  else
    scale0 = 1 - t
    scale1 = t
  end
  v1:Mul(scale0)
  v2:Mul(scale1)
  v2:Add(v1)
  v2:Mul(len)
  return v2
end

function vec3:Mul(q)
  if "number" == type(q) then
    self.x = self.x * q
    self.y = self.y * q
    self.z = self.z * q
  else
    self:MulQuat(q)
  end
  return self
end

function vec3:Div(d)
  self.x = self.x / d
  self.y = self.y / d
  self.z = self.z / d
  return self
end

function vec3:Add(vb)
  self.x = self.x + vb.x
  self.y = self.y + vb.y
  self.z = self.z + vb.z
  return self
end

function vec3:Add1(x, y, z)
  self.x = self.x + x
  self.y = self.y + y
  self.z = self.z + z
  return self
end

function vec3:Sub(vb)
  self.x = self.x - vb.x
  self.y = self.y - vb.y
  self.z = self.z - vb.z
  return self
end

function vec3:Sub1(x, y, z)
  self.x = self.x - x
  self.y = self.y - y
  self.z = self.z - z
  return self
end

function vec3:MulQuat(quat)
  local num = quat.x * 2
  local num2 = quat.y * 2
  local num3 = quat.z * 2
  local num4 = quat.x * num
  local num5 = quat.y * num2
  local num6 = quat.z * num3
  local num7 = quat.x * num2
  local num8 = quat.x * num3
  local num9 = quat.y * num3
  local num10 = quat.w * num
  local num11 = quat.w * num2
  local num12 = quat.w * num3
  local x = (1 - (num5 + num6)) * self.x + (num7 - num12) * self.y + (num8 + num11) * self.z
  local y = (num7 + num12) * self.x + (1 - (num4 + num6)) * self.y + (num9 - num10) * self.z
  local z = (num8 - num11) * self.x + (num9 + num10) * self.y + (1 - (num4 + num5)) * self.z
  self:Set(x, y, z)
  return self
end

function vec3.AngleAroundAxis(from, to, axis)
  from = from - vec3.Project(from, axis)
  to = to - vec3.Project(to, axis)
  local angle = vec3.Angle(from, to)
  return angle * (vec3.Dot(axis, vec3.Cross(from, to)) < 0 and -1 or 1)
end

function vec3.AngleAroundAxis_NoneAlloc(from, to, axis)
  temp_vec3_00:SetA(from)
  temp_vec3_02:SetA(to)
  vec3.ProjectEx(temp_vec3_00, axis, temp_vec3_01)
  temp_vec3_00:Sub(temp_vec3_01)
  vec3.ProjectEx(to, axis, temp_vec3_01)
  temp_vec3_02:Sub(temp_vec3_01)
  local angle = vec3.AngleRaw(temp_vec3_00:SetNormalize(), temp_vec3_02:SetNormalize())
  return angle * (vec3.Dot(axis, vec3.CrossA(temp_vec3_00, temp_vec3_02, temp_vec3_00)) < 0 and -1 or 1)
end

function vec3.SignedProjectLen(normal_x, normal_y, normal_z, vec_x, vec_y, vec_z)
  local sqrMang = normal_x * normal_x + normal_y * normal_y + normal_z * normal_z
  if sqrMang < 1.175494E-38 then
    return 0, 0, 0
  end
  local dotValue = vec3.DotA(normal_x, normal_y, normal_z, vec_x, vec_y, vec_z)
  return dotValue / math.sqrt(sqrMang)
end

function vec3.ProjectLen(normal_x, normal_y, normal_z, vec_x, vec_y, vec_z)
  local sqrMang = normal_x * normal_x + normal_y * normal_y + normal_z * normal_z
  if sqrMang < 1.175494E-38 then
    return 0, 0, 0
  end
  local dotValue = vec3.DotA(normal_x, normal_y, normal_z, vec_x, vec_y, vec_z)
  return math.abs(dotValue) / math.sqrt(sqrMang)
end

function vec3.ProjectA(normal_x, normal_y, normal_z, vec_x, vec_y, vec_z)
  local sqrMang = normal_x * normal_x + normal_y * normal_y + normal_z * normal_z
  if sqrMang < 1.175494E-38 then
    return 0, 0, 0
  end
  local dotValue = vec3.DotA(normal_x, normal_y, normal_z, vec_x, vec_y, vec_z)
  local mul_value = dotValue / sqrMang
  return normal_x * mul_value, normal_y * mul_value, normal_z * mul_value
end

function vec3.GetRotatedVector(dx, dy, dz, vec, result_vec3)
  vec = vec or vec3.forward
  Util.QuatTemp:SetEuler(dx, dy, dz)
  Util.QuatTemp:MulVec3_NoneAlloc(vec, result_vec3)
end

function vec3.IsZeroVectorA(x, y, z)
  local sqrMang = x * x + y * y + z * z
  return sqrMang < 1.175494E-38
end

function vec3.__div(va, d)
  return _new(va.x / d, va.y / d, va.z / d)
end

function vec3.__mul(va, d)
  if "number" == type(d) then
    return _new(va.x * d, va.y * d, va.z * d)
  else
    local vec = va:Clone()
    vec:MulQuat(d)
    return vec
  end
end

function vec3.__add(va, vb)
  return _new(va.x + vb.x, va.y + vb.y, va.z + vb.z)
end

function vec3.__sub(va, vb)
  return _new(va.x - vb.x, va.y - vb.y, va.z - vb.z)
end

function vec3.__unm(va)
  return _new(-va.x, -va.y, -va.z)
end

function vec3.__eq(a, b)
  local v = a - b
  local delta = v:SqrMagnitude()
  return delta < 1.0E-10
end

function vec3.__index(tbl, key)
  local __const = rawget(tbl, "__const")
  if __const then
    return __const[key] or vec3[key]
  else
    return vec3[key]
  end
end

function vec3.__newindex(tbl, key)
  assert(nil, "const vec3 不能赋值")
end

vec3.up = _constNew(0, 1, 0)
vec3.down = _constNew(0, -1, 0)
vec3.right = _constNew(1, 0, 0)
vec3.left = _constNew(-1, 0, 0)
vec3.forward = _constNew(0, 0, 1)
vec3.back = _constNew(0, 0, -1)
vec3.zero = _constNew(0, 0, 0)
vec3.one = _constNew(1, 1, 1)
vec3.magnitude = vec3.Magnitude
vec3.normalized = vec3.Normalize
vec3.sqrMagnitude = vec3.SqrMagnitude
return vec3

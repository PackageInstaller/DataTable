local Math = require("base.mathx")
local Vec3 = require("base.vec3")
local math = _ENV.math
local sin = math.sin
local cos = math.cos
local acos = math.acos
local asin = math.asin
local sqrt = math.sqrt
local min = math.min
local max = math.max
local sign = Math.sign
local atan2 = math.atan
local clamp = Math.Clamp
local abs = math.abs
local setmetatable = _ENV.setmetatable
local getmetatable = _ENV.getmetatable
local rawget = _ENV.rawget
local rawset = _ENV.rawset
local rad2Deg = Math.Rad2Deg
local halfDegToRad = 0.5 * Math.Deg2Rad
local _forward = Vec3.forward
local _up = Vec3.up
local _next = {
  2,
  3,
  1
}
local temp_vec3_00 = Vec3.New()
local Quat = {}
Quat.__index = Quat

function Quat.__newindex(t, name, k)
  if "eulerAngles" == name then
    t:SetEuler(k)
  else
    rawset(t, name, k)
  end
end

function Quat.New(x, y, z, w)
  local quat = {
    x = x or 0,
    y = y or 0,
    z = z or 0,
    w = w or 0
  }
  setmetatable(quat, Quat)
  return quat
end

local _new = Quat.New

function Quat.__call(t, x, y, z, w)
  return _new(x, y, z, w)
end

function Quat:Set(x, y, z, w)
  self.x = x or 0
  self.y = y or 0
  self.z = z or 0
  self.w = w or 0
end

function Quat:CopyValue(quat)
  self.x = quat.x
  self.y = quat.y
  self.z = quat.z
  self.w = quat.w
end

function Quat:Clone()
  return _new(self.x, self.y, self.z, self.w)
end

function Quat:Get()
  return self.x, self.y, self.z, self.w
end

function Quat:GetArray()
  return {
    self.x,
    self.y,
    self.z,
    self.w
  }
end

function Quat.Dot(a, b)
  return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w
end

function Quat.Angle(a, b)
  local dot = Quat.Dot(a, b)
  if dot < 0 then
    dot = -dot
  end
  return acos(min(dot, 1)) * 2 * 57.29578
end

function Quat.AngleAxis(angle, axis)
  local normAxis = axis:Normalize()
  angle = angle * halfDegToRad
  local s = sin(angle)
  local w = cos(angle)
  local x = normAxis.x * s
  local y = normAxis.y * s
  local z = normAxis.z * s
  return _new(x, y, z, w)
end

function Quat.AngleAxisA(angle, axis, out)
  temp_vec3_00:SetA(axis)
  local normAxis = temp_vec3_00:SetNormalize()
  angle = angle * halfDegToRad
  local s = sin(angle)
  local w = cos(angle)
  local x = normAxis.x * s
  local y = normAxis.y * s
  local z = normAxis.z * s
  out:Set(x, y, z, w)
end

function Quat.Equals(a, b)
  return a.x == b.x and a.y == b.y and a.z == b.z and a.w == b.w
end

function Quat.Euler(x, y, z)
  local quat = _new()
  quat:SetEuler(x, y, z)
  return quat
end

function Quat:SetEuler(x, y, z)
  if nil == y and nil == z then
    y = x.y
    z = x.z
    x = x.x
  end
  x = x * halfDegToRad
  y = y * halfDegToRad
  z = z * halfDegToRad
  local sinX = sin(x)
  local cosX = cos(x)
  local sinY = sin(y)
  local cosY = cos(y)
  local sinZ = sin(z)
  local cosZ = cos(z)
  self.w = cosY * cosX * cosZ + sinY * sinX * sinZ
  self.x = cosY * sinX * cosZ + sinY * cosX * sinZ
  self.y = sinY * cosX * cosZ - cosY * sinX * sinZ
  self.z = cosY * cosX * sinZ - sinY * sinX * cosZ
  return self
end

function Quat:Normalize()
  local quat = self:Clone()
  quat:SetNormalize()
  return quat
end

function Quat:SetNormalize()
  local n = self.x * self.x + self.y * self.y + self.z * self.z + self.w * self.w
  if 1 ~= n and n > 0 then
    n = 1 / sqrt(n)
    self.x = self.x * n
    self.y = self.y * n
    self.z = self.z * n
    self.w = self.w * n
  end
end

function Quat.FromToRotation(from, to)
  local quat = Quat.New()
  quat:SetFromToRotation(from, to)
  return quat
end

function Quat:SetFromToRotation1(from, to)
  local v0 = from:Normalize()
  local v1 = to:Normalize()
  local d = Vec3.Dot(v0, v1)
  if d > -0.999999 then
    local s = sqrt((1 + d) * 2)
    local invs = 1 / s
    local c = Vec3.Cross(v0, v1) * invs
    self:Set(c.x, c.y, c.z, s * 0.5)
  elseif d > 0.999999 then
    return _new(0, 0, 0, 1)
  else
    local axis = Vec3.Cross(Vec3.right, v0)
    if axis:SqrMagnitude() < 1.0E-6 then
      axis = Vec3.Cross(Vec3.forward, v0)
    end
    self:Set(axis.x, axis.y, axis.z, 0)
    return self
  end
  return self
end

local temp_q = {
  0,
  0,
  0
}

local function MatrixToQuat(rot, quat)
  local trace = rot[1][1] + rot[2][2] + rot[3][3]
  if trace > 0 then
    local s = sqrt(trace + 1)
    quat.w = 0.5 * s
    s = 0.5 / s
    quat.x = (rot[3][2] - rot[2][3]) * s
    quat.y = (rot[1][3] - rot[3][1]) * s
    quat.z = (rot[2][1] - rot[1][2]) * s
    quat:SetNormalize()
  else
    local i = 1
    if rot[2][2] > rot[1][1] then
      i = 2
    end
    if rot[3][3] > rot[i][i] then
      i = 3
    end
    local j = _next[i]
    local k = _next[j]
    local t = rot[i][i] - rot[j][j] - rot[k][k] + 1
    local s = 0.5 / sqrt(t)
    temp_q[i] = s * t
    local w = (rot[k][j] - rot[j][k]) * s
    temp_q[j] = (rot[j][i] + rot[i][j]) * s
    temp_q[k] = (rot[k][i] + rot[i][k]) * s
    quat:Set(temp_q[1], temp_q[2], temp_q[3], w)
    quat:SetNormalize()
  end
end

local temp_up_tb = {
  0,
  0,
  0
}
local temp_rot_tb = {
  {
    0,
    0,
    0
  },
  {
    0,
    0,
    0
  },
  {
    0,
    0,
    0
  }
}
local temp_left_tb = {
  0,
  0,
  0
}

function Quat:SetFromToRotation(from, to)
  from:SetNormalize()
  to:SetNormalize()
  local e = Vec3.Dot(from, to)
  if e > 0.999999 then
    self:Set(0, 0, 0, 1)
  elseif e < -0.999999 then
    temp_left_tb[1] = 0
    temp_left_tb[2] = from.z
    temp_left_tb[3] = from.y
    local mag = temp_left_tb[2] * temp_left_tb[2] + temp_left_tb[3] * temp_left_tb[3]
    if mag < 1.0E-6 then
      temp_left_tb[1] = -from.z
      temp_left_tb[2] = 0
      temp_left_tb[3] = from.x
      mag = temp_left_tb[1] * temp_left_tb[1] + temp_left_tb[3] * temp_left_tb[3]
    end
    local invlen = 1 / sqrt(mag)
    temp_left_tb[1] = temp_left_tb[1] * invlen
    temp_left_tb[2] = temp_left_tb[2] * invlen
    temp_left_tb[3] = temp_left_tb[3] * invlen
    temp_up_tb[1] = temp_left_tb[2] * from.z - temp_left_tb[3] * from.y
    temp_up_tb[2] = temp_left_tb[3] * from.x - temp_left_tb[1] * from.z
    temp_up_tb[3] = temp_left_tb[1] * from.y - temp_left_tb[2] * from.x
    local fxx = -from.x * from.x
    local fyy = -from.y * from.y
    local fzz = -from.z * from.z
    local fxy = -from.x * from.y
    local fxz = -from.x * from.z
    local fyz = -from.y * from.z
    local uxx = temp_up_tb[1] * temp_up_tb[1]
    local uyy = temp_up_tb[2] * temp_up_tb[2]
    local uzz = temp_up_tb[3] * temp_up_tb[3]
    local uxy = temp_up_tb[1] * temp_up_tb[2]
    local uxz = temp_up_tb[1] * temp_up_tb[3]
    local uyz = temp_up_tb[2] * temp_up_tb[3]
    local lxx = -temp_left_tb[1] * temp_left_tb[1]
    local lyy = -temp_left_tb[2] * temp_left_tb[2]
    local lzz = -temp_left_tb[3] * temp_left_tb[3]
    local lxy = -temp_left_tb[1] * temp_left_tb[2]
    local lxz = -temp_left_tb[1] * temp_left_tb[3]
    local lyz = -temp_left_tb[2] * temp_left_tb[3]
    temp_rot_tb[1][1] = fxx + uxx + lxx
    temp_rot_tb[1][2] = fxy + uxy + lxy
    temp_rot_tb[1][3] = fxz + uxz + lxz
    temp_rot_tb[2][1] = fxy + uxy + lxy
    temp_rot_tb[2][2] = fyy + uyy + lyy
    temp_rot_tb[2][3] = fyz + uyz + lyz
    temp_rot_tb[3][1] = fxz + uxz + lxz
    temp_rot_tb[3][2] = fyz + uyz + lyz
    temp_rot_tb[3][3] = fzz + uzz + lzz
    MatrixToQuat(temp_rot_tb, self)
  else
    Vec3.CrossA(from, to, temp_vec3_00)
    local v = temp_vec3_00
    local h = (1 - e) / Vec3.Dot(v, v)
    local hx = h * v.x
    local hz = h * v.z
    local hxy = hx * v.y
    local hxz = hx * v.z
    local hyz = hz * v.y
    temp_rot_tb[1][1] = e + hx * v.x
    temp_rot_tb[1][2] = hxy - v.z
    temp_rot_tb[1][3] = hxz + v.y
    temp_rot_tb[2][1] = hxy + v.z
    temp_rot_tb[2][2] = e + h * v.y * v.y
    temp_rot_tb[2][3] = hyz - v.x
    temp_rot_tb[3][1] = hxz - v.y
    temp_rot_tb[3][2] = hyz + v.x
    temp_rot_tb[3][3] = e + hz * v.z
    MatrixToQuat(temp_rot_tb, self)
  end
end

function Quat:Inverse()
  local quat = Quat.New()
  quat.x = -self.x
  quat.y = -self.y
  quat.z = -self.z
  quat.w = self.w
  return quat
end

function Quat.Lerp(q1, q2, t)
  t = clamp(t, 0, 1)
  local q = _new()
  if Quat.Dot(q1, q2) < 0 then
    q.x = q1.x + t * (-q2.x - q1.x)
    q.y = q1.y + t * (-q2.y - q1.y)
    q.z = q1.z + t * (-q2.z - q1.z)
    q.w = q1.w + t * (-q2.w - q1.w)
  else
    q.x = q1.x + (q2.x - q1.x) * t
    q.y = q1.y + (q2.y - q1.y) * t
    q.z = q1.z + (q2.z - q1.z) * t
    q.w = q1.w + (q2.w - q1.w) * t
  end
  q:SetNormalize()
  return q
end

function Quat.LerpA(q1, q2, t, out)
  t = clamp(t, 0, 1)
  if Quat.Dot(q1, q2) < 0 then
    out.x = q1.x + t * (-q2.x - q1.x)
    out.y = q1.y + t * (-q2.y - q1.y)
    out.z = q1.z + t * (-q2.z - q1.z)
    out.w = q1.w + t * (-q2.w - q1.w)
  else
    out.x = q1.x + (q2.x - q1.x) * t
    out.y = q1.y + (q2.y - q1.y) * t
    out.z = q1.z + (q2.z - q1.z) * t
    out.w = q1.w + (q2.w - q1.w) * t
  end
  out:SetNormalize()
end

function Quat.LookRotation(forward, up)
  local mag = forward:Magnitude()
  if mag < 1.0E-6 then
    error("error input forward to Quat.LookRotation" + tostring(forward))
    return nil
  end
  forward = forward / mag
  up = up or _up
  local right = Vec3.Cross(up, forward)
  right:SetNormalize()
  up = Vec3.Cross(forward, right)
  right = Vec3.Cross(up, forward)
  local t = right.x + up.y + forward.z
  if t > 0 then
    local x, y, z, w
    t = t + 1
    local s = 0.5 / sqrt(t)
    w = s * t
    x = (up.z - forward.y) * s
    y = (forward.x - right.z) * s
    z = (right.y - up.x) * s
    local ret = _new(x, y, z, w)
    ret:SetNormalize()
    return ret
  else
    local rot = {
      {
        right.x,
        up.x,
        forward.x
      },
      {
        right.y,
        up.y,
        forward.y
      },
      {
        right.z,
        up.z,
        forward.z
      }
    }
    local q = {
      0,
      0,
      0
    }
    local i = 1
    if up.y > right.x then
      i = 2
    end
    if forward.z > rot[i][i] then
      i = 3
    end
    local j = _next[i]
    local k = _next[j]
    local t = rot[i][i] - rot[j][j] - rot[k][k] + 1
    local s = 0.5 / sqrt(t)
    q[i] = s * t
    local w = (rot[k][j] - rot[j][k]) * s
    q[j] = (rot[j][i] + rot[i][j]) * s
    q[k] = (rot[k][i] + rot[i][k]) * s
    local ret = _new(q[1], q[2], q[3], w)
    ret:SetNormalize()
    return ret
  end
end

local temp_right = Vec3.New()
local LookRotation_rot = {
  {
    1,
    2,
    3
  },
  {
    1,
    2,
    3
  },
  {
    1,
    2,
    3
  }
}
local LookRotation_q = {
  0,
  0,
  0
}

function Quat.LookRotationA(forward, up, out)
  local mag = forward:Magnitude()
  if mag < 1.0E-6 then
    error("error input forward to Quat.LookRotation" + tostring(forward))
    return nil
  end
  forward:Div(mag)
  up = up or _up
  Vec3.CrossA(up, forward, temp_right)
  temp_right:SetNormalize()
  Vec3.CrossA(forward, temp_right, up)
  Vec3.CrossA(up, forward, temp_right)
  local t = temp_right.x + up.y + forward.z
  if t > 0 then
    local x, y, z, w
    t = t + 1
    local s = 0.5 / sqrt(t)
    w = s * t
    x = (up.z - forward.y) * s
    y = (forward.x - temp_right.z) * s
    z = (temp_right.y - up.x) * s
    out:Set(x, y, z, w)
    out:SetNormalize()
  else
    local rot = LookRotation_rot
    rot[1][1] = temp_right.x
    rot[1][2] = up.x
    rot[1][3] = forward.x
    rot[2][1] = temp_right.y
    rot[2][2] = up.y
    rot[2][3] = forward.y
    rot[3][1] = temp_right.z
    rot[3][2] = up.z
    rot[3][3] = forward.z
    local q = LookRotation_q
    q[1] = 0
    q[2] = 0
    q[3] = 0
    local i = 1
    if up.y > temp_right.x then
      i = 2
    end
    if forward.z > rot[i][i] then
      i = 3
    end
    local j = _next[i]
    local k = _next[j]
    local t = rot[i][i] - rot[j][j] - rot[k][k] + 1
    local s = 0.5 / sqrt(t)
    q[i] = s * t
    local w = (rot[k][j] - rot[j][k]) * s
    q[j] = (rot[j][i] + rot[i][j]) * s
    q[k] = (rot[k][i] + rot[i][k]) * s
    out:Set(q[1], q[2], q[3], w)
    out:SetNormalize()
  end
end

function Quat:SetIdentity()
  self.x = 0
  self.y = 0
  self.z = 0
  self.w = 1
end

local function UnclampedSlerp(from, to, t)
  local cosAngle = Quat.Dot(from, to)
  if cosAngle < 0 then
    cosAngle = -cosAngle
    to = Quat.New(-to.x, -to.y, -to.z, -to.w)
  end
  local t1, t2
  if cosAngle < 0.95 then
    local angle = acos(cosAngle)
    local sinAngle = sin(angle)
    local invSinAngle = 1 / sinAngle
    t1 = sin((1 - t) * angle) * invSinAngle
    t2 = sin(t * angle) * invSinAngle
    local quat = _new(from.x * t1 + to.x * t2, from.y * t1 + to.y * t2, from.z * t1 + to.z * t2, from.w * t1 + to.w * t2)
    return quat
  else
    return Quat.Lerp(from, to, t)
  end
end

local temp_quat_00 = Quat.New()

local function UnclampedSlerpA(from, to, t, out)
  local cosAngle = Quat.Dot(from, to)
  temp_quat_00:CopyValue(to)
  if cosAngle < 0 then
    cosAngle = -cosAngle
    temp_quat_00:Set(-to.x, -to.y, -to.z, -to.w)
  end
  local t1, t2
  if cosAngle < 0.95 then
    local angle = acos(cosAngle)
    local sinAngle = sin(angle)
    local invSinAngle = 1 / sinAngle
    t1 = sin((1 - t) * angle) * invSinAngle
    t2 = sin(t * angle) * invSinAngle
    out:Set(from.x * t1 + temp_quat_00.x * t2, from.y * t1 + temp_quat_00.y * t2, from.z * t1 + temp_quat_00.z * t2, from.w * t1 + temp_quat_00.w * t2)
  else
    Quat.LerpA(from, to, t, out)
  end
end

function Quat.Slerp(from, to, t)
  t = clamp(t, 0, 1)
  return UnclampedSlerp(from, to, t)
end

function Quat.SlerpA(from, to, t, out)
  t = clamp(t, 0, 1)
  UnclampedSlerpA(from, to, t, out)
end

function Quat.RotateTowards(from, to, maxDegreesDelta)
  local angle = Quat.Angle(from, to)
  if 0 == angle then
    return to
  end
  local t = min(1, maxDegreesDelta / angle)
  return UnclampedSlerp(from, to, t)
end

local function Approximately(f0, f1)
  return abs(f0 - f1) < 1.0E-6
end

function Quat:ToAngleAxis()
  local angle = 2 * acos(self.w)
  if Approximately(angle, 0) then
    return angle * 57.29578, Vec3.New(1, 0, 0)
  end
  local div = 1 / sqrt(1 - sqrt(self.w))
  return angle * 57.29578, Vec3.New(self.x * div, self.y * div, self.z * div)
end

function Quat:ToAngleAxisA(out_vec3)
  local angle = 2 * acos(self.w)
  if Approximately(angle, 0) then
    out_vec3:Set(1, 0, 0)
    return angle * 57.29578
  end
  local div = 1 / sqrt(1 - sqrt(self.w))
  out_vec3:Set(self.x * div, self.y * div, self.z * div)
  return angle * 57.29578
end

local pi = math.pi
local half_pi = pi * 0.5
local two_pi = 2 * pi
local negativeFlip = -1.0E-4
local positiveFlip = two_pi - 1.0E-4

local function SanitizeEuler(euler)
  if euler.x < negativeFlip then
    euler.x = euler.x + two_pi
  elseif euler.x > positiveFlip then
    euler.x = euler.x - two_pi
  end
  if euler.y < negativeFlip then
    euler.y = euler.y + two_pi
  elseif euler.y > positiveFlip then
    euler.y = euler.y - two_pi
  end
  if euler.z < negativeFlip then
    euler.z = euler.z + two_pi
  elseif euler.z > positiveFlip then
    euler.z = euler.z + two_pi
  end
end

function Quat:ToEulerAngles()
  local x = self.x
  local y = self.y
  local z = self.z
  local w = self.w
  local check = 2 * (y * z - w * x)
  if check < 0.999 then
    if check > -0.999 then
      local v = Vec3.New(-asin(check), atan2(2 * (x * z + w * y), 1 - 2 * (x * x + y * y)), atan2(2 * (x * y + w * z), 1 - 2 * (x * x + z * z)))
      SanitizeEuler(v)
      v:Mul(rad2Deg)
      return v
    else
      local v = Vec3.New(half_pi, atan2(2 * (x * y - w * z), 1 - 2 * (y * y + z * z)), 0)
      SanitizeEuler(v)
      v:Mul(rad2Deg)
      return v
    end
  else
    local v = Vec3.New(-half_pi, atan2(-2 * (x * y - w * z), 1 - 2 * (y * y + z * z)), 0)
    SanitizeEuler(v)
    v:Mul(rad2Deg)
    return v
  end
end

function Quat:ToEulerAngles2(v)
  local x = self.x
  local y = self.y
  local z = self.z
  local w = self.w
  local check = 2 * (y * z - w * x)
  if check < 0.999 then
    if check > -0.999 then
      v:Set1(-asin(check), atan2(2 * (x * z + w * y), 1 - 2 * (x * x + y * y)), atan2(2 * (x * y + w * z), 1 - 2 * (x * x + z * z)))
      SanitizeEuler(v)
      v:Mul(rad2Deg)
    else
      v:Set1(half_pi, atan2(2 * (x * y - w * z), 1 - 2 * (y * y + z * z)), 0)
      SanitizeEuler(v)
      v:Mul(rad2Deg)
    end
  else
    v:Set1(-half_pi, atan2(-2 * (x * y - w * z), 1 - 2 * (y * y + z * z)), 0)
    SanitizeEuler(v)
    v:Mul(rad2Deg)
  end
end

function Quat:Forward()
  return self:MulVec3(_forward)
end

function Quat:MulVec3_NoneAlloc(point, ret_vec3)
  local num = self.x * 2
  local num2 = self.y * 2
  local num3 = self.z * 2
  local num4 = self.x * num
  local num5 = self.y * num2
  local num6 = self.z * num3
  local num7 = self.x * num2
  local num8 = self.x * num3
  local num9 = self.y * num3
  local num10 = self.w * num
  local num11 = self.w * num2
  local num12 = self.w * num3
  ret_vec3.x = (1 - (num5 + num6)) * point.x + (num7 - num12) * point.y + (num8 + num11) * point.z
  ret_vec3.y = (num7 + num12) * point.x + (1 - (num4 + num6)) * point.y + (num9 - num10) * point.z
  ret_vec3.z = (num8 - num11) * point.x + (num9 + num10) * point.y + (1 - (num4 + num5)) * point.z
  return ret_vec3
end

function Quat:MulVec3(point)
  local vec = Vec3.New()
  local num = self.x * 2
  local num2 = self.y * 2
  local num3 = self.z * 2
  local num4 = self.x * num
  local num5 = self.y * num2
  local num6 = self.z * num3
  local num7 = self.x * num2
  local num8 = self.x * num3
  local num9 = self.y * num3
  local num10 = self.w * num
  local num11 = self.w * num2
  local num12 = self.w * num3
  vec.x = (1 - (num5 + num6)) * point.x + (num7 - num12) * point.y + (num8 + num11) * point.z
  vec.y = (num7 + num12) * point.x + (1 - (num4 + num6)) * point.y + (num9 - num10) * point.z
  vec.z = (num8 - num11) * point.x + (num9 + num10) * point.y + (1 - (num4 + num5)) * point.z
  return vec
end

function Quat.Mul(q1, q2, out)
  local x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y
  local y = q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z
  local z = q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x
  local w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z
  out:Set(x, y, z, w)
end

function Quat:GetTransRotation(cs_trans)
  if nil == cs_trans then
    return
  end
  local x, y, z, w = cs_trans:GetRotationA(cs_trans)
  self.x, self.y, self.z, self.w = x, y, z, w
end

function Quat.SetTransRotation(cs_trans, quat)
  if nil == cs_trans or nil == quat then
    return
  end
  cs_trans:SetRotationA(quat.x, quat.y, quat.z, quat.w)
end

function Quat.__mul(lhs, rhs)
  if Quat == getmetatable(rhs) then
    return Quat.New(lhs.w * rhs.x + lhs.x * rhs.w + lhs.y * rhs.z - lhs.z * rhs.y, lhs.w * rhs.y + lhs.y * rhs.w + lhs.z * rhs.x - lhs.x * rhs.z, lhs.w * rhs.z + lhs.z * rhs.w + lhs.x * rhs.y - lhs.y * rhs.x, lhs.w * rhs.w - lhs.x * rhs.x - lhs.y * rhs.y - lhs.z * rhs.z)
  elseif Vec3 == getmetatable(rhs) then
    return lhs:MulVec3(rhs)
  end
end

function Quat.__unm(q)
  return Quat.New(-q.x, -q.y, -q.z, -q.w)
end

function Quat.__eq(lhs, rhs)
  return Quat.Dot(lhs, rhs) > 0.999999
end

function Quat:__tostring()
  return "[" .. self.x .. "," .. self.y .. "," .. self.z .. "," .. self.w .. "]"
end

Quat.identity = _new(0, 0, 0, 1)
Quat.eulerAngles = Quat.ToEulerAngles
return Quat

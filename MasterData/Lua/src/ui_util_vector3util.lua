local util = {}
local mSqrt = math.sqrt
local luaV3 = {}
luaV3.x = 0
luaV3.y = 0
luaV3.z = 0

function luaV3:calMagnitude()
  return mSqrt(self:calSqrMagnitude())
end

function luaV3:calSqrMagnitude()
  return self.x * self.x + self.y * self.y + self.z * self.z
end

function luaV3:calNormalized()
  local magnitude = mSqrt(self.x * self.x + self.y * self.y + self.z * self.z)
  return util.new(self.x / magnitude, self.y / magnitude, self.z / magnitude)
end

function luaV3:simplify()
  return {
    x = self.x,
    y = self.y,
    z = self.z
  }
end

function luaV3:toUnityV3()
  return CS.UnityEngine.Vector3(self.x, self.y, self.z)
end

function luaV3:toUnityV2()
  return CS.UnityEngine.Vector2(self.x, self.y)
end

local mt = {
  __index = function(tb, key)
    if key == "normalized" then
      return luaV3.calNormalized(tb)
    elseif key == "magnitude" then
      return luaV3.calMagnitude(tb)
    elseif key == "sqrMagnitude" then
      return luaV3.calSqrMagnitude(tb)
    elseif key == "copy" then
      return util.new(tb.x.tb.y, tb.z)
    else
      return luaV3[key]
    end
  end,
  __add = function(a, b)
    return util.new(a.x + b.x, a.y + b.y, a.z + b.z)
  end,
  __sub = function(a, b)
    return util.new(a.x - b.x, a.y - b.y, a.z - b.z)
  end,
  __div = function(a, value)
    return util.new(a.x / value, a.y / value, a.z / value)
  end,
  __mul = function(a, value)
    return util.new(a.x * value, a.y * value, a.z * value)
  end,
  __eq = function(a, b)
    local result = a.x == b.x and a.y == b.y and a.z == b.z
    return result
  end,
  __unm = function(a)
    return util.new(-a.x, -a.y, -a.z)
  end,
  __tostring = function(a)
    return string.format("{x:%.2f,y:%.2f,z:%.2f }", a.x, a.y, a.z)
  end
}

function util.new(x, y, z)
  local t = setmetatable({}, mt)
  t.x = x or 0
  t.y = y or 0
  t.z = z or 0
  return t
end

function util.UnityV3ToLua(v3)
  local t = setmetatable({}, mt)
  t.x = v3.x
  t.y = v3.y
  t.z = v3.z
  return t
end

function util.UnityV2ToLua(v3)
  local t = setmetatable({}, mt)
  t.x = v3.x
  t.y = v3.y
  return t
end

function util.dot(o1, o2)
  return o1.x * o2.x + o1.y * o2.y + o1.z * o2.z
end

function util.cross(o1, o2)
  local x = o1.y * o2.z - o1.z * o2.y
  local y = o1.z * o2.x - o1.x * o2.z
  local z = o1.x * o2.y - o1.y * o2.x
  return util.new(x, y, z)
end

function util.distance(o1, o2)
  local x = o1.x - o2.x
  local y = o1.y - o2.y
  local z = o1.z - o2.z
  return mSqrt(x * x + y * y + z * z)
end

function util.distance2(x1, y1, z1, x2, y2, z2)
  local x = x1 - x2
  local y = y1 - y2
  local z = z1 - z2
  return mSqrt(x * x + y * y + z * z)
end

function util.sqrDistance(o1, o2)
  local x = o1.x - o2.x
  local y = o1.y - o2.y
  local z = o1.z - o2.z
  return x * x + y * y + z * z
end

function util.sqrDistance2(x1, y1, z1, x2, y2, z2)
  local x = x1 - x2
  local y = y1 - y2
  local z = z1 - z2
  return x * x + y * y + z * z
end

function util.project(src, pTarget)
  local num1 = util.dot(pTarget, pTarget)
  local num2 = util.dot(src, src)
  return util.new(pTarget.x * num2 / num1, pTarget.y * num2 / num1, pTarget.z * num2 / num1)
end

function util.setRelativePos(transform, v)
  transform.position = v
end

function util.setRelativeRot(transform, v)
  util.setRot(transform, v)
end

function util.getRelativePos(transform)
  local x, y, z = transform:GetPosition()
  return util.new(x, y, z)
end

function util.getRelativeRot(transform)
  return util.getRot(transform)
end

function util.getRelativeTransformPoint(transform, v3)
  local x, y, z = transform:GetRelativeTransformPoint(v3.x, v3.y, v3.z)
  return util.new(x, y, z)
end

function util.getPos(transform)
  local x, y, z = transform:GetPosition()
  return util.new(x, y, z)
end

function util.getTransformPoint(transform, ox, oy, oz)
  local x, y, z = transform:GetTransformPoint(ox, oy, oz)
  return util.new(x, y, z)
end

function util.setPos(transform, v)
  transform:SetPosition(v.x, v.y, v.z)
end

function util.projectOnPlane(vector, planeNormal)
  local num1 = util.dot(planeNormal, planeNormal)
  if num1 <= 0 then
    return vector
  end
  local num2 = util.dot(vector, planeNormal)
  return util.new(vector.x - planeNormal.x * num2 / num1, vector.y - planeNormal.y * num2 / num1, vector.z - planeNormal.z * num2 / num1)
end

function util.getForward(transform)
  local x, y, z = transform:GetForward()
  return util.new(x, y, z)
end

function util.setForward(transform, v)
  transform:SetForward(v.x, v.y, v.z)
end

function util.getRight(transform)
  local x, y, z = transform:GetRight()
  return util.new(x, y, z)
end

function util.setRight(transform, v)
  transform:SetRight(v.x, v.y, v.z)
end

function util.getUp(transform)
  local x, y, z = transform:GetUp()
  return util.new(x, y, z)
end

function util.setUp(transform, v)
  transform:SetUp(v.x, v.y, v.z)
end

function util.setRot(transform, v)
  transform:SetEulerAngles(v.x, v.y, v.z)
end

function util.getRot(transform)
  local x, y, z = transform:GetEulerAngles()
  return util.new(x, y, z)
end

function util.getLocalPos(transform)
  local x, y, z = transform:GetLocalPosition()
  return util.new(x, y, z)
end

function util.setLocalPos(transform, v)
  transform:SetLocalPosition(v.x, v.y, v.z)
end

function util.getLocalRot(transform)
  local x, y, z = transform:GetLocalEulerAngles()
  return util.new(x, y, z)
end

function util.setLocalRot(transform, v)
  transform:SetLocalEulerAngles(v.x, v.y, v.z)
end

function util.getScale(transform)
  local x, y, z = transform:GetScale()
  return util.new(x, y, z)
end

function util.setScale(transform, v)
  transform:SetScale(v.x, v.y, v.z)
end

function util.setSize(transform, size)
  transform:SetScale(size, size, size)
end

function util.getSize(transform, size)
  local x = transform:GetScale()
  return x
end

function util.getAnchored(rectTrans)
  local x, y = rectTrans:GetAnchoredPosition()
  return util.new(x, y, 0)
end

function util.setAnchored(rectTrans, v)
  rectTrans:SetAnchoredPosition(v.x, v.y)
end

function util.setAnchored3D(rectTrans, v)
  rectTrans:SetAnchoredPosition3D(v.x, v.y, v.z)
end

function util.setUISize(rectTrans, v)
  rectTrans:SetUISize(v.x, v.y)
end

function util.setPivot(rectTrans, p)
  rectTrans:SetPivot(p.x, p.y)
end

function util.screenToLocalInRectangle(rectTrans, screenPoint, camera)
  camera = camera or C_CameraManager.uiCamera
  local result, x, y = camera:ScreenPointToLocalPointInRectangle(rectTrans, screenPoint.x, screenPoint.y)
  return util.new(x, y), result
end

function util.toScreenPosition(position, camera)
  camera = camera or C_CameraManager.uiCamera
  local scrPos = C_RectTransformUtility.WorldToScreenPoint(camera, position)
  return util.new(scrPos.x, scrPos.y)
end

util.temp = util.new(0, 0, 0)

function util.getTemp(x, y, z)
  local temp = util.temp
  temp.x = x or 0
  temp.y = y or 0
  temp.z = z or 0
  return temp
end

setmetatable(util, {
  __index = function(tb, key)
    if key == "one" then
      return util.new(1, 1, 1)
    elseif key == "zero" then
      return util.new(0, 0, 0)
    elseif key == "up" then
      return util.new(0, 1, 0)
    elseif key == "down" then
      return util.new(0, -1, 0)
    elseif key == "left" then
      return util.new(-1, 0, 0)
    elseif key == "right" then
      return util.new(1, 0, 0)
    elseif key == "forward" then
      return util.new(0, 0, 1)
    elseif key == "back" then
      return util.new(0, 0, -1)
    end
  end
})
return util

local GyroscopeOrientatedCtrl = NewClass("GyroscopeOrientatedCtrl")
local T_Component = typeof(CS.UnityEngine.Component)
local _GetLocalPos = CS.Framework.TransformUtil.GetLocalPos
local _SetLocalPos = CS.Framework.TransformUtil.SetLocalPos
local _GetLocalEulerAngles = CS.Framework.TransformUtil.GetLocalEulerAngles
local _SetLocalEulerAngles = CS.Framework.TransformUtil.SetLocalEulerAngles
local Speed = 0.3
local UnityTime = CS.UnityEngine.Time

function GyroscopeOrientatedCtrl:ctor(container)
  self.container = container
end

function GyroscopeOrientatedCtrl:SetInitPose(x, y, z, ex, ey, ez)
  self.originPositionX = x
  self.originPositionY = y
  self.originPositionZ = z
  self.originEulerX = ex
  self.originEulerY = ey
  self.originEulerZ = ez
end

function GyroscopeOrientatedCtrl:OnEnable()
  if not InputManager.Instance then
    return
  end
  if not self.originPositionX then
    local x, y, z = _GetLocalPos(self.container.transform, nil, nil, nil)
    local ex, ey, ez = _GetLocalEulerAngles(self.container.transform, nil, nil, nil)
    self.originPositionX = x
    self.originPositionY = y
    self.originPositionZ = z
    self.originEulerX = ex
    self.originEulerY = ey
    self.originEulerZ = ez
  end
  self.isDirty = false
  self.timeCount = 0
  if IsNil(self.gyroscopeCtrl) then
    local comps = self.container:GetComponents(T_Component)
    for i = 0, comps.Length - 1 do
      local tName = comps[i]:GetType().FullName
      if "GyroUtils.GyroController" == tName then
        self.gyroscopeCtrl = comps[i]
        break
      end
    end
  end
  if not IsNil(self.gyroscopeCtrl) then
    self.gyroscopeCtrl.enabled = false
    self.gyroscopeCtrl.enabled = true
  end
  InputManager.Instance:EnableDeviceOrientation()
  GlobalDispatcher:AddListener(NotifyId.OnDeviceOrientationChanged, self._OnDeviceOrientationChanged, self)
end

function GyroscopeOrientatedCtrl:OnDisable()
  if not InputManager.Instance then
    return
  end
  self.isDirty = false
  self.timeCount = 0
  InputManager.Instance:DisableDeviceOrientation()
  GlobalDispatcher:RemoveListener(NotifyId.OnDeviceOrientationChanged, self._OnDeviceOrientationChanged, self)
end

function GyroscopeOrientatedCtrl:LateUpdate()
  if not self.isDirty or not self.startX then
    return
  end
  if self.timeCount >= Speed then
    self.isDirty = false
    self:_EnableGyroController(true)
    return
  end
  self.timeCount = self.timeCount or 0
  self.timeCount = self.timeCount + UnityTime.deltaTime
  if self.timeCount >= Speed then
    self.timeCount = Speed
  end
  local scale = self.timeCount / Speed
  local x = self.startX + self.positionXDelta * scale
  local y = self.startY + self.positionYDelta * scale
  local z = self.startZ + self.positionZDelta * scale
  local ex = self.startEX + self.rotationXDelta * scale
  local ey = self.startEY + self.rotationYDelta * scale
  local ez = self.startEZ + self.rotationZDelta * scale
  _SetLocalPos(self.container.transform, x, y, z)
  _SetLocalEulerAngles(self.container.transform, ex, ey, ez)
end

function GyroscopeOrientatedCtrl:_OnDeviceOrientationChanged()
  self.isDirty = true
  local ex, ey, ez = _GetLocalEulerAngles(self.container.transform, nil, nil, nil)
  local x, y, z = _GetLocalPos(self.container.transform, nil, nil, nil)
  self.startX = x
  self.startY = y
  self.startZ = z
  self.startEX = ex
  self.startEY = ey
  self.startEZ = ez
  self.positionXDelta = self.originPositionX - self.startX
  self.positionYDelta = self.originPositionY - self.startY
  self.positionZDelta = self.originPositionZ - self.startZ
  self.rotationXDelta = self.originEulerX - self.startEX
  self.rotationYDelta = self.originEulerY - self.startEY
  self.rotationZDelta = self.originEulerZ - self.startEZ
  self.timeCount = 0
  self:_EnableGyroController(false)
end

function GyroscopeOrientatedCtrl:_EnableGyroController(enabled)
  if IsNil(self.container) then
    return
  end
  if not IsNil(self.gyroscopeCtrl) then
    self.gyroscopeCtrl.enabled = enabled
  end
end

return GyroscopeOrientatedCtrl

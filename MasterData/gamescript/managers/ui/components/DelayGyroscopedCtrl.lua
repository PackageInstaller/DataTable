local DelayGyroscopedCtrl = NewClass("DelayGyroscopedCtrl")
local _SetLocalEulerAngles = CS.Framework.TransformUtil.SetLocalEulerAngles
local DisableGyroscopedRef = 0
local GyroManager

local function ActiveGyroManager()
  DisableGyroscopedRef = DisableGyroscopedRef - 1
  if 0 == DisableGyroscopedRef and not IsNil(GyroManager) then
    GyroManager:SetActive(true)
  end
end

local function DeactiveGyroManager()
  DisableGyroscopedRef = DisableGyroscopedRef + 1
  if not IsNil(GyroManager) then
    GyroManager:SetActive(false)
  end
end

function DelayGyroscopedCtrl:ctor(container)
  self.container = container
  if not GyroManager then
    GyroManager = CS.UnityEngine.GameObject.Find("GyroManager")
  end
end

function DelayGyroscopedCtrl:Frozen()
  self.isFrozen = true
end

function DelayGyroscopedCtrl:Unfrozen()
  self.isFrozen = false
end

function DelayGyroscopedCtrl:OnEnable()
  self.delayFrame = 3
  self.deactiveGyroManager = true
  _SetLocalEulerAngles(self.container.transform, 0, 0, 0)
  DeactiveGyroManager()
end

function DelayGyroscopedCtrl:OnDisable()
  if self.deactiveGyroManager then
    self.deactiveGyroManager = false
    ActiveGyroManager()
  end
end

function DelayGyroscopedCtrl:LateUpdate()
  if self.isFrozen then
    return
  end
  if not self.deactiveGyroManager or self.delayFrame <= 0 then
    return
  end
  self.delayFrame = self.delayFrame - 1
  _SetLocalEulerAngles(self.container.transform, 0, 0, 0)
  if self.delayFrame <= 0 then
    self:OnDisable()
  end
end

return DelayGyroscopedCtrl

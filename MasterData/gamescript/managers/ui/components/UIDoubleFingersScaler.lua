local UIDoubleFingersScaler = NewClass("UIDoubleFingersScaler")
local TransformUtil = CS.Framework.TransformUtil
local TouchPhase = CS.UnityEngine.TouchPhase
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local _SetLocalScale = TransformUtil.SetLocalScale
local _Distance = CS.UnityEngine.Vector2.Distance

function UIDoubleFingersScaler:ctor(go)
  self.gameObject = go
  self.transform = go.transform
  self.oriTouchDistance = nil
  self.lastDeltaScale = 0
  self.minScale = nil
  self.maxScale = nil
  self.scale = 1
end

function UIDoubleFingersScaler:OnEnable()
end

function UIDoubleFingersScaler:OnDisable()
end

function UIDoubleFingersScaler:SetInitScale(scale)
  self.scale = scale
end

function UIDoubleFingersScaler:SetScaleLimit(min, max)
  self.minScale = min
  self.maxScale = max
end

function UIDoubleFingersScaler:SetUpdateCallback(callback)
  self.updateScaleCb = callback
end

function UIDoubleFingersScaler:Update()
  if Input.touchCount <= 1 then
    return
  end
  if 2 == Input.touchCount then
    local touch1 = Input.GetTouch(0)
    local touch2 = Input.GetTouch(1)
    if touch2.phase == TouchPhase.Began then
      self.oriTouchDistance = _Distance(touch1.position, touch2.position)
      return
    end
    if touch1.phase == TouchPhase.Moved or touch2.phase == TouchPhase.Moved then
      local distance = _Distance(touch1.position, touch2.position)
      local offset = distance - self.oriTouchDistance
      local deltaScale = offset / 100
      local isSameTrend = 0 == self.lastDeltaScale or self.lastDeltaScale > 0 and deltaScale > 0 or self.lastDeltaScale < 0 and deltaScale < 0
      if isSameTrend then
        local scale = self.scale + self.lastDeltaScale
        scale = self:_FixedScaleValue(scale)
        _SetLocalScale(self.transform, scale, scale, scale)
        self.scale = scale
        if self.updateScaleCb then
          self.updateScaleCb(self.scale)
        end
      end
      self.oriTouchDistance = distance
      self.lastDeltaScale = deltaScale
    end
  end
end

function UIDoubleFingersScaler:_FixedScaleValue(scale)
  if self.minScale and scale < self.minScale then
    scale = self.minScale
  end
  if self.maxScale and scale > self.maxScale then
    scale = self.maxScale
  end
  return scale
end

return UIDoubleFingersScaler

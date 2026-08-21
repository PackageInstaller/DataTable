_class("StoryEntityMovable", StoryEntity)
StoryEntityMovable = StoryEntityMovable
local StoryEntityAnimationType = {
  AlphaChange = 1,
  BrightnessChange = 2,
  Translate = 3,
  Rotate = 4,
  Scale = 5,
  Shake = 6,
  BlurChange = 7
}
_enum("StoryEntityAnimationType", StoryEntityAnimationType)

function StoryEntityMovable:Constructor(ID, gameObject, resRequest, storyManager)
  StoryEntityMovable.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._animationData = {}
  storyManager:InitLayerInfo(gameObject.transform)
end

function StoryEntityMovable:_TriggerKeyframe(keyframeData)
  if keyframeData.Active ~= nil then
    self._gameObject:SetActive(keyframeData.Active)
  end
  if keyframeData.Alpha ~= nil then
    self:_SetAlpha(keyframeData.Alpha)
  end
  if keyframeData.Brightness ~= nil then
    self:_SetBrightness(keyframeData.Brightness)
  end
  if keyframeData.Position ~= nil then
    self:_SetPosition(Vector3(keyframeData.Position[1], keyframeData.Position[2], 0))
  end
  if keyframeData.Rotation ~= nil then
    self:_SetRotation(Quaternion.Euler(0, 0, keyframeData.Rotation))
  end
  if keyframeData.Scaling ~= nil then
    self:_SetScaling(Vector3(keyframeData.Scaling[1], keyframeData.Scaling[2], 1))
  end
  if keyframeData.Layer ~= nil then
    self:_SetLayer(keyframeData.Layer)
  end
  if keyframeData.PlayAnimation ~= nil then
    local animCmp = self._gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
    if not animCmp then
      Log.fatal("story entity without animation component triggered animation:" .. keyframeData.PlayAnimation)
    else
      animCmp:Play(keyframeData.PlayAnimation)
    end
  end
  if keyframeData.AlphaChange then
    local aniInfo = {
      StoryEntityAnimationType.AlphaChange,
      keyframeData.Time,
      keyframeData.AlphaChange.StartValue,
      keyframeData.AlphaChange.EndValue
    }
    self._animationData[keyframeData.AlphaChange] = aniInfo
  end
  if keyframeData.BrightnessChange then
    local aniInfo = {
      StoryEntityAnimationType.BrightnessChange,
      keyframeData.Time,
      keyframeData.BrightnessChange.StartValue,
      keyframeData.BrightnessChange.EndValue
    }
    self._animationData[keyframeData.BrightnessChange] = aniInfo
  end
  if keyframeData.BlurChange then
    local aniInfo = {
      StoryEntityAnimationType.BlurChange,
      keyframeData.Time,
      keyframeData.BlurChange.BlurType,
      keyframeData.BlurChange.BlurDirection,
      keyframeData.BlurChange.Duration,
      keyframeData.BlurChange.StartValue,
      keyframeData.BlurChange.EndValue
    }
    self._animationData[keyframeData.BlurChange] = aniInfo
  end
  if keyframeData.Translate then
    local aniInfo = {
      StoryEntityAnimationType.Translate,
      keyframeData.Time,
      Vector3(keyframeData.Translate.StartValue[1], keyframeData.Translate.StartValue[2], 0),
      Vector3(keyframeData.Translate.EndValue[1], keyframeData.Translate.EndValue[2], 0)
    }
    self._animationData[keyframeData.Translate] = aniInfo
  end
  if keyframeData.Rotate then
    local aniInfo = {
      StoryEntityAnimationType.Rotate,
      keyframeData.Time,
      Quaternion.Euler(0, 0, keyframeData.Rotate.StartValue),
      Quaternion.Euler(0, 0, keyframeData.Rotate.EndValue)
    }
    self._animationData[keyframeData.Rotate] = aniInfo
  end
  if keyframeData.Scale then
    local aniInfo = {
      StoryEntityAnimationType.Scale,
      keyframeData.Time,
      Vector3(keyframeData.Scale.StartValue[1], keyframeData.Scale.StartValue[2], 1),
      Vector3(keyframeData.Scale.EndValue[1], keyframeData.Scale.EndValue[2], 1)
    }
    self._animationData[keyframeData.Scale] = aniInfo
  end
  if keyframeData.Shake and not self._storyManager:IsJumping() then
    local shakeData = keyframeData.Shake
    local tweener = self._gameObject.transform:DOShakePosition(shakeData.Duration, Vector3(shakeData.Strength[1], shakeData.Strength[2], 0), shakeData.Vibrato, 0, false, shakeData.fadeOut)
    local aniInfo = {
      StoryEntityAnimationType.Shake,
      keyframeData.Time,
      tweener
    }
    self._animationData[keyframeData.Shake] = aniInfo
  end
end

function StoryEntityMovable:_UpdateAnimation(time)
  local allEnd = true
  for aniData, aniInfo in pairs(self._animationData) do
    allEnd = false
    local t = 1
    if aniData.Duration > 0 then
      t = (time - aniInfo[2]) / aniData.Duration
    end
    if 1 < t then
      t = 1
    end
    if aniInfo[1] == StoryEntityAnimationType.AlphaChange then
      self:_SetAlpha(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.BrightnessChange then
      self:_SetBrightness(lmathext.lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Translate then
      self:_SetPosition(Vector3.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Rotate then
      self:_SetRotation(Quaternion.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Scale then
      self:_SetScaling(Vector3.Lerp(aniInfo[3], aniInfo[4], t))
    elseif aniInfo[1] == StoryEntityAnimationType.BlurChange then
      self:_SetPicBlur(aniInfo[3], aniInfo[4], lmathext.lerp(aniInfo[6], aniInfo[7], t))
    elseif aniInfo[1] == StoryEntityAnimationType.Shake and self._storyManager:IsJumping() then
      aniInfo[3]:Kill(true)
      self._animationData[aniData] = nil
    end
    if 1 <= t then
      self._animationData[aniData] = nil
    end
  end
  return allEnd
end

function StoryEntityMovable:_SetAlpha(alpha)
end

function StoryEntityMovable:_SetBrightness(brightness)
end

function StoryEntityMovable:_SetPicBlur(blurType, BlurDirection, blur)
end

function StoryEntityMovable:_SetLayer(layer)
  self._storyManager:SetLayer(self._gameObject.transform, layer)
end

function StoryEntityMovable:_SetPosition(pos)
  self._gameObject.transform.localPosition = pos
end

function StoryEntityMovable:_SetRotation(rot)
  self._gameObject.transform.localRotation = rot
end

function StoryEntityMovable:_SetScaling(scale)
  self._gameObject.transform.localScale = scale
end

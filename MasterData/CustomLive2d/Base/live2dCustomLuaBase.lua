local live2dCustomLuaBase = class("live2dCustomLuaBase")

function live2dCustomLuaBase:ctor()
end

function live2dCustomLuaBase:Init(heroL2dInterationController)
  if IsNull(heroL2dInterationController) or self.__inited then
    return
  end
  self.__inited = true
  self.ctrl = heroL2dInterationController
  self.csCtrl = self.ctrl.cs_CubismInterationController
  self.cs_CubismModel = self.csCtrl:GetComponent(typeof(CS.Live2D.Cubism.Core.CubismModel))
  self.transform = self.csCtrl.transform
  self.gameObject = self.csCtrl.gameObject
  self.name = self.ctrl.config.name
  self.active = self.csCtrl.enabled
  self:OnInit()
end

function live2dCustomLuaBase:SafeCheck()
  if self.ctrl == nil then
    return false
  end
  if IsNull(self.csCtrl) then
    return false
  end
  if IsNull(self.transform) then
    return false
  end
  if IsNull(self.gameObject) then
    return false
  end
  return true
end

function live2dCustomLuaBase:IsHideBg()
  if not self:SafeCheck() then
    return false
  end
  return self.ctrl:IsHideL2dBg()
end

function live2dCustomLuaBase:GetParamValue(paramName)
  if not self:SafeCheck() then
    return
  end
  if self._paramTable == nil then
    self._paramTable = {}
  end
  if self._paramTable[paramName] ~= nil then
    return self._paramTable[paramName].Value
  end
  local parameters = self.cs_CubismModel.Parameters
  local result
  for i = 0, parameters.Length - 1 do
    self._paramTable[parameters[i].name] = parameters[i]
    if parameters[i].name == paramName then
      result = parameters[i].Value
    end
  end
  return result
end

function live2dCustomLuaBase:GetDragParam(dragParamName)
  if not self:SafeCheck() then
    return
  end
  if self.params == nil then
    self.params = self.csCtrl:GetComponentsInChildren(typeof(CS.CubismInterationParameter))
  end
  local dragParams = self.params
  for i = 0, dragParams.Length - 1 do
    if dragParams[i].name == dragParamName then
      return dragParams[i]
    end
  end
end

function live2dCustomLuaBase:GetL2dClip(clipName)
  if not self:SafeCheck() then
    return nil
  end
  local l2DParameterClip = self.csCtrl:GetFirstL2DClipByCondition(function(l2DClip)
    return l2DClip.Name == clipName
  end)
  return l2DParameterClip
end

function live2dCustomLuaBase:PlayCv(cvId, aniLength, dontCheckTime, closeMouseListen)
  if not self:SafeCheck() then
    return nil
  end
  self.ctrl:__PlayCV(cvId, aniLength, dontCheckTime, closeMouseListen)
end

function live2dCustomLuaBase:PlayEffect(particleName)
  if not self:SafeCheck() then
    return nil
  end
  self.ctrl:PlayL2DEffectEvent(particleName, true)
end

function live2dCustomLuaBase:PlayEffect(particleName)
  if not self:SafeCheck() then
    return nil
  end
  self.ctrl:PlayL2DEffectEvent(particleName, false)
end

function live2dCustomLuaBase:PlayOnceAudio(audioId)
  if not self:SafeCheck() then
    return nil
  end
  self.ctrl:PlaySoundFxEvent(audioId, "sfx", true)
end

function live2dCustomLuaBase:StartLoopAudio(audioId)
  if not self:SafeCheck() then
    return nil
  end
  self.ctrl:PlaySoundFxEvent(audioId, "bgSfx", true)
end

function live2dCustomLuaBase:StopLoopAudio(audioId)
  if not self:SafeCheck() then
    return nil
  end
  self.ctrl:PlaySoundFxEvent(audioId, "bgSfx", false)
end

function live2dCustomLuaBase:OnDelete()
  self.__inited = nil
  self.ctrl = nil
  self.csCtrl = nil
  self.transform = nil
  self.gameObject = nil
  self.name = nil
  self.active = nil
end

function live2dCustomLuaBase:OnInit()
end

function live2dCustomLuaBase:OnPlayL2dClip(animName)
end

function live2dCustomLuaBase:OnLive2dEvent(eventName, ...)
end

function live2dCustomLuaBase:OnEventCallCustomLua(eventArg)
end

function live2dCustomLuaBase:OnTriggerCallCustomLua(triggerArg)
end

function live2dCustomLuaBase:OnCvOver()
end

function live2dCustomLuaBase:OnSetInterationOpenWait()
end

function live2dCustomLuaBase:SetInterationOpenRayCast()
end

function live2dCustomLuaBase:OnSetLive2dUIPos()
end

return live2dCustomLuaBase

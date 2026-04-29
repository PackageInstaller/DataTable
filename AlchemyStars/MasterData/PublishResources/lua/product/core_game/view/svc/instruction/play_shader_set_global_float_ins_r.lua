require("base_ins_r")
_class("PlayShaderSetGlobalFloatInstruction", BaseInstruction)
PlayShaderSetGlobalFloatInstruction = PlayShaderSetGlobalFloatInstruction

function PlayShaderSetGlobalFloatInstruction:Constructor(paramList)
  self._paramName = paramList.paramName
  self._value = tonumber(paramList.value) or 0
  self._duration = tonumber(paramList.duration)
end

function PlayShaderSetGlobalFloatInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._duration and self._duration > 0 then
    local duration = self._duration * 0.001
    local baseValue = UnityEngine.Shader.GetGlobalFloat(self._paramName)
    if baseValue == self._value then
      return
    end
    local factor = 0
    if baseValue < self._value then
      factor = 1
    elseif baseValue > self._value then
      factor = -1
    end
    local runTime = 0
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      while runTime <= duration do
        runTime = runTime + UnityEngine.Time.deltaTime
        local timePercent = runTime / duration
        local newValue = baseValue + timePercent * factor * math.abs(baseValue - self._value)
        newValue = Mathf.Clamp(timePercent, newValue, self._value)
        UnityEngine.Shader.SetGlobalFloat(self._paramName, newValue)
        YIELD(TT)
      end
    end)
  else
    UnityEngine.Shader.SetGlobalFloat(self._paramName, self._value)
  end
end

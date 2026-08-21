require("cutscene_base_ins_r")
_class("CutsceneChangeFogColorInstruction", CutsceneBaseInstruction)
CutsceneChangeFogColorInstruction = CutsceneChangeFogColorInstruction

function CutsceneChangeFogColorInstruction:Constructor(paramList)
  self._duration = tonumber(paramList.duration)
  self._colorR = tonumber(paramList.colorR) or 255
  self._colorG = tonumber(paramList.colorG) or 255
  self._colorB = tonumber(paramList.colorB) or 255
  self._colorA = tonumber(paramList.colorA) or 255
end

function CutsceneChangeFogColorInstruction:DoInstruction(TT, phaseContext)
  local world = phaseContext:GetCutsceneWorld()
  local goRenderSetting = UnityEngine.GameObject.Find("[H3DRenderSetting]")
  local csRenderSetting = goRenderSetting:GetComponent("H3DRenderSetting")
  local flogColor = csRenderSetting.FlogColor
  local targetColor = Color(self._colorR / 255, self._colorG / 255, self._colorB / 255, self._colorA / 255)
  local runTime = 0
  self._duration = self._duration / 1000
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    while runTime <= self._duration do
      runTime = runTime + UnityEngine.Time.deltaTime
      local timePercent = runTime / self._duration
      local colorR = Mathf.Clamp(timePercent, flogColor.r, targetColor.r)
      local colorG = Mathf.Clamp(timePercent, flogColor.g, targetColor.g)
      local colorB = Mathf.Clamp(timePercent, flogColor.b, targetColor.b)
      local colorA = Mathf.Clamp(timePercent, flogColor.a, targetColor.a)
      local newColor = Color(colorR, colorG, colorB, colorA)
      csRenderSetting.FlogColor = newColor
      YIELD(TT)
    end
  end)
end

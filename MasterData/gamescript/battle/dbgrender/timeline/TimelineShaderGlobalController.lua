local TimelineShaderGlobalController = System.NewClass("TimelineShaderGlobalController")
local SceneFloatName = "UltiSceneProgress"
local AwakerFloatName = "UltiCharacterProgress"
local SceneColorName = "_UltiSceneColor"
local AwakerColorName = "_UltiCharacterColor"
local _SetGlobalFloat = CS.UnityEngine.Shader.SetGlobalFloat
local _SetGlobalColor = CS.UnityEngine.Shader.SetGlobalColor
local TempColor = CS.UnityEngine.Color(1, 1, 1, 1)

function TimelineShaderGlobalController:ctor()
  self._easeType = 0
  self._duration = 0
  self._fromValue = 0
  self._toValue = 0
  self._sceneColorR = 0
  self._sceneColorG = 0
  self._sceneColorB = 0
  self._awakerColorR = 0
  self._awakerColorG = 0
  self._awakerColorB = 0
  self._curTimeCount = 0
  self._easeFunc = TimelineEaseFunc.Linear
end

function TimelineShaderGlobalController:Start(param)
  local global_params = string.split(param, ",")
  self._fromValue = tonumber(global_params[1])
  self._toValue = tonumber(global_params[2])
  local sr, sg, sb = StrUtils.ConvertHexToRGB(global_params[3])
  local ar, ag, ab = StrUtils.ConvertHexToRGB(global_params[4])
  self._easeType = tonumber(global_params[5])
  self._duration = tonumber(global_params[6])
  self._sceneColorR = sr
  self._sceneColorG = sg
  self._sceneColorB = sb
  self._awakerColorR = ar
  self._awakerColorG = ag
  self._awakerColorB = ab
  self._curTimeCount = 0
  self._easeFunc = TimelineEaseFunc.GetEaseFunction(self._easeType)
  self._easeFunc = self._easeFunc or TimelineEaseFunc.Linear
  UpdateBeat.Instance:Add(self._Update, self)
  self:SetGlobalFloat(self._fromValue)
  self:SetGlobalSceneColor(self._sceneColorR, self._sceneColorG, self._sceneColorB)
  self:SetAwakerSceneColor(self._awakerColorR, self._awakerColorG, self._awakerColorB)
  if bg.battleScene then
    bg.battleScene:EnableApplyDepthFog(true)
  end
end

function TimelineShaderGlobalController:Stop()
  self._curTimeCount = 0
  if 0 == self._toValue and bg.battleScene then
    bg.battleScene:EnableApplyDepthFog(false)
  end
  UpdateBeat.Instance:Remove(self._Update, self)
end

function TimelineShaderGlobalController:SetGlobalFloat(val)
  _SetGlobalFloat(SceneFloatName, val)
  _SetGlobalFloat(AwakerFloatName, val)
end

function TimelineShaderGlobalController:SetGlobalSceneColor(r, g, b)
  TempColor.r = r
  TempColor.g = g
  TempColor.b = b
  _SetGlobalColor(SceneColorName, TempColor)
end

function TimelineShaderGlobalController:SetAwakerSceneColor(r, g, b)
  TempColor.r = r
  TempColor.g = g
  TempColor.b = b
  _SetGlobalColor(AwakerColorName, TempColor)
end

function TimelineShaderGlobalController:_Update(deltaTime)
  if not bg.battleRender then
    self:Stop()
    return
  end
  self._curTimeCount = self._curTimeCount + bg.battleRender.gameSpeed * deltaTime
  local percent = self._easeFunc(0, 1, self._curTimeCount / self._duration)
  local value = self._fromValue + (self._toValue - self._fromValue) * percent
  self:SetGlobalFloat(value)
  self:SetGlobalSceneColor(self._sceneColorR, self._sceneColorG, self._sceneColorB)
  self:SetAwakerSceneColor(self._awakerColorR, self._awakerColorG, self._awakerColorB)
  if self._curTimeCount >= self._duration then
    self:Stop()
  end
end

TimelineShaderGlobalController.Instance = TimelineShaderGlobalController()
return TimelineShaderGlobalController

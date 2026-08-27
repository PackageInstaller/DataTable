local AvgPostProcess = class("AvgPostProcess")
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
local CS_DOTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease
local CS_RenderTextureFormat = CS.UnityEngine.RenderTextureFormat
local CS_SystemInfo = CS.UnityEngine.SystemInfo
local CS_RenderManager_Ins = CS.RenderManager.Instance
local CS_Object = CS.UnityEngine.Object
local eTweenName = {
  cg_saturation = 1,
  dof_focusDistance = 2,
  rRgbS_blurRadius = 3
}
local tweenDuration = 0.5
local avgBlurTweenEndValue = 5

function AvgPostProcess:ctor(avgSystem)
  self.avgSystem = avgSystem
  self.tweenDic = {}
end

function AvgPostProcess:InitAvgPP(ppProfile)
  self._enablePP = CS_RenderManager_Ins.PostEffectLevel > 0
  local uiCamera = UIManager.UICamera
  local instancePPProfile = CameraEffectUtil:InstantiatePostProcessProfile(ppProfile)
  self._new_PPStackItem = CameraEffectUtil:AddPPStack(uiCamera, instancePPProfile)
  UIManager.csUIManager.UICamPPVolume.sharedProfile = instancePPProfile
  UIManager.csUIManager.UICamPPVolume.profile = instancePPProfile
  self._new_ppProfile = instancePPProfile
  if self._enablePP then
    UIManager.csUIManager.UICamPPLayer.enabled = true
  end
end

function AvgPostProcess:ChangeAvgPP(ppCfg)
  if ppCfg == nil then
    return
  end
  self:_ColorGradingTween(ppCfg)
  self:_BlurTween(ppCfg)
  self:_rRgbSTween(ppCfg)
end

function AvgPostProcess:_ColorGradingTween(ppCfg)
  local colorGradient = ppCfg.cg
  if colorGradient == nil then
    return
  end
  if self.__ppColorGrading == nil then
    local ok, ppColorGrading = self._new_ppProfile:TryGetSettings(typeof(CS.UnityEngine.Rendering.PostProcessing.ColorGrading))
    if ok then
      self.__ppColorGrading = ppColorGrading
    else
      error("Cant get ColorGrading")
      return
    end
  end
  if colorGradient.saturation ~= nil then
    local tween = self.tweenDic[eTweenName.cg_saturation]
    if tween ~= nil then
      tween:Kill()
    end
    tween = CS_DOTween.To(function()
      return self.__ppColorGrading.saturation.value
    end, function(value)
      self.__ppColorGrading.saturation:Override(value)
    end, colorGradient.saturation, tweenDuration)
    self.tweenDic[eTweenName.cg_saturation] = tween
    tween:OnComplete(function()
      self.tweenDic[eTweenName.cg_saturation] = nil
      self:_OnTweenComplete()
    end)
    tween:SetUpdate(self.avgSystem:AvgIgnoreTimeScale())
  end
end

function AvgPostProcess:_rRgbSTween(ppCfg)
  local tweenCfg = ppCfg.rRgbSTween
  if tweenCfg == nil then
    return
  end
  if self.__ppRadialRGBSplit == nil then
    local okDof, ppRadialRGBSplit = self._new_ppProfile:TryGetSettings(typeof(CS.XPostProcessing.RadialRGBSplit))
    if okDof then
      self.__ppRadialRGBSplit = ppRadialRGBSplit
    else
      error("Cant get RadialRGBSplit")
      return
    end
  end
  self.__ppRadialRGBSplit.enabled:Override(true)
  local tween = self.tweenDic[eTweenName.rRgbS_blurRadius]
  if tween ~= nil then
    tween:Kill()
  end
  local startValue = tweenCfg.isShow and 0 or tweenCfg.blurRadius
  local endValueValue = tweenCfg.isShow and tweenCfg.blurRadius or 0
  tween = CS_DOTween.To(function()
    return startValue
  end, function(value)
    self.__ppRadialRGBSplit.BlurRadius:Override(value)
  end, endValueValue, tweenCfg.duration)
  self.tweenDic[eTweenName.rRgbS_blurRadius] = tween
  tween:OnComplete(function()
    self.tweenDic[eTweenName.rRgbS_blurRadius] = nil
    if not tweenCfg.isShow then
      self.__ppRadialRGBSplit.enabled:Override(false)
    end
    self:_OnTweenComplete()
  end)
  tween:SetUpdate(self.avgSystem:AvgIgnoreTimeScale()):SetEase(tweenCfg.isShow and cs_Ease.OutQuad or cs_Ease.InQuad)
end

function AvgPostProcess:_BlurTween(ppCfg)
  local depthOfFieldTweenCfg = ppCfg.dofTween
  if depthOfFieldTweenCfg == nil then
    return
  end
  if self.__ppDepthOfField == nil then
    local okDof, ppDepthOfField = self._new_ppProfile:TryGetSettings(typeof(CS.UnityEngine.Rendering.PostProcessing.DepthOfField))
    if okDof then
      self.__ppDepthOfField = ppDepthOfField
      self.__ppDepthOfField.enabled:Override(false)
    else
      error("Cant get DepthOfField")
      return
    end
  end
  local tween = self.tweenDic[eTweenName.dof_focusDistance]
  if tween ~= nil then
    tween:Kill()
  end
  if CS_SystemInfo.SupportsRenderTextureFormat(CS_RenderTextureFormat.ARGBHalf) then
    self.__ppDepthOfField.enabled:Override(true)
  end
  tween = CS_DOTween.To(function()
    local startValue = (1 - depthOfFieldTweenCfg.startValue) * avgBlurTweenEndValue
    return startValue
  end, function(value)
    self.__ppDepthOfField.focusDistance:Override(value)
  end, avgBlurTweenEndValue, depthOfFieldTweenCfg.duration)
  self.tweenDic[eTweenName.dof_focusDistance] = tween
  tween:OnComplete(function()
    self.tweenDic[eTweenName.dof_focusDistance] = nil
    self.__ppDepthOfField.enabled:Override(false)
    self:_OnTweenComplete()
  end)
  tween:SetUpdate(self.avgSystem:AvgIgnoreTimeScale()):SetEase(cs_Ease.InQuad)
end

function AvgPostProcess:SkipAvgPPV()
  for k, tween in pairs(self.tweenDic) do
    tween:Complete()
  end
end

function AvgPostProcess:EndAvgPPV()
  for k, tween in pairs(self.tweenDic) do
    tween:Kill()
  end
end

function AvgPostProcess:_OnTweenComplete()
  self.avgSystem:OnAvgPPVTweenComplete()
end

function AvgPostProcess:Delete()
  for k, tween in pairs(self.tweenDic) do
    if tween ~= nil then
      tween:Kill()
    end
  end
  CameraEffectUtil:RemovePPStack(self._new_PPStackItem)
  self._new_PPStackItem = nil
  DestroyUnityObject(self._new_ppProfile)
  self._new_ppProfile = nil
  self.__ppColorGrading = nil
  self.__ppDepthOfField = nil
  self.__ppRadialRGBSplit = nil
end

return AvgPostProcess

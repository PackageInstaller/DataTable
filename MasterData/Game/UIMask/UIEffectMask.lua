local UIEffectMask = class("UIEffectMask", UIBaseWindow)
local base = UIBaseWindow
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")

function UIEffectMask:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  local uiCamera = UIManager.UICamera
  if not IsNull(uiCamera) then
    self.uiCameraPostProcessLayer = UIManager.csUIManager.UICamPPLayer
    self.uiCameraPostProcessVolume = UIManager.csUIManager.UICamPPVolume
    if not IsNull(self.uiCameraPostProcessLayer) then
      self.originalLayerEnable = self.uiCameraPostProcessLayer.enabled
    end
    if not IsNull(self.uiCameraPostProcessVolume) then
      self.originalProfile = self.uiCameraPostProcessVolume.profile
    end
  end
end

function UIEffectMask:ShowOldMovieEffectMask()
  if not IsNull(self.ui.oldMovieEffectMask) then
    self.ui.oldMovieEffectMask:SetActive(true)
  end
  if not IsNull(self.uiCameraPostProcessLayer) then
    self.uiCameraPostProcessLayer.enabled = true
  end
  if not IsNull(self.uiCameraPostProcessVolume) then
    self.uiCameraPostProcessVolume.profile = self.ui.pp_OldMovie
  end
end

function UIEffectMask:HideOldMovieEffectMask()
  if not IsNull(self.ui.oldMovieEffectMask) then
    self.ui.oldMovieEffectMask:SetActive(false)
  end
  if not IsNull(self.uiCameraPostProcessLayer) then
    self.uiCameraPostProcessLayer.enabled = self.originalLayerEnable
  end
  if not IsNull(self.uiCameraPostProcessVolume) then
    self.uiCameraPostProcessVolume.profile = self.originalProfile
  end
end

function UIEffectMask:ShowWhiteSpaceMask()
  if IsNull(self.uiCameraPostProcessVolume) then
    return
  end
  if not IsNull(self.ui.whiteSpaceEffectMask) then
    self.ui.whiteSpaceEffectMask:SetActive(true)
  end
  local uiCamera = UIManager.UICamera
  local instancePPProfile = CameraEffectUtil:InstantiatePostProcessProfile(self.ui.pp_WhiteSpace)
  self.whiteSpacePPStackItem = CameraEffectUtil:AddPPStack(uiCamera, instancePPProfile)
  self.uiCameraPostProcessVolume.sharedProfile = instancePPProfile
  self.uiCameraPostProcessVolume.profile = instancePPProfile
  local colorGrading
  local ok = false
  ok, colorGrading = self.uiCameraPostProcessVolume.profile:TryGetSettings(typeof(CS.UnityEngine.Rendering.PostProcessing.ColorGrading))
  if not ok then
    error("Cant get ColorGrading")
    return
  end
  self.whiteSpaceColorGrading = colorGrading
  if not IsNull(self.uiCameraPostProcessLayer) then
    self.uiCameraPostProcessLayer.enabled = true
  end
  self._onUpdate = BindCallback(self, self.UpdateWhiteSpaceEffect)
  UpdateManager:AddUpdate(self._onUpdate)
end

function UIEffectMask:UpdateWhiteSpaceEffect()
  if IsNull(self.whiteSpaceColorGrading) then
    return
  end
  local Randomvalue = math.sin(Time.time * 3.5) / 5
  local oldValue = 0.5
  self.whiteSpaceColorGrading.postExposure:Override(oldValue + Randomvalue)
end

function UIEffectMask:HideWhiteSpaceMask()
  if not IsNull(self.ui.whiteSpaceEffectMask) then
    self.ui.whiteSpaceEffectMask:SetActive(false)
  end
  CameraEffectUtil:RemovePPStack(self.whiteSpacePPStackItem)
  self.whiteSpaceColorGrading = nil
  self.whiteSpacePPStackItem = nil
end

function UIEffectMask:ShowWhiteSpaceV2Mask()
  if not IsNull(self.ui.whiteSpaceV2EffectMask) then
    self.ui.whiteSpaceV2EffectMask:SetActive(true)
  end
end

function UIEffectMask:HideWhiteSpaceV2Mask()
  if not IsNull(self.ui.whiteSpaceV2EffectMask) then
    self.ui.whiteSpaceV2EffectMask:SetActive(false)
  end
end

function UIEffectMask:OnShow()
  base.OnShow(self)
end

function UIEffectMask:OnHide()
  if self._onUpdate ~= nil then
    UpdateManager:RemoveUpdate(self._onUpdate)
    self._onUpdate = nil
  end
  base.OnHide(self)
end

function UIEffectMask:OnDelete()
  self.uiCameraPostProcessLayer = nil
  self.uiCameraPostProcessVolume = nil
  self.originalLayerEnable = nil
  self.originalProfile = nil
  base.OnDelete(self)
end

return UIEffectMask

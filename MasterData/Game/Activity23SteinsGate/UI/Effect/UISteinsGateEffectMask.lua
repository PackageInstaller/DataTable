local UISteinsGateEffectMask = class("UISteinsGateEffectMask", UIBaseWindow)
local base = UIBaseWindow
local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")

function UISteinsGateEffectMask:OnInit()
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

function UISteinsGateEffectMask:ShowOldMovieEffectMask()
  if not IsNull(self.ui.oldMovieEffectMask) then
    self.ui.oldMovieEffectMask:SetActive(true)
  end
  if not IsNull(self.uiCameraPostProcessLayer) then
    self.uiCameraPostProcessLayer.enabled = true
  end
  if not IsNull(self.uiCameraPostProcessVolume) then
    self.uiCameraPostProcessVolume.profile = self.ui.pp_OldMovie
  end
  self.ppIsShow = true
end

function UISteinsGateEffectMask:HideOldMovieEffectMask()
  if not IsNull(self.ui.oldMovieEffectMask) then
    self.ui.oldMovieEffectMask:SetActive(false)
  end
  if not IsNull(self.uiCameraPostProcessLayer) then
    self.uiCameraPostProcessLayer.enabled = self.originalLayerEnable
  end
  if not IsNull(self.uiCameraPostProcessVolume) then
    self.uiCameraPostProcessVolume.profile = self.originalProfile
  end
  self.ppIsShow = false
end

function UISteinsGateEffectMask:OnShow()
  base.OnShow(self)
end

function UISteinsGateEffectMask:OnDelete()
  if self.ppIsShow then
    self:HideOldMovieEffectMask()
  end
  self.uiCameraPostProcessLayer = nil
  self.uiCameraPostProcessVolume = nil
  self.originalLayerEnable = nil
  self.originalProfile = nil
  base.OnDelete(self)
end

return UISteinsGateEffectMask

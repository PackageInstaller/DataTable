local UINSpecWeaponStepItem = class("UINSpecWeaponStepItem", UIBaseNode)
local base = UIBaseNode
local CampEnum = require("Game.Common.Camp.CampEnum")

function UINSpecWeaponStepItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickSpecWeaponStep)
end

function UINSpecWeaponStepItem:BindSpecWeaponStep(callback)
  self._callback = callback
end

function UINSpecWeaponStepItem:InitSpecWeaponStep(stepId, specWeaponData)
  self._stepId = stepId
  self._specWeaponData = specWeaponData
  self.ui.tex_NowLv:SetIndex(self._stepId - 1)
  self:RefreshSpecWeaponStep()
  self:OnSelectSpecWeaponStep(false)
end

function UINSpecWeaponStepItem:RefreshSpecWeaponStep()
  self.ui.img_lock:SetActive(self._stepId > self._specWeaponData:GetSpecWeaponCurStep())
end

function UINSpecWeaponStepItem:RefreshStepFrame(camp)
  if camp == CampEnum.eCampTaype.entropy then
    self.ui.img_frame:SetIndex(1)
  else
    self.ui.img_frame:SetIndex(0)
  end
end

function UINSpecWeaponStepItem:OnSelectSpecWeaponStep(flag)
  self.ui.obj_click:SetActive(flag)
end

function UINSpecWeaponStepItem:OnClickSpecWeaponStep()
  if self._callback ~= nil then
    self._callback(self._stepId)
  end
end

return UINSpecWeaponStepItem

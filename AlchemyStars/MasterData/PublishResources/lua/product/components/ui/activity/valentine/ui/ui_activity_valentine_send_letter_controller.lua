_class("UIActivityValentineSendLetterController", UIController)
UIActivityValentineSendLetterController = UIActivityValentineSendLetterController

function UIActivityValentineSendLetterController:Constructor()
  self._spineStr = "n27_g_qiche_spine_idle"
  self._closeTime = 3200
end

function UIActivityValentineSendLetterController:OnShow(uiParams)
  self._callback = uiParams[1]
  self:_GetComponent()
  GameGlobal.TaskManager():StartTask(self._SetSpine, self)
end

function UIActivityValentineSendLetterController:OnHide()
  if self._callback then
    self._callback()
  end
end

function UIActivityValentineSendLetterController:_GetComponent()
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._spine:LoadSpine(self._spineStr)
  self._anim = self:GetUIComponent("Animation", "anim")
  self._spineObj = self:GetGameObject("spine")
  self._spineSkeMultipleTex = self._spineObj:GetComponentInChildren(typeof(Spine.Unity.Modules.SkeletonGraphicMultiObject))
  self._spineSkeMultipleTex.UseInstanceMaterials = true
  
  function self._spineSkeMultipleTex.OnInstanceMaterialCreated(material)
    material:SetFloat("_StencilComp", 3)
  end
  
  self._spineSkeMultipleTex:UpdateMesh()
end

function UIActivityValentineSendLetterController:_SetSpine(TT)
  YIELD(TT, self._closeTime)
  self._anim:Play("uieff_UIActivityValentineSendLetterController_SafeArea_out")
  YIELD(TT, 100)
  self:CloseDialog()
end

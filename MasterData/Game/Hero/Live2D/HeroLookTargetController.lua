local HeroLookTargetController = class("HeroLookTargetController")

function HeroLookTargetController.OpenLookTarget(cubismLookController, target, camera)
  cubismLookController.enabled = true
  cubismLookController:SetCamera(camera)
  local lookTarget = target:GetComponent(typeof(CS.Live2D.Cubism.Samples.OriginalWorkflow.Demo.CubismLookTarget))
  lookTarget:SetCamera(camera)
  lookTarget:SetTimeClip(0.2)
end

return HeroLookTargetController

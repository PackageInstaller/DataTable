require("sp_base_inst")
_class("SkillPreviewTurnTetrisInstruction", SkillPreviewBaseInstruction)
SkillPreviewTurnTetrisInstruction = SkillPreviewTurnTetrisInstruction

function SkillPreviewTurnTetrisInstruction:Constructor(params)
  self._time = tonumber(params.Time)
  self._anim = params.Anim
end

function SkillPreviewTurnTetrisInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local utilDataSvc = self._world:GetService("UtilData")
  local tetrisDir, angle = utilDataSvc:GetFeatureTetrisDir()
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local effectEntityID = previewPickUpComponent:GetPickUpEffectEntityIDArray()[1]
  local effectEntity = self._world:GetEntityByID(effectEntityID)
  local effectGO = effectEntity:View():GetGameObject()
  local anim = effectGO.gameObject:GetComponent("Animation")
  anim:Play(self._anim)
  effectGO.transform:DORotate(Vector3(0, angle, 0), self._time / 1000)
  YIELD(TT, self._time)
end

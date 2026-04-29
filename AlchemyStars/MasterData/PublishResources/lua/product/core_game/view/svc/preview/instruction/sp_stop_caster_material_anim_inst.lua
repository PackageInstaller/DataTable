require("sp_base_inst")
_class("SkillPreviewStopCasterMaterialAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewStopCasterMaterialAnimInstruction = SkillPreviewStopCasterMaterialAnimInstruction

function SkillPreviewStopCasterMaterialAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewStopCasterMaterialAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local comp = casterEntity:MaterialAnimationComponent()
  if comp then
    comp:StopLayer(MaterialAnimLayer.SkillPreview)
    if self._anim then
      casterEntity:StopMaterialAnim(self._anim)
    end
  end
end

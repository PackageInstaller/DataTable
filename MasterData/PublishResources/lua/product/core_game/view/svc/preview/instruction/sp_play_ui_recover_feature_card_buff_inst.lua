require("sp_base_inst")
_class("SkillPreviewPlayUIRecoverFeatureCardBuffInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayUIRecoverFeatureCardBuffInstruction = SkillPreviewPlayUIRecoverFeatureCardBuffInstruction

function SkillPreviewPlayUIRecoverFeatureCardBuffInstruction:Constructor(params)
end

function SkillPreviewPlayUIRecoverFeatureCardBuffInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local world = self._world
  world:EventDispatcher():Dispatch(GameEventType.FeaturePetUIPreviewRecoverCardBuff)
end

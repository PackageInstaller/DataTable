require("sp_base_inst")
_class("SkillPreviewClearUIPreviewInstruction", SkillPreviewBaseInstruction)
SkillPreviewClearUIPreviewInstruction = SkillPreviewClearUIPreviewInstruction

function SkillPreviewClearUIPreviewInstruction:Constructor(params)
end

function SkillPreviewClearUIPreviewInstruction:DoInstruction(TT, casterEntity, previewContext)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.IstavanPreviewCancelPetHeadUI, true)
end

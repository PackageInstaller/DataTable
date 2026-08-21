require("sp_base_inst")
_class("SkillPreviewSetUiPickUpTextStateInstruction", SkillPreviewBaseInstruction)
SkillPreviewSetUiPickUpTextStateInstruction = SkillPreviewSetUiPickUpTextStateInstruction

function SkillPreviewSetUiPickUpTextStateInstruction:Constructor(params)
  self._textState = tonumber(params.TextState)
end

function SkillPreviewSetUiPickUpTextStateInstruction:DoInstruction(TT, casterEntity, previewContext)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangePickUpText, self._textState)
end

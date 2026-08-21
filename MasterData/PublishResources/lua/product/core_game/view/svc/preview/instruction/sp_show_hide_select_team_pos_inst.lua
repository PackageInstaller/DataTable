require("sp_base_inst")
_class("SkillPreviewShowHideSelectTeamPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewShowHideSelectTeamPosInstruction = SkillPreviewShowHideSelectTeamPosInstruction

function SkillPreviewShowHideSelectTeamPosInstruction:Constructor(params)
  self._show = params.show == "true"
end

function SkillPreviewShowHideSelectTeamPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleUIShowHideSelectTeamPositionButton, casterEntity:PetPstID():GetPstID(), self._show)
end

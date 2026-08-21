require("sp_base_inst")
_class("SkillPreviewClearSelectTeamPosInstruction", SkillPreviewBaseInstruction)
SkillPreviewClearSelectTeamPosInstruction = SkillPreviewClearSelectTeamPosInstruction

function SkillPreviewClearSelectTeamPosInstruction:DoInstruction(TT, casterEntity, previewContext)
  local petPstID = casterEntity:PetPstID():GetPstID()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.ClearSelectedTeamOrderPosition, petPstID)
end

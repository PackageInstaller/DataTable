require("sp_base_inst")
_class("SkillPreviewCheckActiveSkillInstruction", SkillPreviewBaseInstruction)
SkillPreviewCheckActiveSkillInstruction = SkillPreviewCheckActiveSkillInstruction

function SkillPreviewCheckActiveSkillInstruction:Constructor(params)
  self._skillID = tonumber(params.skillID)
end

function SkillPreviewCheckActiveSkillInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local utilData = world:GetService("UtilData")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local checkSkillID = self._skillID
  checkSkillID = checkSkillID or pickUpTargetCmpt:GetCurActiveSkillID()
  local resultCommon, tmp, commonReason = utilData:CheckActiveSkillCastCondition(casterEntity:PetPstID():GetPstID(), checkSkillID)
  local fin = resultCommon
  local presentReason
  if not resultCommon then
    presentReason = commonReason
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleUIRefreshActiveSkillCastButtonState, fin, presentReason)
end

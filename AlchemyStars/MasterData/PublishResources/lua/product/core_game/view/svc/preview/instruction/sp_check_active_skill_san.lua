require("sp_base_inst")
_class("SkillPreviewCheckActiveSkillSanInstruction", SkillPreviewBaseInstruction)
SkillPreviewCheckActiveSkillSanInstruction = SkillPreviewCheckActiveSkillSanInstruction

function SkillPreviewCheckActiveSkillSanInstruction:Constructor(params)
  self._skillID = tonumber(params.skillID)
end

function SkillPreviewCheckActiveSkillSanInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local utilData = world:GetService("UtilData")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local checkSkillID = self._skillID
  checkSkillID = checkSkillID or pickUpTargetCmpt:GetCurActiveSkillID()
  local resultCommon, _, commonReason = utilData:CheckActiveSkillCastCondition(casterEntity:PetPstID():GetPstID(), checkSkillID)
  local rsvcFeature = world:GetService("FeatureRender")
  local result, reason = rsvcFeature:IsActiveSkillCanCastInPreview(casterEntity, checkSkillID, previewContext)
  local fin = resultCommon and result
  local presentReason
  if not resultCommon or not result then
    presentReason = commonReason or reason
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.BattleUIRefreshActiveSkillCastButtonState, fin, presentReason)
end

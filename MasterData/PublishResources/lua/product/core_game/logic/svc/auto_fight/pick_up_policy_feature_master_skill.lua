require("pick_up_policy_base")
_class("PickUpPolicy_FeatureMasterSkill", PickUpPolicy_Base)
PickUpPolicy_FeatureMasterSkill = PickUpPolicy_FeatureMasterSkill

function PickUpPolicy_FeatureMasterSkill:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_FeatureMasterSkill(activeSkillID, casterPos, validPosIdxList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_FeatureMasterSkill:_CalPickPosPolicy_FeatureMasterSkill(activeSkillID, casterPos, validPosIdxList)
  local env = self:_GetPickUpPolicyEnv()
  local configService = self._world:GetService("Config")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local teamColor = PieceType.Yellow
  local teamPos = casterPos
  local teamEntity = env.TeamEntity
  if teamEntity then
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    teamColor = teamLeaderEntity:Element():GetPrimaryType()
    teamPos = teamEntity:GetGridPosition()
  end
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local casterPosIndex = self:_Pos2Index(teamPos)
  local pickExtraParam = {}
  local firstPickPos
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and color ~= teamColor then
        firstPickPos = pos
        break
      end
    end
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}, pickExtraParam
  else
    return {}, {}, {}, {}
  end
end

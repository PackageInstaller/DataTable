require("pick_up_policy_base")
_class("PickUpPolicy_FeatureMasterSkillExtra", PickUpPolicy_Base)
PickUpPolicy_FeatureMasterSkillExtra = PickUpPolicy_FeatureMasterSkillExtra

function PickUpPolicy_FeatureMasterSkillExtra:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_FeatureMasterSkillExtra(activeSkillID, casterPos, validPosIdxList, policyParam)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_FeatureMasterSkillExtra:_CalPickPosPolicy_FeatureMasterSkillExtra(activeSkillID, casterPos, validPosIdxList, policyParam)
  local env = self:_GetPickUpPolicyEnv()
  local configService = self._world:GetService("Config")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local ignoreColor = {}
  if policyParam and policyParam.ignoreColor then
    ignoreColor = policyParam.ignoreColor
  end
  local teamPos = casterPos
  local teamEntity = env.TeamEntity
  if teamEntity then
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    teamPos = teamEntity:GetGridPosition()
  end
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpParam = skillConfigData:GetSkillPickParam()
  local maxPickCount = pickUpParam[1] or 0
  local casterPosIndex = self:_Pos2Index(teamPos)
  local pickExtraParam = {}
  local pickPosList = {}
  local pickPos
  if 0 < maxPickCount then
    for _, off in ipairs(ringMax) do
      local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
      if validPosIdxList[posIdx] then
        local pos = self:_Index2Pos(posIdx)
        local color = env.BoardPosPieces[posIdx]
        if color and not table.icontains(ignoreColor, color) then
          pickPos = pos
          table.insert(pickPosList, pickPos)
          if maxPickCount <= #pickPosList then
            break
          end
        end
      end
    end
  end
  if pickPosList and 0 < #pickPosList then
    return pickPosList, pickPosList, {}, pickExtraParam
  else
    return {}, {}, {}, {}
  end
end

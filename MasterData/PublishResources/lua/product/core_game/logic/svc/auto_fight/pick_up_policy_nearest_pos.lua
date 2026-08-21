require("pick_up_policy_base")
_class("PickUpPolicy_NearestPos", PickUpPolicy_Base)
PickUpPolicy_NearestPos = PickUpPolicy_NearestPos

function PickUpPolicy_NearestPos:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickUpNum = self:_GetPickUpNumByConfig(activeSkillID)
  local petColor = petEntity:Element():GetPrimaryType()
  local casterPos = petEntity:GridLocation().Position
  local boardService = self._world:GetService("BoardLogic")
  local posList = {}
  local targetIdList = {}
  local attackPosList = {}
  local ringMax = boardService:GetCurBoardRingMax()
  local casterPosIndex = self:_Pos2Index(casterPos)
  local env = self:_GetPickUpPolicyEnv()
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      if env.BoardPosCanMove[posIdx] and env.BoardPosPieces[posIdx] ~= petColor then
        local result, targetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pos)
        table.appendArray(attackPosList, result:GetAttackRange())
        table.appendArray(targetIdList, targetIds)
        posList[#posList + 1] = pos
        if pickUpNum <= #posList then
          break
        end
      end
    end
  end
  return posList, attackPosList, targetIdList
end

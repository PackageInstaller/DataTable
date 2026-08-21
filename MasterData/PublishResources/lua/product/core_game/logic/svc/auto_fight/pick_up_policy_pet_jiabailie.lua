require("pick_up_policy_base")
_class("PickUpPolicy_PetJiaBaiLie", PickUpPolicy_Base)
PickUpPolicy_PetJiaBaiLie = PickUpPolicy_PetJiaBaiLie

function PickUpPolicy_PetJiaBaiLie:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local env = self:_GetPickUpPolicyEnv()
  local pieceCnt = {
    0,
    0,
    0,
    0,
    0
  }
  local pickPos = {}
  for _, pos in ipairs(validPosList) do
    local posIdx = self:_Pos2Index(pos)
    local color = env.BoardPosPieces[posIdx]
    if color and color ~= PieceType.Green then
      pieceCnt[color] = pieceCnt[color] + 1
      pickPos[color] = pos
    end
  end
  local maxCnt, maxPos = 0
  for color, cnt in ipairs(pieceCnt) do
    if cnt > maxCnt then
      maxCnt = cnt
      maxPos = pickPos[color]
    end
  end
  return {maxPos}, {maxPos}, targetIdList
end

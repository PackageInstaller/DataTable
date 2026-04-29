require("pick_up_policy_base")
_class("PickUpPolicy_PetZhongxuMain", PickUpPolicy_Base)
PickUpPolicy_PetZhongxuMain = PickUpPolicy_PetZhongxuMain

function PickUpPolicy_PetZhongxuMain:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetZhongxuMain(petEntity, casterPos, validPosIdxList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetZhongxuMain:_CalPickPosPolicy_PetZhongxuMain(petEntity, casterPos, validPosIdxList)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local ringMax = boardService:GetCurBoardRingMax()
  local casterPosIndex = self:_Pos2Index(casterPos)
  local firstPickPos, blackFistEnemyPos
  if self._world:MatchType() == MatchType.MT_BlackFist and petEntity:HasPet() then
    local enemy = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    blackFistEnemyPos = enemy:GetGridPosition()
  end
  for _, off in ipairs(ringMax) do
    local posIdx = self:_PosIndexAddOffset(casterPosIndex, off)
    if validPosIdxList[posIdx] then
      local pos = self:_Index2Pos(posIdx)
      local color = env.BoardPosPieces[posIdx]
      if color and color ~= PieceType.Red then
        if self._world:MatchType() == MatchType.MT_BlackFist then
          if blackFistEnemyPos ~= pos then
            firstPickPos = pos
            break
          end
        else
          local isHasMonster, monsterID = utilScopeSvc:IsPosHasMonster(pos)
          if not isHasMonster then
            firstPickPos = pos
            break
          end
        end
      end
    end
  end
  if firstPickPos then
    return {firstPickPos}, {firstPickPos}, {}
  else
    return {}, {}, {}
  end
end

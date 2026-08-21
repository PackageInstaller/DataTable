require("pick_up_policy_base")
_class("PickUpPolicy_PetChenNi", PickUpPolicy_Base)
PickUpPolicy_PetChenNi = PickUpPolicy_PetChenNi

function PickUpPolicy_PetChenNi:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds = self:_CalPickPosPolicyPetChenNi(petEntity, casterPos, validPosIdxList)
  return pickPosList, atkPosList, targetIds
end

function PickUpPolicy_PetChenNi:_CalPickPosPolicyPetChenNi(petEntity, casterPos, validPosIdxList)
  local boardService = self._world:GetService("BoardLogic")
  local pieceType = PieceType.Yellow
  local firstPickPos
  local hori, vert = 0, 0
  for index, _ in pairs(validPosIdxList) do
    local v = self:_Index2Pos(index)
    if v.y == casterPos.y and boardService:GetPieceType(v) ~= pieceType and not boardService:IsPosBlock(v, BlockFlag.ChangeElement) then
      vert = vert + 1
    end
    if v.x == casterPos.x and boardService:GetPieceType(v) ~= pieceType and not boardService:IsPosBlock(v, BlockFlag.ChangeElement) then
      hori = hori + 1
    end
  end
  local pickPos1, pickPos2
  local count1, count2 = 0, 0
  if vert > hori then
    pickPos1 = Vector2(casterPos.x + 1, casterPos.y)
    pickPos2 = Vector2(casterPos.x - 1, casterPos.y)
  else
    pickPos1 = Vector2(casterPos.x, casterPos.y + 1)
    pickPos2 = Vector2(casterPos.x, casterPos.y - 1)
  end
  for index, _ in pairs(validPosIdxList) do
    local v = self:_Index2Pos(index)
    if vert > hori then
      if v.y == casterPos.y then
        if v.x > casterPos.x then
          count1 = count1 + 1
        else
          count2 = count2 + 1
        end
      end
    elseif v.x == casterPos.x then
      if v.y > casterPos.y then
        count1 = count1 + 1
      else
        count2 = count2 + 1
      end
    end
  end
  if count1 > count2 then
    firstPickPos = pickPos1
  else
    firstPickPos = pickPos2
  end
  return {firstPickPos}, {firstPickPos}, {}
end

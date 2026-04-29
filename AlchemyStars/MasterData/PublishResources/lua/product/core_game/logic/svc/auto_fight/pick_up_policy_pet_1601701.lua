require("pick_up_policy_base")
_class("PickUpPolicy_Pet1601701", PickUpPolicy_Base)
PickUpPolicy_Pet1601701 = PickUpPolicy_Pet1601701

function PickUpPolicy_Pet1601701:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicyPet1601701(casterPos, policyParam)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_Pet1601701:_CalPickPosPolicyPet1601701(casterPos, policyParam)
  local leftPos = casterPos.x - 1
  local rightPos = casterPos.x + 1
  local boardSvc = self._world:GetService("BoardLogic")
  local maxY = boardSvc:GetCurBoardMaxY()
  local leftLine, rightLine = {}, {}
  local leftCount, rightCount = 0, 0
  local spPieceType = policyParam[1]
  for i = 1, maxY do
    local newPos = Vector2(leftPos, i)
    local pieceType = boardSvc:GetPieceType(newPos)
    if pieceType and pieceType ~= PieceType.None then
      table.insert(leftLine, newPos)
      if pieceType == spPieceType then
        leftCount = leftCount + 1
      end
    end
    newPos = Vector2(rightPos, i)
    pieceType = boardSvc:GetPieceType(newPos)
    if pieceType and pieceType ~= PieceType.None then
      table.insert(rightLine, newPos)
      if pieceType == spPieceType then
        rightCount = rightCount + 1
      end
    end
  end
  if leftCount == 0 and rightCount == 0 then
    return nil
  end
  local curLine
  if leftCount > rightCount then
    curLine = leftLine
  else
    curLine = rightLine
  end
  if #curLine == 0 then
    if 0 < #leftLine then
      curLine = leftLine
    else
      curLine = rightLine
    end
  end
  local pickUpPos
  local battleSvc = self._world:GetService("Battle")
  for i, pos in ipairs(curLine) do
    local targetEntityList = battleSvc:FindMonsterEntityInPos(pos)
    if #targetEntityList ~= 0 then
      pickUpPos = pos
    end
  end
  if not pickUpPos then
    local index = math.random(1, #curLine)
    pickUpPos = curLine[index]
  end
  local maxX = boardSvc:GetCurBoardMaxX()
  local leftEdgeLen = math.abs(maxX - pickUpPos.x - 1)
  local rightEdgeLen = math.abs(maxX - pickUpPos.x + 1)
  local dirPos
  if leftEdgeLen < rightEdgeLen then
    dirPos = Vector2(pickUpPos.x - 1, pickUpPos.y)
  else
    dirPos = Vector2(pickUpPos.x + 1, pickUpPos.y)
  end
  return {pickUpPos, dirPos}, {pickUpPos, dirPos}, {}
end

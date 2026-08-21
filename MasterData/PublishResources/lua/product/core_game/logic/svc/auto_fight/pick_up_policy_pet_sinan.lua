require("pick_up_policy_base")
_class("PickUpPolicy_PetSinan", PickUpPolicy_Base)
PickUpPolicy_PetSinan = PickUpPolicy_PetSinan

function PickUpPolicy_PetSinan:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GetGridPosition()
  local spColor = PieceType.Blue
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  local leftRow, leftColorCount, leftDis, leftPickPos, leftGridCount, rightRow, rightColorCount, rightDis, rightPickPos, rightGridCount
  for i = 1, boardMaxX do
    leftRow, leftColorCount, leftDis, leftPickPos, leftGridCount = casterPos.x + -1 * i, 0, 1000, Vector2(0, 0), 0
    rightRow, rightColorCount, rightDis, rightPickPos, rightGridCount = casterPos.x + i, 0, 1000, Vector2(0, 0), 0
    for i = 1, boardMaxY do
      local leftPos = Vector2(leftRow, i)
      local rightPos = Vector2(rightRow, i)
      local leftColor = boardServiceLogic:GetPieceType(leftPos)
      if leftColor and leftColor ~= PieceType.None then
        leftGridCount = leftGridCount + 1
        if leftColor == spColor then
          leftColorCount = leftColorCount + 1
        end
        if leftDis > Vector2.Distance(leftPos, casterPos) then
          leftDis = Vector2.Distance(leftPos, casterPos)
          leftPickPos = leftPos
        end
      end
      local rightColor = boardServiceLogic:GetPieceType(rightPos)
      if rightColor and rightColor ~= PieceType.None then
        rightGridCount = rightGridCount + 1
        if rightColor == spColor then
          rightColorCount = rightColorCount + 1
        end
        if rightDis > Vector2.Distance(rightPos, casterPos) then
          rightDis = Vector2.Distance(rightPos, casterPos)
          rightPickPos = rightPos
        end
      end
    end
    if leftGridCount ~= leftColorCount or rightGridCount ~= rightColorCount then
      if leftGridCount ~= leftColorCount and rightGridCount ~= rightColorCount then
        if leftColorCount > rightColorCount then
          table.insert(pickPosList, leftPickPos)
          break
        elseif leftColorCount == rightColorCount then
          if leftDis <= rightDis then
            table.insert(pickPosList, leftPickPos)
            break
          else
            table.insert(pickPosList, rightPickPos)
            break
          end
        else
          table.insert(pickPosList, rightPickPos)
          break
        end
      end
      if leftGridCount ~= leftColorCount then
        table.insert(pickPosList, leftPickPos)
      end
      if rightGridCount ~= rightColorCount then
        table.insert(pickPosList, rightPickPos)
      end
      break
    end
  end
  return pickPosList, pickPosList, {}
end

require("pick_up_policy_base")
_class("PickUpPolicy_PetLarrey", PickUpPolicy_Base)
PickUpPolicy_PetLarrey = PickUpPolicy_PetLarrey

function PickUpPolicy_PetLarrey:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GetGridPosition()
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local configService = self._world:GetService("Config")
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local env = self:_GetPickUpPolicyEnv()
  local posList = {}
  for _, pos in ipairs(validPosList) do
    local posIdx = self:_Pos2Index(pos)
    local color = env.BoardPosPieces[posIdx]
    if color and color ~= PieceType.Red and color ~= PieceType.Any then
      if not posList[pos.x] then
        posList[pos.x] = {}
      end
      table.insert(posList[pos.x], pos)
    end
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  for i = 1, boardMaxX do
    local leftPosList = posList[casterPos.x - i] or {}
    local rightPosList = posList[casterPos.x + i] or {}
    if table.count(leftPosList) > table.count(rightPosList) then
      attackPosList = leftPosList
    elseif table.count(leftPosList) < table.count(rightPosList) then
      attackPosList = rightPosList
    end
    if table.count(attackPosList) > 0 then
      table.sort(attackPosList, function(a, b)
        local disA = Vector2.Distance(casterPos, a)
        local disB = Vector2.Distance(casterPos, b)
        return disA < disB
      end)
      pickPosList = {
        attackPosList[1]
      }
      break
    end
  end
  if table.count(attackPosList) == 0 then
    local curPosList = posList[casterPos.x]
    if curPosList and table.count(curPosList) > 0 then
      attackPosList = curPosList
      pickPosList = {
        attackPosList[1]
      }
    end
  end
  return pickPosList, attackPosList, targetIdList
end

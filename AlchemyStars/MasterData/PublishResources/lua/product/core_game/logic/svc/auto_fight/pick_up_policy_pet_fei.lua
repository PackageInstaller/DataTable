require("pick_up_policy_base")
_class("PickUpPolicy_PetFei", PickUpPolicy_Base)
PickUpPolicy_PetFei = PickUpPolicy_PetFei

function PickUpPolicy_PetFei:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local configService = self._world:GetService("Config")
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local t = {}
  for _, pos in ipairs(validPosList) do
    local posIdx = self:_Pos2Index(pos)
    local env = self:_GetPickUpPolicyEnv()
    local color = env.BoardPosPieces[posIdx]
    if color and color ~= PieceType.Green then
      t[#t + 1] = pos
    end
  end
  validPosList = t
  local validResults = self:_CalcValidResultByPickUpType_PickUpPolicy(petEntity, activeSkillID, validPosList)
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local pickUpType = skillConfigData:GetSkillPickType()
  if 0 < #validResults then
    table.sort(validResults, function(a, b)
      return #a[2] > #b[2]
    end)
    for i = 1, pickUpNum do
      local t = validResults[i]
      if not t then
        break
      end
      pickPosList[i] = t[1]
      table.appendArray(targetIdList, t[2])
      table.appendArray(attackPosList, t[3])
    end
    return pickPosList, attackPosList, targetIdList
  end
  return pickPosList, attackPosList, targetIdList
end

require("pick_up_policy_base")
_class("PickUpPolicy_PetZhongxuExtra", PickUpPolicy_Base)
PickUpPolicy_PetZhongxuExtra = PickUpPolicy_PetZhongxuExtra

function PickUpPolicy_PetZhongxuExtra:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetZhongxuExtra(petEntity, activeSkillID)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetZhongxuExtra:_CalPickPosPolicy_PetZhongxuExtra(petEntity, activeSkillID)
  local trapEntity
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    if not e:HasDeadMark() and e:HasSummoner() and e:Summoner():GetSummonerEntityID() == petEntity:GetID() then
      trapEntity = e
      break
    end
  end
  if not trapEntity then
    return {}, {}, {}
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local scopeType = SkillScopeType.ZhongxuForceMovementPickRange
  local scopeParam, centerType, targetType
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if skillScopeAndTarget and skillScopeAndTarget.useType == AutoFightScopeUseType.PickPosPolicy then
    scopeParam = skillScopeAndTarget.ScopeParam
  else
    return {}, {}, {}
  end
  local centerPos = trapEntity:GetGridPosition()
  local firstPickPos = centerPos
  local result = self:_CalcSkillScopeResult_PickUpPolicy(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
  if result then
    local attackRange = result:GetAttackRange()
    local upPos, downPos, leftPos, rightPos
    for index, rangePos in ipairs(attackRange) do
      if not upPos or rangePos.y > upPos.y then
        upPos = rangePos
      end
      if not downPos or rangePos.y < downPos.y then
        downPos = rangePos
      end
      if not leftPos or rangePos.x < leftPos.x then
        leftPos = rangePos
      end
      if not rightPos or rangePos.x > rightPos.x then
        rightPos = rangePos
      end
    end
    local secondPickRange = {}
    if upPos then
      table.insert(secondPickRange, upPos)
    end
    if downPos then
      table.insert(secondPickRange, downPos)
    end
    if leftPos then
      table.insert(secondPickRange, leftPos)
    end
    if rightPos then
      table.insert(secondPickRange, rightPos)
    end
    local secondPickRangeCount = #secondPickRange
    if secondPickRangeCount == 0 then
      return {}, {}, {}
    end
    local secondPosIndex = math.random(1, secondPickRangeCount)
    local secondPickPos = secondPickRange[secondPosIndex]
    local pickPosList = {}
    table.insert(pickPosList, firstPickPos)
    table.insert(pickPosList, secondPickPos)
    return pickPosList, pickPosList, {}
  end
  return {}, {}, {}
end

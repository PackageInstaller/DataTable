require("pick_up_policy_base")
_class("PickUpPolicy_PetYiSha", PickUpPolicy_Base)
PickUpPolicy_PetYiSha = PickUpPolicy_PetYiSha

function PickUpPolicy_PetYiSha:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetYiSha(petEntity, activeSkillID)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetYiSha:_CalPickPosPolicy_PetYiSha(petEntity, activeSkillID)
  local configService = self._world:GetService("Config")
  local utilDataSvc = self._world:GetService("UtilData")
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local scopeType = SkillScopeType.ZhongxuForceMovementPickRange
  local scopeParam, centerType, targetType
  local skillScopeAndTarget = skillConfigData:GetAutoFightSkillScopeTypeAndTargetType()
  if skillScopeAndTarget and skillScopeAndTarget.useType == AutoFightScopeUseType.PickPosPolicy then
    scopeParam = skillScopeAndTarget.ScopeParam
  else
    return {}, {}, {}
  end
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local validEnemyList = {}
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyTeam = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    table.insert(validEnemyList, enemyTeam)
  else
    for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
      if not monsterEntity:HasDeadMark() then
        local canAttack = true
        if monsterEntity:HasBuff() and not buffLogicSvc:CheckCanBeMagicAttack(petEntity, monsterEntity) then
          canAttack = false
        end
        if canAttack and utilDataSvc:IsEntityForceMovementTarget(monsterEntity, true) then
          table.insert(validEnemyList, monsterEntity)
        end
      end
    end
  end
  if validEnemyList and 0 < #validEnemyList then
    table.shuffle(validEnemyList)
    for index, enemyEntity in ipairs(validEnemyList) do
      local centerPos = enemyEntity:GetGridPosition()
      local firstPickPos = centerPos
      local result = self:_CalcSkillScopeResult_PickUpPolicy(petEntity, skillConfigData, scopeType, scopeParam, centerType, targetType, centerPos)
      if result then
        local attackRange = result:GetAttackRange()
        local secondPickRange = attackRange
        local secondPickRangeCount = #secondPickRange
        if 0 < secondPickRangeCount then
          local secondPosIndex = math.random(1, secondPickRangeCount)
          local secondPickPos = secondPickRange[secondPosIndex]
          local pickPosList = {}
          table.insert(pickPosList, firstPickPos)
          table.insert(pickPosList, secondPickPos)
          return pickPosList, pickPosList, {}
        end
      end
    end
  end
  return {}, {}, {}
end

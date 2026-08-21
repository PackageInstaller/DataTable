require("pick_up_policy_base")
_class("PickUpPolicy_PetSPKaLianWithDamage", PickUpPolicy_Base)
PickUpPolicy_PetSPKaLianWithDamage = PickUpPolicy_PetSPKaLianWithDamage

function PickUpPolicy_PetSPKaLianWithDamage:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetSPKaLian_WithDamage(calcParam.TT, petEntity, activeSkillID, casterPos, validPosList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetSPKaLianWithDamage:_CalPickPosPolicy_PetSPKaLian_WithDamage(TT, petEntity, activeSkillID, casterPos, validPosList)
  local utilScope = self._world:GetService("UtilScopeCalc")
  local tInfo = {}
  for _, v2 in ipairs(validPosList) do
    local convertCount = 0
    local dir = utilScope:GetStandardDirection8D(v2 - casterPos)
    local posForward = v2 + dir
    local posBackward = v2 - dir
    if self:_PetKaLian_CanGridConvertToRed(posForward, casterPos) then
      convertCount = convertCount + 1
    end
    if self:_PetKaLian_CanGridConvertToRed(posBackward, casterPos) then
      convertCount = convertCount + 1
    end
    if 0 < convertCount then
      local tMonsters, tMonsterPos
      if self._world:MatchType() ~= MatchType.MT_BlackFist then
        tMonsters, tMonsterPos = utilScope:SelectNearestMonsterOnPos(v2, 1)
        YIELD(TT)
      else
        local enemyTeamEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
        tMonsters = {enemyTeamEntity}
        tMonsterPos = {
          enemyTeamEntity:GetGridPosition()
        }
      end
      local scopeCalculator = utilScope:GetSkillScopeCalc()
      local attackRangeScopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.AngleFreeLine, {widthThreshold = 1, noExtend = 1}, v2, petEntity:BodyArea():GetArea(), petEntity:GetGridDirection(), SkillTargetType.MonsterTrap, petEntity:GetGridPosition(), petEntity)
      local attackRange = attackRangeScopeResult:GetAttackRange() or {}
      local targetSelector = self._world:GetSkillScopeTargetSelector()
      local targetIds = targetSelector:DoSelectSkillTarget(petEntity, SkillTargetType.Monster, attackRangeScopeResult, activeSkillID) or {}
      local candidateInfo = {
        index = #tInfo,
        pos = v2,
        convertCount = convertCount,
        nearestMonsterCount = #tMonsters,
        nearestMonsterDistance = 0 < #tMonsterPos and Vector2.Distance(v2, tMonsterPos[1]) or nil,
        attackRange = attackRange,
        targetIds = targetIds
      }
      table.insert(tInfo, candidateInfo)
    end
  end
  if #tInfo == 0 then
    return {}, {}, {}, {}
  end
  table.sort(tInfo, function(a, b)
    if a.convertCount ~= b.convertCount then
      return a.convertCount > b.convertCount
    end
    local countA = #a.targetIds
    local countB = #b.targetIds
    if countA ~= countB then
      return countA > countB
    end
    return a.index < b.index
  end)
  local final = tInfo[1]
  YIELD(TT)
  return {
    final.pos
  }, final.attackRange, final.targetIds, {}
end

function PickUpPolicy_PetSPKaLianWithDamage:_PetKaLian_CanGridConvertToRed(pos, casterPos)
  local utilScope = self._world:GetService("UtilScopeCalc")
  local lsvcBoard = self._world:GetService("BoardLogic")
  if not utilScope:IsValidPiecePos(pos) then
    return false
  end
  if pos == casterPos then
    return true
  end
  if not lsvcBoard:GetCanConvertGridElement(pos) then
    return false
  end
  if lsvcBoard:GetPieceType(pos) == PieceType.Red then
    return false
  end
  return true
end

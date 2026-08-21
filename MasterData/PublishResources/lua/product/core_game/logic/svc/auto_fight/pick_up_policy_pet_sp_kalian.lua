require("pick_up_policy_base")
_class("PickUpPolicy_PetSPKaLian", PickUpPolicy_Base)
PickUpPolicy_PetSPKaLian = PickUpPolicy_PetSPKaLian

function PickUpPolicy_PetSPKaLian:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetSPKaLian_NoDamage(petEntity, casterPos, validPosList)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetSPKaLian:_CalPickPosPolicy_PetSPKaLian_NoDamage(petEntity, casterPos, validPosList)
  local utilScope = self._world:GetService("UtilScopeCalc")
  local lsvcBoard = self._world:GetService("BoardLogic")
  local tInfo = {}
  for _, v2 in ipairs(validPosList) do
    local convertCount = 0
    local convertPos = {}
    local dir = utilScope:GetStandardDirection8D(v2 - casterPos)
    local posForward = v2 + dir
    local posBackward = v2 - dir
    if self:_PetKaLian_CanGridConvertToRed(posForward, casterPos) then
      convertCount = convertCount + 1
      table.insert(convertPos, posForward)
    end
    if self:_PetKaLian_CanGridConvertToRed(posBackward, casterPos) then
      convertCount = convertCount + 1
      table.insert(convertPos, posBackward)
    end
    if 0 < convertCount then
      local tMonsters, tMonsterPos
      if self._world:MatchType() ~= MatchType.MT_BlackFist then
        tMonsters, tMonsterPos = utilScope:SelectNearestMonsterOnPos(v2, 1)
      else
        local enemyTeamEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
        tMonsters = {enemyTeamEntity}
        tMonsterPos = {
          enemyTeamEntity:GetGridPosition()
        }
      end
      local candidateInfo = {
        index = #tInfo,
        pos = v2,
        convertCount = convertCount,
        convertPos = convertPos,
        nearestMonsterCount = #tMonsters,
        nearestMonsterDistance = 0 < #tMonsterPos and Vector2.Distance(v2, tMonsterPos[1]) or nil
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
    if a.nearestMonsterDistance ~= b.nearestMonsterDistance then
      return a.nearestMonsterDistance < b.nearestMonsterDistance
    end
    return a.index < b.index
  end)
  local final = tInfo[1]
  return {
    final.pos
  }, final.convertPos, {}, {}
end

function PickUpPolicy_PetSPKaLian:_PetKaLian_CanGridConvertToRed(pos, casterPos)
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

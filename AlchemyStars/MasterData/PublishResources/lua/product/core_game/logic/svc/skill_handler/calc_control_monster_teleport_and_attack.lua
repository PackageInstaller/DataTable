_class("SkillEffectCalc_ControlMonsterTeleportAndAttack", SkillEffectCalc_Base)
SkillEffectCalc_ControlMonsterTeleportAndAttack = SkillEffectCalc_ControlMonsterTeleportAndAttack

function SkillEffectCalc_ControlMonsterTeleportAndAttack:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ControlMonsterTeleportAndAttack:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillResults = {}
  local skillParam = skillEffectCalcParam.skillEffectParam
  local stageIndex = skillParam:GetSkillEffectDamageStageIndex()
  local moveDis = skillParam:GetMoveDis()
  local monsterClassID = skillParam:GetMonsterClassID()
  local attackScopeType = skillParam:GetAttackScopeType()
  local attackScopeParam = skillParam:GetAttackScopeParam()
  local skillRange = skillEffectCalcParam.skillRange or {}
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local targetMonsterEntity
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    if monsterClassID == monsterEntity:MonsterID():GetMonsterClassID() then
      targetMonsterEntity = monsterEntity
      break
    end
  end
  local targetMonsterEntityPos = targetMonsterEntity:GetGridPosition()
  local damagePos = targetMonsterEntityPos
  local utilData = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalculator:ComputeScopeRange(attackScopeType, attackScopeParam, targetMonsterEntityPos)
  local attackRange = scopeResult:GetAttackRange()
  local attackRangeFinish = {}
  if table.icontains(attackRange, teamPos) then
    table.appendArray(attackRangeFinish, attackRange)
  else
    local dirList = {}
    if teamPos.x > targetMonsterEntityPos.x then
      table.insert(dirList, Vector2(1, 0))
    end
    if teamPos.x < targetMonsterEntityPos.x then
      table.insert(dirList, Vector2(-1, 0))
    end
    if teamPos.y > targetMonsterEntityPos.y then
      table.insert(dirList, Vector2(0, 1))
    end
    if teamPos.y < targetMonsterEntityPos.y then
      table.insert(dirList, Vector2(0, -1))
    end
    local moveDir
    for _, dir in ipairs(dirList) do
      local newPos = targetMonsterEntityPos + dir
      local scopeResultTmp = scopeCalculator:ComputeScopeRange(attackScopeType, attackScopeParam, newPos)
      local attackRangeTmp = scopeResultTmp:GetAttackRange()
      if table.icontains(attackRangeTmp, teamPos) then
        moveDir = dir
        break
      end
    end
    if moveDir == nil then
      table.sort(dirList, function(a, b)
        local newPosA = targetMonsterEntityPos + a
        local newPosB = targetMonsterEntityPos + b
        local disA = Vector2.Distance(teamPos, newPosA)
        local disB = Vector2.Distance(teamPos, newPosB)
        return disA < disB
      end)
      moveDir = dirList[1]
    end
    local moveNewPos = targetMonsterEntityPos + moveDir
    local colorOld = utilData:FindPieceElement(targetMonsterEntityPos)
    local casterColorOld = utilData:FindPieceElement(casterPos)
    local casterNewPos = casterPos - moveDir
    if not utilData:IsPosBlock(moveNewPos, BlockFlag.MonsterLand) and not utilData:IsPosBlock(casterNewPos, BlockFlag.MonsterLand) then
      damagePos = moveNewPos
      local skillResultTeleport = SkillEffectResult_Teleport:New(targetMonsterEntity:GetID(), targetMonsterEntityPos, colorOld, moveNewPos, moveDir, stageIndex)
      table.insert(skillResults, skillResultTeleport)
      local skillResultTeleport = SkillEffectResult_Teleport:New(casterEntityID, casterPos, casterColorOld, casterNewPos, -moveDir, stageIndex)
      table.insert(skillResults, skillResultTeleport)
      local scopeResultTmp = scopeCalculator:ComputeScopeRange(attackScopeType, attackScopeParam, moveNewPos)
      local attackRangeTmp = scopeResultTmp:GetAttackRange()
      table.appendArray(attackRangeFinish, attackRangeTmp)
    end
  end
  if table.icontains(attackRangeFinish, teamPos) then
    local effectCalcSvc = self._skillEffectService
    local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(targetMonsterEntity, damagePos, teamEntity, teamPos, skillEffectCalcParam.skillID, skillParam, SkillEffectType.Damage, stageIndex)
    local skillDamageEffectResult = effectCalcSvc:NewSkillDamageEffectResult(teamPos, teamEntity:GetID(), nTotalDamage, listDamageInfo, stageIndex)
    table.insert(skillResults, skillDamageEffectResult)
  end
  local skillEffectResultTeleportAndAttack = SkillEffectResultControlMonsterTeleportAndAttack:New(targetMonsterEntity:GetID())
  table.insert(skillResults, skillEffectResultTeleportAndAttack)
  return skillResults
end

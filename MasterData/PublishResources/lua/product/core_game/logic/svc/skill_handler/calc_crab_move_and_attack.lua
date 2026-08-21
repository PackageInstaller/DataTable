_class("SkillEffectCalc_CrabMoveAndAttack", SkillEffectCalc_Base)
SkillEffectCalc_CrabMoveAndAttack = SkillEffectCalc_CrabMoveAndAttack

function SkillEffectCalc_CrabMoveAndAttack:Constructor(world)
  self._world = world
end

function SkillEffectCalc_CrabMoveAndAttack:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillResults = {}
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local skillParam = skillEffectCalcParam.skillEffectParam
  local attackDis = skillParam:GetAttackDis()
  local moveDir = skillParam:GetMoveDir()
  local moveDis = skillParam:GetMoveDis()
  local skillRange = skillEffectCalcParam.skillRange or {}
  local stageIndex = skillParam:GetSkillEffectDamageStageIndex()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local casterDir = casterEntity:GetGridDirection()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local attackMoveStep
  local movePosList = {}
  local attackPosList = {}
  local targetDir = Vector2(0, 0)
  if casterDir == Vector2(0, 1) then
    targetDir = Vector2(1 * moveDir, 0)
  elseif casterDir == Vector2(0, -1) then
    targetDir = Vector2(-1 * moveDir, 0)
  elseif casterDir == Vector2(1, 0) then
    targetDir = Vector2(0, -1 * moveDir)
  elseif casterDir == Vector2(-1, 0) then
    targetDir = Vector2(0, 1 * moveDir)
  end
  for i = 0, moveDis do
    local movePos = casterPos + Vector2(targetDir.x * i, targetDir.y * i)
    local isBlock = self:IsPosBlockByArea(movePos, BlockFlag.MonsterLand, bodyArea, casterEntity)
    if isBlock then
      break
    end
    if movePos ~= casterPos then
      table.insert(movePosList, movePos)
    end
    if attackDis ~= 0 then
      for _, bodyPos in ipairs(bodyArea) do
        local curPos = movePos + bodyPos
        for k = 1, attackDis do
          local posWork = curPos + Vector2(casterDir.x * k, casterDir.y * k)
          if not table.icontains(attackPosList, posWork) then
            table.insert(attackPosList, posWork)
          end
          if attackMoveStep == nil and table.intable(attackPosList, teamPos) then
            attackMoveStep = i
            local effectCalcSvc = self._skillEffectService
            local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, casterPos, teamEntity, teamPos, skillEffectCalcParam.skillID, skillParam, SkillEffectType.Damage, stageIndex)
            local skillDamageEffectResult = effectCalcSvc:NewSkillDamageEffectResult(teamPos, teamEntity:GetID(), nTotalDamage, listDamageInfo, stageIndex)
            table.insert(skillResults, skillDamageEffectResult)
          end
        end
      end
    end
  end
  if 0 < table.count(movePosList) then
    local newPos = movePosList[#movePosList]
    local utilData = self._world:GetService("UtilData")
    local colorOld = utilData:FindPieceElement(casterPos)
    local skillResultTeleport = SkillEffectResult_Teleport:New(casterEntityID, casterPos, colorOld, newPos, casterDir, stageIndex)
    table.insert(skillResults, skillResultTeleport)
  end
  local skillEffectResultCrabMoveAndAttack = SkillEffectResultCrabMoveAndAttack:New(attackMoveStep)
  table.insert(skillResults, skillEffectResultCrabMoveAndAttack)
  return skillResults
end

function SkillEffectCalc_CrabMoveAndAttack:IsPosBlockByArea(pos, blockFlag, listArea, entityExcept)
  local utilDataSvc = self._world:GetService("UtilData")
  local ret = false
  for i = 1, #listArea do
    local posWork = pos + listArea[i]
    if utilDataSvc:IsPosBlock(posWork, blockFlag) then
      if not entityExcept then
        return true
      end
      local entityMonster = utilDataSvc:GetMonsterAtPos(posWork)
      if not entityMonster or entityMonster ~= entityExcept then
        return true
      end
    end
  end
  return false
end

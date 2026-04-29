require("calc_base")
_class("SkillEffectCalc_DamageAfterHitBack", SkillEffectCalc_Base)
SkillEffectCalc_DamageAfterHitBack = SkillEffectCalc_DamageAfterHitBack

function SkillEffectCalc_DamageAfterHitBack:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_DamageAfterHitBack:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_DamageAfterHitBack:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local effectParam = skillEffectCalcParam.skillEffectParam
  if skillEffectCalcParam.skillRange == nil then
    skillEffectCalcParam.skillRange = {
      skillEffectCalcParam.gridPos
    }
  end
  local formulaService = self._world:GetService("Formula")
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackerPos = attacker:GridLocation().Position
  local attackerDir = attacker:GridLocation().Direction
  local attackerBodyArea = attacker:BodyArea()
  local gridPos = skillEffectCalcParam.gridPos
  local skillResultList = {}
  local defender = self._world:GetEntityByID(defenderEntityID)
  local effectCalcSvc = self._skillEffectService
  local calcType = effectParam:GetCalcType()
  local beAttackEntityID = defenderEntityID
  local hitbackDistance = effectParam:GetDistance()
  local hitbackDirType = effectParam:GetDirType()
  local excludeCasterPos = effectParam:ExcludeCasterPos()
  local extraParam = effectParam:GetExtraParam()
  local bUseCasterPos = effectParam:GetForceUseCasterPos()
  local usePickPosIndex = effectParam:GetUsePickPosIndex()
  local notCalcBomb = effectParam:GetNotCalcBomb()
  local ignorePathBlock = effectParam:GetIgnorePathBlock()
  local backupDirectionPlan = effectParam:GetBackupDirectionPlan()
  local interactType = effectParam:GetInteractType()
  local ignorePlayerBlock = effectParam:GetIgnorePlayerBlock()
  local extraBlockPos = {}
  local type = effectParam:GetType()
  if effectParam:IsCasterPosAsBlock() then
    for _, body in ipairs(attackerBodyArea:GetArea()) do
      table.insert(extraBlockPos, attackerPos + body)
    end
  end
  local skillRange = skillEffectCalcParam.skillRange
  local damageTimes = effectParam:GetTimes()
  for i = 1, damageTimes do
    local defenderPos = defender:GetGridPosition()
    local hitBackEffectResult = self._skillEffectService:CalcHitbackEffectResult(attackerPos, attackerDir, attackerBodyArea, beAttackEntityID, hitbackDirType, type, hitbackDistance, calcType, ignorePlayerBlock, excludeCasterPos, attacker, skillRange, notCalcBomb, ignorePathBlock, backupDirectionPlan, interactType, effectParam:GetSkillType(), extraBlockPos)
    local percent, formulaID
    local hitBackBeginPos = hitBackEffectResult:GetStartPos()
    if hitBackEffectResult:GetStartPos() ~= hitBackEffectResult:GetPosTarget() then
      percent = effectParam:GetHitBackPercent()
      formulaID = effectParam:GetHitBackFormulaID()
    else
      percent = effectParam:GetStopPercent()
      formulaID = effectParam:GetStopFormulaID()
    end
    Log.info("StageIndex", i, "defenderPos：", defenderPos, "StartPos:", hitBackEffectResult:GetStartPos(), " EndPos:", hitBackEffectResult:GetPosTarget(), " Percent:", percent, " formulaID:", formulaID)
    local damageStageIndex = i
    local tmpParam = SkillDamageEffectParam:New({
      percent = percent,
      formulaID = formulaID,
      damageStageIndex = damageStageIndex
    })
    table.insert(skillResultList, hitBackEffectResult)
    local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackerPos, defender, hitBackBeginPos, skillEffectCalcParam.skillID, tmpParam, SkillEffectType.DamageAfterHitBack, damageStageIndex)
    local skillResult = effectCalcSvc:NewSkillDamageEffectResult(hitBackBeginPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
    table.insert(skillResultList, skillResult)
  end
  return skillResultList
end

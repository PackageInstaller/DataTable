require("calc_base")
_class("SkillEffectCalc_SplashDamageAndAddBuff", SkillEffectCalc_Base)
SkillEffectCalc_SplashDamageAndAddBuff = SkillEffectCalc_SplashDamageAndAddBuff

function SkillEffectCalc_SplashDamageAndAddBuff:Constructor(world)
  self._world = world
  self._skillEffectCalcSvc = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SplashDamageAndAddBuff:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  if targetIDs and #targetIDs == 1 and targetIDs[1] == -1 then
    local result = self:_CalculateNoTarget(skillEffectCalcParam)
    if result then
      table.appendArray(results, result)
    end
  else
    for _, targetID in ipairs(targetIDs) do
      local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
      if result then
        table.appendArray(results, result)
      end
    end
  end
  return results
end

function SkillEffectCalc_SplashDamageAndAddBuff:_CalculateNoTarget(skillEffectCalcParam)
  local casterID = skillEffectCalcParam:GetCasterEntityID()
  local caster = self._world:GetEntityByID(casterID)
  local casterPos = caster:GetGridPosition()
  local casterDir = caster:GetGridDirection()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local offset = param:GetSplashOffset()
  local splashCenterPos = casterPos + casterDir * offset
  return self:_CalculateDamageAndAddBuff(skillEffectCalcParam, splashCenterPos)
end

function SkillEffectCalc_SplashDamageAndAddBuff:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local defender = self._world:GetEntityByID(targetID)
  local splashCenterPos = defender:GetGridPosition()
  return self:_CalculateDamageAndAddBuff(skillEffectCalcParam, splashCenterPos)
end

function SkillEffectCalc_SplashDamageAndAddBuff:_CalculateDamageAndAddBuff(skillEffectCalcParam, centerPos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local calcScope = utilScopeSvc:GetSkillScopeCalc()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local targetType = param:GetSplashTargetType()
  local scopeType = param:GetSplashScopeType()
  local scopeParam = param:GetSplashScopeParam()
  local parser = SkillScopeParamParser:New()
  scopeParam = parser:ParseScopeParam(scopeType, scopeParam)
  local caster = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local casterBodyArea = caster:BodyArea():GetArea()
  local casterDirection = caster:GetGridDirection()
  local casterPos = caster:GetGridDirection()
  local splashScopeResult = calcScope:ComputeScopeRange(scopeType, scopeParam, centerPos, casterBodyArea, casterDirection, targetType, casterPos, caster)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetArray = targetSelector:DoSelectSkillTarget(caster, targetType, splashScopeResult)
  table.unique(targetArray)
  table.removev(targetArray, caster:GetID())
  local attackRange = splashScopeResult:GetAttackRange()
  table.removev(attackRange, centerPos)
  local damageResults = self:_CalculateDamageResult(skillEffectCalcParam, attackRange, targetArray)
  local buffResults = self:_CalculateAddBuffResult(skillEffectCalcParam, targetArray)
  return {
    SkillEffectSplashDamageAndAddBuffResult:New(centerPos, damageResults, buffResults)
  }
end

function SkillEffectCalc_SplashDamageAndAddBuff:_GetTargetAreaMap(targetArray)
  local targetGridAreaMap = {}
  for _, targetEntityID in ipairs(targetArray) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      local targetCenterPos = targetEntity:GetGridPosition()
      local bodyAreaComponent = targetEntity:BodyArea()
      if bodyAreaComponent then
        local bodyAreaArray = bodyAreaComponent:GetArea()
        for _, areaPos in ipairs(bodyAreaArray) do
          local absAreaPos = areaPos + targetCenterPos
          if not targetGridAreaMap[absAreaPos.x] then
            targetGridAreaMap[absAreaPos.x] = {}
          end
          targetGridAreaMap[absAreaPos.x][absAreaPos.y] = targetEntityID
        end
      else
        if not targetGridAreaMap[targetCenterPos.x] then
          targetGridAreaMap[targetCenterPos.x] = {}
        end
        targetGridAreaMap[targetCenterPos.x][targetCenterPos.y] = targetEntityID
      end
    end
  end
  return targetGridAreaMap
end

function SkillEffectCalc_SplashDamageAndAddBuff:_CalculateDamageResult(param, attackRange, targetArray)
  local resultArray = {}
  local skillDamageParam = param:GetSkillEffectParam()
  local skillID = param:GetSkillID()
  local caster = self._world:GetEntityByID(param:GetCasterEntityID())
  local attackPos = caster:GetGridPosition()
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local targetGridAreaMap = self:_GetTargetAreaMap(targetArray)
  for _, damagePos in ipairs(attackRange) do
    if targetGridAreaMap[damagePos.x] and targetGridAreaMap[damagePos.x][damagePos.y] then
      local defenderEntityID = targetGridAreaMap[damagePos.x][damagePos.y]
      local defender = self._world:GetEntityByID(defenderEntityID)
      local nTotalDamage, listDamageInfo = self._skillEffectCalcSvc:ComputeSkillDamage(caster, attackPos, defender, damagePos, skillID, skillDamageParam, SkillEffectType.SplashDamageAndAddBuff, damageStageIndex)
      local skillResult = self._skillEffectCalcSvc:NewSkillDamageEffectResult(damagePos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(resultArray, skillResult)
    end
  end
  return resultArray
end

function SkillEffectCalc_SplashDamageAndAddBuff:_CalculateAddBuffResult(skillEffectCalcParam, targetArray)
  local skillID = skillEffectCalcParam:GetSkillID()
  local attackRange = skillEffectCalcParam:GetSkillRange()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local buffID = param:GetBuffID()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local buffLogicService = self._world:GetService("BuffLogic")
  local triggerSvc = self._world:GetService("Trigger")
  local buffResultArray = {}
  for _, targetID in ipairs(targetArray) do
    local defenderEntity = self._world:GetEntityByID(targetID)
    local buffResult = SkillBuffEffectResult:New(defenderEntity:GetID())
    local cfgNewBuff = Cfg.cfg_buff[buffID]
    if cfgNewBuff then
      triggerSvc:Notify(NTEachAddBuffStart:New(skillID, casterEntity, defenderEntity, attackRange))
      local buff = buffLogicService:AddBuff(buffID, defenderEntity, {casterEntity = casterEntity})
      local seqID
      if buff then
        seqID = buff:BuffSeq()
        buffResult:AddBuffResult(seqID)
        table.insert(buffResultArray, buffResult)
      end
      triggerSvc:Notify(NTEachAddBuffEnd:New(skillID, casterEntity, defenderEntity, attackRange, buffID, seqID))
    end
  end
  return buffResultArray
end

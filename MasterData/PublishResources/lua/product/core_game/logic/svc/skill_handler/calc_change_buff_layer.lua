_class("SkillEffectCalc_ChangeBuffLayer", Object)
SkillEffectCalc_ChangeBuffLayer = SkillEffectCalc_ChangeBuffLayer

function SkillEffectCalc_ChangeBuffLayer:Constructor(world)
  self._world = world
end

function SkillEffectCalc_ChangeBuffLayer:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local addBuffParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local addToNonMissDamageTarget = addBuffParam:CanAddToNonMissDamageTarget()
  if addToNonMissDamageTarget == 1 then
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    local stageIndex = addBuffParam:GetCheckDamageEffectResultWithStageIndex() or 1
    local skillResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, stageIndex)
    if not skillResultArray or table.count(skillResultArray) == 0 then
      return {}
    end
    local targetEntityList = {}
    for _, v in ipairs(skillResultArray) do
      local damageResult = v
      local targetEntityID = damageResult:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      local hasDamage = true
      local damageInfoArray = damageResult:GetDamageInfoArray()
      if damageInfoArray then
        for _, damageInfo in ipairs(damageInfoArray) do
          if damageInfo:GetDamageType() == DamageType.Miss then
            hasDamage = false
            break
          end
        end
      end
      if hasDamage and targetEntity and targetEntity:HasMonsterID() and not table.icontains(targetEntityList, targetEntity) then
        table.insert(targetEntityList, targetEntity)
      end
    end
    if not targetEntityList or table.count(targetEntityList) == 0 then
      return {}
    end
  end
  local needPickUpDir = addBuffParam:IsNeedPickUpDir()
  if needPickUpDir then
    local dirList = {}
    local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
    if activeSkillPickUpComponent then
      dirList = activeSkillPickUpComponent:GetAllDirection()
    end
    if #dirList == 0 then
      return {}
    end
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffTargetType = addBuffParam:GetBuffTargetType()
  local buffTargetParam = addBuffParam:GetBuffTargetParam()
  local es = {}
  if buffTargetType == BuffTargetType.Self then
    es[#es + 1] = casterEntity
  elseif buffTargetType == BuffTargetType.SkillTarget or buffTargetType == BuffTargetType.SkillTargetSelectBuffByLayer or buffTargetType == BuffTargetType.SkillTargetRandomBuff then
    local targets = skillEffectCalcParam:GetTargetEntityIDs()
    for _, id in ipairs(targets) do
      local e = self._world:GetEntityByID(id)
      if e == nil then
        Log.warn("addbuff defender is nil entityid=", id)
      end
      if e and buffLogicService:CheckCanAddBuff(casterEntity, e) then
        es[#es + 1] = e
      end
    end
  else
    es = buffLogicService:CalcBuffTargetEntities(buffTargetType, buffTargetParam, casterEntity)
  end
  local buffID = addBuffParam:GetBuffID()
  local buffEffectType = addBuffParam:GetBuffEffectType()
  local changeBuffLayerParam = addBuffParam:GetChangeBuffLayerParam()
  local unloadZeroLayer = addBuffParam:GetUnloadZeroLayer()
  for i, e in ipairs(es) do
    local defenderBuffComp = e:BuffComponent()
    local targetBuff
    if buffID then
      targetBuff = defenderBuffComp:GetBuffById(buffID)
    end
    if buffEffectType then
      targetBuff = defenderBuffComp:GetSingleBuffByBuffEffect(buffEffectType)
    end
    if targetBuff then
      local targetBuffSeq = targetBuff:BuffSeq()
      local targetEffectType = targetBuff:GetBuffEffectType()
      local beforeLayer = buffLogicService:GetBuffLayer(e, targetEffectType) or 0
      local layer = beforeLayer
      local changeLayer = 0
      local isUnload = false
      layer = beforeLayer + changeBuffLayerParam
      changeLayer = layer - beforeLayer
      if layer <= 0 then
        layer = 0
        if unloadZeroLayer == 1 then
          isUnload = true
        end
      end
      if changeLayer ~= 0 then
        local result = SkillEffectResultChangeBuffLayer:New(e:GetID(), targetBuffSeq, targetEffectType, layer, isUnload)
        table.insert(results, result)
      end
    end
  end
  return results
end

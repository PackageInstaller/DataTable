require("play_skill_phase_base_r")
_class("PlaySkillCircleFlyMultipleEffectPhase", PlaySkillPhaseBase)
PlaySkillCircleFlyMultipleEffectPhase = PlaySkillCircleFlyMultipleEffectPhase

function PlaySkillCircleFlyMultipleEffectPhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  local radius = effectParam:GetRadius()
  local effectHigh = effectParam:GetHigh()
  local gridEffectID = effectParam:GetGridEffectID()
  local flyEffectID = effectParam:GetFlyEffectID()
  local hitEffectID = effectParam:GetHitEffectID()
  local waitFlyTime = effectParam:GetWaitFlyTime()
  local flyTime = effectParam:GetFlyTime()
  local angleInterval = effectParam:GetAngle()
  local world = casterEntity:GetOwnerWorld()
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local hasTargetDamageResultArray = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity then
      table.insert(hasTargetDamageResultArray, damageResult)
    end
  end
  if table.count(hasTargetDamageResultArray) == 0 then
    return
  end
  local boardServiceRender = world:GetService("BoardRender")
  local casterPos = casterEntity:GridLocation():GetGridPos()
  local casterRenderPos = casterEntity:Location():GetPosition()
  local casterTansform = casterEntity:View():GetGameObject().transform
  local tmpTableSortDataList = {}
  for _, v in ipairs(hasTargetDamageResultArray) do
    local damageResult = v
    local damagePos = damageResult:GetGridPos()
    local effectRenderPos = boardServiceRender:GridPos2RenderPos(damagePos)
    local curNormalized = (effectRenderPos - casterRenderPos).normalized
    local finalAngle = Vector3.Angle(casterTansform.forward, curNormalized)
    local finalAngle360
    local v3 = Vector3.Cross(casterTansform.forward, curNormalized)
    if 0 < v3.y then
      finalAngle360 = finalAngle
    else
      finalAngle360 = 360 - finalAngle
    end
    local tmpTableSortData = {}
    tmpTableSortData.angle = finalAngle360
    tmpTableSortData.damageResult = damageResult
    tmpTableSortData.curNormalized = curNormalized
    table.insert(tmpTableSortDataList, tmpTableSortData)
  end
  table.sort(tmpTableSortDataList, function(a, b)
    return a.angle < b.angle
  end)
  local baseGridRenderPos = boardServiceRender:GetBaseGridRenderPos()
  local effectGridPosList = {}
  local damagePosList = {}
  local normalizedList = {}
  for i = 1, #tmpTableSortDataList do
    local curNormalized = tmpTableSortDataList[i].curNormalized
    local damagePos = tmpTableSortDataList[i].damageResult:GetGridPos()
    local hasNormalized = self:_OnCheckNormalizIsHas(normalizedList, curNormalized, angleInterval)
    if not hasNormalized then
    else
      local lastNormalized = tmpTableSortDataList[i - 1].curNormalized
      local scondNormalized = lastNormalized * Quaternion.Euler(0, angleInterval, 0)
      tmpTableSortDataList[i].curNormalized = scondNormalized
      curNormalized = scondNormalized
    end
    local newEffectPosV3 = casterRenderPos + curNormalized * radius
    local effectPosV2 = self:BoardRenderPos2FloatGridPos_New(newEffectPosV3, baseGridRenderPos)
    table.insert(normalizedList, curNormalized)
    table.insert(effectGridPosList, effectPosV2)
    table.insert(damagePosList, damagePos)
  end
  local effectService = world:GetService("Effect")
  local effectEntityList = {}
  for _, effectPos in ipairs(effectGridPosList) do
    local effectEntity = effectService:CreatePositionEffect(gridEffectID, effectPos)
    table.insert(effectEntityList, effectEntity)
  end
  YIELD(TT, waitFlyTime)
  local flyEffectEntityList = {}
  for _, effectPos in ipairs(effectGridPosList) do
    local flyEffectPos = effectPos
    local flyEffectEntity = effectService:CreatePositionEffect(flyEffectID, flyEffectPos)
    table.insert(flyEffectEntityList, flyEffectEntity)
  end
  while not flyEffectEntityList[#flyEffectEntityList]:View() do
    YIELD(TT)
  end
  for i = 1, #flyEffectEntityList do
    local effectEntity = flyEffectEntityList[i]
    local view = effectEntity:View()
    local effectTran = view:GetGameObject().transform
    effectTran.position = effectTran.position + Vector3(0, effectHigh, 0)
  end
  for _, effectEntity in ipairs(effectEntityList) do
    world:DestroyEntity(effectEntity)
  end
  for i = 1, #flyEffectEntityList do
    local damagePos = damagePosList[i]
    local renderPos = boardServiceRender:GridPos2RenderPos(damagePos)
    local effectEntity = flyEffectEntityList[i]
    local effectTransform = effectEntity:View():GetGameObject().transform
    effectTransform:LookAt(renderPos, Vector3.up)
    effectTransform:DOMove(renderPos, flyTime / 1000):SetEase(DG.Tweening.Ease.Linear)
  end
  YIELD(TT, flyTime)
  for _, effectEntity in ipairs(flyEffectEntityList) do
    world:DestroyEntity(effectEntity)
  end
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local skillService = self:SkillService()
  for i = 1, #hasTargetDamageResultArray do
    local damageResult = hasTargetDamageResultArray[i]
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    local damage = damageResult:GetDamageInfo(1)
    local damagePos = damageResult:GetGridPos()
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damage):SetHandleBeHitParam_DamagePos(damagePos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(skillService.HandleBeHit, skillService, beHitParam)
  end
end

function PlaySkillCircleFlyMultipleEffectPhase:_OnCheckNormalizIsHas(normalizedList, curNormalized, angleInterval)
  local hasNormalized
  for i = 1, #normalizedList do
    local normalized = normalizedList[i]
    local finalAngle = Vector3.Angle(normalized, curNormalized)
    if finalAngle < angleInterval + 1 then
      hasNormalized = normalized
      break
    end
  end
  return hasNormalized
end

function PlaySkillCircleFlyMultipleEffectPhase:BoardRenderPos2FloatGridPos_New(pos, baseGridRenderPos)
  local render_pos_offset = pos - baseGridRenderPos
  local new_grid_pos = Vector3(1, 0, 1) + render_pos_offset
  return Vector2(new_grid_pos.x, new_grid_pos.z)
end

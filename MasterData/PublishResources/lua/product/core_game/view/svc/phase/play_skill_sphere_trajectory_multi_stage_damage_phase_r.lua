require("play_skill_phase_base_r")
_class("PlaySkillSphereTrajectoryMultiStageDamagePhase", PlaySkillPhaseBase)
PlaySkillSphereTrajectoryMultiStageDamagePhase = PlaySkillSphereTrajectoryMultiStageDamagePhase

function PlaySkillSphereTrajectoryMultiStageDamagePhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  local eftID = effectParam:GetEftID()
  local trajectoryCount = effectParam:GetTrajectoryCount()
  local sphereRadius = effectParam:GetSphereRadius()
  local startWait = effectParam:GetStartWait()
  self._moveSpeed = effectParam:GetMoveSpeed()
  self._rotateSpeed = effectParam:GetRotateSpeed()
  self._turnToTarget = effectParam:GetTurnToTarget()
  self._hitAnimName = effectParam:GetHitAnimName()
  self._hitEffectID = effectParam:GetHitEffectID()
  self._intervalTime = effectParam:GetIntervalTime()
  self._hitSoundID = effectParam:GetHitSoundID()
  local random = effectParam:GetRandom()
  local randomPercent = effectParam:GetRandomPercent()
  local listTask = {}
  local castPos = casterEntity:GridLocation().Position
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  self._formatList = {}
  for _, v in ipairs(damageResultArray) do
    local format = {}
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local damageInfo = damageResult:GetDamageInfo(1)
    local damagePos = damageResult:GetGridPos()
    if targetEntity then
      format.damageResult = damageResult
      format.attackCount = 1
      format.effectEntityIDList = {}
      format.playDamage = false
      table.insert(self._formatList, format)
    end
  end
  if table.count(self._formatList) == 0 then
    return
  end
  local skillResult = skillEffectResultContainer
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local skillRange = scopeResult:GetAttackRange()
  local rangeCount = table.count(skillRange)
  local scopeTotal = Vector2(0, 0)
  for i = 1, rangeCount do
    scopeTotal = scopeTotal + skillRange[i]
  end
  local scopeCenterPos = Vector2(scopeTotal.x / rangeCount, scopeTotal.y / rangeCount)
  local boardServiceRender = self._world:GetService("BoardRender")
  local sphereCenterPos = boardServiceRender:GridPos2RenderPos(scopeCenterPos)
  local damageResultArrayCount = table.count(damageResultArray)
  local needAttackCount = math.max(damageResultArrayCount, trajectoryCount)
  local needSupplementAttackCount = needAttackCount - table.count(self._formatList)
  for i = 1, needSupplementAttackCount do
    local random = math.random(1, damageResultArrayCount)
    self._formatList[random].attackCount = self._formatList[random].attackCount + 1
  end
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  if isFinalAttack then
    local attackCountLargest = 0
    local targetEntityIDLargest = 0
    for i = 1, table.count(self._formatList) do
      local format = self._formatList[i]
      local attackCount = format.attackCount
      if attackCountLargest < attackCount then
        attackCountLargest = attackCount
        local damageResult = format.damageResult
        local damageInfo = damageResult:GetDamageInfo(1)
        targetEntityIDLargest = damageInfo:GetTargetEntityID()
      end
    end
    skillEffectResultContainer:SetFinalAttackEntityID(targetEntityIDLargest)
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  for i = 1, table.count(self._formatList) do
    local format = self._formatList[i]
    local attackCount = format.attackCount
    local damageResult = format.damageResult
    local damageInfo = damageResult:GetDamageInfo(1)
    local damageInfoList, damageStageValueList = utilCalcSvc:DamageInfoSplitMultiStage(damageInfo, attackCount, random, randomPercent)
    format.damageInfoList = damageInfoList
    format.damageStageValueList = damageStageValueList
  end
  local eftEntityList = {}
  local eftTargetPosList = {}
  local effectService = self._world:GetService("Effect")
  for i = 1, needAttackCount do
    local randomDir = math.random(0, 360)
    local tmpX = math.cos(randomDir * 3.14 / 180) * sphereRadius
    local tmpZ = math.sin(randomDir * 3.14 / 180) * sphereRadius
    local tmpY = math.random() * 2 + 0.5
    local randomPos = Vector3(tmpX, tmpY, tmpZ)
    local dir = randomPos - sphereCenterPos
    local workPos = sphereCenterPos + dir.normalized * sphereRadius
    local eftEntity = effectService:CreatePositionEffect(eftID, workPos)
    table.insert(eftEntityList, eftEntity)
    for i = 1, table.count(self._formatList) do
      local format = self._formatList[i]
      if table.count(format.effectEntityIDList) < format.attackCount then
        table.insert(format.effectEntityIDList, eftEntity:GetID())
        local renderGridPos = boardServiceRender:GridPos2RenderPos(format.damageResult:GetGridPos())
        table.insert(eftTargetPosList, renderGridPos)
        break
      end
    end
  end
  if not eftEntityList[table.count(eftEntityList)]:HasView() then
    YIELD(TT)
  end
  for i = 1, table.count(eftEntityList) do
    local eftTansform = eftEntityList[i]:View():GetGameObject().transform
    local offset = Vector3(math.random(), -math.random(), math.random())
    local dir = eftTansform.position + offset - sphereCenterPos
    eftEntityList[i]:SetDirection(dir)
  end
  YIELD(TT, startWait)
  self:_TransformTrajectory(TT, eftEntityList, eftTargetPosList, casterEntity)
end

function PlaySkillSphereTrajectoryMultiStageDamagePhase:_TransformTrajectory(TT, eftEntityList, eftTargetPosList, casterEntity)
  local moveSpeed = self._moveSpeed / 30
  local moveSpeedMin = 1
  local moveSpeedMax = moveSpeed
  local rotateSpeed = self._rotateSpeed / 30
  local lastFrameNormalizedList = {}
  local finalAngleList = {}
  for i = 1, table.count(eftEntityList) do
    local eftEntity = eftEntityList[i]
    local eftTansform = eftEntity:View():GetGameObject().transform
    local lastFrameNormalized = eftTansform.forward
    table.insert(lastFrameNormalizedList, lastFrameNormalized)
    local finalForwardBefore = (eftTargetPosList[i] - eftTansform.position).normalized
    local finalAngle = Vector3.Angle(eftTansform.forward, finalForwardBefore)
    table.insert(finalAngleList, finalAngle)
  end
  local listTask = {}
  local farmCount = 0
  while table.count(eftEntityList) > 0 do
    for i = 1, table.count(eftEntityList) do
      local eftEntity = eftEntityList[i]
      local endPos = eftTargetPosList[i]
      local finalAngle = finalAngleList[i]
      local lastFrameNormalized = lastFrameNormalizedList[i]
      local eftTansform = eftEntity:View():GetGameObject().transform
      local finalForward = (endPos - eftTansform.position).normalized
      if finalForward ~= eftTansform.forward then
        local angleOffset = Vector3.Angle(eftTansform.forward, finalForward)
        local t = farmCount * rotateSpeed / finalAngle
        eftTansform.forward = Vector3.Lerp(lastFrameNormalized, finalForward, t)
      else
        moveSpeed = moveSpeed + 5
      end
      local changeSpeed = moveSpeed / 30
      eftTansform.position = eftTansform.position + Vector3(eftTansform.forward.x * changeSpeed, eftTansform.forward.y * changeSpeed, eftTansform.forward.z * changeSpeed)
    end
    for i = 1, table.count(eftEntityList) do
      local eftEntity = eftEntityList[i]
      local eftTansform = eftEntity:View():GetGameObject().transform
      lastFrameNormalizedList[i] = eftTansform.forward
    end
    farmCount = farmCount + 1
    YIELD(TT)
    for i = table.count(eftEntityList), 1, -1 do
      local eftEntity = eftEntityList[i]
      local eftTansform = eftEntity:View():GetGameObject().transform
      local endPos = eftTargetPosList[i]
      local currentDist = Vector3.Distance(eftTansform.position, endPos)
      if currentDist < 0.7 or 0 > eftTansform.position.y then
        AudioHelperController.PlayInnerGameSfx(self._hitSoundID)
        table.remove(eftEntityList, i)
        table.remove(eftTargetPosList, i)
        table.remove(finalAngleList, i)
        table.remove(lastFrameNormalizedList, i)
        local nTask, nTaskDamage = self:_TrajectoryFinish(eftEntity, casterEntity)
        if nTask and 0 < nTask then
          table.insert(listTask, nTask)
          table.insert(listTask, nTaskDamage)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(listTask) do
    YIELD(TT)
  end
end

function PlaySkillSphereTrajectoryMultiStageDamagePhase:_TrajectoryFinish(eftEntity, casterEntity)
  local curFormat
  for i = 1, table.count(self._formatList) do
    local format = self._formatList[i]
    if not format.playDamage and table.intable(format.effectEntityIDList, eftEntity:GetID()) then
      curFormat = format
      format.playDamage = true
    end
  end
  self._world:DestroyEntity(eftEntity)
  if not curFormat then
    return
  end
  local damageResult = curFormat.damageResult
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageInfoList = curFormat.damageInfoList
  local damageStageValueList = curFormat.damageStageValueList
  for i = 1, #damageInfoList do
    damageInfoList[i]:SetShowType(DamageShowType.Grid)
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageGridPos = damageResult:GetGridPos()
  local targetId = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetId)
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  local playSkillService = self._world:GetService("PlaySkill")
  local playDamageSvc = self._world:GetService("PlayDamage")
  local nTask = GameGlobal.TaskManager():CoreGameStartTask(playSkillService.HandleBeHitMultiStage, playSkillService, casterEntity, targetEntity, self._hitAnimName, self._hitEffectID, damageInfoList, damageGridPos, self._turnToTarget, isFinalAttack, skillID, damageStageValueList, self._intervalTime)
  local nTaskDamage = GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    local intervalCount = table.count(damageStageValueList) - 1
    YIELD(TT, self._intervalTime * intervalCount)
    playDamageSvc:UpdateTargetHPBar(TT, targetEntity, damageInfo)
    playDamageSvc:_OnHpChangeNotifyBuff(TT, targetEntity, damageInfo:GetChangeHP(), damageInfo)
  end)
  return nTask, nTaskDamage
end

function PlaySkillSphereTrajectoryMultiStageDamagePhase:_SortDistanceForFinalAttack(castPos, damageResultArray)
  local function CmpDistancefunc(res1, res2)
    local dis1 = math.abs(castPos.x - res1:GetGridPos().x) + math.abs(castPos.y - res1:GetGridPos().y)
    
    local dis2 = math.abs(castPos.x - res2:GetGridPos().x) + math.abs(castPos.y - res2:GetGridPos().y)
    return dis1 > dis2
  end
  
  table.sort(damageResultArray, CmpDistancefunc)
  for _, v in ipairs(damageResultArray) do
    local result = v
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity:HasDeadFlag() then
      return targetEntityID
    end
  end
end

require("play_skill_phase_base_r")
_class("PlaySkillControlMonsterMoveAttackSummonPhase", PlaySkillPhaseBase)
PlaySkillControlMonsterMoveAttackSummonPhase = PlaySkillControlMonsterMoveAttackSummonPhase

function PlaySkillControlMonsterMoveAttackSummonPhase:PlayFlight(TT, casterEntity, phaseParam)
  local world = casterEntity:GetOwnerWorld()
  local effectParam = phaseParam
  local stageIndex = effectParam:GetStageIndex()
  local moveSpeed = effectParam:GetMoveSpeed()
  local flyOneTime = effectParam:GetFlyOneTime()
  local teleportStartWaitTime = effectParam:GetTeleportStartWaitTime()
  local teleportAnim = effectParam:GetTeleportAnim()
  local teleportTime = effectParam:GetTeleportTime()
  local teleportFinishAnim = effectParam:GetTeleportFinishAnim()
  local teleportFinishWaitTime = effectParam:GetTeleportFinishWaitTime()
  local jumpEffectID = effectParam:GetJumpEffectID()
  local moveAnim = effectParam:GetMoveAnim()
  local moveEffectID = effectParam:GetMoveEffectID()
  self._turnToTarget = effectParam:GetTurnToTarget()
  self._hitAnimName = effectParam:GetHitAnimName()
  self._hitEffectID = effectParam:GetHitEffectID()
  self._casterEntity = casterEntity
  local playSkillInstructionSvc = self._world:GetService("PlaySkillInstruction")
  local renderEntityService = self._world:GetService("RenderEntity")
  local trapServiceRender = self._world:GetService("TrapRender")
  local effectService = self._world:GetService("Effect")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillEffectResultControlMonsterMove = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ControlMonsterMove)
  if not skillEffectResultControlMonsterMove then
    return
  end
  self._resultCount = table.count(skillEffectResultControlMonsterMove)
  local skillEffectResult_Teleport = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport, stageIndex)
  local summonTrapResultDic = {}
  local skillSummonTrapEffectResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap, stageIndex)
  for _, result in pairs(skillSummonTrapEffectResult) do
    local summonTrapResult = result
    local summonPos = summonTrapResult:GetPos()
    local posIndex = Vector2.Pos2Index(summonPos)
    summonTrapResultDic[posIndex] = summonTrapResult
  end
  local damageResultDic = {}
  local SkillDamageEffectResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if SkillDamageEffectResult and table.count(SkillDamageEffectResult) > 0 then
    for _, result in pairs(SkillDamageEffectResult) do
      local damageResult = result
      local damageGridPos = damageResult:GetGridPos()
      local casterID = damageResult:GetCasterID()
      local posIndex = Vector2.Pos2Index(damageGridPos)
      table.insert(damageResultDic, {
        casterID = casterID,
        posIndex = posIndex,
        damageResult = damageResult
      })
    end
  end
  YIELD(TT, teleportStartWaitTime)
  local fakeTeleportSkillResult = {}
  local jumpEffectList = {}
  for _, v in ipairs(skillEffectResultControlMonsterMove) do
    local skillEffectResult = v
    local entityID = skillEffectResult:GetCasterEntityID()
    local posStart = skillEffectResult:GetPosStart()
    local posMiddle = skillEffectResult:GetPosMiddle()
    local posEnd = skillEffectResult:GetPosEnd()
    if posStart ~= posMiddle then
      local targetEntity = self._world:GetEntityByID(entityID)
      targetEntity:SetAnimatorControllerTriggers({teleportAnim})
      renderEntityService:DestroyMonsterAreaOutLineEntity(targetEntity)
      self:_PlayCasterControlGridDown(targetEntity, 0)
      local distance = Vector2.Distance(posStart, posMiddle)
      local speed = distance / teleportTime * 1000
      targetEntity:AddGridMove(speed, posMiddle, posStart)
      local effect = effectService:CreateEffect(jumpEffectID, targetEntity)
      table.insert(jumpEffectList, effect)
    end
  end
  YIELD(TT, teleportTime + teleportFinishWaitTime)
  for _, effectEntity in ipairs(jumpEffectList) do
    self._world:DestroyEntity(effectEntity)
  end
  local moveEffectList = {}
  for _, v in ipairs(skillEffectResultControlMonsterMove) do
    local skillEffectResult = v
    local entityID = skillEffectResult:GetCasterEntityID()
    local posStart = skillEffectResult:GetPosStart()
    local posMiddle = skillEffectResult:GetPosMiddle()
    local posEnd = skillEffectResult:GetPosEnd()
    local dirNew = skillEffectResult:GetDir()
    local dis = tonumber(Vector2.Distance(posMiddle, posEnd))
    local targetEntity = self._world:GetEntityByID(entityID)
    targetEntity:SetDirection(dirNew)
    targetEntity:AddGridMove(moveSpeed, posEnd, posMiddle)
    targetEntity:SetAnimatorControllerTriggers({moveAnim})
    renderEntityService:DestroyMonsterAreaOutLineEntity(targetEntity)
    self:_PlayCasterControlGridDown(targetEntity, 0)
    local effect = effectService:CreateEffect(moveEffectID, targetEntity)
    table.insert(moveEffectList, effect)
    GameGlobal.TaskManager():CoreGameStartTask(function()
      for i = 0, dis do
        local curPos = posMiddle + Vector2(dirNew.x * i, dirNew.y * i)
        local posIndex = Vector2.Pos2Index(curPos)
        local summonTrapResult = summonTrapResultDic[posIndex]
        if summonTrapResult then
          local trapIDList = summonTrapResult:GetTrapIDList()
          for i = 1, #trapIDList do
            local trapEntity = self._world:GetEntityByID(trapIDList[i])
            trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
            trapEntity:SetPosition(Vector2(summonTrapResult:GetPos().x, summonTrapResult:GetPos().y))
          end
          summonTrapResultDic[posIndex] = nil
        end
        for _, v in ipairs(damageResultDic) do
          local damageCasterID = v.casterID
          local damagePosIndex = v.posIndex
          local damageResult = v.damageResult
          if damageCasterID == entityID and damagePosIndex == posIndex then
            self:_OnPlayHit(TT, damageResult)
          end
        end
        YIELD(TT, flyOneTime)
      end
    end)
  end
  YIELD(TT, 1000)
  for _, effectEntity in ipairs(moveEffectList) do
    self._world:DestroyEntity(effectEntity)
  end
  for _, v in ipairs(skillEffectResultControlMonsterMove) do
    local skillEffectResult = v
    local entityID = skillEffectResult:GetCasterEntityID()
    local targetEntity = self._world:GetEntityByID(entityID)
    targetEntity:SetAnimatorControllerTriggers({"Idle"})
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  for _, result in pairs(skillEffectResult_Teleport) do
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    local posOld = result:GetPosOld()
    local posNew = result:GetPosNew()
    targetEntity:SetPosition(posNew)
    local trapIDList = result:GetTriggerTrapIDList()
    local trapEntityList = {}
    for _, v in ipairs(trapIDList) do
      local trapEntity = self._world:GetEntityByID(v)
      trapEntityList[#trapEntityList + 1] = trapEntity
    end
    playSkillInstructionSvc:PlayTrapTrigger(TT, targetEntity, trapEntityList)
    renderEntityService:DestroyMonsterAreaOutLineEntity(targetEntity)
    renderEntityService:CreateMonsterAreaOutlineEntity(targetEntity)
    self:_PlayCasterControlGridDown(targetEntity, 1)
    playBuffSvc:PlayBuffView(TT, NTTeleport:New(casterEntity, posOld, posNew))
  end
  YIELD(TT)
end

function PlaySkillControlMonsterMoveAttackSummonPhase:_OnPlayHit(TT, damageResult)
  local skillEffectResultContainer = self._casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageInfo = damageResult:GetDamageInfo(1)
  local targetEntity = self._world:GetEntityByID(damageResult:GetTargetID())
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  local playSkillService = self._world:GetService("PlaySkill")
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(self._casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlaySkillControlMonsterMoveAttackSummonPhase:_PlayCasterControlGridDown(casterEntity, enable)
  if casterEntity:MonsterID() then
    local monsterIDCmpt = casterEntity:MonsterID()
    monsterIDCmpt:SetNeedGridDownEnable(enable == 1)
  elseif casterEntity:HasTrapID() then
    local trapRender = casterEntity:TrapRender()
    trapRender:SetNeedGridDownEnable(enable == 1)
  else
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local bodyAreaCmpt = casterEntity:BodyArea()
  local areaArray = bodyAreaCmpt:GetArea()
  local pieceSvc = world:GetService("Piece")
  local monsterGridPos = casterEntity:GetRenderGridPosition()
  for i = 1, #areaArray do
    local curAreaPos = areaArray[i]
    local pos = Vector2(curAreaPos.x + monsterGridPos.x, curAreaPos.y + monsterGridPos.y)
    if enable == 1 then
      pieceSvc:SetPieceAnimDark(pos)
    else
      pieceSvc:SetPieceAnimNormal(pos)
    end
  end
end

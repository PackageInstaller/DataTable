require("base_ins_r")
_class("PlayTankRushPerGridInstruction", BaseInstruction)
PlayTankRushPerGridInstruction = PlayTankRushPerGridInstruction

function PlayTankRushPerGridInstruction:Constructor(paramList)
  self._rotateTime = tonumber(paramList.rotateTime) or 1
  self._rushEffectID = tonumber(paramList.rushEffectID)
  self._rushEffectDestroyDelay = tonumber(paramList.rushEffectDestroyDelay)
  self._rushEndEffectID = tonumber(paramList.rushEndEffectID)
  self._rushSpeed = tonumber(paramList.rushSpeed)
  self._rushAnimatorTrigger = paramList.rushAnimatorTrigger
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
end

function PlayTankRushPerGridInstruction:GetCacheResource()
  return {
    self:GetEffectResCacheInfo(self._rushEffectID),
    self:GetEffectResCacheInfo(self._rushEndEffectID),
    self:GetEffectResCacheInfo(self._hitEffectID)
  }
end

function PlayTankRushPerGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.TankRushPerGrid)
  if not result then
    return
  end
  local walkResArray = result:GetWalkResArray()
  local isCasterDead = result:IsCasterDead()
  local lastWalkRes = walkResArray[#walkResArray]
  local lastWalkPos = lastWalkRes:GetWalkPos()
  local casterPos = casterEntity:GetRenderGridPosition()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local dis = 2147483647
  local comparePos = casterPos
  for _, body in ipairs(bodyArea) do
    local v2 = body + casterPos
    local d = Vector2.Distance(v2, lastWalkPos)
    if dis > d then
      dis = d
      comparePos = v2
    end
  end
  local dir = lastWalkPos - comparePos
  if dir.x > 0 then
    dir.x = 1
  elseif dir.x < 0 then
    dir.x = -1
  end
  if 0 < dir.y then
    dir.y = 1
  elseif 0 > dir.y then
    dir.y = -1
  end
  if dir ~= casterEntity:GetRenderGridDirection() then
    local world = casterEntity:GetOwnerWorld()
    local BoardServiceRender = world:GetService("BoardRender")
    local v3Forward = BoardServiceRender:GridPos2RenderPos(lastWalkPos + casterEntity:GridLocation():GetDamageOffset())
    local go = casterEntity:View():GetGameObject()
    local tween = go.transform:DOLookAt(v3Forward, self._rotateTime * 0.001)
    YIELD(TT, self._rotateTime)
    if not tween:IsComplete() then
      tween:Complete()
    end
  end
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local rushEffectEntity = fxsvc:CreateEffect(self._rushEffectID, casterEntity)
  self:_PlayRush(TT, casterEntity, walkResArray, isCasterDead)
  GameGlobal.TaskManager():CoreGameStartTask(function(subTT)
    YIELD(subTT, self._rushEffectDestroyDelay)
    world:DestroyEntity(rushEffectEntity)
  end)
  local damageResultArray = result:GetDamageResultArray() or {}
  local damageResult = damageResultArray[1]
  if damageResult then
    local rushEndEffectEntity = fxsvc:CreateEffect(self._rushEndEffectID, casterEntity)
    self:_PlayDamage(TT, casterEntity, phaseContext, damageResult)
  end
  local hitBackResultArray = result:GetHitBackResultArray() or {}
  local hitBackResult = hitBackResultArray[1]
  if hitBackResult then
    self:_PlayHitBack(TT, casterEntity, phaseContext, hitBackResult)
  end
end

function PlayTankRushPerGridInstruction:_PlayRush(TT, casterEntity, walkResultList, isCasterDead)
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  for _, result in ipairs(walkResultList) do
    local walkPos = result:GetWalkPos()
    local curPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
    casterEntity:AddGridMove(self._rushSpeed, walkPos, curPos)
    local walkDir = walkPos - curPos
    local bodyAreaCmpt = casterEntity:BodyArea()
    local areaCount = bodyAreaCmpt:GetAreaCount()
    if areaCount == 4 then
      local leftDownPos = Vector2(curPos.x - 0.5, curPos.y - 0.5)
      walkDir = walkPos - leftDownPos
    end
    casterEntity:SetDirection(walkDir)
    while casterEntity:HasGridMove() do
      YIELD(TT)
    end
  end
  if isCasterDead then
    local sMonsterShowRender = world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, casterEntity)
  end
end

function PlayTankRushPerGridInstruction:_PlayRushArrivePos(TT, casterEntity, walkRes)
  local world = casterEntity:GetOwnerWorld()
  local trapResList = walkRes:GetWalkTrapResultList()
  for _, v in ipairs(trapResList) do
    local walkTrapRes = v
    local trapEntityID = walkTrapRes:GetTrapEntityID()
    local trapEntity = world:GetEntityByID(trapEntityID)
    local trapSkillRes = walkTrapRes:GetTrapResult()
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    local trapSvc = world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, casterEntity)
  end
end

function PlayTankRushPerGridInstruction:_PlayDamage(TT, casterEntity, phaseContext, damageResult)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = playSkillService:GetFinalAttack(world, casterEntity, phaseContext)
  local targetEntity = world:GetEntityByID(damageResult:GetTargetID())
  local curDamageInfoIndex = phaseContext:GetCurDamageInfoIndex()
  local damageInfo = damageResult:GetDamageInfo(curDamageInfoIndex)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(1)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlayTankRushPerGridInstruction:_PlayHitBack(TT, casterEntity, phaseContext, hitBackResult)
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(hitBackResult:GetTargetID())
  local playSkillService = world:GetService("PlaySkill")
  local processHitTaskID
  processHitTaskID = playSkillService:ProcessHit(casterEntity, targetEntity, hitBackResult)
  if processHitTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
      YIELD(TT)
    end
  end
end

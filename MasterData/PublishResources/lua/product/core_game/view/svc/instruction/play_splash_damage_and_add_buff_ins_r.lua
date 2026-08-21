require("base_ins_r")
_class("PlaySplashDamageAndAddBuffInstruction", BaseInstruction)
PlaySplashDamageAndAddBuffInstruction = PlaySplashDamageAndAddBuffInstruction

function PlaySplashDamageAndAddBuffInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flyTotalTime = tonumber(paramList.flyTotalTime)
  self._flyEffectHeight = tonumber(paramList.flyEffectHeight)
  self._gridEffectDelayTime = tonumber(paramList.gridEffectDelayTime)
  self._gridEffectID = tonumber(paramList.gridEffectID)
  self._hitDelayTime = tonumber(paramList.hitDelayTime)
  self._hitAnimName = paramList.hitAnimName
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._turnToTarget = tonumber(paramList.turnToTarget)
  self._deathClear = tonumber(paramList.deathClear)
  self._buffID = tonumber(paramList.buffID) or 0
  self._buffEffectType = tonumber(paramList.buffEffectType) or 0
end

function PlaySplashDamageAndAddBuffInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      1
    })
  end
  if self._gridEffectID and 0 < self._gridEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlaySplashDamageAndAddBuffInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = resultContainer:GetEffectResultByArray(SkillEffectType.SplashDamageAndAddBuff)
  if not result then
    return
  end
  local boardServiceRender = world:GetService("BoardRender")
  local effectService = world:GetService("Effect")
  local centerPos = result:GetCenterPos()
  local casterEntityPos = casterEntity:GetGridPosition()
  local effectDir = centerPos - casterEntityPos
  local flyBeginPos = boardServiceRender:GridPos2RenderPos(casterEntityPos)
  flyBeginPos.y = flyBeginPos.y + self._flyEffectHeight
  local effectEntity = effectService:CreatePositionEffect(self._flyEffectID, flyBeginPos)
  if effectEntity then
    effectEntity:SetDirection(effectDir)
  end
  local flyTargetPos = Vector2.New(centerPos.x, centerPos.y)
  flyTargetPos = boardServiceRender:GridPos2RenderPos(Vector2.New(flyTargetPos.x + 0.5, flyTargetPos.y + 0.5))
  flyTargetPos.y = flyTargetPos.y + self._flyEffectHeight
  local trajectoryInfo = {
    startHeight = self._flyEffectHeight,
    endHeight = self._flyEffectHeight,
    totalTime = self._flyTotalTime * 0.001,
    totalTimeMs = self._flyTotalTime,
    targetRenderPos = flyTargetPos,
    currentTime = 0,
    trajectoryID = self._flyEffectID,
    trajectoryEntity = effectEntity
  }
  local flyTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, trajectoryInfo)
  YIELD(TT, self._gridEffectDelayTime)
  effectService:CreateWorldPositionEffect(self._gridEffectID, centerPos)
  while not TaskHelper:GetInstance():IsAllTaskFinished({flyTaskID}) do
    YIELD(TT)
  end
  YIELD(TT, self._hitDelayTime)
  local playSkillService = world:GetService("PlaySkill")
  local damageResults = result:GetDamageResults()
  for _, damageResult in ipairs(damageResults) do
    local targetEntity = world:GetEntityByID(damageResult:GetTargetID())
    local damageInfo = damageResult:GetDamageInfo(1)
    local damageGridPos = damageResult:GetGridPos()
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(self._deathClear):SetHandleBeHitParam_IsFinalHit(resultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(resultContainer:GetSkillID())
    playSkillService:HandleBeHit(TT, beHitParam)
  end
  local utilDataSvc = world:GetService("UtilData")
  self._buffID = utilDataSvc:GetReplacedBuffIdForPlayIns(casterEntity, self._buffID)
  self._buffEffectType = utilDataSvc:GetReplacedBuffEffectTypeForPlayIns(casterEntity, self._buffEffectType)
  local playBuffService = world:GetService("PlayBuff")
  local buffResults = result:GetBuffResults()
  for _, v in pairs(buffResults) do
    local eid = v:GetEntityID()
    local buffArray = v:GetAddBuffResult()
    if next(buffArray) then
      local e = world:GetEntityByID(eid)
      for _, seq in pairs(buffArray) do
        local buffViewInstance = e:BuffView():GetBuffViewInstance(seq)
        local buffID = buffViewInstance:BuffID()
        local buffEffectType = buffViewInstance:GetBuffEffectType()
        if self._buffID == buffID or self._buffEffectType == buffEffectType then
          playBuffService:PlayAddBuff(TT, buffViewInstance, casterEntity:GetID())
        end
      end
    end
  end
end

function PlaySplashDamageAndAddBuffInstruction:_DoFly(TT, trajectoryInfo)
  local entity = trajectoryInfo.trajectoryEntity
  local effectViewCmpt = entity:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local transWork = effectObject.transform
  local easeWork = transWork:DOMove(trajectoryInfo.targetRenderPos, trajectoryInfo.totalTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, trajectoryInfo.totalTimeMs)
  local world = entity:GetOwnerWorld()
  world:DestroyEntity(entity)
end

require("play_skill_phase_base_r")
_class("PlaySkillFlotageTrajectoryPhase", PlaySkillPhaseBase)
PlaySkillFlotageTrajectoryPhase = PlaySkillFlotageTrajectoryPhase

function PlaySkillFlotageTrajectoryPhase:PlayFlight(TT, casterEntity, phaseParam)
  local effectParam = phaseParam
  local effectID = effectParam:GetEffectID()
  local spawnRadiusMin = effectParam:GetSpawnRadiusMin()
  local spawnRadiusMax = effectParam:GetSpawnRadiusMax()
  local spawnOffsetPos = effectParam:GetSpawnOffsetPos()
  self._upSpeed = effectParam:GetUpSpeed()
  self._upShakeDis = effectParam:GetUpShakeDis()
  self._upShakeDertaTimeMin = effectParam:GetUpShakeDertaTimeMin()
  self._upShakeDertaTimeMax = effectParam:GetUpShakeDertaTimeMax()
  local fireTimeMin = effectParam:GetFireTimeMin()
  local fireTimeMax = effectParam:GetFireTimeMax()
  self._flyTime = effectParam:GetFlyTime()
  self._flyRandomDis = effectParam:GetFlyRandomDis()
  self._flyRandomPointCount = effectParam:GetFlyRandomPointCount()
  self._lastHitPointTime = 0
  self._hitPointDelay = effectParam:GetHitPointDelay()
  self._destroyBulletDelay = effectParam:GetdestroyBulletDelay()
  local targetHit = effectParam:GetTargetHit()
  local targetHitOffsetMin = effectParam:GetTargetHitOffsetMin()
  local targetHitOffsetMax = effectParam:GetTargetHitOffsetMax()
  self._turnToTarget = effectParam:GetTurnToTarget()
  self._hitAnimName = effectParam:GetHitAnimName()
  self._hitEffectID = effectParam:GetHitEffectID()
  self._casterEntity = casterEntity
  self._fireEffectID = effectParam:GetFireEffectID()
  self._disableRoot = effectParam:GetDisableRoot()
  self._summonTrapWithHit = effectParam:GetSummonTrapWithHit()
  self._summonTrapEffectID = effectParam:GetSummonTrapEffectID()
  self._summonTrapDirToTarget = effectParam:GetSummonTrapDirToTarget()
  self._needLookAt = effectParam:GetNeedLookAt()
  self._pathFirstPos = effectParam:GetPathFirstPos()
  self._firstPosRandom = effectParam:GetFirstPosRandom()
  self._hitSoundID = effectParam:GetHitSoundID()
  local listTask = {}
  local castPos = casterEntity:GetRenderGridPosition()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local trapResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonTrap)
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local playSkillService = world:GetService("PlaySkill")
  local timeService = self._world:GetService("Time")
  local startTime = timeService:GetCurrentTimeMs()
  local playDamageResultList = {}
  self.playEffectDataList = {}
  for i, v in ipairs(damageResultArray) do
    local format = {}
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(targetEntityID)
    if targetEntity then
      if not playDamageResultList[targetEntityID] then
        playDamageResultList[targetEntityID] = {}
      end
      table.insert(playDamageResultList[targetEntityID], damageResult)
      local posWork = castPos
      if spawnRadiusMin then
        local pos1 = UnityEngine.Random.insideUnitCircle * spawnRadiusMin
        local pos2 = pos1.normalized * (spawnRadiusMax + pos1.magnitude)
        posWork = castPos + pos2
      else
        local casterEntityTransform = casterEntity:View():GetGameObject().transform
        posWork = casterEntityTransform:TransformPoint(spawnOffsetPos)
      end
      local eftEntity = effectService:CreatePositionEffect(effectID, posWork)
      local go = eftEntity:View():GetGameObject()
      if self._disableRoot then
        local disableTransform = go.transform:Find(self._disableRoot)
        if disableTransform then
          disableTransform.gameObject:SetActive(true)
        end
      end
      if not self._upSpeed then
        go.gameObject:SetActive(false)
      end
      local targetBoneTransform = playSkillService:GetEntityRenderSelectBoneTransform(targetEntity, targetHit)
      local targetHitOffset = math.random(targetHitOffsetMin * 1000, targetHitOffsetMax * 1000) / 1000
      local targetPos = targetBoneTransform.position + UnityEngine.Random.onUnitSphere * targetHitOffset
      targetPos = Vector3(targetPos.x, math.max(0, targetPos.y), targetPos.z)
      local fireTime = math.random(fireTimeMin, fireTimeMax)
      local fireStartTime = fireTime + startTime
      local playEffectData = PlaySkillFlotageTrajectoryData:New(eftEntity, targetEntity, targetPos, fireStartTime)
      if self._summonTrapWithHit == 1 and trapResultArray and trapResultArray[i] then
        local result = trapResultArray[i]
        local summonTrapID = result:GetTrapID()
        playEffectData:SetSummonTrapID(result:GetTrapID())
        playEffectData:SetSummonTrapPos(result:GetPos())
      end
      playEffectData:SetPlayDamageResultList(playDamageResultList)
      self.playEffectDataList[eftEntity:GetID()] = playEffectData
    end
  end
  while 0 < table.count(self.playEffectDataList) do
    local curTime = timeService:GetCurrentTimeMs()
    for _, v in pairs(self.playEffectDataList) do
      if v.stage == 1 and curTime <= v.fireStartTime then
        v.stage = 2
        self:_OnPlayBezier(TT, v)
      end
      self:_OnPlayClimbNoise(TT, v)
    end
    YIELD(TT)
  end
  YIELD(TT)
end

function PlaySkillFlotageTrajectoryPhase:_OnPlayClimbNoise(TT, playEffectData)
  if playEffectData.stage ~= 1 then
    return
  end
  if not self._upSpeed then
    return
  end
  local effectEntity = playEffectData.effectEntity
  local go = effectEntity:View():GetGameObject()
  local time = math.random(self._upShakeDertaTimeMin, self._upShakeDertaTimeMax) / 1000
  local targetPos = go.transform.position + math.random(-self._upShakeDis.x, self._upShakeDis.x) / 1000 * Vector3.right + math.random(-self._upShakeDis.y, self._upShakeDis.y) / 1000 * Vector3.up + math.random(-self._upShakeDis.z, self._upShakeDis.z) / 1000 * Vector3.forward + Vector3(0, self._upSpeed, 0)
  go.transform:DOMove(targetPos, time):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    self:_OnPlayClimbNoise(TT, playEffectData)
  end)
end

function PlaySkillFlotageTrajectoryPhase:_OnPlayBezier(TT, playEffectData)
  if playEffectData.stage ~= 2 then
    return
  end
  local effectEntity = playEffectData.effectEntity
  local go = effectEntity:View():GetGameObject()
  go.transform:DOKill()
  if not self._upSpeed then
    go.gameObject:SetActive(true)
  end
  local effectService = self._world:GetService("Effect")
  if self._fireEffectID and self._fireEffectID > 0 then
    local hitEffect = effectService:CreateWorldPositionEffect(self._fireEffectID, go.transform.position)
  end
  local path = {}
  table.insert(path, go.transform.position)
  if self._pathFirstPos then
    local posRandom = Vector3(0, 0, 0)
    if self._firstPosRandom then
      posRandom = Vector3(math.random(-self._firstPosRandom * 1000, self._firstPosRandom * 1000) / 1000, math.random(-self._firstPosRandom * 1000, self._firstPosRandom * 1000) / 1000, math.random(-self._firstPosRandom * 1000, self._firstPosRandom * 1000) / 1000)
    end
    local pathFirstPos = go.transform.position + self._pathFirstPos + posRandom
    table.insert(path, pathFirstPos)
  end
  local lastPos = path[#path]
  for i = 1, self._flyRandomPointCount do
    local pos = lastPos + Vector3(math.random(-self._flyRandomDis, self._flyRandomDis), math.random(-5, 5) / 10, math.random(-self._flyRandomDis, self._flyRandomDis))
    if pos.y < 0.8 then
      pos = Vector3(pos.x, 0.8, pos.z)
    end
    table.insert(path, pos)
    lastPos = pos
  end
  table.insert(path, playEffectData.targetPos)
  local pathBezier = {}
  for i = 0, 1, 0.01 do
    table.insert(pathBezier, self:_BezierMethod(i, path))
  end
  table.insert(pathBezier, playEffectData.targetPos)
  local curve = DG.Tweening.Ease.Linear
  local animationCurveHolder = go.gameObject:GetComponent(typeof(AnimationCurveHolder))
  if animationCurveHolder then
    local curveList = animationCurveHolder.acurveList
    if curveList and 0 < curveList.Length then
      curve = curveList[0]
    end
  end
  local flyTime = self._flyTime
  local timeService = self._world:GetService("Time")
  local curTime = timeService:GetCurrentTimeMs()
  local needHitPointTime = self._lastHitPointTime + self._hitPointDelay
  if needHitPointTime > curTime + flyTime then
    flyTime = needHitPointTime - curTime
  end
  self._lastHitPointTime = curTime + flyTime
  if self._needLookAt == 1 then
    local newPathBezier = {}
    for i = 1, table.count(pathBezier) do
      if i % 3 == 0 then
        table.insert(newPathBezier, pathBezier[i])
      end
    end
    go.transform:LookAt(newPathBezier[2])
    YIELD(TT)
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      local tweenTime = flyTime / table.count(newPathBezier)
      for i = 1, table.count(newPathBezier) - 1 do
        local nextPos = newPathBezier[i + 1]
        go.transform:LookAt(nextPos)
        go.transform:DOMove(nextPos, tweenTime * 0.001)
        YIELD(TT, tweenTime)
      end
      self:_OnPlayHit(TT, playEffectData)
    end)
  else
    go.transform:DOLocalPath(pathBezier, flyTime / 1000, DG.Tweening.PathType.CatmullRom, DG.Tweening.PathMode.Full3D):SetEase(curve)
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, flyTime)
      self:_OnPlayHit(TT, playEffectData)
    end)
  end
end

function PlaySkillFlotageTrajectoryPhase:_OnPlayHit(TT, playEffectData)
  local effectEntity = playEffectData.effectEntity
  local go = effectEntity:View():GetGameObject()
  local effectPos = go.transform.position
  if self._disableRoot then
    local disableTransform = go.transform:Find(self._disableRoot)
    if disableTransform then
      disableTransform.gameObject:SetActive(false)
    end
  end
  local targetEntity = playEffectData.targetEntity
  local targetEntityID = targetEntity:GetID()
  local playDamageResultList = playEffectData:GetPlayDamageResultList()
  local damageResult = playDamageResultList[targetEntityID][1]
  table.remove(playDamageResultList[targetEntityID], 1)
  if table.count(playDamageResultList[targetEntityID]) == 0 then
    playDamageResultList[targetEntityID] = nil
  end
  local effectService = self._world:GetService("Effect")
  local hitEffect = effectService:CreateWorldPositionEffect(self._hitEffectID, effectPos)
  local skillEffectResultContainer = self._casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  if skillEffectResultContainer:IsFinalAttack() and table.count(playDamageResultList) == 0 then
    playFinalAttack = true
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(self._casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(0):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
  local summonTrapID = playEffectData:GetSummonTrapID()
  if summonTrapID then
    local summonTrapPos = playEffectData:GetSummonTrapPos()
    local utilSvc = self._world:GetService("UtilData")
    local array = utilSvc:GetTrapsAtPos(summonTrapPos)
    local trapEntity
    for _, eTrap in ipairs(array) do
      local cTrap = eTrap:TrapID()
      if cTrap and cTrap:GetTrapID() == summonTrapID and not eTrap:HasDeadMark() then
        trapEntity = eTrap
        break
      end
    end
    if trapEntity then
      trapEntity:SetPosition(summonTrapPos)
      local trapServiceRender = self._world:GetService("TrapRender")
      trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
      if self._summonTrapEffectID and 0 < self._summonTrapEffectID then
        effectService:CreateWorldPositionDirectionEffect(self._summonTrapEffectID, summonTrapPos)
      end
      if self._summonTrapDirToTarget == 1 then
        local dir = summonTrapPos - targetEntity:GetGridPosition()
        trapEntity:SetDirection(dir)
      end
    end
  end
  if self._hitSoundID and 0 < self._hitSoundID then
    AudioHelperController.PlayInnerGameSfx(self._hitSoundID)
  end
  YIELD(TT, self._destroyBulletDelay)
  self._world:DestroyEntity(effectEntity)
  self.playEffectDataList[playEffectData.effectEntity:GetID()] = nil
end

function PlaySkillFlotageTrajectoryPhase:_BezierMethod(t, foceList)
  if table.count(foceList) < 2 then
    return foceList[1]
  end
  local temp = {}
  for i = 1, table.count(foceList) - 1 do
    local proportion = Vector3((1 - t) * foceList[i].x + t * foceList[i + 1].x, (1 - t) * foceList[i].y + t * foceList[i + 1].y, (1 - t) * foceList[i].z + t * foceList[i + 1].z)
    table.insert(temp, proportion)
  end
  return self:_BezierMethod(t, temp)
end

_class("PlaySkillFlotageTrajectoryData", Object)
PlaySkillFlotageTrajectoryData = PlaySkillFlotageTrajectoryData

function PlaySkillFlotageTrajectoryData:Constructor(eftEntity, targetEntity, targetPos, fireStartTime)
  self.effectID = eftEntity:GetID()
  self.effectEntity = eftEntity
  self.stage = 1
  self.targetEntity = targetEntity
  if targetEntity then
    self.targetID = targetEntity:GetID()
  end
  self.targetPos = targetPos
  self.fireStartTime = fireStartTime
end

function PlaySkillFlotageTrajectoryData:SetSummonTrapID(summonTrapID)
  self.summonTrapID = summonTrapID
end

function PlaySkillFlotageTrajectoryData:GetSummonTrapID()
  return self.summonTrapID
end

function PlaySkillFlotageTrajectoryData:SetSummonTrapPos(summonTrapPos)
  self.summonTrapPos = summonTrapPos
end

function PlaySkillFlotageTrajectoryData:GetSummonTrapPos()
  return self.summonTrapPos
end

function PlaySkillFlotageTrajectoryData:SetConvertPieceType(convertPieceType)
  self.convertPieceType = convertPieceType
end

function PlaySkillFlotageTrajectoryData:GetConvertPieceType()
  return self.convertPieceType
end

function PlaySkillFlotageTrajectoryData:SetConvertPos(gridPos)
  self.gridPos = gridPos
end

function PlaySkillFlotageTrajectoryData:GetConvertPos()
  return self.gridPos
end

function PlaySkillFlotageTrajectoryData:SetSummonTrapEntityIDList(summonTrapEntityIDList)
  self.summonTrapEntityIDList = summonTrapEntityIDList
end

function PlaySkillFlotageTrajectoryData:GetSummonTrapEntityIDList()
  return self.summonTrapEntityIDList
end

function PlaySkillFlotageTrajectoryData:SetPlayDamageResultList(playDamageResultList)
  self.playDamageResultList = playDamageResultList
end

function PlaySkillFlotageTrajectoryData:GetPlayDamageResultList()
  return self.playDamageResultList
end

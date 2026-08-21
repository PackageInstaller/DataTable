require("play_skill_phase_base_r")
_class("PlaySkillPhase_GridReturn", PlaySkillPhaseBase)
PlaySkillPhase_GridReturn = PlaySkillPhase_GridReturn

function PlaySkillPhase_GridReturn:PlayFlight(TT, casterEntity, phaseParam)
  local workParam = phaseParam
  local listGridPos = {}
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if SkillPhaseParam_GridReturn_TargetType.Damage == workParam:GetTargetType() then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.Damage)
    local listEntity = {}
    if skillResultArray and 0 < #skillResultArray then
      for k, res in pairs(skillResultArray) do
        local targetEntityID = res:GetTargetID()
        local targetEntity = self._world:GetEntityByID(targetEntityID)
        if false == table.icontains(listEntity, targetEntity) then
          listEntity[#listEntity + 1] = targetEntity
          listGridPos[#listGridPos + 1] = targetEntity:GetGridPosition()
        end
      end
    end
  elseif SkillPhaseParam_GridReturn_TargetType.RandAttack == workParam:GetTargetType() then
    local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.RandAttack)
    if not skillResultArray then
      return
    end
    local listDeathPos = skillResultArray:GetListDeathPos()
    for i = 1, #listDeathPos do
      listGridPos[#listGridPos + 1] = listDeathPos[i]
    end
  elseif SkillPhaseParam_GridReturn_TargetType.AllRangeGrid == workParam:GetTargetType() then
    local scopeResult = skillEffectResultContainer:GetScopeResult()
    listGridPos = scopeResult:GetAttackRange()
  end
  if #listGridPos <= 0 then
    return
  end
  GameGlobal.TaskManager():CoreGameStartTask(self._skillService.PlayCastAudio, self._skillService, workParam:GetAudioID(), workParam:GetAudioWaitTime())
  local castAnimation, castEffectID, castDelayTime = workParam:GetCastAnimationEffect()
  self:_PlayAnimationEffect(TT, casterEntity, castAnimation, castEffectID, castDelayTime)
  local boardServiceRender = self._world:GetService("BoardRender")
  local effectService = self._world:GetService("Effect")
  local castPos = casterEntity:Location().Position
  local gridEffectID = workParam:GetGridEffectID()
  local bornEffectID = workParam:GetBornEffectID()
  if bornEffectID and 0 < bornEffectID then
    for k, v in pairs(listGridPos) do
      local renderPos = boardServiceRender:GridPos2RenderPos(v)
      local effectEntity = effectService:CreatePositionEffect(bornEffectID, renderPos)
    end
  end
  self:_DelayTime(TT, workParam:GetBornEffectTime())
  local ballHigh = workParam:GetStartHigh()
  local effectEntityList = {}
  for k, v in pairs(listGridPos) do
    local renderPos = boardServiceRender:GridPos2RenderPos(v)
    renderPos.y = renderPos.y + ballHigh
    local effectEntity = effectService:CreatePositionEffect(gridEffectID, renderPos)
    table.insert(effectEntityList, {
      entity = effectEntity,
      position = renderPos,
      gridPos = v
    })
    Log.debug("[Grid_Return]特效：GridPos = (" .. v.x .. "," .. v.y .. "), RenderPos = (" .. renderPos.x .. "," .. renderPos.y .. "," .. renderPos.z .. ")")
  end
  YIELD(TT)
  local nTrajectoryType = workParam:GetTrajectoryType()
  local taskIDs = {}
  for k, v in pairs(effectEntityList) do
    local view = v.entity:View()
    local go = view:GetGameObject()
    local curTaskID = 0
    if 1 == nTrajectoryType then
      curTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoFlyLine, self, v.entity, casterEntity, v.gridPos, phaseParam)
    elseif 2 == nTrajectoryType then
      curTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoSpiral, self, v.entity, casterEntity, v.gridPos, phaseParam)
    end
    if 0 < curTaskID then
      taskIDs[#taskIDs + 1] = curTaskID
    end
    YIELD(TT)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
  self:_PlayAnimationEffect(TT, casterEntity, nil, workParam:GetEndEffectID(), 0)
  self:_DelayTime(TT, workParam:GetFinishDelayTime())
end

function PlaySkillPhase_GridReturn:_GetTotalFlyTime(posCaster, posEffect, phaseParam)
  local nTotalTime = phaseParam:GetFlyTotalTime()
  if nil == nTotalTime or 0 == nTotalTime then
    local nDistance = Vector2.Distance(posCaster, posEffect)
    nTotalTime = phaseParam:GetFlySpeed() * nDistance
  end
  return nTotalTime
end

function PlaySkillPhase_GridReturn:_DoSpiral(TT, effectEntity, casterEntity, posEffectGrid, phaseParam)
  local deltaAngle = phaseParam:GetDeltaAngle()
  local effectViewCmpt = effectEntity:View()
  local effectGo = effectViewCmpt:GetGameObject()
  local effectPos = effectGo.transform.position
  local effectHeight = effectPos.y
  local casterViewCmpt = casterEntity:View()
  local casterGo = casterViewCmpt:GetGameObject()
  local casterPos = casterGo.transform.position
  local totalTime = self:_GetTotalFlyTime(casterEntity:GetGridPosition(), posEffectGrid, phaseParam)
  local startValue = Vector3.Distance(effectPos, casterPos)
  local deltaRotation = Quaternion.AngleAxis(deltaAngle, Vector3.up)
  local curTime = totalTime
  while 0 < curTime do
    local curEffectDir = Vector3.Normalize(effectPos - casterPos)
    local deltaTime = self._timeService:GetDeltaTimeMs()
    curTime = curTime - deltaTime
    local curDistance = curTime / totalTime * startValue
    local curEffectPos = deltaRotation * curEffectDir * curDistance + casterPos
    curEffectPos.y = effectHeight
    effectGo.transform.position = curEffectPos
    effectPos = curEffectPos
    YIELD(TT)
  end
  effectGo:SetActive(false)
  self._world:DestroyEntity(effectEntity)
end

function PlaySkillPhase_GridReturn:_DoFlyLine(TT, entityEffect, entityCaster, posEffectGrid, phaseParam)
  local posCaster = entityCaster:GetGridPosition()
  local boardServiceRender = self._world:GetService("BoardRender")
  local effectViewCmpt = entityEffect:View()
  local effectObject = effectViewCmpt:GetGameObject()
  local posEffect = effectObject.transform.position
  local nTotalTime = self:_GetTotalFlyTime(posCaster, posEffectGrid, phaseParam)
  local nFlyTime = nTotalTime / 1000.0
  local endtime = GameGlobal:GetInstance():GetCurrentTime() + nTotalTime
  local transWork = effectObject.transform
  local gridWorldpos = boardServiceRender:GridPos2RenderPos(posCaster)
  gridWorldpos.y = gridWorldpos.y + phaseParam:GetEndHigh()
  local easeWork = transWork:DOMove(gridWorldpos, nFlyTime, false):SetEase(DG.Tweening.Ease.InOutSine)
  while endtime > GameGlobal:GetInstance():GetCurrentTime() do
    YIELD(TT)
  end
  effectObject:SetActive(false)
  self._world:DestroyEntity(entityEffect)
end

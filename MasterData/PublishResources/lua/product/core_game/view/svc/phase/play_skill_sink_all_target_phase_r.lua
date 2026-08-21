require("play_skill_phase_base_r")
_class("PlaySkillSinkAllTargetPhase", PlaySkillPhaseBase)
PlaySkillSinkAllTargetPhase = PlaySkillSinkAllTargetPhase

function PlaySkillSinkAllTargetPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if damageResultArray == nil then
    return
  end
  local damageResCount = #damageResultArray
  if damageResCount <= 0 then
    return
  end
  local posCaster = casterEntity:GetGridPosition()
  local world = casterEntity:GetOwnerWorld()
  local effectService = world:GetService("Effect")
  local effectId = phaseParam:GetEffectId()
  local effectScale = phaseParam:GetEffectScale()
  local intervalTime = phaseParam:GetIntervalTime()
  local listWaitTask = {}
  local boardServiceRender = world:GetService("BoardRender")
  for i = 1, damageResCount do
    local damageResult = damageResultArray[i]
    local targetEntityId = damageResult:GetTargetID()
    if targetEntityId and 0 < targetEntityId then
      local targetEntity = world:GetEntityByID(targetEntityId)
      if targetEntity:HasTeam() then
        targetEntityId = targetEntity:GetTeamLeaderPetEntity()
      end
      if effectId and 0 < effectId then
        local posDamageCenter = boardServiceRender:GetEntityRealTimeGridPos(targetEntity, true)
        local entityEffect = effectService:CreateWorldPositionDirectionEffect(effectId, posDamageCenter, posDamageCenter - posCaster)
        if entityEffect then
          local nBodyAreaCount = targetEntity:BodyArea():GetAreaCount()
          if nBodyAreaCount and 4 == nBodyAreaCount then
            local trajectoryObject = entityEffect:View():GetGameObject()
            local transWork = trajectoryObject.transform
            local scaleData = Vector3.New(effectScale, effectScale, effectScale)
            local sequence = transWork:DOScale(scaleData, 0)
            local easeWork = sequence:SetEase(DG.Tweening.Ease.InOutSine)
          end
        end
      end
    end
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(self._SinkTarget, self, casterEntity, damageResult, phaseParam)
    listWaitTask[#listWaitTask + 1] = taskID
    YIELD(TT, intervalTime)
  end
  if listWaitTask and 0 < table.count(listWaitTask) then
    while not TaskHelper:GetInstance():IsAllTaskFinished(listWaitTask) do
      YIELD(TT)
    end
  end
end

function PlaySkillSinkAllTargetPhase:_SinkTarget(TT, casterEntity, damageResult, phaseParam)
  local targetEntityId = damageResult:GetTargetID()
  if targetEntityId == nil or targetEntityId <= 0 then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityId)
  local nBodyAreaCount = targetEntity:BodyArea():GetAreaCount()
  local cantSink = targetEntity:View() and targetEntity:View():GetGameObject() and targetEntity:View():GetGameObject().name == "2903001"
  local canSink = true
  if nBodyAreaCount < 1 or 4 < nBodyAreaCount or cantSink then
    canSink = false
  end
  local waitDownTime = phaseParam:GetWaitDownTime()
  local downDis = phaseParam:GetDownDistance()
  local downTime = phaseParam:GetDownTime()
  local waitTime = phaseParam:GetWaitTime()
  local upTime = phaseParam:GetUpTime()
  local waitDamageTime = phaseParam:GetWaitDamageTime()
  local hitEffectId = phaseParam:GetHitEffectId()
  local hitAnimName = phaseParam:GetHitAnimName()
  YIELD(TT, waitDownTime)
  local gridWorldPos = targetEntity:GetPosition()
  local gridWorldNew = UnityEngine.Vector3.New()
  gridWorldNew.x = gridWorldPos.x
  gridWorldNew.y = gridWorldPos.y + downDis
  gridWorldNew.z = gridWorldPos.z
  if canSink then
    self:_ShowLineRenderer(world, casterEntity, false)
    self:_MoveEntity(TT, targetEntity, gridWorldNew, downTime)
    if not phaseParam:DoNotHideTarget() then
      self:_ShowEntity(world, targetEntity, false)
    end
  else
    YIELD(TT, downTime)
  end
  YIELD(TT, waitTime)
  if canSink then
    if not phaseParam:DoNotHideTarget() then
      self:_ShowEntity(world, targetEntity, true)
    end
    self:_MoveEntity(TT, targetEntity, gridWorldPos, upTime)
    self:_ShowLineRenderer(world, casterEntity, true)
  else
    YIELD(TT, upTime)
  end
  YIELD(TT, waitDamageTime)
  local playSkillService = world:GetService("PlaySkill")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectId):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(TurnToTargetType.None):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlaySkillSinkAllTargetPhase:_MoveEntity(TT, entityWork, worldPos, moveTime)
  if nil == entityWork then
    return
  end
  if not entityWork:View() then
    return
  end
  local trajectoryObject = entityWork:View():GetGameObject()
  local transWork = trajectoryObject.transform
  local easeWork = transWork:DOMove(worldPos, moveTime / 1000, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, moveTime)
end

function PlaySkillSinkAllTargetPhase:_ShowEntity(world, entityWork, bShow)
  entityWork:SetUpToVisible(bShow)
  if not entityWork:HP() then
    return
  end
  local slider_entity_id = entityWork:HP():GetHPSliderEntityID()
  local slider_entity = world:GetEntityByID(slider_entity_id)
  if slider_entity then
    slider_entity:SetViewVisible(bShow)
  end
end

function PlaySkillSinkAllTargetPhase:_ShowLineRenderer(world, casterEntity, show)
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  for i, entity in ipairs(monsterGroup:GetEntities()) do
    local effectID
    local effectLineRenderer = entity:EffectLineRenderer()
    if effectLineRenderer then
      effectLineRenderer:SetEffectLineRendererShow(casterEntity:GetID(), show)
      effectID = effectLineRenderer:GetEffectLineRendererEffectID(casterEntity:GetID())
    end
    local buffView = entity:BuffView()
    local notOpenLineEffectObjName = buffView:GetBuffValue("NotOpenLineEffectObjName")
    local effectHolderCmpt = entity:EffectHolder()
    if effectHolderCmpt then
      local effectList = effectHolderCmpt:GetPermanentEffect()
      for i, eff in ipairs(effectList) do
        local e = world:GetEntityByID(eff)
        if e and e:HasView() then
          local go = e:View():GetGameObject()
          local renderers = go:GetComponentsInChildren(typeof(UnityEngine.LineRenderer), true)
          for i = 0, renderers.Length - 1 do
            local line = renderers[i]
            if line and notOpenLineEffectObjName ~= line.gameObject.name then
              line.gameObject:SetActive(show)
            end
          end
        end
      end
    end
  end
end

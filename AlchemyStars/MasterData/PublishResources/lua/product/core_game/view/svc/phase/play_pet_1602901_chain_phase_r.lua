require("play_skill_phase_base_r")
_class("PlayPet1602901ChainPhase", PlaySkillPhaseBase)
PlayPet1602901ChainPhase = PlayPet1602901ChainPhase

function PlayPet1602901ChainPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DynamicCenterDamage) or {}
  local result = resultArray[1]
  if not result then
    return
  end
  local fxsvc = self._world:GetService("Effect")
  local centerScope = result:GetDamageScope()
  local viewCenterPos = centerScope:GetCenterPos()
  local casterRenderPos = casterEntity:GetRenderGridPosition()
  local viewDir = viewCenterPos - casterRenderPos
  casterEntity:SetDirection(viewDir)
  casterEntity:SetAnimatorControllerTriggers({
    phaseParam:GetAnimatorTrigger()
  })
  YIELD(TT, phaseParam:GetHighJumpEffectDelay())
  local highJumpEffectEntity = fxsvc:CreateCommonGridEffect(phaseParam:GetHighJumpEffectID(), viewCenterPos, viewDir)
  YIELD(TT, phaseParam:GetDiveDelay())
  local csCasterGameObject = casterEntity:View():GetGameObject()
  local csCasterHitTransform = GameObjectHelper.FindChild(csCasterGameObject.transform, "Hit")
  local v3TrajectoryBeginPos = csCasterHitTransform.position
  local boardsvc = self._world:GetService("BoardRender")
  local v3ViewCenterPos = boardsvc:GridPos2RenderPos(viewCenterPos)
  local v3TrajectoryDir = v3ViewCenterPos - v3TrajectoryBeginPos
  local diveEffectEntity = fxsvc:CreateWorldPositionDirectionEffect(phaseParam:GetDiveTrajectoryEffectID(), v3TrajectoryBeginPos, v3TrajectoryDir)
  local csDiveEffectTransform = diveEffectEntity:View():GetGameObject().transform
  local tween = csDiveEffectTransform:DOMove(v3ViewCenterPos, phaseParam:GetDiveEffectFlyTime() * 0.001)
  local distance = Vector2.Distance(casterRenderPos, viewCenterPos)
  local speed = distance / phaseParam:GetDiveEffectFlyTime() * 1000
  casterEntity:AddGridMove(speed, viewCenterPos, casterRenderPos)
  while casterEntity:HasGridMove() do
    YIELD(TT)
  end
  if not tween:IsComplete() then
    tween:Complete()
  end
  local groundHitEffect = fxsvc:CreateCommonGridEffect(phaseParam:GetGroundHitEffectID(), viewCenterPos, viewDir)
  YIELD(TT, phaseParam:GetHitDelay())
  local taskids = {}
  local skillID = skillEffectResultContainer:GetSkillID()
  local playSkillService = self:SkillService()
  local damageResults = result:GetDamageResults()
  local playFinalAttack = skillEffectResultContainer:IsFinalAttack()
  for _, damageResult in ipairs(damageResults) do
    local target = damageResult:GetTargetID()
    local damageInfo = damageResult:GetDamageInfo(1)
    if target and 0 < target and damageInfo then
      local eTarget = self._world:GetEntityByID(target)
      local damageGridPos = damageResult:GetGridPos()
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(eTarget):SetHandleBeHitParam_HitAnimName("hit"):SetHandleBeHitParam_HitEffectID(0):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(1):SetHandleBeHitParam_DeathClear(0):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID):SetHandleBeHitParam_DamageIndex(1)
      local hitBackTaskID = TaskManager:GetInstance():CoreGameStartTask(playSkillService.HandleBeHit, playSkillService, beHitParam)
      if hitBackTaskID and 0 < hitBackTaskID then
        table.insert(taskids, hitBackTaskID)
      end
    end
  end
  YIELD(TT, phaseParam:GetDisappearDelay())
  casterEntity:SetViewVisible(false)
  local disappearEffect = fxsvc:CreateCommonGridEffect(phaseParam:GetDisappearEffectID(), viewCenterPos)
  YIELD(TT, phaseParam:GetAppearEffectDelay())
  local appearEffect = fxsvc:CreateCommonGridEffect(phaseParam:GetAppearEffectID(), casterRenderPos)
  YIELD(TT, phaseParam:GetAppearDelay())
  casterEntity:SetViewVisible(true)
  casterEntity:SetLocation(casterRenderPos)
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskids) do
    YIELD(TT)
  end
end

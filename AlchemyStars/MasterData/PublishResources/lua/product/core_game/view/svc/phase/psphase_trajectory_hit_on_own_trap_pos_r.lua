require("play_skill_phase_base_r")
_class("PlaySkillTrajectoryHitOnOwnTrapPosPhase", PlaySkillPhaseBase)
PlaySkillTrajectoryHitOnOwnTrapPosPhase = PlaySkillTrajectoryHitOnOwnTrapPosPhase

function PlaySkillTrajectoryHitOnOwnTrapPosPhase:PlayFlight(TT, casterEntity, phaseParam)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.Damage)
  if not result then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local ownTrapEntity
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    if e:HasSummoner() and e:Summoner():GetSummonerEntityID() == casterEntity:GetID() then
      ownTrapEntity = e
      break
    else
    end
  end
  if not ownTrapEntity then
    return
  end
  local targetEntityID = result:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  local casterGO = casterEntity:View():GetGameObject()
  local oldCasterPos = casterEntity:GetGridPosition()
  local oldCasterPosition = casterGO.transform.position
  local oldForward = casterGO.transform.forward
  local trapEntityPos = ownTrapEntity:GetGridPosition()
  local trapRenderPos = boardServiceRender:GridPos2RenderPos(trapEntityPos)
  local targetEntityPos = targetEntity:GetGridPosition()
  local attackDir = targetEntityPos - trapEntityPos
  local effectService = self._world:GetService("Effect")
  casterGO.transform.position = trapRenderPos
  casterGO.transform.forward = Vector3(attackDir.x, 0, attackDir.y)
  local waitTaskIDs = {}
  local monsterAnimTask = GameGlobal.TaskManager():CoreGameStartTask(self._DoMonsterAnim, self, casterEntity, ownTrapEntity, phaseParam)
  table.insert(waitTaskIDs, monsterAnimTask)
  local bulletTask = GameGlobal.TaskManager():CoreGameStartTask(self._DoBullet, self, casterEntity, targetEntity, phaseParam)
  table.insert(waitTaskIDs, bulletTask)
  local beHitTask = GameGlobal.TaskManager():CoreGameStartTask(self._DoBeHit, self, casterEntity, phaseParam)
  table.insert(waitTaskIDs, beHitTask)
  while not TaskHelper:GetInstance():IsAllTaskFinished(waitTaskIDs) do
    YIELD(TT)
  end
  casterGO.transform.position = oldCasterPosition
  casterGO.transform.forward = oldForward
end

function PlaySkillTrajectoryHitOnOwnTrapPosPhase:_DoMonsterAnim(TT, casterEntity, ownTrapEntity, phaseParam)
  local effectService = self._world:GetService("Effect")
  casterEntity:SetAnimatorControllerTriggers({
    phaseParam:GetCasterAnim()
  })
  local casterEffectID = phaseParam:GetCasterEffectID()
  if casterEffectID then
    effectService:CreateEffect(phaseParam:GetCasterEffectID(), casterEntity)
  end
  YIELD(TT, phaseParam:GetTotalTime())
end

function PlaySkillTrajectoryHitOnOwnTrapPosPhase:_DoBullet(TT, casterEntity, targetEntity, phaseParam)
  local effectService = self._world:GetService("Effect")
  local boardServiceRender = self._world:GetService("BoardRender")
  local playSkillService = self:SkillService()
  local bulletDelayTime = phaseParam:GetBulletStartDelay()
  YIELD(TT, bulletDelayTime)
  local casterBoneTransform = playSkillService:GetEntityRenderSelectBoneTransform(casterEntity, phaseParam:GetBulletBeginBindBone())
  local casterPos = casterBoneTransform.position
  local targetBoneTransform = playSkillService:GetEntityRenderSelectBoneTransform(targetEntity, phaseParam:GetBulletEndBindBone())
  local targetPos = targetBoneTransform.position
  local bulletFlyTime = phaseParam:GetBulletFlyTotalTime()
  local bulletEffectID = phaseParam:GetBulletEffectID()
  local bowlderEffectEntity = effectService:CreatePositionEffect(bulletEffectID, casterPos)
  YIELD(TT)
  local effectViewCmpt = bowlderEffectEntity:View()
  if effectViewCmpt then
    local effectObject = effectViewCmpt:GetGameObject()
    local posEffect = effectObject.transform.position
    local transWork = effectObject.transform
    transWork:DOMove(targetPos, bulletFlyTime / 1000, false)
  end
  YIELD(TT, bulletFlyTime)
end

function PlaySkillTrajectoryHitOnOwnTrapPosPhase:_DoBeHit(TT, casterEntity, phaseParam)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local result = routineComponent:GetEffectResultByArray(SkillEffectType.Damage)
  if not result then
    return
  end
  local delayTime = phaseParam:GetHitDelayTime()
  YIELD(TT, delayTime)
  local hitAnimName = phaseParam:GetHitAnim()
  local hitFxID = phaseParam:GetHitEffectID()
  local skillService = self:SkillService()
  local isFinalHit = routineComponent:IsFinalAttack()
  local skillID = routineComponent:GetSkillID()
  local damageResult = result
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local damageInfoArray = damageResult:GetDamageInfoArray()
  local posTarget = self:_GetEntityBasePos(targetEntity)
  for __, damageInfo in ipairs(damageInfoArray) do
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitFxID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(posTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(skillID)
    skillService:HandleBeHit(TT, beHitParam)
  end
end

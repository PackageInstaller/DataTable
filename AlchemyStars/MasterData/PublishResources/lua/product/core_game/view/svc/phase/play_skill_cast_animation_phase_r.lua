require("play_skill_phase_base_r")
_class("PlaySkillCastAnimationPhase", PlaySkillPhaseBase)
PlaySkillCastAnimationPhase = PlaySkillCastAnimationPhase

function PlaySkillCastAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local e = casterEntity
  if casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local cSuperEntity = casterEntity:SuperEntityComponent()
    e = cSuperEntity:GetSuperEntity()
  end
  local castAnimParam = phaseParam
  local castAnimName = castAnimParam:GetSkillCastEffectAnimationName()
  local castEffectIDArray = castAnimParam:GetSkillCastEffectIDArray()
  local castGridEffectIDArray = castAnimParam:GetSkillCastGridEffectIDArray()
  local buffNeedImmediatelyEffect = castAnimParam:GetBuffNeedImmediatelyEffect()
  local skillEffectResultContainer = e:SkillRoutine():GetResultContainer()
  local hideRoleTime = castAnimParam:GetHideRoleTime()
  local go = e:View().ViewWrapper.GameObject
  local animationLen = GameObjectHelper.GetActorAnimationLength(go, "atkult")
  if hideRoleTime then
    GameGlobal.TaskManager():CoreGameStartTask(PlaySkillCastAnimationPhase._ShowRoleAndHide, self, e, hideRoleTime)
  end
  YIELD(TT)
  local rotateToCenter = phaseParam:GetRotateToCenter()
  if rotateToCenter then
    local scopeResult = skillEffectResultContainer:GetScopeResult()
    local casterPos = e:GetGridPosition()
    local targetPos = scopeResult:GetCenterPos()
    local dir = targetPos - casterPos
    local gridDir = Vector2(dir.x, dir.z)
    e:SetDirection(gridDir)
  end
  e:SetAnimatorControllerTriggers({castAnimName})
  local effectTaskList = ArrayList:New()
  for _, effectData in ipairs(castEffectIDArray) do
    local borntaskid = GameGlobal.TaskManager():CoreGameStartTask(PlaySkillCastAnimationPhase._PlayEffectTask, self, e, effectData:GetSkillEffectID(), effectData:GetStartDelayTime())
    GetCurTask():Join(TT, borntaskid)
  end
  local casterPos = e:GridLocation():GetGridPos()
  local bodyArea = e:BodyArea():GetArea()
  if 0 < #bodyArea then
    local x, y = 0, 0
    for i = 1, #bodyArea do
      x = x + bodyArea[i].x
      y = y + bodyArea[i].y
    end
    x = x / #bodyArea
    y = y / #bodyArea
    casterPos = casterPos + Vector2(x, y)
  end
  for _, effectData in ipairs(castGridEffectIDArray) do
    local borntaskid = GameGlobal.TaskManager():CoreGameStartTask(PlaySkillCastAnimationPhase._PlayGridEffectTask, self, casterPos, effectData:GetSkillEffectID(), effectData:GetStartDelayTime())
    GetCurTask():Join(TT, borntaskid)
  end
  YIELD(TT)
  local finishDelayTime = castAnimParam:GetFinishDelayTime()
  YIELD(TT, finishDelayTime)
end

function PlaySkillCastAnimationPhase:_PlayEffectTask(TT, casterEntity, effectid, delay)
  YIELD(TT, delay)
  self._world:GetService("Effect"):CreateEffect(effectid, casterEntity)
end

function PlaySkillCastAnimationPhase:_PlayGridEffectTask(TT, gridPos, effectid, delay)
  YIELD(TT, delay)
  self._world:GetService("Effect"):CreateWorldPositionEffect(effectid, gridPos)
end

function PlaySkillCastAnimationPhase:_ShowRoleAndHide(TT, e, showTime)
  e:SetViewVisible(true)
  YIELD(TT, showTime)
  e:SetViewVisible(false)
end

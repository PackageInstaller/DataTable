require("play_skill_flight_base_r")
_class("PlaySkillTurnRoundFlightVehiclePhase", PlaySkillPhaseBase)
PlaySkillTurnRoundFlightVehiclePhase = PlaySkillTurnRoundFlightVehiclePhase

function PlaySkillTurnRoundFlightVehiclePhase:Constructor()
  self._bBack = false
end

function PlaySkillTurnRoundFlightVehiclePhase:_GetGridList(pet_entity)
  local skillEffectResultContainer = pet_entity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local ret = scopeResult:GetAttackRange()
  return ret
end

function PlaySkillTurnRoundFlightVehiclePhase:PlayFlight(TT, casterEntity, phaseParam)
  local chainGrid = self:_GetGridList(casterEntity)
  if chainGrid == nil then
    return
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local castPos = casterEntity:GetRenderGridPosition()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  self._bBack = false
  local targetGirdList, _, maxGridCount = InnerGameSortGridHelperRender:SortGrid(gridDataArray, castPos)
  for dir = 1, 8 do
    local targetGird = targetGirdList[dir]
    if #targetGird.gridList > 0 then
      local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoCrossToGridEdges, self, casterEntity, targetGird, phaseParam)
    end
  end
end

function PlaySkillTurnRoundFlightVehiclePhase:_DoCrossToGridEdges(TT, casterEntity, targetGird, phaseParam)
  local effectService = self._world:GetService("Effect")
  local boardServiceRender = self._world:GetService("BoardRender")
  local gridPosStart = casterEntity:GridLocation().Position
  local gridPosEnd = targetGird.gridList[#targetGird.gridList]
  local distance = Vector2.Distance(gridPosStart, gridPosEnd)
  local flyTime = phaseParam:GetFlyTime()
  local flyBackTime = phaseParam:GetFlyBackTime()
  local flyOneGridTime = flyTime / distance
  local flyBackOneGridTime = flyBackTime / distance
  local hitAnimName = phaseParam:GetHitAnimName()
  local hitEffectID = phaseParam:GetHitEffectID()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results1 = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, 1)
  for _, result in pairs(results1) do
    local targetEntityID = result:GetTargetID()
    local pos = result:GetGridPos()
    if table.intable(targetGird.gridList, pos) then
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        local hitTime = Vector2.Distance(pos, gridPosStart) * flyOneGridTime
        YIELD(TT, hitTime)
        local targetDamage = result:GetDamageInfo(1)
        self:_PlayAttackOnPos(TT, casterEntity, pos, targetEntityID, targetDamage, hitAnimName, hitEffectID)
      end)
    end
  end
  local results2 = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, 2)
  for _, result in pairs(results2) do
    local targetEntityID = result:GetTargetID()
    local pos = result:GetGridPos()
    if table.intable(targetGird.gridList, pos) then
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        local hitTime = Vector2.Distance(pos, gridPosEnd) * flyBackOneGridTime
        local backWaitTime = phaseParam:GetFlyBackStartWaitTime() + flyTime
        YIELD(TT, hitTime + backWaitTime)
        local targetDamage = result:GetDamageInfo(1)
        self:_PlayAttackOnPos(TT, casterEntity, pos, targetEntityID, targetDamage, hitAnimName, hitEffectID)
      end)
    end
  end
  local entityEffect = effectService:CreateWorldPositionDirectionEffect(phaseParam:GetFlyEffectID(), gridPosStart, targetGird.direction)
  YIELD(TT)
  local go = entityEffect:View():GetGameObject()
  local tran = go.transform
  local gridWorldpos = boardServiceRender:GridPos2RenderPos(gridPosEnd)
  tran:DOMove(gridWorldpos, phaseParam:GetFlyTime() / 1000.0, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, phaseParam:GetFlyTime())
  GameGlobal.TaskManager():CoreGameStartTask(self._DestroyEffect, self, entityEffect, phaseParam:GetFlyArriveDestory())
  YIELD(TT, phaseParam:GetFlyBackStartWaitTime())
  self._bBack = true
  local entityEffectBack = effectService:CreateWorldPositionDirectionEffect(phaseParam:GetFlyBackEffectID(), gridPosEnd, -targetGird.direction)
  YIELD(TT)
  local goBack = entityEffectBack:View():GetGameObject()
  local tranBack = goBack.transform
  local gridWorldposBack = boardServiceRender:GridPos2RenderPos(gridPosStart)
  tranBack:DOMove(gridWorldposBack, phaseParam:GetFlyBackTime() / 1000.0, false):SetEase(DG.Tweening.Ease.InOutSine)
  YIELD(TT, phaseParam:GetFlyBackTime())
  self._world:DestroyEntity(entityEffectBack)
end

function PlaySkillTurnRoundFlightVehiclePhase:_PlayAttackOnPos(TT, casterEntity, pos, targetEntityID, targetDamage, hitAnimName, hitEffectID)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
    local finalAttackTargetID = skillEffectResultContainer:GetFinalAttackEntityID()
    local skillID = skillEffectResultContainer:GetSkillID()
    if isFinalAttack == true and finalAttackTargetID == targetEntityID and self._bBack ~= nil and not self._bBack then
      isFinalAttack = false
    end
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(pos):SetHandleBeHitParam_HitTurnTarget(TurnToTargetType.Caster):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
    self:SkillService():HandleBeHit(TT, beHitParam)
  end
end

function PlaySkillTurnRoundFlightVehiclePhase:_DestroyEffect(TT, effectEntity, waitTime)
  YIELD(TT, waitTime)
  self._world:DestroyEntity(effectEntity)
end

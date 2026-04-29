require("play_skill_phase_base_r")
_class("PlaySkillLineFlyWithDirectionPhase", PlaySkillPhaseBase)
PlaySkillLineFlyWithDirectionPhase = PlaySkillLineFlyWithDirectionPhase

function PlaySkillLineFlyWithDirectionPhase:PlayFlight(TT, casterEntity, phaseParam)
  local param = phaseParam
  local boardServiceRender = self._world:GetService("BoardRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local castPos = casterEntity:GridLocation().Position
  self._casterPos = casterEntity:GridLocation().Position
  local worldPos = boardServiceRender:GridPos2RenderPos(castPos)
  local scope = skillEffectResultContainer:GetScopeResult()
  local gridRange = scope:GetAttackRange()
  local effectDirection = param:GetEffectDirection()
  self._beAttackPos = {}
  self._LineEffect = {}
  local targetList, maxLength = InnerGameSortGridHelperRender:SortGrid(gridRange, castPos)
  self._targetList = targetList
  YIELD(TT)
  self:_CreateEffect(targetList, castPos, param)
  self:_RotateEffect(TT, targetList, effectDirection)
  local knifeFylTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._StartEffectFly, self, casterEntity, castPos, targetList, maxLength, param, castPos)
end

function PlaySkillLineFlyWithDirectionPhase:_CreateEffect(targets, worldPos, phaseParam)
  local effectID = phaseParam:GetEffectID()
  for k, v in pairs(targets) do
    if v.gridpos ~= nil then
      local effectEntity = self._world:GetService("Effect"):CreateWorldPositionDirectionEffect(effectID, worldPos, v.direction)
      v.entity = effectEntity
    end
  end
end

function PlaySkillLineFlyWithDirectionPhase:_GetDirection(effectDirection)
  if effectDirection == "Bottom" then
    return 180
  elseif effectDirection == "Up" then
    return 0
  elseif effectDirection == "Left" then
    return 90
  elseif effectDirection == "Right" then
    return -90
  end
end

function PlaySkillLineFlyWithDirectionPhase:_RotateEffect(TT, targetList, effectDirection)
  YIELD(TT)
  for k, v in pairs(targetList) do
    local effectEntity = v.entity
    if effectEntity ~= nil then
      local go = effectEntity:View():GetGameObject()
      go.transform:Rotate(0, self:_GetDirection(effectDirection), 0)
    end
  end
end

function PlaySkillLineFlyWithDirectionPhase:_StartEffectFly(TT, castEntity, worldPos, targets, maxLength, phaseParam, castPos)
  local flyOneGridMs = phaseParam:GetEffectFlyOneGridMs()
  local boardServiceRender = self._world:GetService("BoardRender")
  YIELD(TT)
  local atklist = ArrayList:New()
  for k, v in pairs(targets) do
    local effectEntity = v.entity
    if effectEntity ~= nil then
      local gridpos = v.gridEdgePos
      local go = effectEntity:View():GetGameObject()
      local tran = go.transform
      v.tran = go.transform
      local gridWorldpos = boardServiceRender:GridPos2RenderPos(gridpos)
      local disx = math.abs(gridpos.x - castPos.x)
      local disy = math.abs(gridpos.y - castPos.y)
      local dis = math.max(disx, disy)
      v.FinalWorldPos = gridWorldpos
      Log.notice("[skill] PlaySkillService:_StartKnifeFly from ", castPos.x, castPos.y, " to ", gridpos.x, gridpos.y)
      self:_EffectMove(tran, gridWorldpos, dis, flyOneGridMs)
    end
  end
  self:_CheckFlyAttack(TT, targets, maxLength, boardServiceRender, castEntity, phaseParam, atklist)
end

function PlaySkillLineFlyWithDirectionPhase:_CheckFlyAttack(TT, targets, maxLength, boardServiceRender, casterEntity, phaseParam)
  local flyOneGridMs = phaseParam:GetEffectFlyOneGridMs()
  local hitAnimName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffect()
  local totaltime = self:_GetFlyTime(maxLength, flyOneGridMs)
  local endtime = GameGlobal:GetInstance():GetCurrentTime() + totaltime
  local continue = true
  while continue do
    continue = false
    for k, v in pairs(targets) do
      local effectEntity = v.entity
      if effectEntity ~= nil then
        continue = true
        local tran = v.tran
        local flypos = boardServiceRender:BoardRenderPos2GridPos(tran.position)
        if v.flypos ~= flypos then
          if phaseParam:HasDamage() then
            self:_HandlePlayFlyAttack(casterEntity, flypos, hitAnimName, hitEffectID, phaseParam:HitTurnToTarget())
          end
          v.flypos = flypos
        end
        if tran.position == v.FinalWorldPos then
          local go = effectEntity:View():GetGameObject()
          go:SetActive(false)
          self._world:DestroyEntity(effectEntity)
          v.entity = nil
        end
      end
    end
    YIELD(TT)
  end
end

function PlaySkillLineFlyWithDirectionPhase:_GetFlyTime(maxLength, flyOneGridMs)
  return flyOneGridMs * maxLength
end

function PlaySkillLineFlyWithDirectionPhase:_EffectMove(tran, gridWorldPos, disx, flyOneGridMs)
  tran:DOMove(gridWorldPos, disx * flyOneGridMs / 1000.0):SetEase(DG.Tweening.Ease.InOutSine)
end

function PlaySkillLineFlyWithDirectionPhase:_HandlePlayFlyAttack(casterEntity, flypos, hitAnimName, hitEffectID, hitTurnToTarget)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local results = skillEffectResultContainer:GetEffectResultsAsPosDic(SkillEffectType.Damage)
  local boardServiceRender = self._world:GetService("BoardRender")
  if not results then
    return
  end
  for posIdx, res in pairs(results) do
    local pos = Vector2.Index2Pos(posIdx)
    if self:IsAttackDataNeedBeHit(flypos, pos) and boardServiceRender:IsInPlayerArea(pos) then
      local targetEntityID = res:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity ~= nil then
        local targetDamage = res:GetDamageInfo(1)
        Log.debug("[skill] PlaySkillService:_HandlePlayFlyAttack ", targetEntityID, hitAnimName)
        if isFinalAttack == true and self._bBack ~= nil and not self._bBack then
          isFinalAttack = false
        end
        local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(flypos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
        local damageTextPos = targetEntity:GridLocation().Position
        GameGlobal.TaskManager():CoreGameStartTask(self:SkillService().HandleBeHit, self:SkillService(), beHitParam)
      end
    end
  end
end

function PlaySkillLineFlyWithDirectionPhase:CompPos2Caster(flyPos, resultPos, dir)
  if dir == Vector2(0, 1) or dir == Vector2(1, 1) or dir == Vector2(-1, 1) then
    return flyPos.y >= resultPos.y
  elseif dir == Vector2(1, 0) then
    return flyPos.x >= resultPos.x
  elseif dir == Vector2(0, -1) or dir == Vector2(-1, -1) or dir == Vector2(1, -1) then
    return flyPos.y <= resultPos.y
  elseif dir == Vector2(-1, 0) then
    return flyPos.x <= resultPos.x
  else
    return false
  end
end

function PlaySkillLineFlyWithDirectionPhase:IsAttackDataNeedBeHit(flyPos, resultPos)
  local flyDir = Vector2.Normalize(flyPos - self._casterPos)
  local resultDir = Vector2.Normalize(resultPos - self._casterPos)
  if flyDir.x == resultDir.x and flyDir.y == resultDir.y and not self:IsPosBeAttack(resultPos) and self:CompPos2Caster(flyPos, resultPos, flyDir) then
    table.insert(self._beAttackPos, resultPos)
    return true
  end
  return false
end

function PlaySkillLineFlyWithDirectionPhase:IsPosBeAttack(pos)
  for i, v in ipairs(self._beAttackPos) do
    if v.x == pos.x and v.y == pos.y then
      return true
    end
  end
  return false
end

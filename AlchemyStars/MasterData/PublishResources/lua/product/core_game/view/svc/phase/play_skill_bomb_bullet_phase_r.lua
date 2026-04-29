require("play_skill_phase_base_r")
_class("PlaySkillBombBulletPhase", PlaySkillPhaseBase)
PlaySkillBombBulletPhase = PlaySkillBombBulletPhase

function PlaySkillBombBulletPhase:PlayFlight(TT, casterEntity, phaseParam)
  local bulletEffectId = phaseParam:GetBulletEffectId()
  local oneGridFlyTime = phaseParam:GetOnGridFlyTime()
  local bombEffectId = phaseParam:GetBombEffectId()
  local bombDelayTime = phaseParam:GetBombDelayTime()
  local bombEffectId2 = phaseParam:GetBombEffectId2()
  local damageDelayTime = phaseParam:GetDamageDelayTime()
  local hitAnimName = phaseParam:GetHitAnimName()
  local hitEffectID = phaseParam:GetHitEffectId()
  local delayTime = phaseParam:GetDelayTime()
  local audioId = phaseParam:GetAudioId()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local damageResultArr = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultArr then
    return
  end
  local effectService = self._world:GetService("Effect")
  local boardServiceRender = self._world:GetService("BoardRender")
  local castPos = casterEntity:GridLocation().Position
  local castRenderPos = boardServiceRender:GridPos2RenderPos(castPos)
  local bombPos = scopeResult:GetCenterPos()
  local bombRenderPos = boardServiceRender:GridPos2RenderPos(bombPos)
  if 0 < bulletEffectId then
    local flyDir = bombPos - castPos
    local bulletEffectEntity = effectService:CreateWorldPositionDirectionEffect(bulletEffectId, castPos, flyDir)
    YIELD(TT)
    local distance = Vector3.Distance(castRenderPos, bombRenderPos)
    local flyTime = distance * oneGridFlyTime
    local bulletGo = bulletEffectEntity:View():GetGameObject()
    local dotween
    bulletGo.transform:DOMove(bombRenderPos, flyTime / 1000, false)
    YIELD(TT, flyTime)
    self._world:DestroyEntity(bulletEffectEntity)
  end
  local bombEffectEntity = effectService:CreatePositionEffect(bombEffectId, bombRenderPos)
  YIELD(TT, bombDelayTime)
  local bombEffectEntity2
  if 0 < bombEffectId2 then
    bombEffectEntity2 = effectService:CreatePositionEffect(bombEffectId2, bombRenderPos)
  end
  YIELD(TT, damageDelayTime)
  AudioHelperController.PlayInnerGameSfx(audioId)
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
  for i = 1, #damageResultArr do
    local damageResult = damageResultArr[i]
    local targetEntity = self._world:GetEntityByID(damageResult:GetTargetID())
    self:_ShowDamage(damageResult:GetDamageInfo(1), targetEntity, isFinalAttack, hitAnimName, hitEffectID, casterEntity, damageResult:GetGridPos(), false, skillID)
  end
  YIELD(TT, delayTime)
  if bombEffectEntity then
    self._world:DestroyEntity(bombEffectEntity)
  end
  if bombEffectEntity2 then
    self._world:DestroyEntity(bombEffectEntity2)
  end
end

function PlaySkillBombBulletPhase:_ShowDamage(damageInfo, targetEntity, isFinalAttack, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  if targetEntity ~= nil then
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(self:SkillService().HandleBeHit, self:SkillService(), beHitParam)
  end
end

function PlaySkillBombBulletPhase:_GetFlyTargetPos(chainGrid, castPos)
  local leftup, leftbottom, rightbottom, rightup, up, bottom, right, left
  local maxLength = 0
  for i, pos in pairs(chainGrid) do
    local dis = pos - castPos
    if maxLength < math.abs(dis.x) then
      maxLength = math.abs(dis.x)
    end
    if maxLength < math.abs(dis.y) then
      maxLength = math.abs(dis.y)
    end
    if 0 < dis.x and 0 < dis.y then
      if rightbottom == nil or rightbottom.x < pos.x then
        rightbottom = pos
      end
    elseif 0 < dis.x and 0 > dis.y then
      if leftbottom == nil or leftbottom.x < pos.x then
        leftbottom = pos
      end
    elseif 0 > dis.x and 0 > dis.y then
      if leftup == nil or leftup.x > pos.x then
        leftup = pos
      end
    elseif 0 > dis.x and 0 < dis.y then
      if rightup == nil or rightup.x > pos.x then
        rightup = pos
      end
    elseif dis.x == 0 and 0 < dis.y then
      if right == nil or right.y < pos.y then
        right = pos
      end
    elseif dis.x == 0 and 0 > dis.y then
      if left == nil or left.y > pos.y then
        left = pos
      end
    elseif 0 < dis.x and dis.y == 0 then
      if bottom == nil or bottom.x < pos.x then
        bottom = pos
      end
    elseif 0 > dis.x and dis.y == 0 and (up == nil or up.x > pos.x) then
      up = pos
    end
  end
  local targets = {
    {gridpos = leftup},
    {gridpos = leftbottom},
    {gridpos = rightbottom},
    {gridpos = rightup},
    {gridpos = up},
    {gridpos = bottom},
    {gridpos = right},
    {gridpos = left}
  }
  return targets, maxLength
end

function PlaySkillBombBulletPhase:_GetGridList(pet_entity)
  local chainGrid = {}
  local selectComponent = pet_entity:ActiveSkillMutilSelectGridComponent()
  if selectComponent ~= nil then
    chainGrid = selectComponent:GetDirectGridPosArray()
  end
  return chainGrid
end

function PlaySkillBombBulletPhase:_GetSkillScope(chainGrid, petSkillRoutine)
  local tmpChainGrid = {}
  local skillScope = chainGrid
  for index, value in ipairs(chainGrid) do
    table.insert(tmpChainGrid, value)
  end
  return tmpChainGrid
end

function PlaySkillBombBulletPhase:_StartFly(TT, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  local effectService = self._world:GetService("Effect")
  local bulletEffectId = phaseParam:GetBulletEffectId()
  if bulletEffectId <= 0 then
    return
  end
  local oneGridFlyTime = phaseParam:GetOnGridFlyTime()
  local waitTime = 0
  for k, v in pairs(targets) do
    if v.gridpos ~= nil then
      local posDirectory = v.gridpos - castPos
      local effectEntity = effectService:CreateWorldPositionDirectionEffect(bulletEffectId, castPos, posDirectory)
      v.entity = effectEntity
    end
  end
  YIELD(TT)
  for k, v in pairs(targets) do
    local effectEntity = v.entity
    if effectEntity ~= nil then
      local gridpos = v.gridpos
      local go = effectEntity:View():GetGameObject()
      local gridWorldpos = boardServiceRender:GridPos2RenderPos(gridpos)
      local dis = Vector2.Distance(gridpos, castPos)
      local flyTime = dis * oneGridFlyTime / 1000.0
      go.transform:DOMove(gridWorldpos, flyTime, false)
      if waitTime < flyTime then
        waitTime = flyTime
      end
    end
  end
  YIELD(TT, waitTime)
end

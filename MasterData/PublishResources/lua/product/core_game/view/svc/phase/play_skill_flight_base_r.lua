require("play_skill_phase_base_r")
_class("PlaySkillFlightBase", PlaySkillPhaseBase)
PlaySkillFlightBase = PlaySkillFlightBase

function PlaySkillFlightBase:_GetElapseTick()
  return math.floor(GameGlobal:GetInstance():GetCurrentTime() - self._startTick)
end

function PlaySkillFlightBase:_GetSkillScope(chainGrid, petSkillRoutine)
  local tmpChainGrid = {}
  local skillScope = petSkillRoutine:GetScopeResult()._attackGridRange
  for index, value in ipairs(chainGrid) do
    local inScope = false
    for k, v in ipairs(skillScope) do
      if value.x == v.x and value.y == v.y then
        inScope = true
        break
      else
      end
    end
    if inScope then
      table.insert(tmpChainGrid, value)
    end
  end
  return tmpChainGrid
end

function PlaySkillFlightBase:PlayFlight(TT, casterEntity, phaseParam)
  self._startTick = GameGlobal:GetInstance():GetCurrentTime()
  local pet_entity = casterEntity
  local petSkillRoutine = pet_entity:SkillRoutine():GetResultContainer()
  local chainGrid = self:_GetGridList(pet_entity)
  if chainGrid == nil then
    return
  end
  if petSkillRoutine:IsFinalAttack() then
    local finalEnemyEntityID = self:_SortForFinalAttack(casterEntity)
    petSkillRoutine:SetFinalAttackEntityID(finalEnemyEntityID)
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local tmpChainGrid = self:_GetSkillScope(chainGrid, petSkillRoutine)
  local castPos = casterEntity:GridLocation().Position
  local worldPos = boardServiceRender:GridPos2RenderPos(castPos)
  local targets, maxLength = self:_GetFlyTargetPos(tmpChainGrid, castPos)
  self.finalAttack = false
  local bornEffectID = phaseParam:GetBornEffectID()
  local lineEffectID = phaseParam.GetLineEffectID and phaseParam:GetLineEffectID()
  local jumpEffectID = phaseParam.GetJumpEffectID and phaseParam:GetJumpEffectID()
  local finishWaitTime = phaseParam.GetFinishWaitTime and phaseParam:GetFinishWaitTime()
  YIELD(TT)
  if bornEffectID and 0 < bornEffectID then
    local borntaskid = GameGlobal.TaskManager():CoreGameStartTask(PlaySkillFlightBase._PlayBornEffect, self, targets, boardServiceRender, castPos, worldPos, phaseParam)
    GetCurTask():Join(TT, borntaskid)
  end
  local flytaskid = GameGlobal.TaskManager():CoreGameStartTask(PlaySkillFlightBase._StartFly, self, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  GetCurTask():Join(TT, flytaskid)
  if lineEffectID and 0 < lineEffectID then
    maxLength = 2
    local linetaskid = GameGlobal.TaskManager():CoreGameStartTask(PlaySkillFlightBase._PlayLineEffect, self, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
    GetCurTask():Join(TT, linetaskid)
  end
  if jumpEffectID and 0 < jumpEffectID then
    local jumptaskid = GameGlobal.TaskManager():CoreGameStartTask(PlaySkillFlightBase._PlayJumpAndDropEffect, self, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
    GetCurTask():Join(TT, jumptaskid)
  end
  if finishWaitTime and 0 < finishWaitTime then
    YIELD(TT, finishWaitTime)
  end
  self:_PlayDisaprearEffect(targets, phaseParam, castPos)
  self:_DestoryEffect(targets)
  self:_OnEnd(TT, casterEntity, phaseParam)
end

function PlaySkillFlightBase:_GetFlyTime(maxLength, phaseParam)
  return maxLength, maxLength
end

function PlaySkillFlightBase:_GetFlyTargetPos(chainGrid, castPos)
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

function PlaySkillFlightBase:_PlayBornEffect(TT, targets, boardServiceRender, castPos, worldPos, phaseParam)
  YIELD(TT, self:_GetBornEffectDelay(phaseParam))
  local bornEffect = self:_GetBornEffectID(phaseParam)
  for k, v in pairs(targets) do
    if v.gridpos ~= nil then
      local gridpos = v.gridpos
      local disx = gridpos.x - castPos.x
      local disy = gridpos.y - castPos.y
      if disx ~= 0 then
        disx = disx / math.abs(disx)
      end
      if disy ~= 0 then
        disy = disy / math.abs(disy)
      end
      local effectGrid = Vector2(castPos.x + disx, castPos.y + disy)
      local gridWorldpos = boardServiceRender:GridPos2RenderPos(effectGrid)
      local effectEntity = self._world:GetService("Effect"):CreatePositionEffect(bornEffect, gridWorldpos)
      v.bornEffect = effectEntity
      Log.notice(self:_GetElapseTick(), "[flight] play born effect ", effectGrid.x, ",", effectGrid.y)
    end
  end
end

function PlaySkillFlightBase:_StartFly(TT, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  YIELD(TT, self:_GetFlyStartMs(phaseParam))
  local flyEffectID = self:_GetGridEffectID(phaseParam)
  local effectService = self._world:GetService("Effect")
  for k, v in pairs(targets) do
    if v.gridpos ~= nil then
      local posDirectory = v.gridpos - castPos
      local effectEntity = effectService:CreateWorldPositionDirectionEffect(flyEffectID, castPos, posDirectory)
      v.entity = effectEntity
    end
  end
  YIELD(TT)
  local flyOneGridMs = self:_GetFlyOneGridMS(phaseParam)
  for k, v in pairs(targets) do
    local effectEntity = v.entity
    if effectEntity ~= nil then
      local gridpos = v.gridpos
      local go = effectEntity:View():GetGameObject()
      local tran = go.transform
      v.tran = go.transform
      local gridWorldpos = boardServiceRender:GridPos2RenderPos(gridpos)
      local disx = math.abs(gridpos.x - castPos.x)
      local disy = math.abs(gridpos.y - castPos.y)
      local dis = math.max(disx, disy)
      Log.debug("[skill] PlaySkillService:_PlayFlightVehiclePhase from ", castPos.x, castPos.y, " to ", gridpos.x, gridpos.y)
      self:_Move(go, tran, worldPos, gridWorldpos, dis, flyOneGridMs, phaseParam)
    end
  end
  self:_CheckFlyAttack(TT, targets, maxLength, castPos, pet_entity, phaseParam)
end

function PlaySkillFlightBase:_PlayLineEffect(TT, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  if self._PlayLineEffectImp ~= nil then
    self:_PlayLineEffectImp(TT, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  end
end

function PlaySkillFlightBase:_PlayJumpAndDropEffect(TT, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  if self._PlayJumpAndDropEffectImp ~= nil then
    self:_PlayJumpAndDropEffectImp(TT, pet_entity, targets, boardServiceRender, castPos, worldPos, maxLength, phaseParam)
  end
end

function PlaySkillFlightBase:_CheckFlyAttack(TT, targets, maxLength, castPos, casterEntity, phaseParam)
  local flyOneGridMs = self:_GetFlyOneGridMS(phaseParam)
  local hitAnimName = self:_GetHitAnimName(phaseParam)
  local hitEffectID = self:_GetHitEffectID(phaseParam)
  local totaltime, halftime = self:_GetFlyTime(maxLength, phaseParam)
  local endtime = GameGlobal:GetInstance():GetCurrentTime() + totaltime
  local stayTime = phaseParam.GetStayMs and phaseParam:GetStayMs()
  if stayTime and 0 < stayTime then
    endtime = endtime + stayTime
  end
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = self:_GetSkillEffectResult(skillEffectResultContainer)
  local boardServiceRender = self._world:GetService("BoardRender")
  if results == nil then
    return
  end
  for _, result in pairs(results) do
    local pos = result:GetGridPos()
    local hitTime = Vector2.Distance(pos, castPos) * flyOneGridMs
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, hitTime)
      self:_PlayAttackOnPos(TT, casterEntity, pos, result, hitAnimName, hitEffectID)
    end)
  end
end

function PlaySkillFlightBase:_PlayAttackOnPos(TT, casterEntity, pos, result, hitAnimName, hitEffectID)
  local boardServiceRender = self._world:GetService("BoardRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  if boardServiceRender:IsInPlayerArea(pos) then
    local targetEntityID = result:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity ~= nil then
      local targetDamage = self:_GetDamage(result)
      Log.debug("[skill] PlaySkillService:_HandlePlayFlyAttack ", targetEntityID, hitAnimName)
      local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
      local finalAttackTargetID = skillEffectResultContainer:GetFinalAttackEntityID()
      local skillID = skillEffectResultContainer:GetSkillID()
      if isFinalAttack == true and finalAttackTargetID == targetEntityID and self._bBack ~= nil and not self._bBack then
        isFinalAttack = false
      end
      local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(pos):SetHandleBeHitParam_HitTurnTarget(true):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
      self:SkillService():HandleBeHit(TT, beHitParam)
    end
  end
end

function PlaySkillFlightBase:_DestoryEffect(targets)
  for k, v in pairs(targets) do
    local effectEntity = v.entity
    if effectEntity ~= nil then
      self._world:DestroyEntity(effectEntity)
    end
    local bornEffect = v.bornEffect
    if bornEffect ~= nil then
      self._world:DestroyEntity(bornEffect)
    end
    local lineEffect = v.lineEffect
    if lineEffect ~= nil then
      self._world:DestroyEntity(lineEffect)
    end
  end
end

function PlaySkillFlightBase:_PlayDisaprearEffect(targets, phaseParam, castPos)
  local effectService = self._world:GetService("Effect")
  local disapearEffectID = self:_GetDisappearEffectID(phaseParam)
  for k, v in pairs(targets) do
    if v.entity ~= nil then
      local dir = v.gridpos - castPos
      local disapearEffect = effectService:CreateWorldPositionDirectionEffect(disapearEffectID, v.gridpos, dir)
    end
  end
end

function PlaySkillFlightBase:_HandlePlayFlyAttack(TT, casterEntity, flypos, hitAnimName, hitEffectID, atklist, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = self:_GetSkillEffectResult(skillEffectResultContainer)
  local boardServiceRender = self._world:GetService("BoardRender")
  if results == nil then
    return
  end
  for _, result in pairs(results) do
    local pos = result:GetGridPos()
    if pos.x == flypos.x and pos.y == flypos.y and boardServiceRender:IsInPlayerArea(pos) then
      local targetEntityID = result:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity ~= nil then
        local targetDamage = self:_GetDamage(result)
        Log.debug("[skill] PlaySkillService:_HandlePlayFlyAttack ", targetEntityID, hitAnimName)
        local isFinalAttack = skillEffectResultContainer:IsFinalAttack()
        local finalAttackTargetID = skillEffectResultContainer:GetFinalAttackEntityID()
        local skillID = skillEffectResultContainer:GetSkillID()
        if isFinalAttack == true and finalAttackTargetID == targetEntityID and self._bBack ~= nil and not self._bBack then
          isFinalAttack = false
        end
        local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(pos):SetHandleBeHitParam_HitTurnTarget(phaseParam:HitTurnToTarget()):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
        self:SkillService():HandleBeHit(TT, beHitParam)
      end
    end
  end
end

function PlaySkillFlightBase:_GetSkillEffectResult(skillEffectResultContainer)
  return skillEffectResultContainer:GetEffectResultsAsPosDic(SkillEffectType.Damage)
end

function PlaySkillFlightBase:_GetGridList(pet_entity)
  return nil
end

function PlaySkillFlightBase:_GetFlyOneGridMS(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetGridEffectID(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetHitAnimName(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetHitEffectID(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetBornEffectID(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetBornEffectDelay(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetDisappearEffectID(phaseParam)
  return 0
end

function PlaySkillFlightBase:_GetFlyStartMs(phaseParam)
end

function PlaySkillFlightBase:_Move(go, tran, worldPos, gridWorldpos, disx, flyOneGridMs, phaseParam)
end

function PlaySkillFlightBase:_GetDamage(res)
  return res:GetDamageInfo(1)
end

function PlaySkillFlightBase:_OnEnd(TT, casterEntity, phaseParam)
end

function PlaySkillFlightBase:_SortForFinalAttack(casterEntity)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local casterPos = casterEntity:GridLocation().Position
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  
  local function CmpDistancefunc(skillDamageEffectResult1, skillDamageEffectResult2)
    local dis1 = self:_GetDistanceToCaster(casterPos, skillDamageEffectResult1)
    local dis2 = self:_GetDistanceToCaster(casterPos, skillDamageEffectResult2)
    return dis1 > dis2
  end
  
  table.sort(results, CmpDistancefunc)
  for _, v in ipairs(results) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity ~= nil and targetEntity:HasDeadFlag() then
      return targetEntityID
    end
  end
end

function PlaySkillFlightBase:_GetDistanceToCaster(casterPos, skillDamageResult)
  local gridPos = skillDamageResult:GetGridPos()
  return Vector2.Distance(gridPos, casterPos)
end

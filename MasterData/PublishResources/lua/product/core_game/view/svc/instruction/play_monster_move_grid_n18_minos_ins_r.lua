require("base_ins_r")
_class("PlayMonsterMoveGridN18MinosInstruction", BaseInstruction)
PlayMonsterMoveGridN18MinosInstruction = PlayMonsterMoveGridN18MinosInstruction

function PlayMonsterMoveGridN18MinosInstruction:Constructor(paramList)
  self._ghostEffectID = tonumber(paramList.ghostEffectID)
  self._ghostAttackWaitTime = tonumber(paramList.ghostAttackWaitTime)
  self._ghostAttackAudioID = tonumber(paramList.ghostAttackAudioID)
  self._ghostAttackAudioWaitTime = tonumber(paramList.ghostAttackAudioWaitTime)
  self._lastCastEffectID = tonumber(paramList.lastCastEffectID)
  self._ghostLineEffectID = tonumber(paramList.ghostLineEffectID)
  self._castLineEffectID = tonumber(paramList.castLineEffectID)
  self._castAttackWaitTime = tonumber(paramList.castAttackWaitTime)
  self._castAttackAudioID = tonumber(paramList.castAttackAudioID)
  self._castAttackAudioWaitTime = tonumber(paramList.castAttackAudioWaitTime)
  self._ghostHitEffectID = tonumber(paramList.ghostHitEffectID)
  self._castHitEffectID = tonumber(paramList.castHitEffectID)
  self._hitAnimName = paramList.hitAnimName or "Hit"
  self._attackAnimName = paramList.attackAnimName
  self._lineSpeed = tonumber(paramList.lineSpeed)
  self._ghostLineOffsetX = tonumber(paramList.ghostLineOffsetX)
  self._ghostLineOffsetY = tonumber(paramList.ghostLineOffsetY)
  self._ghostLineOffsetZ = tonumber(paramList.ghostLineOffsetZ)
  self._castLineOffsetX = tonumber(paramList.castLineOffsetX)
  self._castLineOffsetY = tonumber(paramList.castLineOffsetY)
  self._castLineOffsetZ = tonumber(paramList.castLineOffsetZ)
end

function PlayMonsterMoveGridN18MinosInstruction:GetCacheAudio()
  local t = {}
  if self._ghostAttackAudioID and self._ghostAttackAudioID > 0 then
    table.insert(t, self._ghostAttackAudioID)
  end
  if self._castAttackAudioID and 0 < self._castAttackAudioID then
    table.insert(t, self._castAttackAudioID)
  end
  return t
end

function PlayMonsterMoveGridN18MinosInstruction:GetCacheResource()
  local t = {}
  if self._ghostEffectID and self._ghostEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._ghostEffectID].ResPath,
      1
    })
  end
  if self._lastCastEffectID and 0 < self._lastCastEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._ghostEffectID].ResPath,
      1
    })
  end
  if self._ghostLineEffectID and 0 < self._ghostLineEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._ghostEffectID].ResPath,
      1
    })
  end
  if self._castLineEffectID and 0 < self._castLineEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._ghostEffectID].ResPath,
      1
    })
  end
  if self._ghostHitEffectID and 0 < self._ghostHitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._ghostEffectID].ResPath,
      1
    })
  end
  if self._castHitEffectID and 0 < self._castHitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._ghostEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayMonsterMoveGridN18MinosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MonsterMoveLongestGrid)
  self._walkAttackList = {}
  self._skillID = skillEffectResultContainer:GetSkillID()
  if not results then
    Log.fatal("no results")
    return
  end
  local result = results[1]
  self._world = casterEntity:GetOwnerWorld()
  self.casterEntity = casterEntity
  self._effectSvc = self._world:GetService("Effect")
  self._playSkillInsSvc = self._world:GetService("PlaySkillInstruction")
  local walkResultList = result:GetWalkResultList()
  local casterIsDead = result:IsCasterDead()
  self._attackGhostEntityList = {}
  self._waitTaskID = {}
  if 0 < #walkResultList then
    self:_DoWalk(TT, casterEntity, walkResultList, casterIsDead)
  end
  local damageResult = result:GetFinalAttackResult()
  if damageResult then
    self._castEffectEntity = self._effectSvc:CreateEffect(self._lastCastEffectID, casterEntity)
    casterEntity:SetAnimatorControllerTriggers({
      self._attackAnimName
    })
    self._playSkillInsSvc:PlayAttackAudio(self._castAttackAudioWaitTime, casterEntity, self._castAttackAudioID)
    local casterPos = casterEntity:GetRenderGridPosition()
    local targetID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetID)
    local targetPos = targetEntity:GetRenderGridPosition()
    local dir = targetPos - casterPos
    casterEntity:SetDirection(dir)
    local lineEffectPos = casterEntity:View():GetGameObject().transform:TransformPoint(Vector3(self._castLineOffsetX, self._castLineOffsetY, self._castLineOffsetZ))
    local castAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(self.PlayBeHit, self, casterEntity, targetEntity, self._castLineEffectID, self._castHitEffectID, damageResult, self._castAttackWaitTime, lineEffectPos)
    table.insert(self._waitTaskID, castAttackTaskID)
  end
  local trapResultArray = result:GetSummonTrapResultList()
  if trapResultArray then
    for i = 1, #trapResultArray do
      local result = trapResultArray[i]
      local index = i
      local taskID = GameGlobal.TaskManager():StartTask(function()
        self:_ShowTrapFromSummonTrap(TT, self._world, result)
      end)
      table.insert(self._waitTaskID, taskID)
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(self._waitTaskID) do
    YIELD(TT)
  end
end

function PlayMonsterMoveGridN18MinosInstruction:_DoWalk(TT, monsterEntity, walkResultList, casterIsDead)
  local boardServiceRender = self._world:GetService("BoardRender")
  local moveSpeed = self:_GetMoveSpeed(monsterEntity)
  local hasWalkPoint = false
  if 0 < #walkResultList then
    hasWalkPoint = true
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, true)
    boardServiceRender:RefreshPiece(monsterEntity, true, true)
  end
  local pieceSvc = self._world:GetService("Piece")
  local lastWalkResult = walkResultList[#walkResultList]
  local lastPos = lastWalkResult:GetWalkPos()
  for _, v in ipairs(walkResultList) do
    local walkRes = v
    local walkPos = walkRes:GetWalkPos()
    local boardServiceRender = self._world:GetService("BoardRender")
    local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
    monsterEntity:AddGridMove(moveSpeed, walkPos, curPos)
    local walkDir = walkPos - curPos
    local bodyAreaCmpt = monsterEntity:BodyArea()
    local areaCount = bodyAreaCmpt:GetAreaCount()
    if areaCount == 4 then
      local leftDownPos = Vector2(curPos.x - 0.5, curPos.y - 0.5)
      walkDir = walkPos - leftDownPos
    end
    monsterEntity:SetDirection(walkDir)
    local newGridType = walkRes:GetNewGridType()
    while monsterEntity:HasGridMove() do
      YIELD(TT)
    end
    self:_PlayArrivePos(TT, monsterEntity, walkRes, lastPos)
    pieceSvc:SetPieceAnimMoveDone(walkPos)
  end
  for _, v in ipairs(walkResultList) do
    local walkRes = v
    local walkPos = walkRes:GetWalkPos()
    local newGridType = walkRes:GetNewGridType()
    local gridEntity = boardServiceRender:ReCreateGridEntity(newGridType, walkPos, false, true)
    pieceSvc:SetPieceEntityAnimNormal(gridEntity)
    pieceSvc:SetPieceEntityBirth(gridEntity)
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, false)
    boardServiceRender:RefreshPiece(monsterEntity, false, true)
  end
  if casterIsDead then
    local sMonsterShowRender = self._world:GetService("MonsterShowRender")
    sMonsterShowRender:_DoOneMonsterDead(TT, monsterEntity)
  end
end

function PlayMonsterMoveGridN18MinosInstruction:_PlayArrivePos(TT, monsterEntity, walkRes, lastPos)
  local trapResList = walkRes:GetWalkTrapResultList()
  for _, v in ipairs(trapResList) do
    local walkTrapRes = v
    local trapEntityID = walkTrapRes:GetTrapEntityID()
    local trapEntity = self._world:GetEntityByID(trapEntityID)
    local trapSkillRes = walkTrapRes:GetTrapResult()
    local skillEffectResultContainer = trapSkillRes:GetResultContainer()
    trapEntity:SkillRoutine():SetResultContainer(skillEffectResultContainer)
    Log.debug("[AIMove] PlayArrivePos() monster=", monsterEntity:GetID(), " pos=", walkRes:GetWalkPos(), " play trapid=", trapEntity:GetID(), " defender=", skillEffectResultContainer:GetScopeResult():GetTargetIDs()[1])
    local trapSvc = self._world:GetService("TrapRender")
    trapSvc:PlayTrapTriggerSkill(TT, trapEntity, false, monsterEntity)
  end
  local flushTrapID = walkRes:GetFlushTrapID()
  if flushTrapID then
    local trapEntity = self._world:GetEntityByID(flushTrapID)
    trapEntity:SetViewVisible(false)
    local playBuffSvc = self._world:GetService("PlayBuff")
    playBuffSvc:PlayBuffView(TT, NTMinosAbsorbTrap:New(trapEntity))
  end
  local damageResult = walkRes:GetAttackResult()
  if damageResult then
    local pos = walkRes:GetWalkPos()
    table.insert(self._walkAttackList, pos)
    if pos == lastPos then
      local utilData = self._world:GetService("UtilData")
      local bFind = false
      for i = 1, 8 do
        local ringPosList = ComputeScopeRange.ComputeRange_SquareRing(pos, 1, i)
        for _, newPos in ipairs(ringPosList) do
          if not utilData:IsPosBlock(newPos, BlockFlag.MonsterLand) and not table.Vector2Include(self._walkAttackList, newPos) then
            pos = newPos
            bFind = true
            break
          end
        end
        if bFind then
          break
        end
      end
    end
    local targetID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetID)
    local targetPos = targetEntity:GetGridPosition()
    local dir = targetPos - pos
    local ghostEntity = self._effectSvc:CreateCommonGridEffect(self._ghostEffectID, pos, dir)
    self._playSkillInsSvc:PlayAttackAudio(self._ghostAttackAudioWaitTime, monsterEntity, self._ghostAttackAudioID)
    table.insert(self._attackGhostEntityList, ghostEntity)
    local lineEffectPos = ghostEntity:View():GetGameObject().transform:TransformPoint(Vector3(self._ghostLineOffsetX, self._ghostLineOffsetY, self._ghostLineOffsetZ))
    local ghostAttackTaskID = TaskManager:GetInstance():CoreGameStartTask(self.PlayBeHit, self, ghostEntity, targetEntity, self._ghostLineEffectID, self._ghostHitEffectID, damageResult, self._ghostAttackWaitTime, lineEffectPos)
    table.insert(self._waitTaskID, ghostAttackTaskID)
  end
end

function PlayMonsterMoveGridN18MinosInstruction:_GetMoveSpeed(casterEntity)
  local cfgSvc = self._world:GetService("Config")
  local configData = cfgSvc:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local speed = configData:GetMonsterSpeed(monsterID)
  speed = speed or 1
  return speed
end

function PlayMonsterMoveGridN18MinosInstruction:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

function PlayMonsterMoveGridN18MinosInstruction:PlayBeHit(TT, effectCastEntity, targetEntity, lineEffectID, hitEffectID, damageResult, waitTime, casterPos)
  if 0 < waitTime then
    YIELD(TT, waitTime)
  end
  local targetPos = targetEntity:GetPosition()
  local holderTf = targetEntity:View().ViewWrapper.Transform
  local bindTf = GameObjectHelper.FindChild(holderTf, "Hit")
  if bindTf then
    targetPos = bindTf.position
  end
  local dis = Vector3.Distance(casterPos, targetPos)
  local dir = targetPos - casterPos
  if 1.4 < dis then
    local effectEntity = self._effectSvc:CreatePositionEffect(lineEffectID, casterPos)
    effectEntity:SetDirection(dir)
    local go = effectEntity:View():GetGameObject()
    local dotween = go.transform:DOMove(targetPos, self._lineSpeed / 1000.0, false)
    if self._flyEaseType then
      local easyType = DG.Tweening.Ease[self._flyEaseType]
      dotween:SetEase(easyType)
    end
    YIELD(TT, self._lineSpeed)
  end
  local playSkillService = self._world:GetService("PlaySkill")
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(self.casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(false):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(self._skillID):SetHandleBeHitParam_DamageIndex(1)
  playSkillService:HandleBeHit(TT, beHitParam)
end

function PlayMonsterMoveGridN18MinosInstruction:_ShowTrapFromSummonTrap(TT, world, result)
  local posSummon = result:GetPos()
  local utilSvc = world:GetService("UtilData")
  local array = utilSvc:GetTrapsAtPos(posSummon)
  local trapID = result:GetTrapID()
  local trapEntity
  for _, eTrap in ipairs(array) do
    local cTrap = eTrap:TrapID()
    if cTrap and cTrap:GetTrapID() == trapID and not eTrap:HasDeadMark() then
      trapEntity = eTrap
      break
    end
  end
  if not trapEntity then
    Log.error(self._className, "trap not found: ", tostring(result:GetPos()), " id=", trapID)
    return
  end
  self:_ShowTrap(TT, world, trapEntity, posSummon)
end

function PlayMonsterMoveGridN18MinosInstruction:_ShowTrap(TT, world, trapEntity, posSummon)
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, false)
end

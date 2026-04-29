require("base_ins_r")
_class("PlayMonsterMoveGridByParamInstruction", BaseInstruction)
PlayMonsterMoveGridByParamInstruction = PlayMonsterMoveGridByParamInstruction

function PlayMonsterMoveGridByParamInstruction:Constructor(paramList)
  self._attackAnimName = paramList.attackAnimName
  self._attackEffectID = tonumber(paramList.attackEffectID)
  self._attackAudioID = tonumber(paramList.attackAudioID)
  self._attackAudioWaitTime = tonumber(paramList.attackAudioWaitTime)
  self._hitDelayTime = tonumber(paramList.hitDelayTime) or 0
  self._hitAnimName = paramList.hitAnimName or "Hit"
  self._hitEffectID = tonumber(paramList.hitEffectID)
end

function PlayMonsterMoveGridByParamInstruction:GetCacheAudio()
  local t = {}
  if self._attackAudioID and self._attackAudioID > 0 then
    table.insert(t, self._attackAudioID)
  end
  return t
end

function PlayMonsterMoveGridByParamInstruction:GetCacheResource()
  local t = {}
  if self._attackEffectID and self._attackEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._attackEffectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayMonsterMoveGridByParamInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  self._effectSvc = self._world:GetService("Effect")
  self._playSkillInsSvc = self._world:GetService("PlaySkillInstruction")
  self._playBuffSvc = self._world:GetService("PlayBuff")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MonsterMoveGridByParam)
  if not results then
    Log.fatal("no results")
    return
  end
  self._skillID = skillEffectResultContainer:GetSkillID()
  local result = results[1]
  local walkResultList = result:GetWalkResultList()
  local casterIsDead = result:IsCasterDead()
  self._waitTaskID = {}
  if 0 < #walkResultList then
    self:_DoWalk(TT, casterEntity, walkResultList, casterIsDead)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(self._waitTaskID) do
    YIELD(TT)
  end
end

function PlayMonsterMoveGridByParamInstruction:_DoWalk(TT, monsterEntity, walkResultList, casterIsDead)
  local boardServiceRender = self._world:GetService("BoardRender")
  local pieceSvc = self._world:GetService("Piece")
  local moveSpeed = self:_GetMoveSpeed(monsterEntity)
  local hasWalkPoint = false
  if 0 < #walkResultList then
    hasWalkPoint = true
  end
  if hasWalkPoint then
    self:StartMoveAnimation(monsterEntity, true)
    boardServiceRender:RefreshPiece(monsterEntity, true, true)
  end
  for _, v in ipairs(walkResultList) do
    local walkRes = v
    local walkPos = walkRes:GetWalkPos()
    local curPos = boardServiceRender:GetRealEntityGridPos(monsterEntity)
    monsterEntity:AddGridMove(moveSpeed, walkPos, curPos)
    local walkDir = walkPos - curPos
    monsterEntity:SetDirection(walkDir)
    while monsterEntity:HasGridMove() do
      YIELD(TT)
    end
    self:_PlayArrivePos(TT, monsterEntity, walkRes)
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

function PlayMonsterMoveGridByParamInstruction:_PlayArrivePos(TT, monsterEntity, walkRes)
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
  local damageResult = walkRes:GetAttackResult()
  if damageResult then
    local pos = walkRes:GetWalkPos()
    local targetID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetID)
    local targetPos = targetEntity:GetGridPosition()
    local dir = targetPos - pos
    monsterEntity:SetDirection(dir)
    monsterEntity:SetAnimatorControllerTriggers({
      self._attackAnimName
    })
    if self._attackEffectID then
      local attackEff = self._effectSvc:CreateEffect(self._attackEffectID, monsterEntity)
    end
    local audioTaskID = self._playSkillInsSvc:PlayAttackAudio(self._attackAudioWaitTime, monsterEntity, self._attackAudioID)
    table.insert(self._waitTaskID, audioTaskID)
    YIELD(TT, self._hitDelayTime)
    local playSkillService = self._world:GetService("PlaySkill")
    local damageInfo = damageResult:GetDamageInfo(1)
    local damageGridPos = damageResult:GetGridPos()
    local hitAnimName = self._hitAnimName
    local hitEffectID = self._hitEffectID
    local skillID = self._skillID
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(monsterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
    playSkillService:HandleBeHit(TT, beHitParam)
    self._playBuffSvc:PlayBuffView(TT, NTSE189NormalEachAttackEnd:New(monsterEntity))
  end
end

function PlayMonsterMoveGridByParamInstruction:_GetMoveSpeed(casterEntity)
  local cfgSvc = self._world:GetService("Config")
  local configData = cfgSvc:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local speed = configData:GetMonsterSpeed(monsterID)
  speed = speed or 1
  return speed
end

function PlayMonsterMoveGridByParamInstruction:StartMoveAnimation(casterEntity, isMove)
  local curVal = casterEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    casterEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

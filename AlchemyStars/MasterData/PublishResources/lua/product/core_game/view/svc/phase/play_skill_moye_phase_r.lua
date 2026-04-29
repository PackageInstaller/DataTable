require("play_skill_phase_base_r")
_class("PlaySkillMoyePhase", PlaySkillPhaseBase)
PlaySkillMoyePhase = PlaySkillMoyePhase

function PlaySkillMoyePhase:PlayFlight(TT, casterEntity, phaseParam)
  self._casterEntity = casterEntity
  self._param = phaseParam
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  self._skillResultLinkLine = resultContainer:GetEffectResultByArray(SkillEffectType.ConvertAndDamageByLinkLine)
  self._skillResultMoyeMove = resultContainer:GetEffectResultByArray(SkillEffectType.MoyeMove)
  self._skillResultTriggerTraps = resultContainer:GetEffectResultByArrayAll(SkillEffectType.TriggerTrap)
  if not self._skillResultLinkLine or not self._skillResultMoyeMove then
    return
  end
  self._skillID = resultContainer:GetSkillID()
  self._chainPath = self._skillResultLinkLine:GetChainPath()
  self._teleportResult = self._skillResultMoyeMove:GetTeleportResult()
  self._damageResult = self._skillResultLinkLine:GetDamageResult()
  self._utilDataSvc = self._world:GetService("UtilData")
  self._effectSvc = self._world:GetService("Effect")
  self._boardSvc = self._world:GetService("BoardRender")
  self._trapServiceRender = self._world:GetService("TrapRender")
  local lastPos = self._chainPath[#self._chainPath]
  local existMonster = self._utilDataSvc:GetMonsterAtPos(lastPos)
  if existMonster then
    local renderEntitySvc = self._world:GetService("RenderEntity")
    renderEntitySvc:TurnToTarget(casterEntity, existMonster)
    YIELD(TT)
    self:_PlayAnimation(casterEntity, {
      self._param.monsterAnim
    })
    self:_PlayEffect(self._param.monsterEffID)
    self:_PlayAudio(self._param.monsterAudioID)
    YIELD(TT, self._param.yieldTime)
  else
    self:_PlayAnimation(casterEntity, {
      self._param.noMonsterAnim
    })
    self:_PlayEffect(self._param.noMonsterEffID)
    self:_PlayAudio(self._param.noMonsterAudioID)
    YIELD(TT, self._param.yieldTimeNoMonster)
  end
  if existMonster then
    self:_PlayEffect(self._param.monsterWeaponEffID)
    YIELD(TT, self._param.yieldTime1)
  else
    self:_PlayEffect(self._param.noMonsterWeaponEffID)
    YIELD(TT, self._param.yieldTime1NoMonster)
  end
  local allTrajectoryIntervalTime = 0
  if self._param.trapIDs then
    if self._skillResultTriggerTraps then
      local temp = {}
      for _, _result in ipairs(self._skillResultTriggerTraps) do
        local result = _result
        local beginPos = self._teleportResult:GetPosOld()
        local endPos = result:GetPos()
        local effectEntity = self._effectSvc:CreateEffect(self._param.trajectoryEffID, casterEntity)
        if effectEntity and effectEntity:View() then
          local gameObject = effectEntity:View():GetGameObject()
          local transform = gameObject.transform
          local endPosV3 = self._boardSvc:GridPos2RenderPos(endPos)
          endPosV3.y = 0.5
          transform:DOMove(endPosV3, self._param.flyTime * 0.001, false)
          YIELD(TT, self._param.trajectoryIntervalTime)
          allTrajectoryIntervalTime = allTrajectoryIntervalTime + self._param.trajectoryIntervalTime
          local t = {}
          t.effectEntity = effectEntity
          t.trapEntity = self._world:GetEntityByID(result:GetEntityID())
          table.insert(temp, t)
        end
      end
      YIELD(TT, self._param.flyTime - 300)
      for _, _t in ipairs(temp) do
        GameGlobal.TaskManager():CoreGameStartTask(self._PlayTrapSkill, self, _t.trapEntity, casterEntity)
      end
      for _, _t in ipairs(temp) do
        self._effectSvc:CreateWorldPositionEffect(self._param.trajectoryEndEff, _t.trapEntity:GetGridPosition())
      end
      YIELD(TT, 100)
      for _, _t in ipairs(temp) do
        self._world:DestroyEntity(_t.effectEntity)
      end
      if existMonster then
        YIELD(TT, self._param.yieldTime2)
      else
        YIELD(TT, self._param.yieldTime2NoMonster)
      end
    elseif existMonster then
      YIELD(TT, self._param.yieldTime2Monster)
    else
      YIELD(TT, self._param.yieldTime2NoMonster)
    end
  end
  if self._damageResult then
    self:_DoDamage(TT, casterEntity)
    YIELD(TT, self._param.yieldTime3 + allTrajectoryIntervalTime)
  end
  if #self._chainPath > 0 then
    self:_DoTelePort(TT, casterEntity)
  end
  self:_DestroyLinkLine()
end

function PlaySkillMoyePhase:_DoTelePort(TT, casterEntity)
  local newDir = self._teleportResult:GetDirNew()
  local oldPos = self._teleportResult:GetPosOld()
  local newPos = self._teleportResult:GetPosNew()
  self:_PlayAnimation(casterEntity, {
    self._param.teleportAnim
  })
  YIELD(TT, self._param.teleportAnimTime)
  self:_PlayEffect(self._param.teleportEffID)
  local dir = newPos - oldPos
  casterEntity:SetDirection(dir)
  local distance = Vector2.Distance(newPos, oldPos)
  local speed = distance / self._param.teleportTime * 1000
  YIELD(TT, self._param.teleportWaitTime)
  casterEntity:AddGridMove(speed, newPos, oldPos)
  while casterEntity:HasGridMove() do
    YIELD(TT)
  end
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(pets) do
    petEntity:SetPosition(newPos)
  end
  teamEntity:SetLocation(newPos, newDir)
  teamLeaderEntity:SetLocation(newPos, newDir)
end

function PlaySkillMoyePhase:_DestroyLinkLine()
  local board = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = board:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  local removeList = {}
  for _, linkLineEntity in ipairs(allEntities) do
    table.insert(removeList, linkLineEntity)
  end
  local linkageRenderService = self._world:GetService("LinkageRender")
  for _, e in ipairs(removeList) do
    linkageRenderService:DestroyLinkLine(e)
  end
end

function PlaySkillMoyePhase:_DoDamage(TT, casterEntity)
  local targetPos = self._damageResult:GetGridPos()
  local curPos = self._boardSvc:GetRealEntityGridPos(casterEntity)
  local attackDir = targetPos - curPos
  casterEntity:SetDirection(attackDir)
  AudioHelperController.PlayInnerGameSfx(self._param.lastPosAudioID)
  local targetID = self._damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetID)
  if self._param.lastPosEffID then
    self._effectService:CreateEffect(self._param.lastPosEffID, targetEntity)
  end
  local damageInfo = self._damageResult:GetDamageInfo(1)
  local skillID = self._skillID
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(targetPos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
  self._skillService:HandleBeHit(TT, beHitParam)
end

function PlaySkillMoyePhase:_PlayAnimation(entity, animNames)
  if entity then
    entity:SetAnimatorControllerTriggers(animNames)
  end
end

function PlaySkillMoyePhase:_PlayEffect(effectID, entity)
  if effectID then
    entity = entity or self._casterEntity
    self._effectSvc:CreateEffect(effectID, entity)
  end
end

function PlaySkillMoyePhase:_PlayAudio(audioID)
  if audioID then
    AudioHelperController.PlayInnerGameSfx(audioID)
  end
end

function PlaySkillMoyePhase:_PlayTrapSkill(TT, trapEntity, casterEntity)
  self._trapServiceRender:PlayTrapTriggerSkill(TT, trapEntity, false, casterEntity)
  self._trapServiceRender:DestroyTrap(TT, trapEntity)
end

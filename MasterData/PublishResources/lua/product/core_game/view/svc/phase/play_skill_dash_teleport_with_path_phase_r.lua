require("play_skill_phase_base_r")
_class("PlaySkillDashTeleportWithPathPhase", PlaySkillPhaseBase)
PlaySkillDashTeleportWithPathPhase = PlaySkillDashTeleportWithPathPhase

function PlaySkillDashTeleportWithPathPhase:PlayFlight(TT, casterEntity, phaseParam, phaseIndex, phaseAdapter)
  local effectService = self._world:GetService("Effect")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if not skillResult then
    return
  end
  local path = skillResult:GetRenderTeleportPath()
  if path and 0 < #path then
  else
    return
  end
  casterEntity:SetAnimatorControllerTriggers({
    phaseParam.castAnimation
  })
  if phaseParam.castEffectID and phaseParam.castEffectID ~= 0 then
    effectService:CreateEffect(phaseParam.castEffectID, casterEntity)
  end
  local startPos = skillResult:GetPosOld()
  local firstPos = path[1]
  local startDir = firstPos - startPos
  casterEntity:SetDirection(startDir)
  YIELD(TT, phaseParam.castDuration)
  local world = casterEntity:GetOwnerWorld()
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  if path and 0 < #path then
    local lastPos = skillResult:GetPosOld()
    for index, pathPos in ipairs(path) do
      local isFirst = false
      local isFinal = false
      if index == 1 then
        isFirst = true
      end
      if index == #path then
        isFinal = true
      end
      self:_PlayDashToPos(TT, casterEntity, phaseParam, lastPos, pathPos, isFirst, isFinal)
      lastPos = pathPos
    end
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportMove, false, skillResult)
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportShow, false, skillResult)
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.BuffNotify, false, skillResult)
    local stopDelay = phaseParam:GetStopDelay()
    if stopDelay and 0 <= stopDelay then
      YIELD(TT, stopDelay)
    end
  end
  YIELD(TT, 100)
end

function PlaySkillDashTeleportWithPathPhase:_PlayDashToPos(TT, casterEntity, phaseParam, lastPos, toPos, isFirst, isFinal)
  local boardServiceRender = self._world:GetService("BoardRender")
  local effectService = self._world:GetService("Effect")
  local dashAction = phaseParam:GetDashAction()
  local dashDuration = phaseParam:GetEachDashDuration() or 500
  local entity = casterEntity
  local viewCmpt = entity:View()
  local entityGo = viewCmpt:GetGameObject()
  local transWork = entityGo.transform
  local toPosRender = boardServiceRender:GridPos2RenderPos(toPos)
  local dir = toPos - lastPos
  local pathPointEffectID = phaseParam:GetPathPointEffectID()
  if isFirst then
    casterEntity:SetDirection(dir)
    local firstStartAction = phaseParam:GetStartAction()
    if firstStartAction then
      casterEntity:SetAnimatorControllerTriggers({firstStartAction})
    end
    local firstStartEffectID = phaseParam:GetStartEffectID()
    if firstStartEffectID then
      effectService:CreateEffect(firstStartEffectID, casterEntity)
    end
    if pathPointEffectID then
      effectService:CreateEffect(pathPointEffectID, casterEntity)
    end
    local firstStartDelay = phaseParam:GetStartDashDelay()
    if firstStartDelay and 0 <= firstStartDelay then
      YIELD(TT, firstStartDelay)
    end
  else
    local middleStartAction = phaseParam:GetMiddleStartAction()
    if middleStartAction then
      casterEntity:SetAnimatorControllerTriggers({middleStartAction})
    end
    local eachDashFinishEffectID = phaseParam:GetEachDashFinishEffectID()
    if eachDashFinishEffectID then
      effectService:CreateEffect(eachDashFinishEffectID, casterEntity)
    end
    if pathPointEffectID then
      effectService:CreateEffect(pathPointEffectID, casterEntity)
    end
    local middleStartDelay = phaseParam:GetMiddleStartDashDelay()
    if middleStartDelay and 0 <= middleStartDelay then
      YIELD(TT, middleStartDelay)
    end
  end
  local dashEffectID = phaseParam:GetDashEffectID()
  if dashEffectID then
    effectService:CreateEffect(dashEffectID, casterEntity)
  end
  local dashAudioID = phaseParam:GetDashAudioID()
  if dashAudioID then
    AudioHelperController.PlayInnerGameSfx(dashAudioID)
  end
  if dashAction then
    casterEntity:SetAnimatorControllerTriggers({dashAction})
  end
  casterEntity:SetDirection(dir)
  local easeWork = transWork:DOMove(toPosRender, dashDuration / 1000, false):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
    entity:SetLocation(toPos, dir)
  end)
  YIELD(TT, dashDuration)
  YIELD(TT)
  self:_SacrificeTrap(TT, casterEntity, toPos)
  if isFinal then
    local stopAction = phaseParam:GetStopAction()
    if stopAction then
      casterEntity:SetAnimatorControllerTriggers({stopAction})
    end
    if pathPointEffectID then
      effectService:CreateEffect(pathPointEffectID, casterEntity)
    end
  end
end

function PlaySkillDashTeleportWithPathPhase:_SacrificeTrap(TT, casterEntity, pos)
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local sacrificeResults = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PetSacrificeSuperGridTraps)
  if not sacrificeResults then
    return
  end
  local sacrificeResult = sacrificeResults[1]
  if sacrificeResult then
    local trapIDs = sacrificeResult:GetTrapIDs()
    local playBuffSvc = self._world:GetService("PlayBuff")
    for i, id in ipairs(trapIDs) do
      local trapEntity = self._world:GetEntityByID(id)
      if trapEntity then
        local trapPos = trapEntity:GetGridPosition()
        if trapPos == pos then
          trapEntity:SetViewVisible(false)
          playBuffSvc:PlayBuffView(TT, NTPetMinosAbsorbTrap:New(trapEntity, casterEntity))
          local fakeNt = NTTrapSkillStart:New(trapEntity, self._fakeTriggerTrapSkillID, teamEntity)
          fakeNt:SetIsActiveSkillFake(true)
          playBuffSvc:PlayBuffView(TT, fakeNt)
          break
        end
      end
    end
  end
end

require("play_skill_phase_base_r")
_class("PlaySkillDrillerSummonBaseMonsterPhase", PlaySkillPhaseBase)
PlaySkillDrillerSummonBaseMonsterPhase = PlaySkillDrillerSummonBaseMonsterPhase

function PlaySkillDrillerSummonBaseMonsterPhase:PlayFlight(TT, casterEntity, phaseParam, phaseIndex, phaseAdapter)
  local effectService = self._world:GetService("Effect")
  local playSkillInstructionService = self._world:GetService("PlaySkillInstruction")
  local trapServiceRender = self._world:GetService("TrapRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  local sacrificeResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DestroyTrap, 1)
  local destroyResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DestroyTrap, 2)
  local hitBackResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.HitBack)
  local summonResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  self:SetHPVisible(casterEntity, false)
  YIELD(TT)
  local starAction = phaseParam:GetStartAction()
  casterEntity:SetAnimatorControllerTriggers({starAction})
  local upEffAnim = phaseParam:GetUpEffAnim()
  casterEntity:PlayMaterialAnim(upEffAnim)
  local upTailEffectID = phaseParam:GetUpTailEffectID()
  if upTailEffectID and upTailEffectID ~= 0 then
    effectService:CreateEffect(upTailEffectID, casterEntity)
  end
  if sacrificeResultArray and 0 < #sacrificeResultArray then
    local lineTraps = {}
    for index, sacrificeResult in ipairs(sacrificeResultArray) do
      local trapEntityID = sacrificeResult:GetEntityID()
      local trapEntity = self._world:GetEntityByID(trapEntityID)
      table.insert(lineTraps, trapEntity)
    end
    local lineEffectID = phaseParam:GetLineEffectID()
    local lineEffectCasterBone = phaseParam:GetLineEffectCasterBone()
    local lineEffectTrapBone = phaseParam:GetLineEffectTrapBone()
    if lineEffectID then
      effectService:CreateLineEffects(TT, lineEffectID, casterEntity, lineEffectCasterBone, lineTraps, lineEffectTrapBone)
    end
  end
  if sacrificeResultArray and 0 < #sacrificeResultArray then
    for index, sacrificeResult in ipairs(sacrificeResultArray) do
      local trapEntityID = sacrificeResult:GetEntityID()
      local eTrap = self._world:GetEntityByID(trapEntityID)
      local donotPlayDie = false
      GameGlobal.TaskManager():CoreGameStartTask(function()
        trapServiceRender:PlayTrapDieSkill(TT, {eTrap}, donotPlayDie)
      end)
    end
  end
  local showDropDelay = phaseParam:GetShowDropDelay()
  YIELD(TT, showDropDelay)
  local downTailEffectID = phaseParam:GetDownTailEffectID()
  if teleportResult then
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportHide, false, teleportResult)
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportMove, false, teleportResult)
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportShow, false, teleportResult)
    self:SetHPVisible(casterEntity, false)
    playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.BuffNotify, false, teleportResult)
  end
  casterEntity:SetViewVisible(false)
  local baseMonsterEntity
  if summonResultArray and 0 < #summonResultArray then
    local summonRes = summonResultArray[1]
    playSkillInstructionService:ShowSummonAction(TT, self._world, summonRes)
    local tmpData = summonRes:GetMonsterData()
    local entityWorkID = tmpData.m_entityWorkID
    local entityWork = self._world:GetEntityByID(entityWorkID)
    baseMonsterEntity = entityWork
    baseMonsterEntity:SetViewVisible(false)
    self:SetHPVisible(baseMonsterEntity, false)
    YIELD(TT)
    baseMonsterEntity:SetViewVisible(true)
    self:SetHPVisible(baseMonsterEntity, false)
  end
  if baseMonsterEntity then
    local downAction = phaseParam:GetDownAction()
    baseMonsterEntity:SetAnimatorControllerTriggers({downAction})
    local downTailEffectID = phaseParam:GetDownTailEffectID()
    if downTailEffectID and downTailEffectID ~= 0 then
      effectService:CreateEffect(downTailEffectID, baseMonsterEntity)
    end
    local downEffAnim = phaseParam:GetDownEffAnim()
    baseMonsterEntity:PlayMaterialAnim(downEffAnim)
    local landDelay = phaseParam:GetLandDelay()
    YIELD(TT, landDelay)
    local landEffectID = phaseParam:GetLandEffectID()
    if landEffectID and landEffectID ~= 0 then
      effectService:CreateEffect(landEffectID, baseMonsterEntity)
    end
    if destroyResultArray and 0 < #destroyResultArray then
      for index, destroyResult in ipairs(destroyResultArray) do
        local trapEntityID = destroyResult:GetEntityID()
        local eTrap = self._world:GetEntityByID(trapEntityID)
        local donotPlayDie = false
        GameGlobal.TaskManager():CoreGameStartTask(function()
          trapServiceRender:PlayTrapDieSkill(TT, {eTrap}, donotPlayDie)
        end)
      end
    end
    if hitBackResult then
      local hitBackSpeed = 10
      local processHitTaskID
      local targetEntityID = hitBackResult:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if hitBackResult and not targetEntity:HasHitback() and not hitBackResult:GetHadPlay() then
        hitBackResult:SetHadPlay(true)
        processHitTaskID = self:SkillService():ProcessHit(casterEntity, targetEntity, hitBackResult, hitBackSpeed)
      end
      if processHitTaskID then
        while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
          YIELD(TT)
        end
      end
      YIELD(TT)
      if hitBackResult then
        local pieceService = self._world:GetService("Piece")
        pieceService:RemovePrismAt(hitBackResult:GetPosTarget())
      end
    end
    casterEntity:ReplaceRenderPerformanceByAgent(baseMonsterEntity:GetID())
    YIELD(TT)
    self:SetHPVisible(casterEntity, true)
    self:SetHPVisible(baseMonsterEntity, true)
    baseMonsterEntity:ReplaceHPComponent()
    YIELD(TT)
  end
end

function PlaySkillDrillerSummonBaseMonsterPhase:SetHPVisible(entity, bVisible)
  local hpCmpt = entity:HP()
  if hpCmpt then
    local sliderEntityID = entity:HP():GetHPSliderEntityID()
    local sliderEntity = self._world:GetEntityByID(sliderEntityID)
    if sliderEntity then
      hpCmpt:SetHPBarTempHide(not bVisible)
      hpCmpt:SetHPPosDirty(true)
    end
  end
end

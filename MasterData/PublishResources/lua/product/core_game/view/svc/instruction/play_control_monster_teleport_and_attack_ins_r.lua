require("base_ins_r")
_class("PlayControlMonsterTeleportAndAttackInstruction", BaseInstruction)
PlayControlMonsterTeleportAndAttackInstruction = PlayControlMonsterTeleportAndAttackInstruction

function PlayControlMonsterTeleportAndAttackInstruction:Constructor(paramList)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._hitAnimName = paramList.hitAnimName or "Hit"
  self._turnToTarget = tonumber(paramList.turnToTarget) or 1
  self._damageWaitTime = tonumber(paramList.damageWaitTime) or 5000
  self._damageAnim = paramList.damageAnim
  self._damageEffectID = tonumber(paramList.damageEffectID)
  self._damageEffectWaitTime = tonumber(paramList.damageEffectWaitTime)
  self._damageTextWaitTime = tonumber(paramList.damageTexttWaitTime) or 800
  self._damageDurationTime = tonumber(paramList.damageDurationTime) or 4000
  self._teleportWaitTime = tonumber(paramList.teleportWaitTime) or 1000
  self._teleportAnim = paramList.teleportAnim
  self._teleportFinishAnim = paramList.teleportFinishAnim
  self._teleportMaterialAnim = paramList.teleportMaterialAnim
  self._teleportDurationTime = tonumber(paramList.teleportDurationTime) or 500
end

function PlayControlMonsterTeleportAndAttackInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  if self._damageEffectID and 0 < self._damageEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._damageEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayControlMonsterTeleportAndAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local teleportAndAttackResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ControlMonsterTeleportAndAttack)
  if not teleportAndAttackResult then
    return
  end
  self._needWaitTeleport = false
  self._needWaitDamage = false
  local targetMonsterEntityID = teleportAndAttackResult:GetTargetMonsterEntityID()
  local targetMonsterEntity = world:GetEntityByID(targetMonsterEntityID)
  local teleportResults = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport)
  if teleportResults and table.count(teleportResults) > 0 then
    self._needWaitTeleport = true
    for _, result in pairs(teleportResults) do
      local targetEntityID = result:GetTargetID()
      if targetEntityID == casterEntity:GetID() then
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          self:_PlayCasterTeleportResult(TT, casterEntity, result)
        end)
      else
        local targetEntity = world:GetEntityByID(targetEntityID)
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          self:_PlayTargetTeleportResult(TT, targetEntity, result)
        end)
      end
    end
  end
  local damageResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage)
  if damageResult then
    local beAttackEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(beAttackEntityID)
    if targetEntity then
      self._needWaitDamage = true
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        if self._needWaitTeleport == true then
          YIELD(TT, self._damageWaitTime)
        end
        self:_PlayDamageResult(TT, targetMonsterEntity, damageResult, skillID)
      end)
    end
  end
  while self._needWaitTeleport == true or self._needWaitDamage == true do
    YIELD(TT)
  end
end

function PlayControlMonsterTeleportAndAttackInstruction:_PlayCasterTeleportResult(TT, entity, teleportResult)
  local world = entity:GetOwnerWorld()
  local posOld = teleportResult:GetPosOld()
  local posNew = teleportResult:GetPosNew()
  local dirNew = teleportResult:GetDirNew()
  entity:SetAnimatorControllerBools({Move = true})
  entity:AddGridMove(BattleConst.MoveSpeed, posNew, posOld)
  entity:SetDirection(dirNew)
  while entity:HasGridMove() do
    YIELD(TT)
  end
  entity:SetAnimatorControllerBools({Move = false})
  entity:SetLocation(posNew, dirNew)
  local trapIDList = teleportResult:GetTriggerTrapIDList()
  local trapEntityList = {}
  for _, trapID in ipairs(trapIDList) do
    local trapEntity = world:GetEntityByID(trapID)
    trapEntityList[#trapEntityList + 1] = trapEntity
  end
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  sPlaySkillInstruction:PlayTrapTrigger(TT, entity, trapEntityList)
  local playBuffService = world:GetService("PlayBuff")
  playBuffService:PlayBuffView(TT, NTTeleport:New(entity, posOld, posNew))
end

function PlayControlMonsterTeleportAndAttackInstruction:_PlayTargetTeleportResult(TT, entity, teleportResult)
  YIELD(TT, self._teleportWaitTime)
  local world = entity:GetOwnerWorld()
  local posOld = teleportResult:GetPosOld()
  local posNew = teleportResult:GetPosNew()
  local dirNew = teleportResult:GetDirNew()
  entity:SetDirection(dirNew)
  entity:SetAnimatorControllerTriggers({
    self._teleportAnim
  })
  entity:PlayMaterialAnim(self._teleportMaterialAnim)
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, entity, RoleShowType.TeleportHide2Sky, false, teleportResult)
  playSkillInstructionService:Teleport(TT, entity, RoleShowType.TeleportMove, false, teleportResult)
  YIELD(TT, self._teleportDurationTime)
  entity:SetAnimatorControllerTriggers({
    self._teleportFinishAnim
  })
  playSkillInstructionService:Teleport(TT, entity, RoleShowType.TeleportShow, false, teleportResult)
  playSkillInstructionService:Teleport(TT, entity, RoleShowType.BuffNotify, false, teleportResult)
  self._needWaitTeleport = false
end

function PlayControlMonsterTeleportAndAttackInstruction:_PlayCasterControlGridDown(casterEntity, enable)
  if casterEntity:MonsterID() then
    local monsterIDCmpt = casterEntity:MonsterID()
    monsterIDCmpt:SetNeedGridDownEnable(enable == 1)
  elseif casterEntity:HasTrapID() then
    local trapRender = casterEntity:TrapRender()
    trapRender:SetNeedGridDownEnable(enable == 1)
  else
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local bodyAreaCmpt = casterEntity:BodyArea()
  local areaArray = bodyAreaCmpt:GetArea()
  local pieceSvc = world:GetService("Piece")
  local monsterGridPos = casterEntity:GetRenderGridPosition()
  for i = 1, #areaArray do
    local curAreaPos = areaArray[i]
    local pos = Vector2(curAreaPos.x + monsterGridPos.x, curAreaPos.y + monsterGridPos.y)
    if enable == 1 then
      pieceSvc:SetPieceAnimDark(pos)
    else
      pieceSvc:SetPieceAnimNormal(pos)
    end
  end
end

function PlayControlMonsterTeleportAndAttackInstruction:_PlayDamageResult(TT, entity, damageResult, skillID)
  local world = entity:GetOwnerWorld()
  entity:SetAnimatorControllerTriggers({
    self._damageAnim
  })
  YIELD(TT, self._damageEffectWaitTime)
  local effect = world:GetService("Effect"):CreateEffect(self._damageEffectID, entity)
  YIELD(TT, self._damageTextWaitTime)
  local beAttackEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(beAttackEntityID)
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  local deathClear = false
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(entity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  local playSkillService = world:GetService("PlaySkill")
  playSkillService:HandleBeHit(TT, beHitParam)
  YIELD(TT, self._damageDurationTime)
  self._needWaitDamage = false
end

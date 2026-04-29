require("base_ins_r")
_class("PlayCrabMoveAndAttackInstruction", BaseInstruction)
PlayCrabMoveAndAttackInstruction = PlayCrabMoveAndAttackInstruction

function PlayCrabMoveAndAttackInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
  self._speed = tonumber(paramList.speed)
  self._materialAnim = paramList.materialAnim
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._hitAnimName = paramList.hitAnimName or "Hit"
  self._turnToTarget = tonumber(paramList.turnToTarget) or 1
  self._baseHitTime = tonumber(paramList.baseHitTime) or 50
  self._oneMoveHitTime = tonumber(paramList.oneMoveHitTime) or 20
end

function PlayCrabMoveAndAttackInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayCrabMoveAndAttackInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local crabMoveAndAttackResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.CrabMoveAndAttack)
  if not crabMoveAndAttackResult then
    return
  end
  local attackMoveStep = crabMoveAndAttackResult:GetAttackMoveStep() or 0
  local teleportResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if teleportResult then
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:_PlayTeleportResult(TT, casterEntity, teleportResult)
    end)
  end
  local damageResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage)
  if damageResult then
    local beAttackEntityID = damageResult:GetTargetID()
    local targetEntity = world:GetEntityByID(beAttackEntityID)
    if targetEntity then
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        local waitHitTime = self._baseHitTime + self._oneMoveHitTime * attackMoveStep
        YIELD(TT, waitHitTime)
        self:_PlayDamageResult(TT, casterEntity, damageResult, skillID)
        if targetEntity:HasTeam() then
          targetEntity = targetEntity:GetTeamLeaderPetEntity()
        end
        targetEntity:PlayMaterialAnim(self._materialAnim)
      end)
    end
  end
end

function PlayCrabMoveAndAttackInstruction:_PlayTeleportResult(TT, casterEntity, teleportResult)
  local world = casterEntity:GetOwnerWorld()
  local posOld = teleportResult:GetPosOld()
  local posNew = teleportResult:GetPosNew()
  local distance = Vector2.Distance(posNew, posOld)
  local speed = self._speed
  if self._time then
    speed = distance / self._time * 1000
  end
  local renderEntityService = world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  self:_PlayCasterControlGridDown(casterEntity, 0)
  local dir = teleportResult:GetDirNew()
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  casterEntity:AddGridMove(speed, posNew, gridPos)
  while casterEntity:HasGridMove() do
    YIELD(TT)
  end
  local viewPos = posNew:Clone()
  local offset = casterEntity:GetGridOffset()
  if offset then
    viewPos = viewPos + offset
  end
  casterEntity:SetPosition(viewPos)
  local trapIDList = teleportResult:GetTriggerTrapIDList()
  local trapEntityList = {}
  for _, v in ipairs(trapIDList) do
    local trapEntity = world:GetEntityByID(v)
    trapEntityList[#trapEntityList + 1] = trapEntity
  end
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  sPlaySkillInstruction:PlayTrapTrigger(TT, casterEntity, trapEntityList)
  local renderEntityService = world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
  self:_PlayCasterControlGridDown(casterEntity, 1)
  world:GetService("PlayBuff"):PlayBuffView(TT, NTTeleport:New(casterEntity, posOld, posNew))
end

function PlayCrabMoveAndAttackInstruction:_PlayCasterControlGridDown(casterEntity, enable)
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

function PlayCrabMoveAndAttackInstruction:_PlayDamageResult(TT, casterEntity, damageResult, skillID)
  local world = casterEntity:GetOwnerWorld()
  local beAttackEntityID = damageResult:GetTargetID()
  local targetEntity = world:GetEntityByID(beAttackEntityID)
  local damageInfo = damageResult:GetDamageInfo(1)
  local damageGridPos = damageResult:GetGridPos()
  local playFinalAttack = false
  local deathClear = false
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(self._hitAnimName):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(self._turnToTarget):SetHandleBeHitParam_DeathClear(deathClear):SetHandleBeHitParam_IsFinalHit(playFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  local playSkillService = world:GetService("PlaySkill")
  playSkillService:HandleBeHit(TT, beHitParam)
end

require("base_ins_r")
_class("PlayTeleportAsMovingInstruction", BaseInstruction)
PlayTeleportAsMovingInstruction = PlayTeleportAsMovingInstruction

function PlayTeleportAsMovingInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
  self._speed = tonumber(paramList.speed)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
  assert(self._time or self._speed, "PlayTeleportAsMoving指令需要配置time参数")
  self._notifyBuff = tonumber(paramList.notifyBuff) or 1
  self._leftAnimName = paramList.leftAnimName
  self._rightAnimName = paramList.rightAnimName
  self._animName = paramList.animName
  self._moveSetDir = tonumber(paramList.moveSetDir)
  self._moveUseResDir = tonumber(paramList.moveUseResDir)
  self._dontSetGridDown = paramList.dontSetGridDown
end

function PlayTeleportAsMovingInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local teleportResult = routineComponent:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportResult then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local teleportedEntityID = teleportResult:GetTargetID()
  local teleportedEntity = world:GetEntityByID(teleportedEntityID)
  if not teleportedEntity then
    return
  end
  local posOld = teleportResult:GetPosOld()
  local posNew = teleportResult:GetPosNew()
  local dir = teleportResult:GetDirNew()
  if self._moveUseResDir and self._moveUseResDir == 1 then
    teleportedEntity:SetDirection(dir)
  end
  if posOld == posNew then
    if self._notifyBuff == 1 then
      world:GetService("PlayBuff"):PlayBuffView(TT, NTTeleport:New(casterEntity, posOld, posNew))
    end
    return
  end
  local animName
  if posOld.x < posNew.x then
    animName = self._leftAnimName
  elseif posOld.x > posNew.x then
    animName = self._rightAnimName
  else
    animName = self._animName
  end
  if animName then
    casterEntity:SetAnimatorControllerTriggers({animName})
  end
  if casterEntity:HasPetPstID() then
    local boardService = world:GetService("BoardRender")
    local oldPos = teleportResult:GetPosOld()
    local oldColor = teleportResult:GetColorOld()
    boardService:ReCreateGridEntity(oldColor, oldPos)
  end
  YIELD(TT)
  local distance = Vector2.Distance(posNew, posOld)
  local speed = self._speed
  if self._time then
    speed = distance / self._time * 1000
  end
  if casterEntity:HasMonsterID() then
    local renderEntityService = world:GetService("RenderEntity")
    renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  end
  if not self._dontSetGridDown then
    self:_PlayCasterControlGridDown(casterEntity, 0)
  end
  while teleportedEntity:HasGridMove() do
    local gridMoveComponent = teleportedEntity:GridMove()
    YIELD(TT)
  end
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(teleportedEntity)
  if self._moveSetDir and self._moveSetDir == 1 then
    local moveDir = (posNew - posOld):SetNormalize()
    teleportedEntity:SetDirection(moveDir)
  end
  teleportedEntity:AddGridMove(speed, posNew, gridPos)
  while teleportedEntity:HasGridMove() do
    YIELD(TT)
  end
  local viewPos = posNew:Clone()
  local offset = teleportedEntity:GetGridOffset()
  if offset then
    viewPos = viewPos + offset
  end
  teleportedEntity:SetPosition(viewPos)
  local trapServiceRender = world:GetService("TrapRender")
  local pieceService = world:GetService("Piece")
  if casterEntity:HasPetPstID() then
    local boardService = world:GetService("BoardRender")
    local newColor = teleportResult:GetColorNew()
    local newPos = teleportResult:GetPosNew()
    boardService:ReCreateGridEntity(newColor, newPos)
    trapServiceRender:ShowHideTrapAtPos(newPos, false)
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for i, petEntity in ipairs(pets) do
      petEntity:SetPosition(posNew, dir)
    end
    teamEntity:SetLocation(posNew, dir)
    teamLeaderEntity:SetLocation(posNew, dir)
    pieceService:RemovePrismAt(newPos)
  elseif casterEntity:HasMonsterID() then
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
    if self._moveSetDir and self._moveSetDir == 1 then
      casterEntity:SetDirection(dir)
    end
  elseif casterEntity:HasTrapID() and casterEntity:HasTrapRoundInfoRender() then
    local eid = casterEntity:TrapRoundInfoRender():GetRoundInfoEntityID()
    if eid then
      local eff = world:GetEntityByID(eid)
      eff:AddGridMove(self._speed, posNew, posOld)
    end
  end
  if not self._dontSetGridDown then
    self:_PlayCasterControlGridDown(casterEntity, 1)
  end
  if self._notifyBuff == 1 then
    world:GetService("PlayBuff"):PlayBuffView(TT, NTTeleport:New(casterEntity, posOld, posNew))
  end
end

function PlayTeleportAsMovingInstruction:_PlayCasterControlGridDown(casterEntity, enable)
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

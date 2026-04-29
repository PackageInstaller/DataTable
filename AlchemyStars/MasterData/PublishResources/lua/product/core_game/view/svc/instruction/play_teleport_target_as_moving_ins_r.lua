require("base_ins_r")
_class("PlayTeleportTargetAsMovingInstruction", BaseInstruction)
PlayTeleportTargetAsMovingInstruction = PlayTeleportTargetAsMovingInstruction

function PlayTeleportTargetAsMovingInstruction:Constructor(paramList)
  self._time = tonumber(paramList.time)
  self._speed = tonumber(paramList.speed)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
  assert(self._time or self._speed, "PlayTeleportAsMoving指令需要配置time参数")
  self._notifyBuff = tonumber(paramList.notifyBuff) or 1
  self._moveAni = paramList.moveAni
  self._moveEffID = tonumber(paramList.moveEffID)
  local oriOffSetX = tonumber(paramList.oriOffSetX)
  local oriOffSetY = tonumber(paramList.oriOffSetY)
  self._oriOffSet = nil
  if oriOffSetX and oriOffSetY then
    self._oriOffSet = Vector2(oriOffSetX, oriOffSetY)
  end
end

function PlayTeleportTargetAsMovingInstruction:GetCacheResource()
  local t = {}
  if self._moveEffID and self._moveEffID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._moveEffID].ResPath,
      1
    })
  end
  return t
end

function PlayTeleportTargetAsMovingInstruction:DoInstruction(TT, casterEntity, phaseContext)
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
  if posOld == posNew then
    return
  end
  if teleportedEntity:HasPetPstID() then
    local boardService = world:GetService("BoardRender")
    local oldPos = teleportResult:GetPosOld()
    local oldColor = teleportResult:GetColorOld()
    boardService:ReCreateGridEntity(oldColor, oldPos)
  end
  local viewPosOld = posOld:Clone()
  local offset = teleportedEntity:GetGridOffset()
  if self._oriOffSet then
    viewPosOld = viewPosOld + self._oriOffSet
  elseif offset then
    viewPosOld = viewPosOld + offset
  end
  teleportedEntity:SetLocation(viewPosOld, dir)
  YIELD(TT)
  local distance = Vector2.Distance(posNew, posOld)
  local speed = self._speed
  if self._time then
    speed = distance / self._time * 1000
  end
  if teleportedEntity:HasMonsterID() then
    local renderEntityService = world:GetService("RenderEntity")
    renderEntityService:DestroyMonsterAreaOutLineEntity(teleportedEntity)
  end
  self:_PlayCasterControlGridDown(teleportedEntity, 0)
  while teleportedEntity:HasGridMove() do
    YIELD(TT)
  end
  teleportedEntity:SetAnimatorControllerTriggers({
    self._moveAni
  })
  if self._moveEffID and self._moveEffID ~= 0 then
    local effectService = world:GetService("Effect")
    effectService:CreateEffect(self._moveEffID, casterEntity)
  end
  local boardServiceRender = world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(teleportedEntity)
  teleportedEntity:AddGridMove(speed, posNew, gridPos)
  local trapServiceRender = world:GetService("TrapRender")
  local trapIDs = teleportResult:GetNeedDelTrapEntityIDs()
  if 0 < #trapIDs then
    local trapEntitys = {}
    for _, trapID in ipairs(trapIDs) do
      local trap = world:GetEntityByID(trapID)
      if trap then
        table.insert(trapEntitys, trap)
      end
    end
    trapServiceRender:PlayTrapDieSkill(TT, trapEntitys)
  end
  while teleportedEntity:HasGridMove() do
    YIELD(TT)
  end
  local viewPos = posNew:Clone()
  if offset then
    viewPos = viewPos + offset
  end
  teleportedEntity:SetLocation(viewPos, dir)
  local pieceService = world:GetService("Piece")
  if teleportedEntity:HasPetPstID() then
    local boardService = world:GetService("BoardRender")
    local newColor = teleportResult:GetColorNew()
    local newPos = teleportResult:GetPosNew()
    boardService:ReCreateGridEntity(newColor, newPos)
    trapServiceRender:ShowHideTrapAtPos(newPos, false)
    local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
    local teamLeaderEntity = teamEntity:Team():GetTeamLeaderEntity()
    local pets = teamEntity:Team():GetTeamPetEntities()
    for _, petEntity in ipairs(pets) do
      petEntity:SetLocation(posNew, dir)
    end
    teamEntity:SetLocation(posNew, dir)
    teamLeaderEntity:SetLocation(posNew, dir)
    pieceService:RemovePrismAt(newPos)
  elseif teleportedEntity:HasMonsterID() then
    local trapIDList = teleportResult:GetTriggerTrapIDList()
    local trapEntityList = {}
    for _, trapID in ipairs(trapIDList) do
      local trapEntity = world:GetEntityByID(trapID)
      trapEntityList[#trapEntityList + 1] = trapEntity
    end
    local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
    sPlaySkillInstruction:PlayTrapTrigger(TT, casterEntity, trapEntityList)
    local renderEntityService = world:GetService("RenderEntity")
    renderEntityService:DestroyMonsterAreaOutLineEntity(teleportedEntity)
    renderEntityService:CreateMonsterAreaOutlineEntity(teleportedEntity)
  elseif teleportedEntity:HasTrapID() and teleportedEntity:HasTrapRoundInfoRender() then
    local eid = teleportedEntity:TrapRoundInfoRender():GetRoundInfoEntityID()
    if eid then
      local eff = world:GetEntityByID(eid)
      eff:AddGridMove(self._speed, posNew, posOld)
    end
  end
  self:_PlayCasterControlGridDown(teleportedEntity, 1)
  if self._notifyBuff == 1 then
    world:GetService("PlayBuff"):PlayBuffView(TT, NTTeleport:New(teleportedEntity, posOld, posNew))
  end
end

function PlayTeleportTargetAsMovingInstruction:_PlayCasterControlGridDown(casterEntity, enable)
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

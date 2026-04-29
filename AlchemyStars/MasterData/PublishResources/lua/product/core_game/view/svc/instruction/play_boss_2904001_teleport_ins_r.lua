require("base_ins_r")
_class("PlayBoss2904001TeleportInstruction", BaseInstruction)
PlayBoss2904001TeleportInstruction = PlayBoss2904001TeleportInstruction

function PlayBoss2904001TeleportInstruction:Constructor(paramList)
  self._stockpileTimeMs = tonumber(paramList.stockpileTimeMs)
  self._stockpileAnimTriggerName = paramList.stockpileAnimTriggerName
  self._jumpTimeMs = tonumber(paramList.jumpTimeMs)
  self._jumpAnimTriggerName = paramList.jumpAnimTriggerName
  self._landTimeMs = tonumber(paramList.landTimeMs)
  self._landAnimTriggerName = paramList.landAnimTriggerName
end

function PlayBoss2904001TeleportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local casterPos = casterEntity:GetGridPosition()
  local targetPos = casterEntity:GetGridPosition()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local teleportResult = routineComponent:GetEffectResultByArray(SkillEffectType.Teleport)
  if teleportResult then
    casterPos = teleportResult:GetPosOld()
    local posNew = teleportResult:GetPosNew()
    if posNew then
      targetPos = posNew
    else
      targetPos = casterPos
    end
  end
  if self._stockpileAnimTriggerName then
    casterEntity:SetAnimatorControllerTriggers({
      self._stockpileAnimTriggerName
    })
  end
  YIELD(TT, self._stockpileTimeMs)
  if self._jumpAnimTriggerName then
    casterEntity:SetAnimatorControllerTriggers({
      self._jumpAnimTriggerName
    })
  end
  if casterPos ~= targetPos then
    local speed = Vector2.Distance(targetPos, casterPos) / self._jumpTimeMs * 1000
    casterEntity:AddGridMove(speed, targetPos, casterPos)
  end
  local pieceService = world:GetService("Piece")
  local renderEntityService = world:GetService("RenderEntity")
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  local bodyArea = casterEntity:BodyArea():GetArea()
  for _, body in ipairs(bodyArea) do
    pieceService:SetPieceAnimUp(casterPos + body)
  end
  YIELD(TT, self._jumpTimeMs)
  while casterEntity:HasGridMove() do
    YIELD(TT)
  end
  local trapServiceRender = world:GetService("TrapRender")
  trapServiceRender:ShowHideTrapAtPos(targetPos, false)
  local trapIDList = {}
  if teleportResult then
    trapIDList = teleportResult:GetTriggerTrapIDList()
  end
  local trapEntityList = {}
  for _, v in ipairs(trapIDList) do
    local trapEntity = world:GetEntityByID(v)
    trapEntityList[#trapEntityList + 1] = trapEntity
  end
  local sPlaySkillInstruction = world:GetService("PlaySkillInstruction")
  sPlaySkillInstruction:PlayTrapTrigger(TT, casterEntity, trapEntityList)
  renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
  if self._landAnimTriggerName then
    casterEntity:SetAnimatorControllerTriggers({
      self._landAnimTriggerName
    })
  end
  YIELD(TT, self._landTimeMs)
  for _, body in ipairs(bodyArea) do
    pieceService:SetPieceAnimDown(targetPos + body)
  end
end

function PlayBoss2904001TeleportInstruction:_PlayCasterControlGridDown(casterEntity, enable)
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

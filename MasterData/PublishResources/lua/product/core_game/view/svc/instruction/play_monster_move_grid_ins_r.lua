require("base_ins_r")
_class("PlayMonsterMoveGridInstruction", BaseInstruction)
PlayMonsterMoveGridInstruction = PlayMonsterMoveGridInstruction

function PlayMonsterMoveGridInstruction:Constructor(paramList)
end

function PlayMonsterMoveGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MonsterMoveGrid)
  if not results then
    Log.fatal("no results")
    return
  end
  local result = results[1]
  self._world = casterEntity:GetOwnerWorld()
  local walkResultList = result:GetWalkResultList()
  local casterIsDead = result:IsCasterDead()
  self:_DoWalk(TT, casterEntity, walkResultList, casterIsDead)
end

function PlayMonsterMoveGridInstruction:_DoWalk(TT, monsterEntity, walkResultList, casterIsDead)
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

function PlayMonsterMoveGridInstruction:_PlayArrivePos(TT, monsterEntity, walkRes)
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
end

function PlayMonsterMoveGridInstruction:_GetMoveSpeed(casterEntity)
  local cfgSvc = self._world:GetService("Config")
  local configData = cfgSvc:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local speed = configData:GetMonsterSpeed(monsterID)
  speed = speed or 1
  return speed
end

function PlayMonsterMoveGridInstruction:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

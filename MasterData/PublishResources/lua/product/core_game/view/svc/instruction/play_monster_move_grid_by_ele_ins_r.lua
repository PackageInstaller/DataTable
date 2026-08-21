require("base_ins_r")
_class("PlayMonsterMoveGridByEleInstruction", BaseInstruction)
PlayMonsterMoveGridByEleInstruction = PlayMonsterMoveGridByEleInstruction

function PlayMonsterMoveGridByEleInstruction:Constructor(paramList)
end

function PlayMonsterMoveGridByEleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.MonsterMoveGridByMonsterElement)
  if not results then
    Log.fatal("no results")
    return
  end
  local element = casterEntity:Element():GetPrimaryType()
  local result = results[1]
  self._world = casterEntity:GetOwnerWorld()
  local walkResultList = result:GetWalkResultList()
  local casterIsDead = result:IsCasterDead()
  self:_ShowLinkLine(TT, walkResultList, element)
  self:_DoWalk(TT, casterEntity, walkResultList, casterIsDead)
end

function PlayMonsterMoveGridByEleInstruction:_ShowLinkLine(TT, walkResultList, element)
  local linkageRenderService = self._world:GetService("LinkageRender")
  linkageRenderService:DestroyAllLinkLine()
  for i, v in ipairs(walkResultList) do
    if i ~= 1 then
      local resultBegin = walkResultList[i - 1]
      local beginPos = resultBegin:GetWalkPos()
      local curPos = v:GetWalkPos()
      local dir = beginPos - curPos
      linkageRenderService:CreateLineRender(beginPos, curPos, i, curPos, dir, element)
    end
  end
end

function PlayMonsterMoveGridByEleInstruction:_DestroyLinkLine(moveInPos)
  local entityPoolService = self._world:GetService("EntityPool")
  local reBoard = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  local previewEntity = self._world:GetPreviewEntity()
  local previewChainPathCmpt = previewEntity:PreviewChainPath()
  local chain_path = previewChainPathCmpt:GetPreviewChainPath()
  local remove_list = {}
  local exist_pos = {}
  local boardServiceRender = self._world:GetService("BoardRender")
  for _, link_line_entity in ipairs(allEntities) do
    local pos = boardServiceRender:GetRealEntityGridPos(link_line_entity)
    if pos == moveInPos then
      table.insert(remove_list, link_line_entity)
    end
  end
  local linkageRenderService = self._world:GetService("LinkageRender")
  for _, e in ipairs(remove_list) do
    linkageRenderService:DestroyLinkLine(e)
  end
end

function PlayMonsterMoveGridByEleInstruction:_DoWalk(TT, monsterEntity, walkResultList, casterIsDead)
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
    while monsterEntity:HasGridMove() do
      YIELD(TT)
    end
    self:_PlayArrivePos(TT, monsterEntity, walkRes)
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

function PlayMonsterMoveGridByEleInstruction:_PlayArrivePos(TT, monsterEntity, walkRes)
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
  self:_DestroyLinkLine(walkRes:GetWalkPos())
end

function PlayMonsterMoveGridByEleInstruction:_GetMoveSpeed(casterEntity)
  local cfgSvc = self._world:GetService("Config")
  local configData = cfgSvc:GetMonsterConfigData()
  local monsterIDCmpt = casterEntity:MonsterID()
  local monsterID = monsterIDCmpt:GetMonsterID()
  local speed = configData:GetMonsterSpeed(monsterID)
  speed = speed or 1
  return speed
end

function PlayMonsterMoveGridByEleInstruction:StartMoveAnimation(targetEntity, isMove)
  local curVal = targetEntity:GetAnimatorControllerBoolsData("Move")
  if curVal ~= isMove then
    targetEntity:SetAnimatorControllerBools({Move = isMove})
  end
end

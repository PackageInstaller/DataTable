_class("ChessServiceLogic", BaseService)
ChessServiceLogic = ChessServiceLogic

function ChessServiceLogic:DoChessPetPathMove()
  local boardEntity = self._world:GetBoardEntity()
  local logicChessPathComponent = boardEntity:LogicChessPath()
  local chessPath = logicChessPathComponent:GetLogicChessPath()
  local entityID = logicChessPathComponent:GetLogicChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  if not chessPetEntity then
    return
  end
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterWalkResultList = {}
  for _, pos in ipairs(chessPath) do
    if chessPetEntity:HasMonsterEscape() then
      break
    end
    local walkRes = MonsterWalkResult:New()
    local lastPos = chessPetEntity:GetGridPosition()
    boardServiceLogic:UpdateEntityBlockFlag(chessPetEntity, lastPos, pos)
    chessPetEntity:SetGridPosition(pos)
    walkRes:SetWalkPos(pos)
    self:_OnChessPetMoveArrivePos(chessPetEntity, walkRes)
    table.insert(monsterWalkResultList, walkRes)
  end
  logicChessPathComponent:SetLogicWalkResultList(monsterWalkResultList)
  return entityID
end

function ChessServiceLogic:_OnChessPetMoveArrivePos(chessPetEntity, walkRes)
  local utilSvc = self._world:GetService("UtilData")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(chessPetEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local passGrids = {}
  
  local function isDuplicate(pos)
    for _, value in ipairs(passGrids) do
      if value.x == pos.x and value.y == pos.y then
        return true
      end
    end
    return false
  end
  
  local bodyArea = chessPetEntity:BodyArea():GetArea()
  local dir = chessPetEntity:GridLocation():GetGridDir()
  local curPos = chessPetEntity:GetGridPosition()
  for _, value in ipairs(bodyArea) do
    local pos = curPos + value - dir
    if not isDuplicate(pos) then
      passGrids[#passGrids + 1] = pos
    end
  end
  walkRes:SetWalkPassedGrid(passGrids)
end

function ChessServiceLogic:DoChessPetAttack()
  local boardEntity = self._world:GetBoardEntity()
  local logicChessPathComponent = boardEntity:LogicChessPath()
  local chessPath = logicChessPathComponent:GetLogicChessPath()
  local entityID = logicChessPathComponent:GetLogicChessPetEntityID()
  local chessPetEntity = self._world:GetEntityByID(entityID)
  if not chessPetEntity then
    return
  end
  local chessPetCmpt = chessPetEntity:ChessPet()
  local attackSkill = chessPetCmpt:GetAttackSkillID()
  local ntChessPetSkillAttackStart = NTChessPetSkillAttackStart:New(chessPetEntity, attackSkill)
  self._world:GetService("Trigger"):Notify(ntChessPetSkillAttackStart)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  skillLogicSvc:CalcSkillEffect(chessPetEntity, attackSkill)
  local ntChessPetSkillAttackEnd = NTChessPetSkillAttackEnd:New(chessPetEntity, attackSkill)
  self._world:GetService("Trigger"):Notify(ntChessPetSkillAttackEnd)
end

function ChessServiceLogic:FinishChessPetTurn(finishAll, targetEntityID)
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  local chessPetEntities = group:GetEntities()
  for i, v in ipairs(chessPetEntities) do
    local chessPetCmpt = v:ChessPet()
    if finishAll then
      chessPetCmpt:SetChessPetFinishTurn(true)
    elseif targetEntityID == v:GetID() then
      chessPetCmpt:SetChessPetFinishTurn(true)
    end
  end
end

function ChessServiceLogic:IsAllChessPetTurnFinish()
  local group = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for i, entity in ipairs(group:GetEntities()) do
    if self:_OnCheckChessCanAction(entity) then
      return false
    end
  end
  return true
end

function ChessServiceLogic:_OnCheckChessCanAction(entity)
  if entity:HasDeadMark() then
    return false
  end
  local chessPetCmpt = entity:ChessPet()
  if chessPetCmpt:IsChessPetFinishTurn() then
    return false
  end
  if entity:HasMonsterEscape() then
    return false
  end
  local buffCmpt = entity:BuffComponent()
  local isSkipTurn = buffCmpt:HasFlag(BuffFlags.SkipTurn)
  if isSkipTurn then
    return false
  end
  return true
end

function ChessServiceLogic:DoChessPetListDeadLogic(deadEntityIDList)
  for _, v in ipairs(deadEntityIDList) do
    local e = self._world:GetEntityByID(v)
    self:AddChessPetDeadMark(e)
    self:_DoOneChessLogicDead(e)
  end
end

function ChessServiceLogic:_DoOneChessLogicDead(chessPetEntity)
  if not chessPetEntity:HasDeadMark() then
    return
  end
  local deadMarkCmpt = chessPetEntity:DeadMark()
  if deadMarkCmpt:HasDoLogicDead() then
    return
  end
  local chessPetCmpt = chessPetEntity:ChessPet()
  if not chessPetCmpt then
    return
  end
  deadMarkCmpt:SetDoLogicDead(true)
  local utilDataSvc = self._world:GetService("UtilData")
  local stateId = utilDataSvc:GetCurMainStateID()
  if stateId ~= GameStateID.ChessPetResult then
    self:_CalcChessPetDeathSkill(chessPetEntity)
  end
  local sBoard = self._world:GetService("BoardLogic")
  sBoard:RemoveEntityBlockFlag(chessPetEntity, chessPetEntity:GridLocation().Position)
  local sTrigger = self._world:GetService("Trigger")
  sTrigger:Notify(NTChessDead:New(chessPetEntity))
  chessPetEntity:SetGridPosition(Vector2(BattleConst.CacheHeight, BattleConst.CacheHeight))
end

function ChessServiceLogic:GetDeadChessPetList()
  local deadChessPetEntityIDList = {}
  local chessPetGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for _, e in ipairs(chessPetGroup:GetEntities()) do
    local attrCmpt = e:Attributes()
    local curHp = attrCmpt:GetCurrentHP()
    if curHp <= 0 and not e:HasDeadMark() then
      deadChessPetEntityIDList[#deadChessPetEntityIDList + 1] = e:GetID()
    end
  end
  return deadChessPetEntityIDList
end

function ChessServiceLogic:GetHasDeadMarkChessPetList()
  local deadChessPetEntityIDList = {}
  local chessPetGroup = self._world:GetGroup(self._world.BW_WEMatchers.ChessPet)
  for _, e in ipairs(chessPetGroup:GetEntities()) do
    local attrCmpt = e:Attributes()
    local curHp = attrCmpt:GetCurrentHP()
    if e:HasDeadMark() then
      deadChessPetEntityIDList[#deadChessPetEntityIDList + 1] = e:GetID()
    end
  end
  return deadChessPetEntityIDList
end

function ChessServiceLogic:AddChessPetDeadMark(e)
  if not e:HasChessPet() then
    return
  end
  local cAttributes = e:Attributes()
  local curHp = cAttributes:GetCurrentHP()
  if 0 < curHp then
    return
  end
  if e:HasDeadMark() then
    return
  end
  e:AddDeadMark()
  return e:DeadMark()
end

function ChessServiceLogic:_CalcChessPetDeathSkill(chessPetEntity)
  local chessPetCmpt = chessPetEntity:ChessPet()
  local deathSkillID = chessPetCmpt:GetDieSkillID()
  if deathSkillID and 0 < deathSkillID then
    local skillLogicService = self._world:GetService("SkillLogic")
    skillLogicService:CalcSkillEffect(chessPetEntity, deathSkillID)
    skillLogicService:UpdateRenderSkillRoutine(chessPetEntity)
  end
end

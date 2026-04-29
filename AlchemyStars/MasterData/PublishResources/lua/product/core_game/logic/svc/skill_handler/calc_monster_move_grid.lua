_class("SkillEffectCalc_MonsterMoveGrid", Object)
SkillEffectCalc_MonsterMoveGrid = SkillEffectCalc_MonsterMoveGrid

function SkillEffectCalc_MonsterMoveGrid:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_MonsterMoveGrid:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local param = skillEffectCalcParam.skillEffectParam
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  local movePath, pieceType = utilCalcSvc:GetMonsterMove2PlayerNearestPath(casterEntity, param:IsEnableAnyPiece())
  local isCasterDead = false
  local posWalkResultList = {}
  if pieceType then
    local oldPosList = {}
    for i, pos in ipairs(movePath) do
      local posSelf = casterEntity:GetGridPosition()
      local walkRes = MonsterMoveGridResult:New()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
      casterEntity:SetGridPosition(pos)
      casterEntity:SetGridDirection(pos - posSelf)
      local entityID = casterEntity:GetID()
      table.insert(posWalkResultList, walkRes)
      walkRes:SetWalkPos(pos)
      self:_OnArrivePos(casterEntity, walkRes)
      table.insert(oldPosList, pos)
      if casterEntity:HasDeadMark() then
        isCasterDead = true
        break
      end
    end
    local newPosList = sBoard:SupplyPieceList(oldPosList)
    local boardEntity = self._world:GetBoardEntity()
    local boardCmpt = boardEntity:Board()
    boardCmpt:FillPieces(newPosList)
    for i, walkRes in ipairs(posWalkResultList) do
      local newPos = newPosList[i]
      walkRes:SetNewGridType(newPos.color)
    end
  end
  local result = SkillEffectMonsterMoveGridResult:New(posWalkResultList, isCasterDead)
  return {result}
end

function SkillEffectCalc_MonsterMoveGrid:_OnArrivePos(casterEntity, walkRes)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local pos = casterEntity:GetGridPosition()
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.MonsterGridMove)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local nTrapCount = table.count(listTrapWork)
end

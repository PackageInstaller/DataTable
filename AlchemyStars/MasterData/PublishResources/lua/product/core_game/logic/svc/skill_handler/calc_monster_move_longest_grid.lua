_class("SkillEffectCalc_MonsterMoveLongestGrid", Object)
SkillEffectCalc_MonsterMoveLongestGrid = SkillEffectCalc_MonsterMoveLongestGrid

function SkillEffectCalc_MonsterMoveLongestGrid:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._arriveTrapIDs = {}
end

function SkillEffectCalc_MonsterMoveLongestGrid:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  local targetID = false
  if table.count(targetIDList) >= 1 then
    targetID = targetIDList[1]
  end
  if not targetID or targetID == -1 then
    Log.fatal("Need Target SkillID", skillEffectCalcParam:GetSkillID())
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  local param = skillEffectCalcParam.skillEffectParam
  self.skillID = skillEffectCalcParam.skillID
  local targetEntity = self._world:GetEntityByID(targetID)
  local movePath = {}
  if not targetEntity:HasDeadMark() then
    local findType = param:GetFindType()
    if findType == MonsterMoveLongestGridFindType.Normal then
      movePath = utilCalcSvc:FindMonsterLongestGridPath(casterEntity)
    elseif findType == MonsterMoveLongestGridFindType.MoreSpTraps then
      local trapID = param:GetLineNeedTrapID()
      local lineCount = param:GetLineCount()
      movePath = utilCalcSvc:FindMonsterLongestGridPathByTrapID(casterEntity, lineCount, trapID)
    elseif findType == MonsterMoveLongestGridFindType.Spiral then
      local runCountList = param:GetRunCountList()
      movePath = utilCalcSvc:FindMinosMoveGridPath(casterEntity, runCountList)
    end
  end
  local isCasterDead = false
  local posWalkResultList = {}
  local finalAttackResult
  local summonTrapResultList = {}
  local triggerService = self._world:GetService("Trigger")
  if #movePath ~= 0 then
    local oldPosList = {}
    for i, pos in ipairs(movePath) do
      local posSelf = casterEntity:GetGridPosition()
      local walkRes = MonsterMoveLongestGridResult:New()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
      casterEntity:SetGridPosition(pos)
      casterEntity:SetGridDirection(pos - posSelf)
      local entityID = casterEntity:GetID()
      table.insert(posWalkResultList, walkRes)
      walkRes:SetWalkPos(pos)
      triggerService:Notify(NTEffect156MoveOneGridBegin:New(casterEntity))
      self:_OnArrivePos(casterEntity, walkRes, param, targetEntity)
      triggerService:Notify(NTEffect156MoveOneGridEnd:New(casterEntity))
      table.insert(oldPosList, pos)
      if casterEntity:HasDeadMark() then
        isCasterDead = true
        break
      end
      if param:IsResetGrid() then
        local newPosList = sBoard:SupplyPieceList(oldPosList)
        local boardEntity = self._world:GetBoardEntity()
        local boardCmpt = boardEntity:Board()
        boardCmpt:FillPieces(newPosList)
        for i, walkRes in ipairs(posWalkResultList) do
          local newPos = newPosList[i]
          walkRes:SetNewGridType(newPos.color)
        end
      end
    end
    triggerService:Notify(NTEffect156MoveFinishBegin:New(casterEntity, #movePath))
    summonTrapResultList, finalAttackResult = self:_OnFinished(casterEntity, posWalkResultList, param, oldPosList, targetEntity)
    triggerService:Notify(NTEffect156MoveFinishEnd:New(casterEntity))
  end
  local casterPos = casterEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  local dir = targetPos - casterPos
  casterEntity:SetGridDirection(dir)
  triggerService:Notify(NTEffect156MoveFinish:New(casterEntity))
  local result = SkillEffectMonsterMoveLongestGridResult:New(posWalkResultList, isCasterDead, finalAttackResult, summonTrapResultList)
  return {result}
end

function SkillEffectCalc_MonsterMoveLongestGrid:_OnArrivePos(casterEntity, walkRes, param, targetEntity)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local pos = casterEntity:GetGridPosition()
  local trapIDsOnPos = trapServiceLogic:FindTrapByPos(pos)
  local arriveType = param._arrivePosType
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local triggerSvc = self._world:GetService("Trigger")
  local flushTrapIDs = param:GetFlushTrapIDs()
  local utilSvc = self._world:GetService("UtilData")
  local array = utilSvc:GetTrapsAtPos(pos)
  for _, eTrap in ipairs(array) do
    if eTrap then
      local trapIDCmpt = eTrap:TrapID()
      if flushTrapIDs[trapIDCmpt:GetTrapID()] then
        eTrap:Attributes():Modify("HP", 0)
        trapServiceLogic:AddTrapDeadMark(eTrap, param:GetDisableDieSkill())
        walkRes:SetFlushTrapID(eTrap:GetID())
        triggerSvc:Notify(NTMinosAbsorbTrap:New(eTrap))
      end
    end
  end
  local triggerService = self._world:GetService("Trigger")
  triggerService:Notify(NTEffect156MoveOneGrid:New(casterEntity, pos))
  local nTrapCount = table.count(listTrapWork)
  for i, entityID in ipairs(trapIDsOnPos) do
    local trapEntity = self._world:GetEntityByID(entityID)
    local trapID = trapEntity:TrapID():GetTrapID()
    table.insert(self._arriveTrapIDs, trapID)
    if arriveType == MonsterMoveLongestGridArrivePosType.NormalAndAttackAtSpTraps then
      local attackTrapIDs = param:GetAttackTrapIDs()
      if attackTrapIDs[trapID] then
        local attackResult = self:_Attack(casterEntity, targetEntity, param)
        walkRes:SetAttackResult(attackResult)
      end
    end
  end
end

function SkillEffectCalc_MonsterMoveLongestGrid:_OnFinished(casterEntity, posWalkResultList, param, oldPosList, targetEntity)
  local finishType = param:GetFinishType()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local summonTrapID = param:GetSummonTrapID()
  local summonTrapResultArray = {}
  local attackResult
  if finishType == MonsterMoveLongestGridMoveFinishType.ResetGridAndSummonTraps then
    local sBoard = self._world:GetService("BoardLogic")
    local newPosList = sBoard:SupplyPieceList(oldPosList)
    local boardEntity = self._world:GetBoardEntity()
    local boardCmpt = boardEntity:Board()
    boardCmpt:FillPieces(newPosList)
    for i, walkRes in ipairs(posWalkResultList) do
      local newPos = newPosList[i]
      walkRes:SetNewGridType(newPos.color)
    end
    for i, pos in ipairs(oldPosList) do
      if trapServiceLogic:CanSummonTrapOnPos(pos, summonTrapID) then
        local trapEntity = trapServiceLogic:CreateTrap(summonTrapID, pos, Vector2(0, 1), true, nil, casterEntity, param:IsTransferDisabled())
        local summonTrapResult = SkillSummonTrapEffectResult:New(summonTrapID, pos)
        summonTrapResult:SetTrapIDList({
          trapEntity:GetID()
        })
        table.insert(summonTrapResultArray, summonTrapResult)
      end
    end
    attackResult = self:_Attack(casterEntity, targetEntity, param, param:GetFinalAttackPercent())
  end
  if finishType == MonsterMoveLongestGridMoveFinishType.NoTrapsSummonTraps then
    local casterPos = casterEntity:GetGridPosition()
    local ringCount = param:GetSummonScopeRingCount()
    local rangeList = ComputeScopeRange.ComputeRange_SquareRing(casterPos, 1, ringCount)
    local trapCount = param:GetSummonTrapCount()
    if not table.icontains(self._arriveTrapIDs, summonTrapID) then
      local randomSvc = self._world:GetService("RandomLogic")
      while 0 < #rangeList and 0 < trapCount do
        local index = randomSvc:LogicRand(1, #rangeList)
        local pos = rangeList[index]
        if trapServiceLogic:CanSummonTrapOnPos(pos, summonTrapID) then
          local trapEntity = trapServiceLogic:CreateTrap(summonTrapID, pos, Vector2(0, 1), true, nil, casterEntity, param:IsTransferDisabled())
          local summonTrapResult = SkillSummonTrapEffectResult:New(summonTrapID, pos)
          summonTrapResult:SetTrapIDList({
            trapEntity:GetID()
          })
          table.insert(summonTrapResultArray, summonTrapResult)
          trapCount = trapCount - 1
        end
        table.remove(rangeList, index)
      end
    end
  end
  return summonTrapResultArray, attackResult
end

function SkillEffectCalc_MonsterMoveLongestGrid:_Attack(casterEntity, targetEntity, param, finalAttackPercent)
  local effectCalcSvc = self._skillEffectService
  local damageStageIndex = param:GetSkillEffectDamageStageIndex()
  local attackPos = casterEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  local percent = param:GetDamagePercent()
  if finalAttackPercent then
    percent = finalAttackPercent
  end
  local tmpParam = SkillDamageEffectParam:New({
    percent = percent,
    formulaID = param:GetDamageFormulaID(),
    damageStageIndex = damageStageIndex
  })
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, attackPos, targetEntity, targetPos, self.skillID, tmpParam, SkillEffectType.MonsterMoveLongestGrid, damageStageIndex)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(targetPos, targetEntity:GetID(), nTotalDamage, listDamageInfo, damageStageIndex)
  return skillResult
end

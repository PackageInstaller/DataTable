_class("SkillEffectCalc_MonsterMoveGridByParam", Object)
SkillEffectCalc_MonsterMoveGridByParam = SkillEffectCalc_MonsterMoveGridByParam

function SkillEffectCalc_MonsterMoveGridByParam:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._utilCalcSvc = self._world:GetService("UtilCalc")
  self._triggerSvc = self._world:GetService("Trigger")
end

function SkillEffectCalc_MonsterMoveGridByParam:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local targetID
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  if table.count(targetIDList) >= 1 then
    targetID = targetIDList[1]
  end
  if not targetID or targetID == -1 then
    Log.fatal("Need Target SkillID", skillEffectCalcParam:GetSkillID())
  end
  local sBoard = self._world:GetService("BoardLogic")
  local param = skillEffectCalcParam.skillEffectParam
  self.skillID = skillEffectCalcParam.skillID
  local targetEntity = self._world:GetEntityByID(targetID)
  local movePath = self:_FindMovePath(casterEntity, targetEntity, param)
  local posWalkResultList = {}
  local isCasterDead = false
  if #movePath ~= 0 then
    local oldPosList = {}
    for _, pos in ipairs(movePath) do
      local posSelf = casterEntity:GetGridPosition()
      local walkRes = MoveGridByParamResult:New()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
      casterEntity:SetGridPosition(pos)
      casterEntity:SetGridDirection(pos - posSelf)
      table.insert(posWalkResultList, walkRes)
      walkRes:SetWalkPos(pos)
      self:_OnArrivePos(casterEntity, walkRes, param, targetEntity)
      table.insert(oldPosList, pos)
      if casterEntity:HasDeadMark() then
        isCasterDead = true
        break
      end
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
  local casterPos = casterEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  local dir = targetPos - casterPos
  casterEntity:SetGridDirection(dir)
  local result = SkillEffectMonsterMoveGridByParamResult:New(posWalkResultList, isCasterDead)
  return {result}
end

function SkillEffectCalc_MonsterMoveGridByParam:_FindMovePath(casterEntity, targetEntity, param)
  local movePath = {}
  local pieceTypeList = {}
  local casterPieceType = casterEntity:Element():GetPrimaryType()
  table.insert(pieceTypeList, casterPieceType)
  local partnerIDList = param:GetPartnerIDList()
  local monsterEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, entity in ipairs(monsterEntityList) do
    local monsterIDCmpt = entity:MonsterID()
    local monsterClassID = monsterIDCmpt:GetMonsterClassID()
    if not entity:HasDeadMark() and table.icontains(partnerIDList, monsterClassID) then
      local pieceType = entity:Element():GetPrimaryType()
      table.insert(pieceTypeList, pieceType)
    end
  end
  local moveType = param:GetMoveType()
  if not targetEntity:HasDeadMark() then
    movePath = self._utilCalcSvc:FindPath_MonsterMoveGridByParam2(casterEntity, targetEntity, pieceTypeList, moveType)
  end
  return movePath
end

function SkillEffectCalc_MonsterMoveGridByParam:_CheckCanAttack(casterEntity, targetEntity, attackSkillID)
  if attackSkillID == 0 then
    return false
  end
  local pos = targetEntity:GetGridPosition()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local centerPos = casterEntity:GetGridPosition()
  local casterDir = casterEntity:GetGridDirection()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local configSvc = self._world:GetService("Config")
  local skillConfig = configSvc:GetSkillConfigData(attackSkillID)
  local skillCalculater = SkillScopeCalculator:New(utilScopeSvc)
  local result = skillCalculater:CalcSkillScope(skillConfig, centerPos, casterDir, bodyArea, casterEntity)
  local attackRange = result:GetAttackRange()
  return table.Vector2Include(attackRange, pos)
end

function SkillEffectCalc_MonsterMoveGridByParam:_OnArrivePos(casterEntity, walkRes, param, targetEntity)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local isAttack = self:_CheckCanAttack(casterEntity, targetEntity, param:GetAttackSkillID())
  if isAttack then
    local attackResult = self:_Attack(casterEntity, targetEntity, param)
    walkRes:SetAttackResult(attackResult)
    self._triggerSvc:Notify(NTSE189NormalEachAttackEnd:New(casterEntity))
  end
end

function SkillEffectCalc_MonsterMoveGridByParam:_Attack(casterEntity, targetEntity, param)
  local effectCalcSvc = self._skillEffectService
  local damageStageIndex = param:GetSkillEffectDamageStageIndex()
  local attackPos = casterEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  local percent = param:GetDamagePercent()
  local tmpParam = SkillDamageEffectParam:New({
    percent = percent,
    formulaID = param:GetDamageFormulaID(),
    damageStageIndex = damageStageIndex
  })
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, attackPos, targetEntity, targetPos, param:GetAttackSkillID(), tmpParam, SkillEffectType.MonsterMoveGridByParam, damageStageIndex)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(targetPos, targetEntity:GetID(), nTotalDamage, listDamageInfo, damageStageIndex)
  return skillResult
end

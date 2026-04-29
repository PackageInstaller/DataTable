_class("BuffLogicCreateTrapWithChainScope", BuffLogicBase)
BuffLogicCreateTrapWithChainScope = BuffLogicCreateTrapWithChainScope

function BuffLogicCreateTrapWithChainScope:Constructor(buffInstance, logicParam)
  self._trapID = logicParam.trapID
  self._useScopeType = logicParam.useScopeType or 0
  self._useScopeParam = logicParam.useScopeParam or {}
  self._addMulAttackPercent = logicParam.addMulAttackPercent or 0
  self._addMulAttackStart = logicParam.addMulAttackStart or 0
  self._addMulAttackEnd = logicParam.addMulAttackEnd or 0
  self._useCfgScope = logicParam.useCfgScope or {}
  self._useOwnerElement = logicParam.useOwnerElement or 0
end

function BuffLogicCreateTrapWithChainScope:DoLogic(notify)
  local ownerEntity = self._buffInstance:Entity()
  local petEntity
  if ownerEntity:HasPet() then
    petEntity = ownerEntity
  elseif ownerEntity:HasSummoner() then
    local buffSkillHolder = ownerEntity:GetSummonerEntity()
    if buffSkillHolder and buffSkillHolder:HasSuperEntity() then
      petEntity = buffSkillHolder:SuperEntityComponent():GetSuperEntity()
    end
  end
  if not petEntity then
    Log.error("BuffLogicCreateTrapWithChainScope not find petEntity, ownerEntity")
    return
  end
  local buffComponent = petEntity:BuffComponent()
  local saveChainSkillID = buffComponent:GetBuffValue("SavePetChainScope")
  if not saveChainSkillID or saveChainSkillID == 0 then
    return
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeFinalList = {}
  local utilData = self._world:GetService("UtilData")
  if self._useScopeType ~= 0 then
    local curPos = ownerEntity:GetGridPosition()
    local curBodyArea = ownerEntity:BodyArea():GetArea()
    local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
    local scopeResult = scopeCalculator:ComputeScopeRange(self._useScopeType, self._useScopeParam, curPos, curBodyArea)
    local attackRange = scopeResult:GetAttackRange()
    table.appendArray(scopeFinalList, attackRange)
  elseif 0 < table.count(self._useCfgScope) then
    local curPos = ownerEntity:GetGridPosition()
    local curBodyArea = ownerEntity:BodyArea():GetArea()
    local scopeType = 0
    local scopeParam = {}
    local cfgScope = self._useCfgScope[saveChainSkillID]
    if cfgScope then
      scopeType = cfgScope.scopeType
      scopeParam = cfgScope.scopeParam
    else
      local configService = self._world:GetService("Config")
      local skillConfigData = configService:GetSkillConfigData(saveChainSkillID)
      scopeType = skillConfigData:GetSkillScopeType()
      scopeParam = skillConfigData:GetSkillScopeParam()
    end
    local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
    local scopeResult = scopeCalculator:ComputeScopeRange(scopeType, scopeParam, curPos, curBodyArea)
    local attackRange = scopeResult:GetAttackRange()
    table.appendArray(scopeFinalList, attackRange)
  else
    local curPos = ownerEntity:GetGridPosition()
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(saveChainSkillID)
    local scopeResult = utilScopeSvc:CalcSkillScope(skillConfigData, curPos, ownerEntity)
    local chainScope = scopeResult:GetAttackRange()
    for _, grid in ipairs(chainScope) do
      if utilData:IsValidPiecePos(grid) then
        table.insert(scopeFinalList, grid)
      end
    end
  end
  local attrCmpt = petEntity:Attributes()
  local petAttack = attrCmpt:GetAttribute("Attack")
  local exElementParam = attrCmpt:GetAttribute("ExElementParam")
  local boardCmpt = self._world:GetBoardEntity():Board()
  if 0 < self._addMulAttackPercent then
    local saveFinalChainRate = buffComponent:GetBuffValue("SaveFinalChainRate")
    if saveFinalChainRate > self._addMulAttackEnd then
      saveFinalChainRate = self._addMulAttackEnd
    end
    local addMul = (saveFinalChainRate - self._addMulAttackStart) * self._addMulAttackPercent
    if 0 < addMul then
      petAttack = (addMul + 1) * petAttack
    end
  end
  local initAttributes = {}
  if self._useOwnerElement == 1 then
    initAttributes.Element = attrCmpt:GetAttribute("Element")
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local eIds = {}
  local result = BuffResultCreateTrapWithChainScope:New(eIds)
  for _, grid in ipairs(scopeFinalList) do
    local trapEntity = trapServiceLogic:CreateTrap(self._trapID, grid, Vector2(0, 0), false, initAttributes, ownerEntity)
    if trapEntity then
      local attributeComponent = trapEntity:Attributes()
      attributeComponent:Modify("Attack", petAttack)
      attributeComponent:Modify("ExElementParam", exElementParam)
      table.insert(eIds, trapEntity:GetID())
      local es = boardCmpt:GetPieceEntities(grid, function(e)
        return e:HasMonsterID() or e:Team()
      end)
      for _, target in ipairs(es) do
        local triggerTraps, triggerResults = trapServiceLogic:CalcTrapTriggerSkill(trapEntity, target)
        if triggerTraps then
          for i, trap in ipairs(triggerTraps) do
            local skillResult = triggerResults[i]
            result:AddTrapSkillResult(trap:GetID(), skillResult, target:GetID())
          end
        end
      end
    end
  end
  return result
end

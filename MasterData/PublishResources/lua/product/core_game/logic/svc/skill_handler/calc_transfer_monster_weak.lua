_class("SkillEffectCalc_TransferMonsterWeak", SkillEffectCalc_Base)
SkillEffectCalc_TransferMonsterWeak = SkillEffectCalc_TransferMonsterWeak

function SkillEffectCalc_TransferMonsterWeak:Constructor(world)
  self._world = world
end

function SkillEffectCalc_TransferMonsterWeak:DoSkillEffectCalculator(paramSECP)
  local casterID = paramSECP:GetCasterEntityID()
  local weakEntity = self._world:GetEntityByID(casterID)
  if weakEntity:HasSuperEntity() then
    weakEntity = weakEntity:GetSuperEntity()
  end
  if not weakEntity:HasMonsterWeak() then
    return
  end
  local monsterWeakCmpt = weakEntity:MonsterWeak()
  local weakCount = monsterWeakCmpt:GetMonsterWeakCount()
  local weakEdges = self:_OnGetNearestWeakEdges(weakEntity)
  local results = {}
  for i = 1, weakCount do
    local result = self:_CalculateTransferOneWeak(weakEntity, weakEdges[i], paramSECP)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_TransferMonsterWeak:_OnGetNearestWeakEdges(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local centerPos = entity:GridLocation():Center()
  local monsterList = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, entity in ipairs(monsterGroup:GetEntities()) do
    if utilDataSvc:OnCheckTargetCanAddWeak(entity:GetID()) then
      table.insert(monsterList, entity)
    end
  end
  local edgeList = {}
  for _, entity in ipairs(monsterList) do
    local tmpEdges = self:_GetInactiveMonsterWeakEdges(entity)
    if tmpEdges and 0 < #tmpEdges then
      table.appendArray(edgeList, tmpEdges)
    end
  end
  
  local function sortFun(dataA, dataB)
    local disA = self:_CalculateDistance(dataA, centerPos)
    local disB = self:_CalculateDistance(dataB, centerPos)
    return disA < disB
  end
  
  table.sort(edgeList, sortFun)
  return edgeList
end

function SkillEffectCalc_TransferMonsterWeak:_GetInactiveMonsterWeakEdges(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local allWeakEdges = utilDataSvc:OnGetEntityWeakEdgeDataList(entity:GetID())
  if not entity:HasMonsterWeak() then
    return allWeakEdges
  end
  local monsterWeakComponent = entity:MonsterWeak()
  local inactiveList = {}
  for _, weakEdge in ipairs(allWeakEdges) do
    if not monsterWeakComponent:GetMonsterWeakDataByKey(weakEdge:GetKey()) then
      table.insert(inactiveList, weakEdge)
    end
  end
  return inactiveList
end

function SkillEffectCalc_TransferMonsterWeak:_CalculateDistance(data, centerPos)
  local monsterEntity = self._world:GetEntityByID(data:GetEntityID())
  local monsterCenter = monsterEntity:GridLocation():Center()
  local disMin = 999999
  local edgePosList = data:GetEdgePosList()
  for _, edgePos in ipairs(edgePosList) do
    local edgePosCur = monsterCenter + edgePos
    local disCur = Vector2.Distance(centerPos, edgePosCur)
    if disMin > disCur then
      disMin = disCur
    end
  end
  return disMin
end

function SkillEffectCalc_TransferMonsterWeak:_CalculateTransferOneWeak(weakEntity, weakData, paramSECP)
  local resultEntityID = paramSECP:GetCasterEntityID()
  local weakResult = {}
  local damageResult = {}
  if weakData then
    resultEntityID = weakData:GetEntityID()
    table.insert(weakResult, weakData)
  else
    local damageSkillResult = self:_DoDamage(weakEntity, paramSECP)
    if damageSkillResult then
      resultEntityID = damageSkillResult:GetTargetID()
      table.insert(damageResult, damageSkillResult)
    end
  end
  local skillResult = SkillEffectResultAddMonsterWeak:New(resultEntityID, weakResult, damageResult)
  return skillResult
end

function SkillEffectCalc_TransferMonsterWeak:_DoDamage(weakEntity, paramSECP)
  local skillID = paramSECP:GetSkillID()
  local skillParam = paramSECP:GetSkillEffectParam()
  local damageStageIndex = skillParam:GetSkillEffectDamageStageIndex()
  local petTemplateID = skillParam:GetPetTemplateID()
  local castPetEntity
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, e in ipairs(pets) do
    local cPetPstID = e:PetPstID()
    if petTemplateID == cPetPstID:GetTemplateID() then
      castPetEntity = e
      break
    end
  end
  if not castPetEntity then
    return
  end
  local attackerPos = weakEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local monsterList, posList = utilScopeSvc:SelectNearestMonsterOnPos(attackerPos, 1)
  if #monsterList == 0 or #posList == 0 then
    return
  end
  local defender = monsterList[1]
  local defenderID = defender:GetID()
  local defenderPos = posList[1]
  local effectCalcSvc = self._skillEffectService
  local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(castPetEntity, attackerPos, defender, defenderPos, skillID, skillParam, SkillEffectType.TransferMonsterWeak, damageStageIndex)
  local skillResult = effectCalcSvc:NewSkillDamageEffectResult(defenderPos, defenderID, nTotalDamage, listDamageInfo, damageStageIndex)
  return skillResult
end

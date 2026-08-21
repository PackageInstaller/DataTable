_class("SkillEffectCalc_GatherThrowDamage", Object)
SkillEffectCalc_GatherThrowDamage = SkillEffectCalc_GatherThrowDamage

function SkillEffectCalc_GatherThrowDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_GatherThrowDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_GatherThrowDamage:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local param = skillEffectCalcParam.skillEffectParam
  local defenderEntity = self._world:GetEntityByID(targetID)
  if not defenderEntity then
    return
  end
  local monsterClassIdDic = param:GetMonsterClassIdDic()
  local utilSvc = self._world:GetService("UtilData")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local monsterList = {}
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  for _, pos in ipairs(skillEffectCalcParam.skillRange) do
    local entity = utilSvc:GetMonsterAtPos(pos)
    if entity then
      local nMonsterID = entity:MonsterID():GetMonsterID()
      local nMonsterClassID = monsterConfigData:GetMonsterClassID(nMonsterID)
      if monsterClassIdDic[nMonsterClassID] then
        table.insert(monsterList, entity:GetID())
      end
    end
  end
  local monsterCount = #monsterList
  local basePercent = param:GetBasePercent()
  local addVal = param:GetAddValue()
  local addPercent = addVal * monsterCount
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local svcCalcDamage = self._world:GetService("CalcDamage")
  local teamEntity = defenderEntity
  if defenderEntity:HasPet() then
    teamEntity = defenderEntity:Pet():GetOwnerTeamEntity()
  end
  local transTarEntityIds = {
    teamEntity:GetID()
  }
  local transEffCalcParam = SkillEffectCalcParam:New(targetID, transTarEntityIds, param:GetTeleportParam(), skillEffectCalcParam:GetSkillID(), param:GetTeleportScope())
  local teleportResultList = self._skillEffectService:CalcSkillEffectByType(transEffCalcParam)
  local damagePos = defenderEntity:GetGridPosition()
  local teleKillMonster = {}
  if 0 < #teleportResultList then
    local teleportInfo = teleportResultList[1]
    damagePos = teleportInfo:GetPosNew()
    local entity = utilSvc:GetMonsterAtPos(damagePos)
    if entity then
      local nMonsterID = entity:MonsterID():GetMonsterID()
      local nMonsterClassID = monsterConfigData:GetMonsterClassID(nMonsterID)
      if monsterClassIdDic[nMonsterClassID] then
        table.insert(teleKillMonster, entity:GetID())
      end
    end
  end
  local curFormulaID = param:GetThrowDamageFormulaID()
  if curFormulaID == nil then
    curFormulaID = 100
  end
  local skillDamageParam = SkillDamageEffectParam:New({
    percent = {basePercent},
    addPercent = addPercent,
    formulaID = curFormulaID,
    damageStageIndex = 1
  })
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), defenderEntity, damagePos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.GatherThrowDamage, 1)
  local damageInfo = listDamageInfo[1]
  local targetArray = {targetID}
  local target = self:_TransTargetData(targetArray)
  local damageInfoArray = {damageInfo}
  local serDamage = self._skillEffectService:NewSkillDamageEffectResult(damagePos, target, damageInfo:GetDamageValue(), damageInfoArray)
  return SkillEffectGatherThrowDamageResult:New(targetID, monsterList, teleportResultList, {serDamage}, teleKillMonster)
end

function SkillEffectCalc_GatherThrowDamage:_TransTargetData(targetData)
  local nReturn = 0
  if type(targetData) == "number" then
    nReturn = targetData
  elseif type(targetData) == "table" then
    nReturn = targetData[1]
  end
  return nReturn
end

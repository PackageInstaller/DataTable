require("pick_up_policy_base")
_class("PickUpPolicy_PetVice", PickUpPolicy_Base)
PickUpPolicy_PetVice = PickUpPolicy_PetVice

function PickUpPolicy_PetVice:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetVice(petEntity, activeSkillID)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetVice:_CalPickPosPolicy_PetVice(petEntity, activeSkillID)
  local targetEntity
  local utilSvc = self._world:GetService("UtilData")
  local utilData = self._world:GetService("UtilData")
  local configService = self._world:GetService("Config")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  if self._world:MatchType() == MatchType.MT_BlackFist then
    targetEntity = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
  else
    local bossEntityList = {}
    local targetEntityList = {}
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster(petEntity)
    for i, e in ipairs(monsterList) do
      local gridPos = e:GridLocation():GetGridPos()
      local bodyArea = e:BodyArea():GetArea()
      local hasCacPickPos = false
      for _, value in pairs(bodyArea) do
        local workPos = gridPos + value
        if self:_IsPosCanPick(workPos, true, true, utilSvc, extraBoardPosRange) then
          hasCacPickPos = true
          break
        end
      end
      if hasCacPickPos then
        if e:HasBoss() then
          table.insert(bossEntityList, e)
        end
        table.insert(targetEntityList, e)
      end
    end
    if table.count(bossEntityList) > 0 then
      targetEntityList = bossEntityList
    end
    local skillConfigData = configService:GetSkillConfigData(activeSkillID)
    local policyParam = skillConfigData:GetAutoFightPickPosPolicyParam()
    for i, e in ipairs(targetEntityList) do
      local buffCmp = e:BuffComponent()
      if buffCmp then
        local buffEffect = policyParam[1]
        if buffCmp:HasBuffEffect(buffEffect) then
          targetEntity = e
          break
        end
      end
    end
    if not targetEntity then
      local maxHP = 0
      for i, e in ipairs(targetEntityList) do
        local hp = e:Attributes():GetCurrentHP()
        if not targetEntity or maxHP < hp then
          maxHP = hp
          targetEntity = e
        end
      end
    end
  end
  if not targetEntity then
    return {}, {}, {}
  end
  local retScopeResult = {}
  local retTargetIds = {}
  local pickPos = targetEntity:GridLocation():GetGridPos()
  if not self:_IsPosCanPick(pickPos, true, true, utilSvc, extraBoardPosRange) then
    local bodyArea = targetEntity:BodyArea():GetArea()
    for _, value in pairs(bodyArea) do
      local workPos = pickPos + value
      local isCanPickPos = self:_IsPosCanPick(workPos, true, true, utilSvc, extraBoardPosRange)
      if isCanPickPos then
        pickPos = workPos
        break
      end
    end
  end
  retScopeResult, retTargetIds = self:_CalcSkillScopeResultAndTargets_PickUpPolicy(petEntity, activeSkillID, pickPos)
  return {pickPos}, retScopeResult:GetAttackRange(), retTargetIds
end

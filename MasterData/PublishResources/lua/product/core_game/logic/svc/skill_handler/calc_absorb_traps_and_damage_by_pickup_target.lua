_class("SkillEffectCalc_AbsorbTrapsAndDamageByPickupTarget", Object)
SkillEffectCalc_AbsorbTrapsAndDamageByPickupTarget = SkillEffectCalc_AbsorbTrapsAndDamageByPickupTarget

function SkillEffectCalc_AbsorbTrapsAndDamageByPickupTarget:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_AbsorbTrapsAndDamageByPickupTarget:DoSkillEffectCalculator(skillEffectCalcParam)
  if not self:_CanAbsorb(skillEffectCalcParam) then
    return
  end
  local param = skillEffectCalcParam.skillEffectParam
  local attackCount = 1
  local trapID = param:GetTrapID()
  local trapEntityIDs = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  for i, e in ipairs(trapGroup:GetEntities()) do
    local isTargetTrap = true
    isTargetTrap = isTargetTrap and not e:HasDeadMark()
    isTargetTrap = isTargetTrap and e:TrapID():GetTrapID() == trapID
    isTargetTrap = isTargetTrap and e:HasSummoner()
    if isTargetTrap then
      local summonerID = e:Summoner():GetSummonerEntityID()
      local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
      if summonerID == skillEffectCalcParam.casterEntityID then
        isTargetTrap = true
      elseif casterEntity:HasPet() then
        local eTeam = casterEntity:Pet():GetOwnerTeamEntity()
        local summonerID = e:Summoner():GetSummonerEntityID()
        local pets = eTeam:Team():GetTeamPetEntities()
        local isTeamPetSummoner = false
        for _, ePet in ipairs(pets) do
          if ePet:GetID() == summonerID then
            isTeamPetSummoner = true
            break
          end
        end
        isTargetTrap = isTeamPetSummoner
      end
    end
    if isTargetTrap then
      table.insert(trapEntityIDs, e:GetID())
    end
  end
  local trapCount = #trapEntityIDs
  attackCount = attackCount + trapCount
  local basePercent = param:GetBasePercent()
  local addPercent = param:GetAddPercent()
  local limitPercent = param:GetLimitPercent()
  local curFormulaID = param:GetFormulaID()
  if curFormulaID == nil then
    curFormulaID = 100
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterGridPos = casterEntity:GetGridPosition()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local targetType = param:GetDamageTargetType()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local damageScopeResult = scopeCalculator:ComputeScopeRange(param:GetDamageScopeType(), param:GetDamageScopeParam(), casterGridPos, casterBodyArea, casterEntity:GridLocation():GetGridDir(), targetType)
  local targetArray = utilScopeSvc:SelectSkillTarget(casterEntity, targetType, damageScopeResult)
  targetArray = table.unique(targetArray)
  local targetDisArray = utilScopeSvc:SortMonstersListByPos(casterGridPos, targetArray, true)
  local skillDamageResArray = {}
  for i = 1, attackCount do
    if #targetDisArray == 0 then
      break
    end
    local targetEntity = targetDisArray[1].monster_e
    local targetPos = targetDisArray[1].pos
    local disX = math.abs(casterGridPos.x - targetPos.x)
    local disY = math.abs(casterGridPos.y - targetPos.y)
    local disRingCount = math.max(disX, disY) - 1
    local curAdd = addPercent * disRingCount
    if limitPercent and math.abs(curAdd) > math.abs(limitPercent) then
      curAdd = limitPercent
    end
    local curPercent = basePercent * (1 + curAdd)
    local skillDamageParam = SkillDamageEffectParam:New({
      percent = {curPercent},
      formulaID = curFormulaID,
      damageStageIndex = 1
    })
    local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterEntity:GetGridPosition(), targetEntity, targetPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.AbsorbTrapsAndDamageByPickupTarget, 1)
    local damageInfo = listDamageInfo[1]
    local damageInfoArray = {damageInfo}
    local serDamage = self._skillEffectService:NewSkillDamageEffectResult(targetPos, targetEntity:GetID(), damageInfo:GetDamageValue(), damageInfoArray)
    table.insert(skillDamageResArray, serDamage)
    local currentHP = targetEntity:Attributes():GetCurrentHP()
    if currentHP <= 0 then
      table.remove(targetDisArray, 1)
    end
  end
  local result = SkillEffectAbsorbTrapsAndDamageByPickupTargetResult:New(trapEntityIDs, skillDamageResArray)
  local btsvc = self._world:GetService("Battle")
  if btsvc:IsFinalAttack() then
    result:SetFinalAttackIndex(#skillDamageResArray)
  end
  return result
end

function SkillEffectCalc_AbsorbTrapsAndDamageByPickupTarget:_CanAbsorb(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  if skillResult then
    return true
  end
  return false
end

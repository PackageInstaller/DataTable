_class("SkillEffectCalc_AlphaBlinkAttack", Object)
SkillEffectCalc_AlphaBlinkAttack = SkillEffectCalc_AlphaBlinkAttack

function SkillEffectCalc_AlphaBlinkAttack:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._rideSvc = self._world:GetService("RideLogic")
end

function SkillEffectCalc_AlphaBlinkAttack:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local effectParam = skillEffectCalcParam.skillEffectParam
  local backOffset = effectParam:GetBackOffset()
  local trapID = effectParam:GetTrapID()
  local height = effectParam:GetTrapHeight()
  local attackPos, teleportPos = self:CalcPos(casterEntity, backOffset, trapID)
  if not attackPos or not teleportPos then
    return
  end
  local summonPosList = self:CalcSummonTrap(trapID, attackPos, teleportPos)
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local centerPos = teamEntity:GetGridPosition()
  local attackDir = centerPos - attackPos
  local result = SkillEffectAlphaBlinkAttackResult:New(casterPos, attackPos, attackDir, teleportPos, height, trapID, summonPosList)
  return result
end

function SkillEffectCalc_AlphaBlinkAttack:CalcPos(casterEntity, backOffset, trapID)
  local casterPos = casterEntity:GetGridPosition()
  local teamEntity = self._world:Player():GetLocalTeamEntity()
  local centerPos = teamEntity:GetGridPosition()
  local bodyArea = teamEntity:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local scopeRes = skillCalc:ComputeScopeRange(SkillScopeType.CrossABackBNearCaster, {backOffset, trapID}, centerPos, bodyArea, nil, nil, casterPos)
  local posList = scopeRes:GetAttackRange()
  if #posList < 2 then
    return
  end
  return posList[1], posList[2]
end

function SkillEffectCalc_AlphaBlinkAttack:CalcSummonTrap(trapID, attackPos, teleportPos)
  local summonPosList = {}
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  if not utilScopeSvc:IsPosHasTrapByTrapID(attackPos, trapID) then
    table.insert(summonPosList, attackPos)
  end
  if not utilScopeSvc:IsPosHasTrapByTrapID(teleportPos, trapID) then
    table.insert(summonPosList, teleportPos)
  end
  return summonPosList
end

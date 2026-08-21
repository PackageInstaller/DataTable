require("calc_damage")
_class("SkillEffectCalc_DynamicCenterDamage", SkillEffectCalc_Damage)
SkillEffectCalc_DynamicCenterDamage = SkillEffectCalc_DynamicCenterDamage

function SkillEffectCalc_DynamicCenterDamage:SelectCenter(casterEntity, effectParam, centerPos, skillID)
  local centerScopeType = effectParam:GetCenterScopeType()
  local centerScopeParam = effectParam:GetCenterScopeParam()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCal = SkillScopeCalculator:New(utilScopeSvc)
  local centerScope = scopeCal:ComputeScopeRange(centerScopeType, centerScopeParam, centerPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), SkillTargetType.MonsterTrap, casterEntity:GetGridPosition(), casterEntity)
  utilScopeSvc:ExpandMaxChainSkillScope(casterEntity, skillID, centerScope, centerPos)
  local selector = SkillScopeTargetSelector:New(self._world)
  local tTargetID = selector:DoSelectSkillTarget(casterEntity, SkillTargetType.MonsterTrap, centerScope)
  if #tTargetID == 0 or table.icontains(tTargetID, -1) then
    return {}, SkillScopeResult:New(SkillScopeType.None, Vector2.zero, {}, {})
  end
  return tTargetID, centerScope
end

function SkillEffectCalc_DynamicCenterDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local tTargetID, centerScope = self:SelectCenter(casterEntity, effectParam, skillEffectCalcParam:GetCenterPos(), skillEffectCalcParam:GetSkillID())
  if not centerScope then
    return {}
  end
  local centerScopeAttackRange = centerScope:GetAttackRange() or {}
  local casterPos = casterEntity:GetGridPosition()
  local candidates = {}
  local trapCandidates = {}
  for _, eid in ipairs(tTargetID) do
    local e = self._world:GetEntityByID(eid)
    local gridPos = e:GetGridPosition()
    local nearestGrid = gridPos
    local nearestDistance = math.abs(casterPos.x - gridPos.x) + math.abs(casterPos.y - gridPos.y)
    local bodyArea = e:BodyArea():GetArea()
    if 1 < #bodyArea then
      for i = 2, #bodyArea do
        local v2 = bodyArea[i] + gridPos
        if table.Vector2Include(centerScopeAttackRange, v2) then
          local dis = math.abs(casterPos.x - v2.x) + math.abs(casterPos.y - v2.y)
          if nearestDistance > dis then
            nearestDistance = dis
            nearestGrid = v2
          end
        end
      end
    end
    local isTrap = e:HasTrap()
    local data = {
      eid = eid,
      v2 = nearestGrid,
      distance = nearestDistance
    }
    if isTrap then
      table.insert(trapCandidates, data)
    else
      table.insert(candidates, data)
    end
  end
  if #candidates == 0 then
    if #trapCandidates ~= 0 then
      candidates = trapCandidates
    else
      return {}
    end
  end
  local nearestCandidates = {}
  local dis = candidates[1].distance
  for _, data in ipairs(candidates) do
    if dis == data.distance then
      table.insert(nearestCandidates, data)
    elseif dis > data.distance then
      dis = data.distance
      nearestCandidates = {}
      table.insert(nearestCandidates, data)
    end
  end
  local finalCenterEntity = self._world:GetEntityByID(nearestCandidates[1].eid)
  local finalCenterPos = nearestCandidates[1].v2
  local hpPercent = 0
  if 1 < #nearestCandidates then
    for _, data in ipairs(nearestCandidates) do
      local eid = data.eid
      local e = self._world:GetEntityByID(eid)
      local attr = e:Attributes()
      local hp = attr:GetCurrentHP()
      local maxHP = attr:CalcMaxHp()
      local pct = hp / maxHP
      if hpPercent < pct then
        finalCenterEntity = e
        finalCenterPos = data.v2
        hpPercent = pct
      end
    end
  end
  local skillConfigData = self._world:GetService("Config"):GetSkillConfigData(skillEffectCalcParam:GetSkillID(), casterEntity)
  local damageScopeType = skillConfigData:GetSkillScopeType()
  local damageScopeParam = skillConfigData:GetSkillScopeParam()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCal = SkillScopeCalculator:New(utilScopeSvc)
  local damageScope = scopeCal:ComputeScopeRange(damageScopeType, damageScopeParam, finalCenterPos, {
    Vector2.zero
  }, finalCenterEntity:GetGridDirection(), skillConfigData:GetSkillTargetType(), finalCenterPos, finalCenterEntity)
  local selector = SkillScopeTargetSelector:New(self._world)
  local targetIDs = selector:DoSelectSkillTarget(casterEntity, skillConfigData:GetSkillTargetType(), damageScope, skillEffectCalcParam:GetSkillID(), skillConfigData:GetSkillTargetTypeParam())
  local damageResults = {}
  local utilData = self._world:GetService("UtilData")
  local targets = {}
  for _, id in ipairs(targetIDs) do
    if not table.icontains(targets, id) then
      table.insert(targets, id)
    end
  end
  local attackRange = damageScope:GetAttackRange() or {}
  for _, id in ipairs(targets) do
    local e = self._world:GetEntityByID(id)
    local gridPos = e:GetGridPosition()
    local bodyArea = e:BodyArea():GetArea() or {
      Vector2.zero
    }
    for _, v2Body in ipairs(bodyArea) do
      local v2 = gridPos + v2Body
      if table.Vector2Include(attackRange, v2) then
        local calcParam = SkillEffectCalcParam:New(skillEffectCalcParam.casterEntityID, {
          e:GetID()
        }, skillEffectCalcParam.skillEffectParam, skillEffectCalcParam.skillID, damageScope:GetAttackRange(), skillEffectCalcParam.attackPos, v2, skillEffectCalcParam.centerPos, damageScope:GetWholeGridRange())
        local r = SkillEffectCalc_DynamicCenterDamage.super.DoSkillEffectCalculator(self, calcParam)
        if r and 0 < #r then
          table.appendArray(damageResults, r)
        end
      end
    end
  end
  local result = SkillEffectResult_DynamicCenterDamage:New(damageScope, damageResults, finalCenterPos)
  return {result}
end

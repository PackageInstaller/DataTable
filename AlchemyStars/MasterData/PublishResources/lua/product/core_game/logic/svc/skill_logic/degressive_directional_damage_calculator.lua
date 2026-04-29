_class("DegressiveDirectionalDamageCalculator", Object)
DegressiveDirectionalDamageCalculator = DegressiveDirectionalDamageCalculator

function DegressiveDirectionalDamageCalculator:Constructor(world)
  self._world = world
end

function DegressiveDirectionalDamageCalculator:GetNewScopeCenter(casterEntity, effectParam)
  local pickupComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    Log.error(self._className, "施法者没有ActiveSkillPickupComponent")
    return
  end
  local pickupPosArray = pickupComponent:GetAllValidPickUpGridPos()
  if #pickupPosArray == 0 then
    Log.error(self._className, "没有点选位置记录")
    return
  end
  local selectedPickupPos = pickupPosArray[1]
  local v2CasterPos = casterEntity:GetGridPosition()
  local directionType = effectParam:GetDirection()
  local v2Dir = selectedPickupPos - v2CasterPos
  if 0 < v2Dir.x then
    v2Dir.x = 1
  elseif 0 > v2Dir.x then
    v2Dir.x = -1
  end
  if 0 < v2Dir.y then
    v2Dir.y = 1
  elseif 0 > v2Dir.y then
    v2Dir.y = -1
  end
  local v2 = Vector2.zero
  if directionType == DegressiveDamageDirection.PICKUP_POS then
  elseif directionType == DegressiveDamageDirection.PICKUP_LEFT_CORNER then
    if v2Dir == Vector2.up then
      v2 = Vector2.New(-1, 1)
    elseif v2Dir == Vector2.down then
      v2 = Vector2.New(1, -1)
    elseif v2Dir == Vector2.left then
      v2 = Vector2.New(-1, -1)
    elseif v2Dir == Vector2.right then
      v2 = Vector2.New(1, 1)
    end
  elseif directionType == DegressiveDamageDirection.PICKUP_RIGHT_CORNER then
    if v2Dir == Vector2.up then
      v2 = Vector2.New(1, 1)
    elseif v2Dir == Vector2.down then
      v2 = Vector2.New(-1, -1)
    elseif v2Dir == Vector2.left then
      v2 = Vector2.New(-1, 1)
    elseif v2Dir == Vector2.right then
      v2 = Vector2.New(1, -1)
    end
  elseif directionType == DegressiveDamageDirection.PICKUP_FRONT_LEFT then
    if v2Dir == Vector2.up then
      v2 = Vector2.New(-1, 0)
    elseif v2Dir == Vector2.down then
      v2 = Vector2.New(1, 0)
    elseif v2Dir == Vector2.left then
      v2 = Vector2.New(0, -1)
    elseif v2Dir == Vector2.right then
      v2 = Vector2.New(0, 1)
    end
  elseif directionType == DegressiveDamageDirection.PICKUP_FRONT_RIGHT then
    if v2Dir == Vector2.up then
      v2 = Vector2.New(1, 0)
    elseif v2Dir == Vector2.down then
      v2 = Vector2.New(-1, 0)
    elseif v2Dir == Vector2.left then
      v2 = Vector2.New(0, 1)
    elseif v2Dir == Vector2.right then
      v2 = Vector2.New(0, -1)
    end
  end
  v2 = v2 + v2CasterPos
  return v2
end

function DegressiveDirectionalDamageCalculator:Calculate(casterEntity, effectParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local sep = effectParam
  local scopeType = sep:GetSkillEffectScopeType()
  local scopeParamRaw = sep:GetSkillEffectScopeParam()
  local targetType = sep:GetSkillEffectTargetType()
  local configSvc = self._world:GetService("Config")
  local helper = configSvc._skillConfigHelper
  local parser = helper._scopeParamParser
  local scopeParam = parser:ParseScopeParam(scopeType, scopeParamRaw)
  if scopeType == nil or scopeParam == nil or targetType == nil then
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(skillID)
    scopeType = skillConfigData:GetSkillScopeType()
    scopeParam = skillConfigData:GetSkillScopeParam()
    targetType = skillConfigData:GetSkillTargetType()
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = utilScopeSvc:GetSkillScopeCalc()
  local v2CenterPos = self:GetNewScopeCenter(casterEntity, effectParam)
  local scopeResult = scopeCalc:ComputeScopeRange(scopeType, scopeParam, v2CenterPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), targetType, casterEntity:GetGridPosition())
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetIDArray = targetSelector:DoSelectSkillTarget(casterEntity, targetType, scopeResult, skillID)
  local dicTargetIDPos = {}
  local selectEntityIDByPosIndex = {}
  for _, id in ipairs(targetIDArray) do
    local e = self._world:GetEntityByID(id)
    local bodyArea = e:BodyArea():GetArea()
    for __, v2Relative in ipairs(bodyArea) do
      local v2 = v2Relative + e:GetGridPosition()
      local posIndex = Vector2.Pos2Index(v2)
      if table.icontains(scopeResult:GetAttackRange(), v2) and not selectEntityIDByPosIndex[posIndex] then
        local selectedID = id
        if e:HasRide() then
          local cRide = e:Ride()
          local mountID = cRide:GetMountID()
          selectedID = mountID
        end
        if not dicTargetIDPos[selectedID] then
          dicTargetIDPos[selectedID] = {}
        end
        table.insert(dicTargetIDPos[selectedID], v2)
        selectEntityIDByPosIndex[posIndex] = selectedID
      end
    end
  end
  local utilScope = self._world:GetService("UtilScopeCalc")
  local v2CasterGridPos = casterEntity:GetGridPosition()
  local tTargetDistanceInfo = utilScope:GetEntityDistanceInfoArrayByPosDic(targetIDArray, v2CasterGridPos, dicTargetIDPos)
  local damageStageIndex = effectParam:GetSkillEffectDamageStageIndex()
  local cSkillContext = casterEntity:SkillContext()
  local tDamageResults = {}
  local sMonsterShowLogic = self._world:GetService("MonsterShowLogic")
  local effectCalcSvc = self._world:GetService("SkillEffectCalc")
  local tResults = {}
  local damageRates = effectParam:GetDegressiveRates()
  for i = 1, #damageRates do
    local index = i
    local damageRate = damageRates[i]
    local targetDistanceInfo = tTargetDistanceInfo[index]
    if not targetDistanceInfo then
      break
    end
    local eTargetID = targetDistanceInfo.targetID
    local eTarget = self._world:GetEntityByID(eTargetID)
    cSkillContext:SetDegressiveDamageParam(damageRate)
    local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, v2CasterGridPos, eTarget, targetDistanceInfo.gridPos, skillID, effectParam, SkillEffectType.Damage, damageStageIndex)
    local skillResult = effectCalcSvc:NewSkillDamageEffectResult(targetDistanceInfo.gridPos, targetDistanceInfo.targetID, nTotalDamage, listDamageInfo, damageStageIndex)
    skillResult:SetSkillEffectScopeResult(scopeResult)
    if eTarget:HasMonsterID() then
      local currentHP = eTarget:Attributes():GetCurrentHP()
      if currentHP <= 0 then
        sMonsterShowLogic:AddMonsterDeadMark(eTarget)
      end
    end
    local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
    skillEffectResultContainer:AddEffectResult(skillResult)
    table.insert(tResults, skillResult)
  end
  return tResults
end

require("scope_base")
_class("SkillScopeCalculator_PickUpFrontExtendWithDamage", SkillScopeCalculator_Base)
SkillScopeCalculator_PickUpFrontExtendWithDamage = SkillScopeCalculator_PickUpFrontExtendWithDamage

function SkillScopeCalculator_PickUpFrontExtendWithDamage:CalcRange(scopeType, scopeParam, centerPos, bodyArea, casterDir, nTargetType, casterPos, casterEntity, calcEffectFcuntion)
  self._baseLength = scopeParam[1]
  self._calcExtend = scopeParam[2] or 1
  self._crossExtendLength = scopeParam[3] or 0
  self._extendDamage = scopeParam[4] or 1
  self._calcBlock = scopeParam[5] or 1
  self._oneGridAddDamagePercent = scopeParam[6] or 0
  self._hadExtendTargetIDs = {}
  self._calcEffectFcuntion = calcEffectFcuntion
  self._blocks = self._gridFilter:GetBlockGridTrapPosList()
  local world = self._gridFilter._world
  local pickUpCenterPos = centerPos[1]
  local pickUpSecondPos = centerPos[2]
  local activeSkillPickUpComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickUpSecondPos and activeSkillPickUpComponent then
    pickUpCenterPos = activeSkillPickUpComponent:GetFirstValidPickUpGridPos()
    pickUpSecondPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
  end
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  if not activeSkillPickUpComponent and not pickUpSecondPos and previewPickUpComponent then
    pickUpCenterPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
    pickUpSecondPos = previewPickUpComponent:GetLastPickUpGridPos()
  end
  local pickUpDir = pickUpSecondPos - pickUpCenterPos
  self._scopeGridDictionary = {}
  self._scopeGridList = {}
  self._hadCalcDamageGridList = {}
  local stepOneGridList = {}
  stepOneGridList = self:_CalcScopeWithDirAndBlock(pickUpCenterPos, pickUpDir, self._baseLength - 1)
  if self._calcExtend == 0 then
    local resultNotExtend = SkillScopeResult:New(SkillScopeType.PickUpFrontExtendWithDamage, pickUpCenterPos, stepOneGridList, stepOneGridList)
    return resultNotExtend
  end
  local stepThreeGridList = {}
  stepThreeGridList = self:_CalcEachPosCross(stepOneGridList, true, casterEntity)
  local scopeResultRange = {}
  local specialScopeResult = {}
  for i, posList in ipairs(self._scopeGridDictionary) do
    table.appendArray(scopeResultRange, posList)
    for _, pos in ipairs(posList) do
      local specialScope = SkillScopeGrid:New(i, pos)
      table.insert(specialScopeResult, specialScope)
    end
  end
  local result = SkillScopeResult:New(SkillScopeType.PickUpFrontExtendWithDamage, pickUpCenterPos, scopeResultRange, scopeResultRange)
  result:SetSpecialScopeResult(specialScopeResult)
  return result
end

function SkillScopeCalculator_PickUpFrontExtendWithDamage:_CalcEachPosCross(gridPosList, firstCalc, casterEntity)
  local addGridList = {}
  local world = self._gridFilter._world
  local targetSelector = world:GetSkillScopeTargetSelector()
  local configService = world:GetService("Config")
  local trapConfigData = configService:GetTrapConfigData()
  local dirExtendList = {}
  table.insert(dirExtendList, Vector2(1, 0))
  table.insert(dirExtendList, Vector2(-1, 0))
  table.insert(dirExtendList, Vector2(0, 1))
  table.insert(dirExtendList, Vector2(0, -1))
  for i, pos in ipairs(gridPosList) do
    if firstCalc or not table.icontains(self._hadCalcDamageGridList, pos) then
      table.insert(self._hadCalcDamageGridList, pos)
      local scope = SkillScopeResult:New(SkillScopeType.None, pos, {pos}, {pos})
      local targetIDArray = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.MonsterTrap, scope)
      local canExtend = false
      if targetIDArray and 0 < table.count(targetIDArray) then
        local hasDamage = true
        if self._extendDamage == 1 and self._calcEffectFcuntion ~= nil then
          local baseIndex = self:_CalcBaseIndex(pos)
          local addDamagePercent = self._oneGridAddDamagePercent * (baseIndex - 1)
          local results = self._calcEffectFcuntion(pos, targetIDArray, addDamagePercent)
          for _, result in ipairs(results) do
            local damageResult = result
            local damageInfoArray = damageResult:GetDamageInfoArray()
            if damageInfoArray then
              for _, damageInfo in ipairs(damageInfoArray) do
                if damageInfo:GetDamageType() == DamageType.Miss then
                  hasDamage = false
                  break
                end
              end
            end
          end
        end
        for _, id in ipairs(targetIDArray) do
          local entity = world:GetEntityByID(id)
          if not table.icontains(self._hadExtendTargetIDs, entity:GetID()) and hasDamage then
            if entity:HasMonsterID() then
              table.insert(self._hadExtendTargetIDs, entity:GetID())
              canExtend = true
            elseif entity:HasTrap() then
              local trapID = entity:TrapID():GetTrapID()
              local trapData = trapConfigData:GetTrapData(trapID)
              if trapData.HPSliderType ~= 1 then
                table.insert(self._hadExtendTargetIDs, entity:GetID())
                canExtend = true
              end
            end
          end
        end
      end
      if canExtend then
        for _, dir in ipairs(dirExtendList) do
          local curDirAddGridList = self:_CalcScopeWithDirAndBlock(pos, dir, self._crossExtendLength)
          table.appendArray(addGridList, curDirAddGridList)
        end
      end
    end
  end
  if 0 < table.count(addGridList) then
    local nextAddGridList = self:_CalcEachPosCross(addGridList, false, casterEntity)
    table.appendArray(addGridList, nextAddGridList)
  end
  return addGridList
end

function SkillScopeCalculator_PickUpFrontExtendWithDamage:_CalcScopeWithDirAndBlock(gridPos, dir, length)
  local addGridList = {}
  local baseIndex = -1
  local isBlocked = false
  for i = 0, length do
    local nextPos = Vector2(gridPos.x + i * dir.x, gridPos.y + i * dir.y)
    if self._gridFilter:IsValidPiecePos(nextPos) then
      if not isBlocked and (self._calcBlock == 0 or not table.icontains(self._blocks, nextPos)) then
        if not table.icontains(self._scopeGridList, nextPos) then
          if baseIndex == -1 then
            baseIndex = self:_CalcBaseIndex(gridPos)
          end
          local curIndex = baseIndex + i
          if not self._scopeGridDictionary[curIndex] then
            self._scopeGridDictionary[curIndex] = {}
          end
          table.insert(self._scopeGridDictionary[curIndex], nextPos)
          table.insert(self._scopeGridList, nextPos)
          table.insert(addGridList, nextPos)
        end
      else
        isBlocked = true
      end
    end
  end
  return addGridList
end

function SkillScopeCalculator_PickUpFrontExtendWithDamage:_CalcBaseIndex(gridPos)
  local baseIndex = 1
  for i, posList in ipairs(self._scopeGridDictionary) do
    if table.icontains(posList, gridPos) then
      baseIndex = i
      break
    end
  end
  return baseIndex
end

_class("SkillScopeGrid", Object)
SkillScopeGrid = SkillScopeGrid

function SkillScopeGrid:Constructor(index, gridPos, percent)
  self._index = index
  self._gridPos = gridPos
  self._percent = percent
end

function SkillScopeGrid:GetIndex()
  return self._index
end

function SkillScopeGrid:GetGridPos()
  return self._gridPos
end

function SkillScopeGrid:GetPercent()
  return self._percent
end

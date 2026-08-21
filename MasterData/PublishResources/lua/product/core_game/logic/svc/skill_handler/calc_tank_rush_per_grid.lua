_class("SkillEffectCalc_TankRushPerGrid", SkillEffectCalc_Base)
SkillEffectCalc_TankRushPerGrid = SkillEffectCalc_TankRushPerGrid

function SkillEffectCalc_TankRushPerGrid:DoSkillEffectCalculator(skillEffectCalcParam)
  local resultArray = {}
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local targetTeamID = skillEffectCalcParam.targetEntityIDs[1]
  local targetEntity = self._world:GetEntityByID(targetTeamID)
  if not targetEntity then
    return {}
  end
  local targetPos = targetEntity:GetGridPosition()
  if table.Vector2Include(skillEffectCalcParam.skillRange, targetPos) then
    local r = self:_RushToTarget(targetEntity, targetPos, skillEffectCalcParam, true)
    if r then
      table.insert(resultArray, r)
    end
  else
    local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
    local nearestGridArray = {}
    local nearestDistance = 999
    for _, v2 in ipairs(skillEffectCalcParam.skillRange) do
      local dis = Vector2.Distance(v2, targetPos)
      if self:IsPosAccessibleForEntity(casterEntity, v2) then
        if nearestDistance > dis then
          nearestGridArray = {v2}
          nearestDistance = dis
        elseif nearestDistance == dis then
          table.insert(nearestGridArray, v2)
        end
      end
    end
    if 0 < #nearestGridArray then
      local minX = casterPos.x
      local minY = casterPos.y
      local maxX = casterPos.x
      local maxY = casterPos.y
      for _, v in ipairs(casterBodyArea) do
        local v2 = casterPos + v
        if minX > v2.x then
          minX = v2.x
        end
        if maxX < v2.x then
          maxX = v2.x
        end
        if minY > v2.y then
          minY = v2.y
        end
        if maxY < v2.y then
          maxY = v2.y
        end
      end
      local nearestGrid, secondaryGrid
      for _, v2 in ipairs(nearestGridArray) do
        if minX <= v2.x and maxX >= v2.x then
          nearestGrid = v2
        else
          secondaryGrid = v2
        end
      end
      local selectedGridPos = nearestGrid or secondaryGrid
      local r = self:_RushToTarget(targetEntity, selectedGridPos, skillEffectCalcParam, false)
      if r then
        table.insert(resultArray, r)
      end
    end
  end
  return resultArray
end

local function isPosSafeForBody(v2, bodyArea, range)
  for _, body in ipairs(bodyArea) do
    local v = v2 + body
    if not table.Vector2Include(range, v) then
      return false
    end
  end
  return true
end

local searchDirs = {
  Vector2.down,
  Vector2.up,
  Vector2.left,
  Vector2.right,
  Vector2.New(-1, -1),
  Vector2.New(1, 1),
  Vector2.New(-1, 1),
  Vector2.New(1, -1)
}

local function generateLogicGridPosMap(range, casterBodyArea)
  local logicGridPosMap = {}
  for _, v2 in ipairs(range) do
    local index = Vector2.Pos2Index(v2)
    if isPosSafeForBody(v2, casterBodyArea, range) then
      logicGridPosMap[index] = v2
    else
      for _, dir in ipairs(searchDirs) do
        local v = v2 + dir
        if isPosSafeForBody(v, casterBodyArea, range) then
          logicGridPosMap[index] = v
          break
        end
      end
    end
  end
  return logicGridPosMap
end

function SkillEffectCalc_TankRushPerGrid:_RushToTarget(targetEntity, targetPos, skillEffectCalcParam, calcDamage)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local casterPos = casterEntity:GetGridPosition()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local logicGridPosMap = generateLogicGridPosMap(skillEffectCalcParam.skillRange, casterBodyArea)
  local targetPosIndex = Vector2.Pos2Index(targetPos)
  local targetLogicGridPos = logicGridPosMap[targetPosIndex]
  if not targetLogicGridPos then
    Log.error("TankRushPerGrid: bad target pos index: ", targetPosIndex)
    return
  end
  local dir = targetLogicGridPos - casterPos
  if dir.x > 0 then
    dir.x = 1
  elseif dir.x < 0 then
    dir.x = -1
  end
  if 0 < dir.y then
    dir.y = 1
  elseif 0 > dir.y then
    dir.y = -1
  end
  if dir == Vector2.zero then
    return
  end
  local fullCasterBodyPos = {}
  for _, v in ipairs(casterBodyArea) do
    table.insert(fullCasterBodyPos, casterPos + v)
  end
  local utilData = self._world:GetService("UtilData")
  local blockFlag = casterEntity:HasMonsterID() and casterEntity:MonsterID():GetMonsterBlockData() or BlockFlag.LinkLine
  local targetRushPos = casterPos
  while true do
    local v2 = targetRushPos + dir
    local isPosSafe = isPosSafeForBody(v2, casterBodyArea, skillEffectCalcParam.skillRange)
    isPosSafe = isPosSafe and (table.Vector2Include(fullCasterBodyPos, v2) or utilData:IsPosBlock(v2, blockFlag))
    if isPosSafeForBody(v2, casterBodyArea, skillEffectCalcParam.skillRange) then
      targetRushPos = v2
    else
      break
    end
  end
  local walkResArray = {}
  local isCasterDead = false
  local isRushFinished = true
  local utilScope = self._world:GetService("UtilScopeCalc")
  local directLineCalc = SkillScopeCalculator_DirectLineExpand:New(utilScope)
  local targetSelector = SkillScopeTargetSelector:New(self._world)
  local damageScopeResult, damageTargetIDArray
  local currentPos = casterPos:Clone()
  if currentPos ~= targetRushPos then
    while currentPos ~= targetRushPos do
      currentPos = currentPos + dir
      if not self:IsPosAccessibleForEntity(casterEntity, currentPos) then
        isRushFinished = false
        break
      end
      if calcDamage then
        local scopeResult = directLineCalc:CalcRange(SkillScopeType.DirectLineExpand, {0, 1}, currentPos, casterBodyArea, dir)
        local selectResult = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.Pet, scopeResult, skillEffectCalcParam.skillID)
        if 0 < #selectResult then
          damageScopeResult = scopeResult
          damageTargetIDArray = selectResult
        end
      end
      local walkRes, isDead = self:MoveAndGenerateWalkResult(casterEntity, currentPos)
      table.insert(walkResArray, walkRes)
      if isDead then
        isCasterDead = true
        break
      end
    end
  end
  if #walkResArray == 0 then
    return
  end
  casterEntity:SetGridDirection(dir)
  local damageResults, hitbackResults
  if calcDamage and damageScopeResult and damageTargetIDArray then
    local damageCalc = SkillEffectCalc_Damage:New(self._world)
    local damageCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam.casterEntityID, damageTargetIDArray, effectParam:GetDamageParam(), skillEffectCalcParam.skillID, damageScopeResult:GetAttackRange(), currentPos, currentPos)
    damageResults = damageCalc:DoSkillEffectCalculator(damageCalcParam)
    if damageResults and 0 < #damageResults then
      local hitbackCalc = SkillEffectCalc_HitBack:New(self._world)
      local hitbackCalcParam = SkillEffectCalcParam:New(skillEffectCalcParam.casterEntityID, skillEffectCalcParam.targetEntityIDs, effectParam:GetHitBackParam(), skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange, currentPos, currentPos)
      hitbackResults = hitbackCalc:DoSkillEffectCalculator(hitbackCalcParam)
    end
  end
  return SkillEffectResult_TankRushPerGrid:New(walkResArray, damageResults, hitbackResults, isCasterDead)
end

function SkillEffectCalc_TankRushPerGrid:IsPosAccessibleForEntity(e, pos)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local monsterIDCmpt = e:MonsterID()
  local nMonsterBlockData = monsterIDCmpt:GetMonsterBlockData()
  local coverList = e:GetCoverAreaList(pos)
  local coverListSelf = e:GetCoverAreaList(e:GetGridPosition())
  for i = 1, #coverList do
    local posWork = coverList[i]
    if not table.icontains(coverListSelf, posWork) and boardServiceLogic:IsPosBlock(posWork, nMonsterBlockData) then
      return false
    end
  end
  return true
end

function SkillEffectCalc_TankRushPerGrid:MoveAndGenerateWalkResult(e, pos)
  local sBoard = self._world:GetService("BoardLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local selfPos = e:GetGridPosition()
  local walkRes = MonsterMoveGridResult:New()
  sBoard:UpdateEntityBlockFlag(e, e:GetGridPosition(), pos)
  e:SetGridPosition(pos)
  e:SetGridDirection(pos - selfPos)
  walkRes:SetWalkPos(pos)
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(e, TrapTriggerOrigin.MonsterGridMove)
  for i, trapEntity in ipairs(listTrapWork) do
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  return walkRes, e:HasDeadMark()
end

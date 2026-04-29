require("pick_up_policy_base")
_class("PickUpPolicy_PetLen", PickUpPolicy_Base)
PickUpPolicy_PetLen = PickUpPolicy_PetLen

function PickUpPolicy_PetLen:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local policyParam = calcParam.policyParam
  local casterPos = petEntity:GridLocation().Position
  local pickPosList = {}
  local attackPosList = {}
  local targetIdList = {}
  local validPosIdxList, validPosList = self:_CalcPickUpValidGridList(petEntity, activeSkillID)
  local pickPosList, atkPosList, targetIds, extraParam = self:_CalPickPosPolicy_PetLen(policyParam, petEntity)
  return pickPosList, atkPosList, targetIds, extraParam
end

function PickUpPolicy_PetLen:_CalPickPosPolicy_PetLen(policyParam, petEntity)
  local pickPosList = {}
  local atkPosList = {}
  local targetIds = {}
  local extraParam = {}
  local greatestHPVal = 0
  local greatestHPValEntity
  local posIndexEntityIDDic = {}
  local monsterGlobalEntityGroup = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    monsterGlobalEntityGroup = {
      petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    }
  end
  local utilData = self._world:GetService("UtilData")
  local extraBoardPosRange = utilData:GetExtraBoardPosList()
  for _, e in ipairs(monsterGlobalEntityGroup) do
    local isSelectable = true
    if e:HasBuff() then
      isSelectable = not e:BuffComponent():HasBuffEffect(BuffEffectType.NotBeSelectedAsSkillTarget)
    end
    if not e:HasDeadMark() and isSelectable then
      local hp = e:Attributes():GetCurrentHP()
      local tv2BodyArea = e:BodyArea():GetArea()
      local v2GridPos = e:GetGridPosition()
      local eid = e:GetID()
      local hasValidBodyPos = false
      for _, v2Relative in ipairs(tv2BodyArea) do
        local v2 = v2GridPos + v2Relative
        if not table.intable(extraBoardPosRange, v2) then
          local index = Vector2.Pos2Index(v2)
          posIndexEntityIDDic[index] = eid
          hasValidBodyPos = true
        end
      end
      if hasValidBodyPos and greatestHPVal < hp then
        greatestHPVal = hp
        greatestHPValEntity = e
      end
    end
  end
  if not greatestHPValEntity then
    Log.debug(self._className, "自动主动技释放：场上没怪")
    return pickPosList, atkPosList, targetIds, extraParam
  end
  local greatestHPValEntityID = greatestHPValEntity:GetID()
  Log.debug(self._className, "自动主动技释放：必然包含目标：", greatestHPValEntityID)
  local greatestHPValGridPos = greatestHPValEntity:GetGridPosition()
  if table.intable(extraBoardPosRange, greatestHPValGridPos) then
    local v2GridPos = greatestHPValGridPos
    local tv2BodyArea = greatestHPValEntity:BodyArea():GetArea()
    local validList = {}
    for _, v2Relative in ipairs(tv2BodyArea) do
      local v2 = v2GridPos + v2Relative
      if not table.intable(extraBoardPosRange, v2) then
        table.insert(validList, v2)
      end
    end
    if 0 < #validList then
      table.sort(validList, function(a, b)
        if a.x ~= b.x then
          return a.x < b.x
        else
          return a.y < b.y
        end
      end)
      greatestHPValGridPos = validList[1]
    else
      return pickPosList, atkPosList, targetIds, extraParam
    end
  end
  local utilData = self._world:GetService("UtilData")
  local testResult = {}
  local resultIndex = 0
  for i = 1, #policyParam, 2 do
    local policyXOffset = policyParam[i]
    local policyYOffset = policyParam[i + 1]
    local gridPosX = greatestHPValGridPos.x
    local gridPosY = greatestHPValGridPos.y
    local gridPosOffsetX = gridPosX + policyXOffset
    local gridPosOffsetY = gridPosY + policyYOffset
    local pickPos2 = Vector2.New(gridPosOffsetX, gridPosOffsetY)
    if utilData:IsValidPiecePos(pickPos2) and not self:_IsPosInExtraBoard(pickPos2, extraBoardPosRange) then
      resultIndex = resultIndex + 1
      local result = {
        greatestHPValEntityCount = 0,
        otherMonsterEntityCount = 0,
        index = resultIndex,
        x1 = gridPosX,
        x2 = gridPosOffsetX,
        y1 = gridPosY,
        y2 = gridPosOffsetY,
        targetIDs = {}
      }
      local minX = math.min(gridPosX, gridPosOffsetX)
      local maxX = math.max(gridPosX, gridPosOffsetX)
      local minY = math.min(gridPosY, gridPosOffsetY)
      local maxY = math.max(gridPosY, gridPosOffsetY)
      for x = minX, maxX do
        for y = minY, maxY do
          local v2 = Vector2.New(x, y)
          local tMonsterList = utilData:FindEntityByPosAndType(v2, EnumTargetEntity.Monster)
          if self._world:MatchType() == MatchType.MT_BlackFist then
            local eTeam = petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
            if eTeam:GetGridPosition() == v2 then
              tMonsterList = {
                eTeam:GetID()
              }
            end
          end
          for _, eid in ipairs(tMonsterList) do
            if not table.icontains(result.targetIDs, eid) then
              table.insert(result.targetIDs, eid)
            end
            if eid == greatestHPValEntityID then
              result.greatestHPValEntityCount = result.greatestHPValEntityCount + 1
            else
              result.otherMonsterEntityCount = result.otherMonsterEntityCount + 1
            end
          end
        end
      end
      table.insert(testResult, result)
    end
  end
  table.sort(testResult, function(a, b)
    if a.greatestHPValEntityCount ~= b.greatestHPValEntityCount then
      return a.greatestHPValEntityCount > b.greatestHPValEntityCount
    elseif a.otherMonsterEntityCount ~= b.otherMonsterEntityCount then
      return a.otherMonsterEntityCount > b.otherMonsterEntityCount
    else
      return a.index < b.index
    end
  end)
  local finalResult = testResult[1]
  local pickPosA = Vector2.New(finalResult.x1, finalResult.y1)
  local pickPosB = Vector2.New(finalResult.x2, finalResult.y2)
  local minX = math.min(pickPosA.x, pickPosB.x)
  local maxX = math.max(pickPosA.x, pickPosB.x)
  local minY = math.min(pickPosA.y, pickPosB.y)
  local maxY = math.max(pickPosA.y, pickPosB.y)
  for x = minX, maxX do
    for y = minY, maxY do
      local v2 = Vector2.New(x, y)
      if utilData:IsValidPiecePos(v2) then
        table.insert(atkPosList, v2)
      end
    end
  end
  return {pickPosA, pickPosB}, atkPosList, finalResult.targetIDs, extraParam
end

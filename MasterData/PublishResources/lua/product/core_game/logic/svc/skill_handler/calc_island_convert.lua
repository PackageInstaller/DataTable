require("calc_base")
_class("SkillEffectCalc_IslandConvert", SkillEffectCalc_Base)
SkillEffectCalc_IslandConvert = SkillEffectCalc_IslandConvert

function SkillEffectCalc_IslandConvert:DoSkillEffectCalculator(calcParam)
  local effectParam = calcParam.skillEffectParam
  local eCaster = self._world:GetEntityByID(calcParam.casterEntityID)
  local v2Pos = eCaster:GetGridPosition()
  local cmptRoutine = eCaster:SkillContext():GetResultContainer()
  local iEdgeLeftX, iEdgeRightX = v2Pos.x, v2Pos.x
  local iEdgeDownY, iEdgeUpperY = v2Pos.y, v2Pos.y
  local tv2WholeGridRange = calcParam.skillRange
  for _, v2RangePos in ipairs(tv2WholeGridRange) do
    local x = v2RangePos.x
    local y = v2RangePos.y
    if iEdgeLeftX > x then
      iEdgeLeftX = x
    end
    if iEdgeRightX < x then
      iEdgeRightX = x
    end
    if iEdgeDownY > y then
      iEdgeDownY = y
    end
    if iEdgeUpperY < y then
      iEdgeUpperY = y
    end
  end
  local tv2BodyArea = eCaster:BodyArea():GetArea()
  local iBodyAreaLeftX, iBodyAreaRightX = v2Pos.x, v2Pos.x
  local iBodyAreaDownY, iBodyAreaUpY = v2Pos.y, v2Pos.y
  for _, v2Relative in ipairs(tv2BodyArea) do
    local v2Abs = v2Relative + v2Pos
    local x = v2Abs.x
    local y = v2Abs.y
    if iBodyAreaLeftX > x then
      iBodyAreaLeftX = x
    end
    if iBodyAreaRightX < x then
      iBodyAreaRightX = x
    end
    if iBodyAreaDownY > y then
      iBodyAreaDownY = y
    end
    if iBodyAreaUpY < y then
      iBodyAreaUpY = y
    end
  end
  local isLeftExtra, isRightExtra, isDownExtra, isUpperExtra = false, false, false, false
  local leftRange = math.abs(iEdgeLeftX - iBodyAreaLeftX)
  local rightRange = math.abs(iEdgeRightX - iBodyAreaRightX)
  local upperRange = math.abs(iEdgeUpperY - iBodyAreaUpY)
  local downRange = math.abs(iEdgeDownY - iBodyAreaDownY)
  local maxRange = math.max(leftRange, rightRange, upperRange, downRange)
  if leftRange < rightRange then
    isLeftExtra = true
  elseif leftRange > rightRange then
    isRightExtra = true
  end
  if upperRange < downRange then
    isUpperExtra = true
  elseif upperRange > downRange then
    isDownExtra = true
  end
  local bodyRangeX = math.abs(iBodyAreaLeftX - iBodyAreaRightX)
  local bodyRangeY = math.abs(iBodyAreaDownY - iBodyAreaUpY)
  local maxBodyRange = math.max(bodyRangeX, bodyRangeY)
  if maxBodyRange == 0 then
    maxBodyRange = 2
    Log.exception(self._className, "施法者为单格单位，无法正确生成孤岛地形。点击确定以继续游戏。")
  end
  local finalLeft = iEdgeLeftX - (isLeftExtra and 1 or 0)
  local finalRight = iEdgeRightX + (isRightExtra and 1 or 0)
  local finalUpper = iEdgeUpperY + (isUpperExtra and 1 or 0)
  local finalDown = iEdgeDownY - (isDownExtra and 1 or 0)
  local pos2GroupCenter = {}
  local tv2GroupCenters = {}
  local theoricalRange = {}
  for x = finalLeft, finalRight do
    for y = finalDown, finalUpper do
      local relativeX = x - finalLeft
      local relativeY = y - finalDown
      local a = relativeX // 2
      local b = relativeY // 2
      local offsetX = relativeX % 2 == 0 and 0.5 or 0
      local offsetY = relativeY % 2 == 0 and 0.5 or 0
      local v2Center = Vector2.New(finalLeft + a * 2 + 0.5, finalDown + b * 2 + 0.5)
      table.insert(theoricalRange, Vector2.New(x, y))
      if not table.icontains(tv2GroupCenters, v2Center) then
        table.insert(tv2GroupCenters, v2Center)
      end
    end
  end
  local pattern = effectParam:GetPattern()
  local fillingGridArray = self:_GenerateFillingGridArray(pattern, theoricalRange)
  local convertAtomicData = {}
  local svcTrap = self._world:GetService("TrapLogic")
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local attackRange = calcParam.skillRange
  local teTraps = self._world:GetGroup(self._world.BW_WEMatchers.Trap):GetEntities()
  for _, v2Atk in ipairs(attackRange) do
    if not boardServiceLogic:IsPosBlock(v2Atk, BlockFlag.Skill | BlockFlag.SkillSkip | BlockFlag.ChangeElement) then
      local targetElementType = fillingGridArray[v2Atk.x][v2Atk.y]
      local flushTraps = {}
      for _, eTrap in ipairs(teTraps) do
        if not eTrap:HasDeadMark() then
          local level = eTrap:Trap():GetTrapLevel()
          local pos = eTrap:GetGridPosition()
          local isFlushed = svcTrap:IsTrapFlushable(level)
          if isFlushed and pos == v2Atk then
            table.insert(flushTraps, eTrap:GetID())
          end
        end
      end
      local oldElementType = boardServiceLogic:GetPieceType(v2Atk)
      local atomicData = SkillEffectResult_IslandConvert_AtomicData:New(v2Atk, oldElementType, targetElementType, flushTraps)
      table.insert(convertAtomicData, atomicData)
    end
  end
  local result = SkillEffectResult_IslandConvert:New(convertAtomicData, tv2GroupCenters)
  return {result}
end

function SkillEffectCalc_IslandConvert:_GenerateFillingGridArray(pattern, tv2FillGrid)
  local fillingGridArray = {}
  for _, v2 in ipairs(tv2FillGrid) do
    local x = v2.x
    local y = v2.y
    local a = x % 2 > 0 and 1 or 2
    local b = y % 2 > 0 and 2 or 0
    local index = a + b
    if not fillingGridArray[x] then
      fillingGridArray[x] = {}
    end
    fillingGridArray[x][y] = pattern[index]
  end
  return fillingGridArray
end

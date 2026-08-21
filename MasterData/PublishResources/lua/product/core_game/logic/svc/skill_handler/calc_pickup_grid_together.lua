require("calc_base")
_class("SkillEffectCalc_PickUpGridTogether", SkillEffectCalc_Base)
SkillEffectCalc_PickUpGridTogether = SkillEffectCalc_PickUpGridTogether

function SkillEffectCalc_PickUpGridTogether:Constructor(world)
  self._world = world
end

function SkillEffectCalc_PickUpGridTogether:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local skillRange = skillEffectCalcParam.skillRange
  local rangeCount = #skillRange
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local component = casterEntity:ActiveSkillPickUpComponent()
  local pickVec = component:GetAllValidPickUpGridPos()
  local pickupPos = pickVec[1]
  local pickupIndex = self:FindPickIndex(skillRange, pickupPos)
  local pieceType = skillEffectParam:GetGridType()
  local gridDataList = self:BuildData(skillRange)
  local replaceIndex = pickupIndex
  for i = pickupIndex, rangeCount do
    local gridData = gridDataList[i]
    if pieceType == gridData:GetGridType() and gridData:IsCanConvert() and i ~= replaceIndex then
      local tmpData = gridData
      Log.info("ReplaceIndex:", replaceIndex, "Type:", gridData:GetGridType(), " GridPos:", gridData:GetGridPos())
      local j = replaceIndex
      while i >= j do
        local tmpR = self:FindCanTogetherGrid(gridDataList, j, i, 1)
        if tmpR then
          Log.info("DownToUp Index:", tmpR, "Pos:", skillRange[tmpR], " NewType:", tmpData:GetGridType())
          local tempGridData = gridDataList[tmpR]
          gridDataList[tmpR] = tmpData
          tmpData = tempGridData
          j = tmpR
        end
        j = j + 1
      end
      replaceIndex = replaceIndex + 1
    end
  end
  replaceIndex = pickupIndex
  for i = pickupIndex, 1, -1 do
    local gridData = gridDataList[i]
    if pieceType == gridData:GetGridType() and gridData:IsCanConvert() and i ~= replaceIndex then
      Log.info("ReplaceIndex:", replaceIndex, "GridPos:", gridData:GetGridPos())
      local tmpData = gridData
      local j = replaceIndex
      while i <= j do
        local tmpR = self:FindCanTogetherGrid(gridDataList, j, i, -1)
        if tmpR then
          Log.info("UpToDown Index:", tmpR, "Pos:", skillRange[tmpR], " NewType:", tmpData:GetGridType())
          local tempGridData = gridDataList[tmpR]
          gridDataList[tmpR] = tmpData
          tmpData = tempGridData
          j = tmpR
        end
        j = j - 1
      end
      replaceIndex = replaceIndex - 1
    end
  end
  for i, pos in ipairs(skillRange) do
    gridDataList[i]:SetGridPos(pos)
  end
  local results = SkillEffectResult_PickUpGridTogether:New(gridDataList)
  return results
end

function SkillEffectCalc_PickUpGridTogether:FindCanTogetherGrid(gridDataList, beginIndex, endIndex, step)
  for i = beginIndex, endIndex, step do
    local gridData = gridDataList[i]
    if gridData:IsCanConvert() then
      return i
    end
  end
end

function SkillEffectCalc_PickUpGridTogether:FindPickIndex(range, pickPos)
  for i, v in ipairs(range) do
    if v.x == pickPos.x and v.y == pickPos.y then
      return i
    end
  end
end

function SkillEffectCalc_PickUpGridTogether:BuildData(skillRange)
  local ret = {}
  local utilDataSvc = self._world:GetService("UtilData")
  for i, pos in ipairs(skillRange) do
    local pieceType = utilDataSvc:GetPieceType(pos)
    local canConvert = utilDataSvc:IsPosCanConvertGridElement(pos)
    if pieceType == PieceType.None then
      canConvert = false
    end
    local data = PickUpGridTogetherData:New(pieceType, pos, canConvert)
    table.insert(ret, data)
  end
  return ret
end

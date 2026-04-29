GridRangeSortType = {
  None = 0,
  NearToFar = 1,
  NearToFarFourDirections2x2 = 2,
  AbsDistance = 3,
  Random = 4,
  XSmallToLarge = 5,
  YSmallToLarge = 6,
  FixedPos = 7,
  MultiRandomRange = 8,
  FarToNear = 9,
  BoardCenterToFar = 10,
  AbsDistanceForPickUp = 11,
  JieweiZuo = 12,
  SpecialScopeResultIndex = 13,
  SectorAngle = 14,
  XYSmallToLargeSort = 15,
  AbsDistanceForPickUpFirstAndExcludePickUp = 16,
  YLargeToSmall = 17,
  NearToFarByPickUp = 18,
  LineEdgeToCenter = 19,
  CasterDisTable = 20,
  MAX = 99
}
_enum("GridRangeSortType", GridRangeSortType)
require("base_ins_r")
_class("DataSortScopeGridRangeInstruction", BaseInstruction)
DataSortScopeGridRangeInstruction = DataSortScopeGridRangeInstruction

function DataSortScopeGridRangeInstruction:Constructor(paramList)
  self._sortType = tonumber(paramList.sortType)
  local metaParam = paramList.sortParam
  if metaParam then
    local arr = string.split(metaParam, "|")
    self._sortParam = arr
  end
end

function DataSortScopeGridRangeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local sConfig = world:GetService("Config")
  local utilDataSvc = world:GetService("UtilData")
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local randomSvc = world:GetService("RandomRender")
  local gridRange, maxRange = {}, 0
  local array = phaseContext._scopeGridList
  if self._sortType == GridRangeSortType.NearToFar then
    gridRange, maxRange = self:_SortGridNearToFar(array, casterEntity:GridLocation().Position)
  elseif self._sortType == GridRangeSortType.FarToNear then
    gridRange, maxRange = self:_SortGridFarToNear(array, casterEntity:GridLocation().Position)
  elseif self._sortType == GridRangeSortType.NearToFarFourDirections2x2 then
    gridRange, maxRange = self:_SortGridNearToFarFourDirections2x2(array, casterEntity:GridLocation().Position, casterEntity:BodyArea():GetArea())
  elseif self._sortType == GridRangeSortType.AbsDistance then
    gridRange, maxRange = self:_AbsDistanceSort(array, casterEntity:GridLocation().Position)
  elseif self._sortType == GridRangeSortType.Random then
    gridRange, maxRange = self:_RandomSort(array, casterEntity:GridLocation().Position, randomSvc)
  elseif self._sortType == GridRangeSortType.XSmallToLarge then
    gridRange, maxRange = self:_XSmallToLargeSort(array)
  elseif self._sortType == GridRangeSortType.YSmallToLarge then
    gridRange, maxRange = self:_YSmallToLargeSort(array)
  elseif self._sortType == GridRangeSortType.FixedPos then
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local skillId = skillEffectResultContainer:GetSkillID()
    gridRange, maxRange = self:_FixedPosSort(sConfig, array, skillId)
  elseif self._sortType == GridRangeSortType.MultiRandomRange then
    local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
    local skillId = skillEffectResultContainer:GetSkillID()
    gridRange, maxRange = self:_MultiRandomRangeSort(sConfig, array, skillId)
  elseif self._sortType == GridRangeSortType.BoardCenterToFar then
    local boardCenterPos = utilDataSvc:GetCurBoardCenterPos()
    gridRange, maxRange = self:_SortBoardCenterToFar(array, boardCenterPos)
  elseif self._sortType == GridRangeSortType.AbsDistanceForPickUp then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
    gridRange, maxRange = self:_AbsDistanceSort(array, scopeGridList[1])
  elseif self._sortType == GridRangeSortType.JieweiZuo then
    gridRange, maxRange = self:_JieweiZuoSort(array)
  elseif self._sortType == GridRangeSortType.SpecialScopeResultIndex then
    local specialScopeResultList = phaseContext:GetSpecialScopeResultList()
    gridRange, maxRange = self:_SpecialScopeIndexSort(specialScopeResultList)
  elseif self._sortType == GridRangeSortType.SectorAngle then
    local casterPos = casterEntity:GridLocation().Position
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    local pickList = renderPickUpComponent:GetAllValidPickUpGridPos()
    gridRange, maxRange = self:_SortBySectorAngle(array, casterPos, pickList)
  elseif self._sortType == GridRangeSortType.XYSmallToLargeSort then
    gridRange, maxRange = self:_XYSmallToLargeSort(array)
  elseif self._sortType == GridRangeSortType.AbsDistanceForPickUpFirstAndExcludePickUp then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
    for i, pos in pairs(scopeGridList) do
      table.removev(array, pos)
    end
    gridRange, maxRange = self:_AbsDistanceSort(array, scopeGridList[1])
  elseif self._sortType == GridRangeSortType.YLargeToSmall then
    gridRange, maxRange = self:_YLargeToSmallSort(array)
  elseif self._sortType == GridRangeSortType.NearToFarByPickUp then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    local scopeGridList = renderPickUpComponent:GetAllValidPickUpGridPos()
    gridRange, maxRange = self:_SortGridNearToFar(array, scopeGridList[1])
  elseif self._sortType == GridRangeSortType.CasterDisTable then
    gridRange, maxRange = self:_SortGridCasterDisTable(array, casterEntity:GridLocation().Position)
  elseif self._sortType == GridRangeSortType.LineEdgeToCenter then
    local gridCenterPos = utilScopeSvc:GetGridListCenterPos(array)
    
    local function Com(a, b)
      return b < a
    end
    
    gridRange, maxRange = self:_SortGridCasterDisTable(array, gridCenterPos, Com)
  else
    gridRange, maxRange = self:_NoneSort(array)
  end
  phaseContext:SetScopeGridRange(gridRange, maxRange)
end

function DataSortScopeGridRangeInstruction:_NoneSort(gridList)
  if not gridList then
    return
  end
  return {
    {gridList}
  }, 1
end

function DataSortScopeGridRangeInstruction:_SortGridNearToFar(gridList, castPos)
  local leftUpList = {}
  local leftBottomList = {}
  local rightBottomList = {}
  local rightUpList = {}
  local upList = {}
  local bottomList = {}
  local rightList = {}
  local leftList = {}
  local maxGridCount = 0
  for i, pos in pairs(gridList) do
    local dis = pos - castPos
    if dis.x == 0 then
      if 0 < dis.y then
        table.insert(upList, pos)
      else
        table.insert(bottomList, pos)
      end
    elseif 0 < dis.x then
      if dis.y == 0 then
        table.insert(rightList, pos)
      elseif 0 < dis.y then
        if dis.x > dis.y then
          table.insert(rightList, pos)
        elseif dis.x == dis.y then
          table.insert(rightUpList, pos)
        elseif dis.x < dis.y then
          table.insert(upList, pos)
        end
      elseif 0 > dis.y then
        if dis.x > math.abs(dis.y) then
          table.insert(rightList, pos)
        elseif dis.x == math.abs(dis.y) then
          table.insert(rightBottomList, pos)
        elseif dis.x < math.abs(dis.y) then
          table.insert(bottomList, pos)
        end
      end
    elseif 0 > dis.x then
      if dis.y == 0 then
        table.insert(leftList, pos)
      elseif 0 < dis.y then
        if math.abs(dis.x) > dis.y then
          table.insert(leftList, pos)
        elseif math.abs(dis.x) == dis.y then
          table.insert(leftUpList, pos)
        elseif math.abs(dis.x) < dis.y then
          table.insert(upList, pos)
        end
      elseif 0 > dis.y then
        if math.abs(dis.x) > math.abs(dis.y) then
          table.insert(leftList, pos)
        elseif math.abs(dis.x) == math.abs(dis.y) then
          table.insert(leftBottomList, pos)
        elseif math.abs(dis.x) < math.abs(dis.y) then
          table.insert(bottomList, pos)
        end
      end
    end
  end
  
  local function cmpNearToFar(pos1, pos2)
    local disX1 = math.abs(pos1.x - castPos.x)
    local disY1 = math.abs(pos1.y - castPos.y)
    local disX2 = math.abs(pos2.x - castPos.x)
    local disY2 = math.abs(pos2.y - castPos.y)
    local dis1 = disX1 + disY1
    local dis2 = disX2 + disY2
    return dis1 < dis2
  end
  
  table.sort(leftBottomList, cmpNearToFar)
  table.sort(rightBottomList, cmpNearToFar)
  table.sort(leftUpList, cmpNearToFar)
  table.sort(rightUpList, cmpNearToFar)
  
  local function convertFunc(array)
    local list = {}
    for i = 1, #array do
      local t = {}
      t[1] = array[i]
      list[i] = t
    end
    return list
  end
  
  leftBottomList = convertFunc(leftBottomList)
  rightBottomList = convertFunc(rightBottomList)
  leftUpList = convertFunc(leftUpList)
  rightUpList = convertFunc(rightUpList)
  
  local function reverseTbale(tab)
    local tmp = {}
    for i = 1, #tab do
      local key = #tab
      tmp[i] = table.remove(tab)
    end
    return tmp
  end
  
  local function sortDic(dic)
    local newDic = {}
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  local upDic = {}
  for _, p in pairs(upList) do
    local y = p.y
    if not upDic[y] then
      upDic[y] = {}
    end
    table.insert(upDic[y], p)
  end
  upList = sortDic(upDic)
  local bottomDic = {}
  for _, p in pairs(bottomList) do
    local y = p.y
    if not bottomDic[y] then
      bottomDic[y] = {}
    end
    table.insert(bottomDic[y], p)
  end
  bottomList = sortDic(bottomDic)
  bottomList = reverseTbale(bottomList)
  local leftDic = {}
  for _, p in pairs(leftList) do
    local x = p.x
    if not leftDic[x] then
      leftDic[x] = {}
    end
    table.insert(leftDic[x], p)
  end
  leftList = sortDic(leftDic)
  leftList = reverseTbale(leftList)
  local rightDic = {}
  for _, p in pairs(rightList) do
    local x = p.x
    if not rightDic[x] then
      rightDic[x] = {}
    end
    table.insert(rightDic[x], p)
  end
  rightList = sortDic(rightDic)
  
  local function GetMaxGridCount(table, maxGridCount)
    if maxGridCount < #table then
      maxGridCount = #table
    end
    return maxGridCount
  end
  
  maxGridCount = GetMaxGridCount(upList, maxGridCount)
  maxGridCount = GetMaxGridCount(bottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftBottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightBottomList, maxGridCount)
  local res = {}
  res[1] = leftList
  res[2] = rightList
  res[3] = upList
  res[4] = bottomList
  res[5] = leftUpList
  res[6] = rightUpList
  res[7] = leftBottomList
  res[8] = rightBottomList
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_SortGridFarToNear(gridList, castPos)
  local gridRange, maxRange = self:_AbsDistanceSort(gridList, castPos)
  local resultGridRange = self:_ReverseTable(gridRange)
  return resultGridRange, maxRange
end

function DataSortScopeGridRangeInstruction:_ReverseTable(gridRange)
  local tmp = {}
  local tab = gridRange[1]
  for i = 1, #tab do
    local key = #tab
    tmp[i] = table.remove(tab)
  end
  gridRange[1] = tmp
  return gridRange
end

function DataSortScopeGridRangeInstruction:_SortGridNearToFarFourDirections2x2(gridList, castPos, bodyArea)
  local xTbl = {}
  local yTbl = {}
  for index, vec2 in ipairs(bodyArea) do
    local x = castPos.x + vec2.x
    local y = castPos.y + vec2.y
    table.insert(xTbl, x)
    table.insert(yTbl, y)
  end
  local minX = table.min(xTbl)
  local minY = table.min(yTbl)
  local maxX = table.max(xTbl)
  local maxY = table.max(yTbl)
  local upList = {}
  local bottomList = {}
  local rightList = {}
  local leftList = {}
  local maxGridCount = 0
  for i, pos in pairs(gridList) do
    local dis = pos
    local includeX = minX - 1 <= pos.x and pos.x <= maxX + 1
    local includeY = minY - 1 <= pos.y and pos.y <= maxY + 1
    if maxY < pos.y and includeX then
      table.insert(upList, pos)
    elseif minY > pos.y and includeX then
      table.insert(bottomList, pos)
    elseif minX > pos.x and includeY then
      table.insert(leftList, pos)
    elseif maxX < pos.x and includeY then
      table.insert(rightList, pos)
    end
  end
  local bottomStartPosList = {}
  table.insert(bottomStartPosList, Vector2(minX - 0.5, minY - 1.5))
  table.insert(bottomStartPosList, Vector2(maxX + 0.5, minY - 1.5))
  local bottomCenterList = self:_GetBodyAreaCenter(bottomList, bottomStartPosList, Vector2(0, -2))
  local upStartPosList = {}
  table.insert(upStartPosList, Vector2(minX - 0.5, maxY + 1.5))
  table.insert(upStartPosList, Vector2(maxX + 0.5, maxY + 1.5))
  local upCenterList = self:_GetBodyAreaCenter(upList, upStartPosList, Vector2(0, 2))
  local leftStartPosList = {}
  table.insert(leftStartPosList, Vector2(minX - 1.5, minY - 0.5))
  table.insert(leftStartPosList, Vector2(minX - 1.5, maxY + 0.5))
  local leftCenterList = self:_GetBodyAreaCenter(leftList, leftStartPosList, Vector2(-2, 0))
  local rightStartPosList = {}
  table.insert(rightStartPosList, Vector2(maxX + 1.5, minY - 0.5))
  table.insert(rightStartPosList, Vector2(maxX + 1.5, maxY + 0.5))
  local rightCenterList = self:_GetBodyAreaCenter(rightList, rightStartPosList, Vector2(2, 0))
  
  local function GetMaxGridCount(table, maxGridCount)
    if maxGridCount < #table then
      maxGridCount = #table
    end
    return maxGridCount
  end
  
  maxGridCount = GetMaxGridCount(bottomCenterList, maxGridCount)
  maxGridCount = GetMaxGridCount(upCenterList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftCenterList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightCenterList, maxGridCount)
  local res = {}
  res[1] = bottomCenterList
  res[2] = upCenterList
  res[3] = leftCenterList
  res[4] = rightCenterList
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_GetBodyAreaCenter(gridList, startPosList, interval)
  local centerList = {}
  local bodyAreaFix = {}
  table.insert(bodyAreaFix, Vector2(0.5, 0.5))
  table.insert(bodyAreaFix, Vector2(0.5, -0.5))
  table.insert(bodyAreaFix, Vector2(-0.5, 0.5))
  table.insert(bodyAreaFix, Vector2(-0.5, -0.5))
  for i = 1, 5 do
    local centerFix = interval * (i - 1)
    for _, pos in pairs(startPosList) do
      local wordCenterPos = pos + centerFix
      for _, bodyArea in pairs(bodyAreaFix) do
        local workPos = pos + bodyArea + centerFix
        if table.intable(gridList, workPos) then
          if not centerList[i] then
            centerList[i] = {}
          end
          if not table.intable(centerList[i], wordCenterPos) then
            table.insert(centerList[i], wordCenterPos)
          end
        end
      end
    end
  end
  return centerList
end

function DataSortScopeGridRangeInstruction:_AbsDistanceSort(gridList, castPos)
  local posDic = {}
  for _, pos in pairs(gridList) do
    local dis = Vector2.Distance(castPos, pos)
    if not posDic[dis] then
      posDic[dis] = {}
    end
    table.insert(posDic[dis], pos)
  end
  
  local function sortDicFunc(dic)
    local newDic = {}
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_RandomSort(gridList, castPos, randomSvc)
  local posDic = {}
  local bShuffle
  if self._sortParam then
    bShuffle = tonumber(self._sortParam[1])
  end
  if bShuffle and bShuffle == 1 then
    local randGrids = {}
    for _, pos in pairs(gridList) do
      table.insert(randGrids, pos)
    end
    gridList = randomSvc:Shuffle(randGrids)
  end
  for _, pos in pairs(gridList) do
    local t = {}
    table.insert(t, pos)
    table.insert(posDic, t)
  end
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_XSmallToLargeSort(gridList)
  local posDic = {}
  for _, pos in pairs(gridList) do
    local dis = pos.x
    if not posDic[dis] then
      posDic[dis] = {}
    end
    table.insert(posDic[dis], pos)
  end
  posDic = self:_SmallToLargeSort(posDic)
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_YSmallToLargeSort(gridList)
  local posDic = {}
  for _, pos in pairs(gridList) do
    local dis = pos.y
    if not posDic[dis] then
      posDic[dis] = {}
    end
    table.insert(posDic[dis], pos)
  end
  posDic = self:_SmallToLargeSort(posDic)
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_SmallToLargeSort(posDic)
  local function sortDicFunc(dic)
    local newDic = {}
    
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  return posDic
end

function DataSortScopeGridRangeInstruction:_YLargeToSmallSort(gridList)
  local posDic = {}
  for _, pos in pairs(gridList) do
    local dis = pos.y
    if not posDic[dis] then
      posDic[dis] = {}
    end
    table.insert(posDic[dis], pos)
  end
  posDic = self:_LargeToSmallSort(posDic)
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_LargeToSmallSort(posDic)
  local function sortDicFunc(dic)
    local newDic = {}
    
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return b < a
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  return posDic
end

function DataSortScopeGridRangeInstruction:_FixedPosSort(sConfig, gridList, skillId)
  local cfg = sConfig:GetSkillConfigData(skillId)
  local param = cfg:GetSkillScopeParam()
  local count = table.count(param.pos)
  local cellCount = table.count(gridList) / count
  local posDic = {}
  for i, pos in ipairs(gridList) do
    local mod = (i - 1) // cellCount + 1
    if not posDic[mod] then
      posDic[mod] = {}
    end
    table.insert(posDic[mod], pos)
  end
  local res = {}
  res[1] = posDic
  return res, count
end

function DataSortScopeGridRangeInstruction:_MultiRandomRangeSort(sConfig, gridList, skillId)
  local cfg = sConfig:GetSkillConfigData(skillId)
  local param = cfg:GetSkillScopeParam()
  local count = param.multiCount
  local cellCount = table.count(gridList) / count
  local posDic = {}
  for i, pos in ipairs(gridList) do
    local mod = (i - 1) // cellCount + 1
    if not posDic[mod] then
      posDic[mod] = {}
    end
    table.insert(posDic[mod], pos)
  end
  local res = {}
  res[1] = posDic
  return res, count
end

function DataSortScopeGridRangeInstruction:_SortBoardCenterToFar(gridList, castPos)
  local leftUpList = {}
  local leftBottomList = {}
  local rightBottomList = {}
  local rightUpList = {}
  local upList = {}
  local bottomList = {}
  local rightList = {}
  local leftList = {}
  local centerList = {}
  local maxGridCount = 0
  table.insert(centerList, castPos)
  for i, pos in pairs(gridList) do
    local dis = pos - castPos
    if dis.x == 0 then
      if 0 < dis.y then
        table.insert(upList, pos)
      elseif 0 > dis.y then
        table.insert(bottomList, pos)
      end
    elseif 0 < dis.x then
      if dis.y == 0 then
        table.insert(rightList, pos)
      elseif 0 < dis.y then
        if dis.x > dis.y then
          table.insert(rightList, pos)
        elseif dis.x == dis.y then
          table.insert(rightUpList, pos)
        elseif dis.x < dis.y then
          table.insert(upList, pos)
        end
      elseif 0 > dis.y then
        if dis.x > math.abs(dis.y) then
          table.insert(rightList, pos)
        elseif dis.x == math.abs(dis.y) then
          table.insert(rightBottomList, pos)
        elseif dis.x < math.abs(dis.y) then
          table.insert(bottomList, pos)
        end
      end
    elseif 0 > dis.x then
      if dis.y == 0 then
        table.insert(leftList, pos)
      elseif 0 < dis.y then
        if math.abs(dis.x) > dis.y then
          table.insert(leftList, pos)
        elseif math.abs(dis.x) == dis.y then
          table.insert(leftUpList, pos)
        elseif math.abs(dis.x) < dis.y then
          table.insert(upList, pos)
        end
      elseif 0 > dis.y then
        if math.abs(dis.x) > math.abs(dis.y) then
          table.insert(leftList, pos)
        elseif math.abs(dis.x) == math.abs(dis.y) then
          table.insert(leftBottomList, pos)
        elseif math.abs(dis.x) < math.abs(dis.y) then
          table.insert(bottomList, pos)
        end
      end
    end
  end
  
  local function cmpNearToFar(pos1, pos2)
    local disX1 = math.abs(pos1.x - castPos.x)
    local disY1 = math.abs(pos1.y - castPos.y)
    local disX2 = math.abs(pos2.x - castPos.x)
    local disY2 = math.abs(pos2.y - castPos.y)
    local dis1 = disX1 + disY1
    local dis2 = disX2 + disY2
    return dis1 < dis2
  end
  
  table.sort(leftBottomList, cmpNearToFar)
  table.sort(rightBottomList, cmpNearToFar)
  table.sort(leftUpList, cmpNearToFar)
  table.sort(rightUpList, cmpNearToFar)
  
  local function convertFunc(array)
    local list = {}
    for i = 1, #array do
      local t = {}
      t[1] = array[i]
      list[i] = t
    end
    return list
  end
  
  leftBottomList = convertFunc(leftBottomList)
  rightBottomList = convertFunc(rightBottomList)
  leftUpList = convertFunc(leftUpList)
  rightUpList = convertFunc(rightUpList)
  centerList = convertFunc(centerList)
  
  local function reverseTbale(tab)
    local tmp = {}
    for i = 1, #tab do
      local key = #tab
      tmp[i] = table.remove(tab)
    end
    return tmp
  end
  
  local function sortDic(dic)
    local newDic = {}
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  local upDic = {}
  for _, p in pairs(upList) do
    local y = p.y
    if not upDic[y] then
      upDic[y] = {}
    end
    table.insert(upDic[y], p)
  end
  upList = sortDic(upDic)
  local bottomDic = {}
  for _, p in pairs(bottomList) do
    local y = p.y
    if not bottomDic[y] then
      bottomDic[y] = {}
    end
    table.insert(bottomDic[y], p)
  end
  bottomList = sortDic(bottomDic)
  bottomList = reverseTbale(bottomList)
  local leftDic = {}
  for _, p in pairs(leftList) do
    local x = p.x
    if not leftDic[x] then
      leftDic[x] = {}
    end
    table.insert(leftDic[x], p)
  end
  leftList = sortDic(leftDic)
  leftList = reverseTbale(leftList)
  local rightDic = {}
  for _, p in pairs(rightList) do
    local x = p.x
    if not rightDic[x] then
      rightDic[x] = {}
    end
    table.insert(rightDic[x], p)
  end
  rightList = sortDic(rightDic)
  
  local function GetMaxGridCount(table, maxGridCount)
    if maxGridCount < #table then
      maxGridCount = #table
    end
    return maxGridCount
  end
  
  maxGridCount = GetMaxGridCount(upList, maxGridCount)
  maxGridCount = GetMaxGridCount(bottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightUpList, maxGridCount)
  maxGridCount = GetMaxGridCount(leftBottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(rightBottomList, maxGridCount)
  maxGridCount = GetMaxGridCount(centerList, maxGridCount)
  local res = {}
  res[1] = leftList
  res[2] = rightList
  res[3] = upList
  res[4] = bottomList
  res[5] = leftUpList
  res[6] = rightUpList
  res[7] = leftBottomList
  res[8] = rightBottomList
  res[9] = centerList
  return res, maxGridCount
end

local function GetDistanceInfo(center, pool)
  local dic = {}
  local array = {}
  local indexer = {}
  for index, v2 in ipairs(pool) do
    local distance = Vector2.Distance(center, v2)
    if not dic[distance] then
      dic[distance] = {
        distance = distance,
        elements = {}
      }
      table.insert(array, dic[distance])
    end
    local container = dic[distance].elements
    table.insert(container, v2)
    indexer[v2:Pos2Index()] = index
  end
  return array, indexer
end

function DataSortScopeGridRangeInstruction:_JieweiZuoSort(array)
  local pool = {}
  for _, v2 in ipairs(array) do
    table.insert(pool, v2)
  end
  local bestDistance = tonumber(self._sortParam[1])
  local maxGroup = tonumber(self._sortParam[2])
  local v2LastSelected = table.remove(pool, math.random(1, #pool))
  local sequence = {v2LastSelected}
  while 0 < #pool do
    local array, indexer = GetDistanceInfo(v2LastSelected, pool)
    table.sort(array, function(a, b)
      if a.distance == bestDistance then
        return true
      end
      if b.distance == bestDistance then
        return false
      end
      local absDisA = math.abs(a.distance)
      local absDisB = math.abs(b.distance)
      if absDisA == absDisB then
        return a.distance > b.distance
      end
      return absDisA < absDisB
    end)
    local firstGroup = array[1].elements
    local selectedIndex = math.random(1, #firstGroup)
    local v2Selected = firstGroup[selectedIndex]
    local indexInPool = indexer[v2Selected:Pos2Index()]
    table.remove(pool, indexInPool)
    table.insert(sequence, v2Selected)
  end
  local bestGroupElementCount = #sequence // maxGroup
  local final = {}
  local currentGroupIndex = 1
  for i = 1, #sequence do
    if final[currentGroupIndex] and currentGroupIndex ~= maxGroup and bestGroupElementCount <= #final[currentGroupIndex] then
      currentGroupIndex = currentGroupIndex + 1
    end
    if not final[currentGroupIndex] then
      final[currentGroupIndex] = {}
    end
    table.insert(final[currentGroupIndex], sequence[i])
  end
  return {final}, maxGroup
end

function DataSortScopeGridRangeInstruction:_SpecialScopeIndexSort(specialScopeResultList)
  local posDic = {}
  for _, skillScopeGrid in pairs(specialScopeResultList) do
    local index = skillScopeGrid:GetIndex()
    local pos = skillScopeGrid:GetGridPos()
    if not posDic[index] then
      posDic[index] = {}
    end
    table.insert(posDic[index], pos)
  end
  
  local function sortDicFunc(dic)
    local newDic = {}
    local keyList = {}
    for k, _ in pairs(dic) do
      table.insert(keyList, k)
    end
    table.sort(keyList, function(a, b)
      return a < b
    end)
    for i = 1, #keyList do
      newDic[#newDic + 1] = dic[keyList[i]]
    end
    return newDic
  end
  
  posDic = sortDicFunc(posDic)
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_SortBySectorAngle(gridList, castPos, pickList)
  local mainPick, expandPick
  if pickList and 2 <= #pickList then
    mainPick = pickList[1]
    expandPick = pickList[2]
  else
    return
  end
  local mainDir = mainPick - castPos
  local groupAngle = tonumber(self._sortParam[1])
  groupAngle = groupAngle or 15
  groupAngle = 0 < groupAngle and groupAngle or 15
  local maxAngle = tonumber(self._sortParam[2])
  maxAngle = maxAngle or 45
  maxAngle = 0 < maxAngle and maxAngle or 45
  local posDic = {}
  local totalGroup = math.ceil(maxAngle / groupAngle)
  for i = 1, totalGroup do
    posDic[i] = {}
  end
  for _, pos in pairs(gridList) do
    local targetDir = pos - castPos
    local diffAngle = Vector2.Angle(mainDir, targetDir)
    diffAngle = math.floor(diffAngle + 0.5)
    local index = math.ceil(diffAngle / groupAngle)
    if index == 0 then
      index = 1
    end
    if not posDic[index] then
      posDic[index] = {}
    end
    table.insert(posDic[index], pos)
  end
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_XYSmallToLargeSort(gridList)
  local posDic = {}
  local posList = {}
  for _, pos in pairs(gridList) do
    table.insert(posList, pos)
  end
  
  local function sortDicFunc(a, b)
    local disA = a.x + a.y
    local disB = b.x + b.y
    if disA == disB then
      return a.x > b.x
    else
      return disA < disB
    end
  end
  
  table.sort(posList, sortDicFunc)
  posDic[1] = {}
  for _, pos in ipairs(posList) do
    table.insert(posDic[1], pos)
  end
  local maxGridCount = table.count(posDic)
  local res = {}
  res[1] = posDic
  return res, maxGridCount
end

function DataSortScopeGridRangeInstruction:_SortGridLineEdgeToCenter(gridList, gridCenter)
  local tmp = {}
  for i, pos in pairs(gridList) do
    local len = Vector2.Distance(pos, gridCenter)
    if not tmp[len] then
      tmp[len] = {}
    end
    table.insert(tmp[len], pos)
  end
  local ret = {}
  
  local function com(a, b)
    return b < a
  end
  
  for _, v in HelperProxy:GetInstance():pairsByKeys(tmp, com) do
    ret[#ret + 1] = v
  end
  local maxGridCount = table.count(ret)
  return {ret}, maxGridCount
end

function DataSortScopeGridRangeInstruction:_SortGridCasterDisTable(gridList, castPos, Com)
  local tmp = {}
  for i, pos in pairs(gridList) do
    local len = Vector2.Distance(pos, castPos)
    if not tmp[len] then
      tmp[len] = {}
    end
    table.insert(tmp[len], pos)
  end
  local ret = {}
  for _, v in HelperProxy:GetInstance():PairsByKeys(tmp, Com) do
    ret[#ret + 1] = v
  end
  local maxGridCount = table.count(ret)
  return {ret}, maxGridCount
end

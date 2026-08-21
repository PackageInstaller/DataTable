require("base_ins_r")
_class("PlayJohuaTrapEffectInstruction", BaseInstruction)
PlayJohuaTrapEffectInstruction = PlayJohuaTrapEffectInstruction

function PlayJohuaTrapEffectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._intervalEffect1 = tonumber(paramList.intervalEffect1)
  self._intervalEffect2 = tonumber(paramList.intervalEffect2)
  self._startWait = tonumber(paramList.startWait)
  self._intervalTime1 = tonumber(paramList.intervalTime1)
  self._intervalWait = tonumber(paramList.intervalWait)
  self._intervalTime2 = tonumber(paramList.intervalTime2)
  local trapIDList = paramList.trapIDList
  self._trapIDList = {}
  if trapIDList then
    local arr = string.split(trapIDList, "|")
    for k, idStr in ipairs(arr) do
      local trapID = tonumber(idStr)
      table.insert(self._trapIDList, trapID)
    end
  end
  self._materialAnim = paramList.materialAnim
end

function PlayJohuaTrapEffectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._intervalEffect1 and 0 < self._intervalEffect1 then
    table.insert(t, {
      Cfg.cfg_effect[self._intervalEffect1].ResPath,
      10
    })
  end
  if self._intervalEffect2 and 0 < self._intervalEffect2 then
    table.insert(t, {
      Cfg.cfg_effect[self._intervalEffect2].ResPath,
      10
    })
  end
  return t
end

function PlayJohuaTrapEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillResultArray = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ResetGridElement)
  local pieceService = world:GetService("Piece")
  local svcPlayBuff = world:GetService("PlayBuff")
  local trapServiceRender = world:GetService("TrapRender")
  local effectService = world:GetService("Effect")
  local utilDataSvc = world:GetService("UtilData")
  local boardGridPosList = utilDataSvc:GetCloneBoardGridPos()
  local tarpEntity
  local trapGroup = world:GetGroup(world.BW_WEMatchers.Trap)
  for _, e in ipairs(trapGroup:GetEntities()) do
    local trapRenderCmpt = e:TrapRender()
    local trapPos = e:GetRenderGridPosition()
    if trapRenderCmpt and table.icontains(self._trapIDList, trapRenderCmpt:GetTrapID()) and table.icontains(boardGridPosList, trapPos) then
      tarpEntity = e
      break
    end
  end
  tarpEntity:PlayMaterialAnim(self._materialAnim)
  local tarpPos = tarpEntity:GetRenderGridPosition()
  local tarpDir = tarpEntity:GetRenderGridDirection()
  local effectEntity = effectService:CreateWorldPositionDirectionEffect(self._effectID, tarpPos, tarpDir)
  effectEntity:SetDirection(tarpDir)
  local resultPosList = {}
  local scopeResult = skillResultArray:GetSkillEffectScopeResult()
  if scopeResult then
    local array = scopeResult:GetAttackRange()
    for _, v in pairs(array) do
      if not table.icontains(resultPosList, v) then
        table.insert(resultPosList, v)
      end
    end
  end
  local FarToNearList = {}
  local NearToFarList = {}
  local nearToFarList = self:_CalcScopeForSquareRing(world, tarpPos)
  local farToNearList = self:_ReverseRingTable(nearToFarList)
  YIELD(TT, self._startWait)
  GameGlobal.TaskManager():StartTask(function(TT)
    for i, posList in pairs(farToNearList) do
      for _, pos in pairs(posList) do
        if table.icontains(resultPosList, pos) then
          effectService:CreateWorldPositionEffect(self._intervalEffect1, pos)
        end
      end
      YIELD(TT, self._intervalTime1)
    end
  end)
  YIELD(TT, self._intervalWait)
  GameGlobal.TaskManager():StartTask(function(TT)
    for i, posList in pairs(nearToFarList) do
      local tConvertInfo = {}
      for _, pos in pairs(posList) do
        if table.icontains(resultPosList, pos) then
          effectService:CreateWorldPositionEffect(self._intervalEffect2, pos)
          local nOldGridType = PieceType.None
          local gridEntity = pieceService:FindPieceEntity(pos)
          local pieceCmpt = gridEntity:Piece()
          nOldGridType = pieceCmpt:GetPieceType()
          local nNewGridType = skillResultArray:FindGridDataNew(pos)
          local flushTraps = skillResultArray:GetFlushTrapsAt(pos)
          self:_Convert(world, pos, nNewGridType, flushTraps, TT)
          local convertInfo = NTGridConvert_ConvertInfo:New(pos, nOldGridType, nNewGridType)
          table.insert(tConvertInfo, convertInfo)
          pieceService:RemovePrismAt(pos)
        end
      end
      if 0 < #tConvertInfo then
        local notify = NTGridConvert:New(casterEntity, tConvertInfo)
        notify:SetConvertEffectType(SkillEffectType.ResetGridElement)
        notify.__attackPosMatchRequired = true
        svcPlayBuff:PlayBuffView(TT, notify)
      end
      YIELD(TT, self._intervalTime2)
    end
  end)
  YIELD(TT)
end

function PlayJohuaTrapEffectInstruction:_CalcScopeForSquareRing(world, castPos)
  local utilDataSvc = world:GetService("UtilData")
  local posDic = {}
  local hasRingPosList = {}
  local hasPosList = {}
  posDic[1] = {castPos}
  for i = 1, 7 do
    local curRingPosList = {}
    local listTotalData = ComputeScopeRange.ComputeRange_SquareRing(castPos, 1, i)
    for key, pos in ipairs(listTotalData) do
      local isValidGrid = utilDataSvc:IsValidPiecePos(pos)
      if isValidGrid and not table.icontains(hasRingPosList, pos) then
        table.insert(curRingPosList, pos)
        table.insert(hasRingPosList, pos)
      end
    end
    posDic[i + 1] = curRingPosList
  end
  return posDic
end

function PlayJohuaTrapEffectInstruction:_ReverseRingTable(gridRange)
  local newGridRange = {}
  for i = #gridRange, 1, -1 do
    local value = gridRange[i]
    table.insert(newGridRange, value)
  end
  return newGridRange
end

function PlayJohuaTrapEffectInstruction:_AbsDistanceSort(gridList, castPos)
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

function PlayJohuaTrapEffectInstruction:_ReverseTable(gridRange)
  local tmp = {}
  local tab = gridRange[1]
  for i = 1, #tab do
    local key = #tab
    tmp[i] = table.remove(tab)
  end
  gridRange[1] = tmp
  return gridRange
end

function PlayJohuaTrapEffectInstruction:_Convert(world, gridPos, newGridType, flushTraps, TT)
  if flushTraps and table.count(flushTraps) > 0 then
    local trapServiceRender = world:GetService("TrapRender")
    trapServiceRender:PlayTrapDieSkill(TT, flushTraps)
    for _, trap in ipairs(flushTraps) do
      trapServiceRender:DestroyTrap(TT, trap)
    end
  end
  if newGridType and newGridType >= PieceType.None and newGridType <= PieceType.Any then
    local boardServiceR = world:GetService("BoardRender")
    local newGridEntity = boardServiceR:ReCreateGridEntity(newGridType, gridPos)
    if newGridEntity then
      local pieceSvc = world:GetService("Piece")
      pieceSvc:SetPieceEntityAnimNormal(newGridEntity)
    end
  end
end

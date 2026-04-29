_class("SkillEffectCalc_PopStar", Object)
SkillEffectCalc_PopStar = SkillEffectCalc_PopStar

function SkillEffectCalc_PopStar:Constructor(world)
  self._world = world
end

function SkillEffectCalc_PopStar:DoSkillEffectCalculator(skillEffectCalcParam)
  local popStarParam = skillEffectCalcParam:GetSkillEffectParam()
  local skillRange = skillEffectCalcParam:GetSkillRange()
  local pieceList = self:_GetPopPieceList(popStarParam, skillRange)
  if not pieceList or #pieceList == 0 then
    return
  end
  local popStarSvc
  if self._world:MatchType() == MatchType.MT_PopStar then
    popStarSvc = self._world:GetService("PopStarLogic")
  elseif self._world:MatchType() == MatchType.MT_PopStarPro then
    popStarSvc = self._world:GetService("PopStarProLogic")
  else
    return
  end
  local dataPopResult = popStarSvc:CalculatePopPieces(pieceList)
  local result = SkillEffectPopStarResult:New(dataPopResult)
  return {result}
end

function SkillEffectCalc_PopStar:_GetPopPieceList(popStarParam, skillRange)
  local utilDataSvc = self._world:GetService("UtilData")
  local pieceTypeList = popStarParam:GetPieceTypeList()
  local matchTypePosList = {}
  for _, pos in ipairs(skillRange) do
    local pieceType = utilDataSvc:GetPieceType(pos)
    if table.icontains(pieceTypeList, pieceType) and not table.icontains(matchTypePosList, pos) then
      matchTypePosList[#matchTypePosList + 1] = pos
    end
  end
  if #matchTypePosList == 0 then
    return
  end
  local popCount = popStarParam:GetPopCount()
  local countRandomTab = popStarParam:GetCountRandomTab()
  if not popCount and not countRandomTab then
    return matchTypePosList
  end
  local randomSvc = self._world:GetService("RandomLogic")
  if countRandomTab then
    local min = countRandomTab.min
    local max = countRandomTab.max
    popCount = randomSvc:LogicRand(min, max)
  end
  if popCount >= #matchTypePosList then
    return matchTypePosList
  end
  local posList = {}
  local needRandom = popStarParam:NeedRandom()
  if needRandom then
    while popCount > #posList do
      local index = randomSvc:LogicRand(1, #matchTypePosList)
      posList[#posList + 1] = matchTypePosList[index]
      table.remove(matchTypePosList, index)
    end
  else
    posList = table.sub(matchTypePosList, 1, popCount)
  end
  return posList
end

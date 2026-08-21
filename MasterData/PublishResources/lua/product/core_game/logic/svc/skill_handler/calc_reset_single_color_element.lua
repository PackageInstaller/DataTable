_class("SkillEffectCalcResetSingleColorGridElement", Object)
SkillEffectCalcResetSingleColorGridElement = SkillEffectCalcResetSingleColorGridElement

function SkillEffectCalcResetSingleColorGridElement:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalcResetSingleColorGridElement:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local newColorList = param:GetTargetGridTypeList()
  local scopeList = skillEffectCalcParam.skillRange
  local boardService = self._world:GetService("BoardLogic")
  local randomSvc = self._world:GetService("RandomLogic")
  local skillLogicService = self._world:GetService("SkillLogic")
  local excludeColor = boardService:GetPieceType(scopeList[1])
  for k, v in ipairs(newColorList) do
    if v == excludeColor then
      table.remove(newColorList, k)
      table.sort(newColorList)
      break
    end
  end
  local newGridList = {}
  for _, pos in ipairs(scopeList) do
    local index = randomSvc:LogicRand(1, #newColorList)
    local newColor = newColorList[index]
    local newGridData = SkillEffectResult_ResetGridData:New(pos.x, pos.y, newColor)
    table.insert(newGridList, newGridData)
  end
  local flushTrapList = self._skillEffectService:GetFlushTrap(scopeList, param:GetExcludeTrapIDList())
  local trapIDList = {}
  for _, v in ipairs(flushTrapList) do
    trapIDList[#trapIDList + 1] = v:GetID()
  end
  return SkillEffectResultResetSingleColorGridElement:New(newGridList, trapIDList)
end

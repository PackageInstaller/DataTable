_class("SkillEffectCalc_ConvertOccupiedGridElement", SkillEffectCalc_Base)
SkillEffectCalc_ConvertOccupiedGridElement = SkillEffectCalc_ConvertOccupiedGridElement

function SkillEffectCalc_ConvertOccupiedGridElement:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_ConvertOccupiedGridElement:_CalculateSingleTarget(skillEffectCalcParam, targetEntityId)
  local logicParam = skillEffectCalcParam.skillEffectParam
  local targetGridElement = logicParam:GetTargetGridElement()
  local priorityTarget = logicParam:GetPriorityTarget()
  local victimEntity = self._world:GetEntityByID(targetEntityId)
  if not victimEntity then
    return
  end
  local gridArray = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local ePos = victimEntity:GridLocation().Position
  local bodyAreaCmpt = victimEntity:BodyArea()
  local area = bodyAreaCmpt:GetArea()
  local nMaxConvertPerMonster = logicParam:GetMaxPosPerTarget() or #area
  local tPreselectPos = {}
  local priorityElementPosList = {}
  local lagElementPosList = {}
  local utilData = self._world:GetService("UtilData")
  for i, p in ipairs(area) do
    local absolutePos = ePos + p
    if not boardServiceLogic:IsPosBlock(absolutePos, BlockFlag.ChangeElement) and table.icontains(skillEffectCalcParam.skillRange, absolutePos) and boardServiceLogic:GetCanConvertGridElement(absolutePos) then
      table.insert(tPreselectPos, absolutePos)
      local elementType = utilData:FindPieceElement(absolutePos)
      if targetGridElement == elementType then
        table.insert(lagElementPosList, absolutePos)
      else
        table.insert(priorityElementPosList, absolutePos)
      end
    end
  end
  local tConvertPosList = {}
  if nMaxConvertPerMonster >= #tPreselectPos then
    tConvertPosList = tPreselectPos
  else
    local randomSvc = self._world:GetService("RandomLogic")
    while nMaxConvertPerMonster > #tConvertPosList do
      if priorityTarget and priorityTarget == 1 then
        if 0 < #priorityElementPosList then
          local rand = randomSvc:LogicRand(1, #priorityElementPosList)
          local v2Selected = table.remove(priorityElementPosList, rand)
          table.insert(tConvertPosList, v2Selected)
        else
          local rand = randomSvc:LogicRand(1, #lagElementPosList)
          local v2Selected = table.remove(lagElementPosList, rand)
          table.insert(tConvertPosList, v2Selected)
        end
      else
        local rand = randomSvc:LogicRand(1, #tPreselectPos)
        local v2Selected = table.remove(tPreselectPos, rand)
        table.insert(tConvertPosList, v2Selected)
      end
    end
  end
  local trapID = logicParam:GetTrapID()
  local trapResults = {}
  if trapID then
    for _, v2Pos in ipairs(tConvertPosList) do
      table.insert(trapResults, SkillSummonTrapEffectResult:New(trapID, v2Pos))
    end
  end
  local skillEffectConvertOccupiedGridElementResult = SkillEffectConvertOccupiedGridElementResult:New(tConvertPosList, targetGridElement, trapResults)
  return skillEffectConvertOccupiedGridElementResult
end

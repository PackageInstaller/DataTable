_class("SkillEffectCalc_SummonTrapByCasterPos", Object)
SkillEffectCalc_SummonTrapByCasterPos = SkillEffectCalc_SummonTrapByCasterPos

function SkillEffectCalc_SummonTrapByCasterPos:Constructor(world)
  self._world = world
  self._configService = self._world:GetService("Config")
end

function SkillEffectCalc_SummonTrapByCasterPos:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillRange = skillEffectCalcParam.skillRange
  if not skillRange or table.count(skillRange) == 0 then
    return
  end
  local casterID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterID)
  local casterPos = casterEntity:GetGridPosition()
  local effectParam = skillEffectCalcParam.skillEffectParam
  local trapMaxCount = effectParam:GetMaxCount()
  local rangeAndCount = effectParam:GetRangeAndCount()
  local trapID = effectParam:GetTrapID()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local casterBodyArea = {}
  for i, p in ipairs(bodyArea) do
    local newPos = Vector2(p.x + casterPos.x, p.y + casterPos.y)
    table.insert(casterBodyArea, newPos)
  end
  local trapSvc = self._world:GetService("TrapLogic")
  local resultList = {}
  for i, param in ipairs(rangeAndCount) do
    local range = table.clone(param.vectorRange)
    local inRangeCount = self:RangeInRangeCount(range, casterBodyArea)
    local maxCount = param.maxCount
    if param.casterInRange[inRangeCount] then
      maxCount = maxCount - param.casterInRange[inRangeCount]
    end
    local trapList = trapSvc:FindTrapByTrapIDAndRange(trapID, range)
    if maxCount > #trapList then
      self:SummonTrapInRange(range, trapID, maxCount - #trapList, resultList)
    end
  end
  return resultList
end

function SkillEffectCalc_SummonTrapByCasterPos:SummonTrapInRange(range, trapID, count, resultList)
  local randomSvc = self._world:GetService("RandomLogic")
  local trapSvc = self._world:GetService("TrapLogic")
  while 0 < #range and 0 < count do
    local index = randomSvc:BoardLogicRand(1, #range)
    local pos = range[index]
    table.remove(range, index)
    if trapSvc:CanSummonTrapOnPos(pos, trapID) then
      local result = SkillSummonTrapEffectResult:New(trapID, Vector2(pos.x, pos.y))
      table.insert(resultList, result)
      count = count - 1
    end
  end
end

function SkillEffectCalc_SummonTrapByCasterPos:RangeInRangeCount(range1, range2)
  local count = 0
  for _, pos in ipairs(range1) do
    if table.Vector2Include(range2, pos) then
      count = count + 1
    end
  end
  return count
end

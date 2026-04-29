_class("SkillEffectCalc_EnhanceOccupiedGrid", SkillEffectCalc_Base)
SkillEffectCalc_EnhanceOccupiedGrid = SkillEffectCalc_EnhanceOccupiedGrid

function SkillEffectCalc_EnhanceOccupiedGrid:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_EnhanceOccupiedGrid:_CalculateSingleTarget(calcParam, nTargetID)
  local eTarget = self._world:GetEntityByID(nTargetID)
  if not eTarget then
    return {}
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  local v2PosTarget = eTarget:GetGridPosition()
  local cBodyArea = eTarget:BodyArea()
  local tv2RelativeBody
  if not cBodyArea then
    tv2RelativeBody = {
      Vector2.zero
    }
  else
    tv2RelativeBody = cBodyArea:GetArea()
  end
  local tv2AbsBody = {}
  for _, v2Relative in ipairs(tv2RelativeBody) do
    table.insert(tv2AbsBody, v2Relative + v2PosTarget)
  end
  local rangeMap = self:GetRangeMap(calcParam.skillRange)
  
  local function filter(e)
    return e:HasTrap() and e:Trap():GetTrapLevel() == 0
  end
  
  local tv2Candidates = {}
  for _, v2Abs in ipairs(tv2AbsBody) do
    if rangeMap[v2Abs.x] and rangeMap[v2Abs.x][v2Abs.y] then
      local es = boardCmpt:GetPieceEntities(v2Abs, filter)
      if #es == 0 then
        table.insert(tv2Candidates, v2Abs)
      end
    end
  end
  local effectParam = calcParam.skillEffectParam
  local limit = effectParam:GetMaxCountPerTarget()
  local tv2FinalPos = {}
  if limit >= #tv2Candidates then
    tv2FinalPos = tv2Candidates
  else
    local randomSvc = self._world:GetService("RandomLogic")
    while 0 < #tv2Candidates and 0 < limit do
      local max = #tv2Candidates
      local rand = randomSvc:LogicRand(1, max)
      local v2Selected = table.remove(tv2Candidates, rand)
      table.insert(tv2FinalPos, v2Selected)
      limit = limit - 1
    end
  end
  local tResults = {}
  if #tv2FinalPos == 0 then
    return tResults
  end
  for _, v2 in ipairs(tv2FinalPos) do
    local result = SkillSummonTrapEffectResult:New(effectParam:GetTrapID(), v2)
    table.insert(tResults, result)
  end
  return tResults
end

function SkillEffectCalc_EnhanceOccupiedGrid:GetRangeMap(skillRange)
  local t = {}
  for _, v2 in ipairs(skillRange) do
    local x = v2.x
    local y = v2.y
    if not t[x] then
      t[x] = {}
    end
    t[x][y] = true
  end
  return t
end

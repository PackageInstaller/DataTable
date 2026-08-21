_class("GridPurifyCalculator", Object)
GridPurifyCalculator = GridPurifyCalculator

function GridPurifyCalculator:Constructor(world)
  self._world = world
end

function GridPurifyCalculator:Calculate(casterEntity, effectParam)
  local container = casterEntity:SkillContext():GetResultContainer()
  local scopeResult = container:GetScopeResult()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeType = effectParam:GetSkillEffectScopeType()
  if scopeType ~= nil then
    local casterPos = casterEntity:GetGridPosition()
    scopeResult = utilScopeSvc:CalcSkillEffectScopeResult(effectParam, casterPos, casterEntity)
  end
  local udsvc = self._world:GetService("UtilData")
  local ltsvc = self._world:GetService("TrapLogic")
  local tv2Candidate = {}
  for _, v2GridPos in ipairs(scopeResult:GetAttackRange()) do
    table.insert(tv2Candidate, v2GridPos)
  end
  if #tv2Candidate == 0 then
    return
  end
  local randomSvc = self._world:GetService("RandomLogic")
  local purifyRate = effectParam:GetPurifyRate()
  local purifyMax = math.ceil(#tv2Candidate * purifyRate)
  local purifyRange = {}
  for purifyIndex = 1, purifyMax do
    if #tv2Candidate == 0 then
      break
    end
    local random = randomSvc:LogicRand(1, #tv2Candidate)
    local v2GridPos = table.remove(tv2Candidate, random)
    table.insert(purifyRange, v2GridPos)
    local array = udsvc:GetTrapsAtPos(v2GridPos)
    local trapIDArray = {}
    for _, eTrap in ipairs(array) do
      local cTrap = eTrap:Trap()
      if cTrap and not eTrap:HasDeadMark() and cTrap:CanBePurified() then
        local trapCmpt = eTrap:Trap()
        eTrap:Attributes():Modify("HP", 0)
        if not eTrap:HasDeadMark() then
          ltsvc:AddTrapDeadMark(eTrap, true)
          table.insert(trapIDArray, eTrap:GetID())
        end
      end
    end
    container:AddEffectResult(SkillEffectResult_GridPurify:New(v2GridPos, trapIDArray))
  end
  if not effectParam:GetTrapID() then
    return
  end
  local trapSvc = self._world:GetService("TrapLogic")
  local trapMax = effectParam:GetTrapMax() or #purifyRange
  for trapIndex = 1, trapMax do
    local v2GridPos
    while 0 < #purifyRange do
      local random = randomSvc:LogicRand(1, #purifyRange)
      local v2 = table.remove(purifyRange, random)
      if trapSvc:CanSummonTrapOnPos(v2, effectParam:GetTrapID()) then
        v2GridPos = v2
        break
      end
    end
    if not v2GridPos then
      break
    end
    local eTrap = trapSvc:CreateTrap(effectParam:GetTrapID(), v2GridPos, Vector2.up, true, nil, casterEntity)
    if eTrap then
      local trapResult = SkillSummonTrapEffectResult:New(effectParam:GetTrapID(), v2GridPos)
      trapResult:SetTrapIDList({
        eTrap:GetID()
      })
      container:AddEffectResult(trapResult)
    end
  end
end

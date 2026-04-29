require("calc_base")
_class("SkillEffectCalc_DestroyTrap", SkillEffectCalc_Base)
SkillEffectCalc_DestroyTrap = SkillEffectCalc_DestroyTrap

function SkillEffectCalc_DestroyTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam.skillEffectParam
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local utilSvc = self._world:GetService("UtilData")
  local entity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  if entity:HasSuperEntity() then
    entity = entity:GetSuperEntity()
  end
  local destroyType = effectParam:GetDestroyType()
  local stageIndex = effectParam:GetStageIndex()
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local trapEntities = trapGroup:GetEntities()
  local resultArray = {}
  if destroyType == SkillEffectDestroyTrapType.Range then
    local range = skillEffectCalcParam.skillRange or {}
    for _, pos in ipairs(range) do
      local array = utilSvc:GetTrapsAtPos(pos)
      for _, eTrap in ipairs(array) do
        local cTrap = eTrap:Trap()
        if cTrap and not eTrap:HasDeadMark() and effectParam:IsDestroyTrap(cTrap:GetTrapID()) and self:_TrapCanDestroy(effectParam, cTrap) then
          local entityID = eTrap:GetID()
          local trapID = cTrap:GetTrapID()
          table.insert(resultArray, SkillEffectDestroyTrapResult:New(entityID, trapID, pos, stageIndex))
        end
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.Self then
    if entity:HasTrap() and not entity:HasDeadMark() then
      table.insert(resultArray, SkillEffectDestroyTrapResult:New(entity:GetID(), entity:Trap():GetTrapID()))
    end
  elseif destroyType == SkillEffectDestroyTrapType.Other then
    for _, entity in ipairs(trapEntities) do
      local cTrap = entity:Trap()
      if entity:GetID() ~= skillEffectCalcParam.casterEntityID and self:_TrapCanDestroy(effectParam, cTrap) then
        local cAttributes = entity:Attributes()
        local curHp = cAttributes:GetCurrentHP()
        if curHp then
          cAttributes:Modify("HP", 0)
          Log.debug("SkillEffectCalc_DestroyTrap ModifyHP =0 defender=", entity:GetID())
        end
        table.insert(resultArray, SkillEffectDestroyTrapResult:New(entity:GetID(), entity:Trap():GetTrapID()))
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.RangeExceptConfig then
    local range = skillEffectCalcParam.skillRange or {}
    for _, pos in ipairs(range) do
      local array = utilSvc:GetTrapsAtPos(pos)
      for _, eTrap in ipairs(array) do
        local cTrap = eTrap:Trap()
        if cTrap and not eTrap:HasDeadMark() and not effectParam:IsProtectTrap(cTrap:GetTrapID()) and self:_TrapCanDestroy(effectParam, cTrap) then
          local entityID = eTrap:GetID()
          local trapID = cTrap:GetTrapID()
          table.insert(resultArray, SkillEffectDestroyTrapResult:New(entityID, trapID))
        end
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.Sticker then
    local pos = skillEffectCalcParam.centerPos
    local array = utilSvc:GetTrapsAtPos(pos)
    local onAbyss = false
    for _, eTrap in ipairs(array) do
      if eTrap:Trap():GetTrapType() == TrapType.TerrainAbyss then
        onAbyss = true
        break
      end
    end
    local entity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
    if entity:HasTrap() and not entity:HasDeadMark() then
      table.insert(resultArray, SkillEffectDestroyTrapResult:New(entity:GetID(), entity:Trap():GetTrapID()))
    end
    if onAbyss then
      for _, eTrap in ipairs(array) do
        local cTrap = eTrap:Trap()
        if cTrap and not eTrap:HasDeadMark() and cTrap:GetTrapType() ~= TrapType.TerrainAbyss then
          local entityID = eTrap:GetID()
          local trapID = cTrap:GetTrapID()
          table.insert(resultArray, SkillEffectDestroyTrapResult:New(entityID, trapID))
        end
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.RangeSelectTrapType then
    local range = skillEffectCalcParam.skillRange or {}
    for _, pos in ipairs(range) do
      local array = utilSvc:GetTrapsAtPos(pos)
      for _, eTrap in ipairs(array) do
        local cTrap = eTrap:Trap()
        if cTrap and not eTrap:HasDeadMark() and effectParam:IsDestroyTrapWithType(cTrap:GetTrapType()) and self:_TrapCanDestroy(effectParam, cTrap) then
          local entityID = eTrap:GetID()
          local trapID = cTrap:GetTrapID()
          table.insert(resultArray, SkillEffectDestroyTrapResult:New(entityID, trapID))
        end
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.MySummonTrap then
    for i, eTrap in ipairs(trapEntities) do
      local cTrap = eTrap:Trap()
      if eTrap:HasSummoner() and eTrap:GetSummonerEntity() == entity and self:_TrapCanDestroy(effectParam, cTrap) then
        table.insert(resultArray, SkillEffectDestroyTrapResult:New(eTrap:GetID(), eTrap:Trap():GetTrapID()))
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.RangeAll then
    local range = skillEffectCalcParam.skillRange or {}
    for _, pos in ipairs(range) do
      local array = utilSvc:GetTrapsAtPos(pos)
      for _, eTrap in ipairs(array) do
        local cTrap = eTrap:Trap()
        if cTrap and not eTrap:HasDeadMark() and self:_TrapCanDestroy(effectParam, cTrap) then
          local entityID = eTrap:GetID()
          local trapID = cTrap:GetTrapID()
          table.insert(resultArray, SkillEffectDestroyTrapResult:New(entityID, trapID, pos, stageIndex))
        end
      end
    end
  elseif destroyType == SkillEffectDestroyTrapType.SelfSummonDone then
    local attCpt = entity:Attributes()
    local summonDone = attCpt:GetAttribute("TrapSummonDone")
    if summonDone and summonDone == 1 and entity:HasTrap() then
      table.insert(resultArray, SkillEffectDestroyTrapResult:New(entity:GetID(), entity:Trap():GetTrapID()))
    end
  elseif destroyType == SkillEffectDestroyTrapType.HitBackRange then
    local targetIDs = skillEffectCalcParam.targetEntityIDs
    local targetID = targetIDs[1]
    local targetEntity = self._world:GetEntityByID(targetID)
    local range = self:CalcHitBackRange(entity, targetEntity)
    for _, pos in ipairs(range) do
      local array = utilSvc:GetTrapsAtPos(pos)
      for _, eTrap in ipairs(array) do
        local cTrap = eTrap:Trap()
        if cTrap and not eTrap:HasDeadMark() and effectParam:IsDestroyTrap(cTrap:GetTrapID()) and self:_TrapCanDestroy(effectParam, cTrap) then
          local entityID = eTrap:GetID()
          local trapID = cTrap:GetTrapID()
          table.insert(resultArray, SkillEffectDestroyTrapResult:New(entityID, trapID, pos, stageIndex))
        end
      end
    end
  end
  return resultArray
end

function SkillEffectCalc_DestroyTrap:CalcHitBackRange(entity, targetEntity)
  local routineComponent = entity:SkillContext():GetResultContainer()
  local hitDir = entity:GetGridDirection()
  local startPos = targetEntity:GetGridPosition()
  local range = {}
  local boardSvc = self._world:GetService("BoardLogic")
  local count = math.max(boardSvc:GetCurBoardMaxX(), boardSvc:GetCurBoardMaxY())
  for i = 1, count do
    local newPos = Vector2(startPos.x + i * hitDir.x, startPos.y + i * hitDir.y)
    if boardSvc:IsValidPiecePos(newPos) then
      table.insert(range, newPos)
    end
  end
  return range
end

function SkillEffectCalc_DestroyTrap:_TrapCanDestroy(effectParam, cTrap)
  local canDestroy = true
  if cTrap and cTrap:GetSpecialDestroy() and effectParam:GetSpecial() == 0 then
    canDestroy = false
  end
  return canDestroy
end

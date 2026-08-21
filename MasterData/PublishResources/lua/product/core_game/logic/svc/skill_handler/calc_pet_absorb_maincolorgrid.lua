_class("SkillEffectCalc_PetAbsorbMaintainColorGrid", Object)
SkillEffectCalc_PetAbsorbMaintainColorGrid = SkillEffectCalc_PetAbsorbMaintainColorGrid

function SkillEffectCalc_PetAbsorbMaintainColorGrid:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_PetAbsorbMaintainColorGrid:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local trapID = param:GetTrapID()
  local notifyTrapSkillTrapIDList = param:GetNotifyTrapSkillTrapIDList()
  local utilSvc = self._world:GetService("UtilData")
  local triggerSvc = self._world:GetService("Trigger")
  local trapSvcLogic = self._world:GetService("TrapLogic")
  local traps = {}
  local trapEntitys = {}
  local trapPos = {}
  for _, pos in ipairs(skillEffectCalcParam.skillRange) do
    local entities = utilSvc:GetTrapsAtPos(pos)
    for _, entity in ipairs(entities) do
      local trapComponent = entity:Trap()
      if trapID[trapComponent:GetTrapID()] then
        table.insert(traps, entity:GetID())
        table.insert(trapEntitys, entity)
        table.insert(trapPos, pos)
      end
    end
  end
  casterEntity:BuffComponent():SetBuffValue("AbsorbMainColorGridPos", trapPos)
  local result = SkillEffectResultPetAbsorbMaintainColorGrid:New(traps)
  for index, entity in ipairs(trapEntitys) do
    triggerSvc:Notify(NTBeforePetAbsorbMainColorGrid:New(entity, casterEntity))
    local trapID = entity:Trap():GetTrapID()
    if table.intable(notifyTrapSkillTrapIDList, trapID) then
      local pieceType = utilSvc:GetPieceType(trapPos[index])
      local trapCmpt = entity:Trap()
      local fakeTriggerTrapSkillID = trapCmpt:GetTriggerSkillID()
      local notifySecondPieceType = param:GetNotifySecondPieceType()
      if notifySecondPieceType == pieceType then
        local fakeNt2 = NTTrapSkillStart:New(entity, fakeTriggerTrapSkillID, casterEntity)
        fakeNt2:SetIsActiveSkillFake(true)
        triggerSvc:Notify(fakeNt2)
      end
    end
    local triggerTraps, triggerResults = trapSvcLogic:CalcTrapTriggerSkill(entity, casterEntity)
    if triggerTraps then
      for i, trap in ipairs(triggerTraps) do
        local skillResult = triggerResults[i]
        result:AddTrapSkillResult(trap:GetID(), skillResult)
      end
    end
    local cAttr = entity:Attributes()
    if cAttr:GetCurrentHP() then
      cAttr:Modify("HP", 0)
    end
    local boardEntity = self._world:GetBoardEntity()
    local boardCmpt = boardEntity:Board()
    local pos = trapPos[index]
    local posIndex = Vector2.Pos2Index(pos)
    local retColor = boardCmpt:GetMaintainColorForSupply(posIndex)
    if retColor then
      boardCmpt:ResetMaintainColorForSupply(posIndex)
    end
    trapSvcLogic:AddTrapDeadMark(entity, true)
  end
  return {result}
end

require("base_ins_r")
_class("PlayAbsorbMainColorGridInstruction", BaseInstruction)
PlayAbsorbMainColorGridInstruction = PlayAbsorbMainColorGridInstruction

function PlayAbsorbMainColorGridInstruction:Constructor(paramList)
  local strNotifyTrapSkillTrapIDList = string.split(paramList.notifyTrapSkillTrapIDList, "|")
  self._notifyTrapSkillTrapIDList = {}
  for _, value in ipairs(strNotifyTrapSkillTrapIDList) do
    table.insert(self._notifyTrapSkillTrapIDList, tonumber(value))
  end
  self._notifySecondPieceType = tonumber(paramList.notifySecondPieceType)
end

function PlayAbsorbMainColorGridInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PetAbsorbMaintainColorGrid)
  local result = results[1]
  if not result then
    Log.fatal("NoResult ")
    return
  end
  local trapIDs = result:GetTrapIDs()
  local trapServiceRender = self._world:GetService("TrapRender")
  local playBuffSvc = self._world:GetService("PlayBuff")
  local utilDataSvc = self._world:GetService("UtilData")
  for i, id in ipairs(trapIDs) do
    local trapEntity = world:GetEntityByID(id)
    playBuffSvc:PlayBuffView(TT, NTBeforePetAbsorbMainColorGrid:New(trapEntity, casterEntity))
    local trapID = trapEntity:TrapID():GetTrapID()
    if table.intable(self._notifyTrapSkillTrapIDList, trapID) then
      local gridPos = trapEntity:GetRenderGridPosition()
      local pieceType = utilDataSvc:GetPieceType(gridPos)
      local trapRenderCmpt = trapEntity:TrapRender()
      local fakeTriggerTrapSkillID = trapRenderCmpt:GetTriggerSkillID()
      if self._notifySecondPieceType == pieceType then
        local fakeNt2 = NTTrapSkillStart:New(trapEntity, fakeTriggerTrapSkillID, casterEntity)
        fakeNt2:SetIsActiveSkillFake(true)
        playBuffSvc:PlayBuffView(TT, fakeNt2)
      end
    end
    local trapSkillResultContainer = result:GetTrapSkillResult(id)
    trapEntity:SkillRoutine():SetResultContainer(trapSkillResultContainer)
    trapEntity:TrapRender():SetTriggerSkillResultContainer(trapSkillResultContainer)
    trapServiceRender:PlayTrapTriggerSkill(TT, trapEntity, false, casterEntity)
  end
end

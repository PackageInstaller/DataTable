require("base_ins_r")
_class("PlayPetSacrificeTrapVisibleInstruction", BaseInstruction)
PlayPetSacrificeTrapVisibleInstruction = PlayPetSacrificeTrapVisibleInstruction

function PlayPetSacrificeTrapVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  self._fakeTriggerTrapSkillID = 500202
end

function PlayPetSacrificeTrapVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  self._world = world
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.PetSacrificeSuperGridTraps)
  if not results then
    return
  end
  local result = results[1]
  if not result then
    Log.fatal("NoResult ")
    return
  end
  local isShow = self._visible == 1
  local trapIDs = result:GetTrapIDs()
  local playBuffSvc = self._world:GetService("PlayBuff")
  for i, id in ipairs(trapIDs) do
    local trapEntity = world:GetEntityByID(id)
    trapEntity:SetViewVisible(isShow)
    playBuffSvc:PlayBuffView(TT, NTPetMinosAbsorbTrap:New(trapEntity, casterEntity))
    local fakeNt = NTTrapSkillStart:New(trapEntity, self._fakeTriggerTrapSkillID, teamEntity)
    fakeNt:SetIsActiveSkillFake(true)
    playBuffSvc:PlayBuffView(TT, fakeNt)
  end
end

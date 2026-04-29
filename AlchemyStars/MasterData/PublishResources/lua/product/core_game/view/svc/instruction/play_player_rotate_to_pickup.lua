require("base_ins_r")
_class("PlayPlayerRotateToPickupInstruction", BaseInstruction)
PlayPlayerRotateToPickupInstruction = PlayPlayerRotateToPickupInstruction

function PlayPlayerRotateToPickupInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayPlayerRotateToPickupInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local routineComponent = casterEntity:SkillRoutine():GetResultContainer()
  local rotateResult = routineComponent:GetEffectResultByArray(SkillEffectType.RotateToPickup, self._stageIndex)
  local dir = rotateResult:GetNewDir()
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local pets = teamEntity:Team():GetTeamPetEntities()
  for i, petEntity in ipairs(pets) do
    petEntity:SetDirection(dir)
  end
  teamEntity:SetDirection(dir)
end

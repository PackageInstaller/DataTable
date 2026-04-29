require("base_ins_r")
_class("PlayRoleTeleportInstruction", BaseInstruction)
PlayRoleTeleportInstruction = PlayRoleTeleportInstruction

function PlayRoleTeleportInstruction:Constructor(paramList)
  self._type = tonumber(paramList.type)
  self._onlySelf = tonumber(paramList.onlySelf)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayRoleTeleportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, casterEntity, self._type, self._onlySelf, teleportEffectResult)
end

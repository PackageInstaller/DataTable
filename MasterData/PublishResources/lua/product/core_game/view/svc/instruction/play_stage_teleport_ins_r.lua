require("base_ins_r")
_class("PlayStageTeleportInstruction", BaseInstruction)
PlayStageTeleportInstruction = PlayStageTeleportInstruction

function PlayStageTeleportInstruction:Constructor(paramList)
  self._type = tonumber(paramList.type)
  self._onlySelf = tonumber(paramList.onlySelf)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayStageTeleportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult or table.count(teleportEffectResult) == 0 then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, casterEntity, self._type, self._onlySelf, teleportEffectResult[1])
end

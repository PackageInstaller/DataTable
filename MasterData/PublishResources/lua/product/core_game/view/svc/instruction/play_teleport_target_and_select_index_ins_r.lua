require("base_ins_r")
_class("PlayTeleportTargetAndSelectIndexInstruction", BaseInstruction)
PlayTeleportTargetAndSelectIndexInstruction = PlayTeleportTargetAndSelectIndexInstruction

function PlayTeleportTargetAndSelectIndexInstruction:Constructor(paramList)
  self._type = tonumber(paramList.type)
  self._onlySelf = tonumber(paramList.onlySelf)
  self._index = tonumber(paramList.index) or 1
end

function PlayTeleportTargetAndSelectIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResultAll = skillEffectResultContainer:GetEffectResultByArrayAll(SkillEffectType.Teleport)
  if not teleportEffectResultAll then
    return
  end
  local teleportEffectResult = teleportEffectResultAll[self._index]
  if not teleportEffectResult then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local targetEntityID = teleportEffectResult:GetTargetID()
  local targetEntity = world:GetEntityByID(targetEntityID)
  casterEntity = targetEntity
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, casterEntity, self._type, self._onlySelf, teleportEffectResult)
end

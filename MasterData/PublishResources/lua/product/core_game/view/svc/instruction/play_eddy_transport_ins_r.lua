require("base_ins_r")
_class("PlayEddyTransportInstruction", BaseInstruction)
PlayEddyTransportInstruction = PlayEddyTransportInstruction

function PlayEddyTransportInstruction:Constructor(paramList)
  self._waitTime = tonumber(paramList.waitTime)
end

function PlayEddyTransportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local posCaster = casterEntity:GetGridPosition()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillEffectResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.EddyTransport, posCaster)
  if nil == skillEffectResult then
    return
  end
  local nTargetID = skillEffectResult:GetTargetID()
  if nTargetID <= 0 then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(nTargetID)
  if targetEntity:HasTeam() then
    targetEntity = targetEntity:GetTeamLeaderPetEntity()
  end
  local skillEffectResultContainer = targetEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, 1)
  if not teleportEffectResult then
    return
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportHide, true, teleportEffectResult)
  YIELD(TT, self._waitTime)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportMove, true, teleportEffectResult)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportShow, true, teleportEffectResult)
end

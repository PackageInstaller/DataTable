require("base_ins_r")
_class("PlayDimensionTransportInstruction", BaseInstruction)
PlayDimensionTransportInstruction = PlayDimensionTransportInstruction

function PlayDimensionTransportInstruction:Constructor(paramList)
  self._waitTime = tonumber(paramList.waitTime)
end

function PlayDimensionTransportInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.DimensionTransport, casterEntity:GetGridPosition())
  if not result then
    return
  end
  local nTargetID = result:GetTargetID()
  if nTargetID <= 0 then
    return
  end
  local targetEntity = world:GetEntityByID(nTargetID)
  if targetEntity:HasTeam() then
    targetEntity = targetEntity:GetTeamLeaderPetEntity()
  end
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportHide, false, result)
  YIELD(TT, self._waitTime)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportMove, false, result)
  playSkillInstructionService:Teleport(TT, targetEntity, RoleShowType.TeleportShow, false, result)
  local posOld = result:GetPosOld()
  local posNew = result:GetPosNew()
  world:GetService("PlayBuff"):PlayBuffView(TT, NTDimensionTransport:New(targetEntity, posOld, posNew))
end

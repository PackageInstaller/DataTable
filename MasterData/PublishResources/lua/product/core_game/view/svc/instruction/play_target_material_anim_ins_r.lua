require("base_ins_r")
_class("PlayTargetMaterialAnimInstruction", BaseInstruction)
PlayTargetMaterialAnimInstruction = PlayTargetMaterialAnimInstruction

function PlayTargetMaterialAnimInstruction:Constructor(paramList)
  self._animName = paramList.animName
end

function PlayTargetMaterialAnimInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetEntityID = phaseContext:GetCurTargetEntityID()
  if not targetEntityID then
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local targetEntity = world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return
  end
  if targetEntity:HasTeam() then
    targetEntity = targetEntity:GetTeamLeaderPetEntity()
  end
  targetEntity:PlayMaterialAnim(self._animName)
end

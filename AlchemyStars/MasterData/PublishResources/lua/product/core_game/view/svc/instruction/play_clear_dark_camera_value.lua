require("base_ins_r")
_class("PlayClearDarkCameraValueInstruction", BaseInstruction)
PlayClearDarkCameraValueInstruction = PlayClearDarkCameraValueInstruction

function PlayClearDarkCameraValueInstruction:Constructor(paramList)
end

function PlayClearDarkCameraValueInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local mainCameraCmpt = world:MainCamera()
  mainCameraCmpt:ClearDarkCameraValue()
  return
end

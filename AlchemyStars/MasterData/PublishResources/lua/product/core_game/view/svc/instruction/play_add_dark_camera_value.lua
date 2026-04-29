require("base_ins_r")
_class("PlayAddDarkCameraValueInstruction", BaseInstruction)
PlayAddDarkCameraValueInstruction = PlayAddDarkCameraValueInstruction

function PlayAddDarkCameraValueInstruction:Constructor(paramList)
  self._addValue = tonumber(paramList.addValue) or 0
end

function PlayAddDarkCameraValueInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  self._world = world
  local mainCameraCmpt = world:MainCamera()
  mainCameraCmpt:AddDarkCameraValue(self._addValue)
  return
end

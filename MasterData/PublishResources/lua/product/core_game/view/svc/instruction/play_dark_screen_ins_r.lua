require("base_ins_r")
_class("PlayDarkScreenInstruction", BaseInstruction)
PlayDarkScreenInstruction = PlayDarkScreenInstruction

function PlayDarkScreenInstruction:Constructor(paramList)
  local param = tonumber(paramList.enable)
  if param == 1 then
    self._enable = true
  else
    self._enable = false
  end
end

function PlayDarkScreenInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local mainCameraCmpt = world:MainCamera()
  mainCameraCmpt:EnableDarkCamera(self._enable)
end

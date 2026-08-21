require("base_ins_r")
_class("UiHudVisibleInstruction", BaseInstruction)
UiHudVisibleInstruction = UiHudVisibleInstruction

function UiHudVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
end

function UiHudVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local hudCamera = world:MainCamera():HUDCamera()
  hudCamera.enabled = self._visible == 1 and true or false
end

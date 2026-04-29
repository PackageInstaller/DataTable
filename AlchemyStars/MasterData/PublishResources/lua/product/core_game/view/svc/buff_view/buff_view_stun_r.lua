_class("BuffViewSetStun", BuffViewBase)
BuffViewSetStun = BuffViewSetStun

function BuffViewSetStun:PlayView(TT)
  self._entity:SetAnimatorControllerBools({Stun = true})
end

_class("BuffViewResetStun", BuffViewBase)
BuffViewResetStun = BuffViewResetStun

function BuffViewResetStun:PlayView(TT)
  local targetEntity = self._entity
  targetEntity:SetAnimatorControllerBools({Stun = false})
  local effectService = self._world:GetService("Effect")
  if effectService ~= nil then
    effectService:ShowIdleEffect(targetEntity, true)
    effectService:DestroyWeakEffect(targetEntity)
  end
end

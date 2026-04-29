_class("BuffViewSetPalsy", BuffViewBase)
BuffViewSetPalsy = BuffViewSetPalsy

function BuffViewSetPalsy:PlayView(TT)
  self._entity:SetAnimatorControllerBools({Palsy = true})
end

_class("BuffViewResetPalsy", BuffViewBase)
BuffViewResetPalsy = BuffViewResetPalsy

function BuffViewResetPalsy:PlayView(TT)
  self._entity:SetAnimatorControllerBools({Palsy = false})
end

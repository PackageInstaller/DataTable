_class("BuffViewSetBenumb", BuffViewBase)
BuffViewSetBenumb = BuffViewSetBenumb

function BuffViewSetBenumb:PlayView(TT)
  self._entity:SetAnimatorControllerBools({Benumb = true})
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTBenumbed:New(self._entity))
end

_class("BuffViewResetBenumb", BuffViewBase)
BuffViewResetBenumb = BuffViewResetBenumb

function BuffViewResetBenumb:PlayView(TT)
  local targetEntity = self._entity
  targetEntity:SetAnimatorControllerBools({Benumb = false})
end

_class("BuffViewSetReplaceChain", BuffViewBase)
BuffViewSetReplaceChain = BuffViewSetReplaceChain

function BuffViewSetReplaceChain:PlayView(TT)
  local result = self._buffResult
  local bvcmpt = self._entity:BuffView()
  bvcmpt:SetBuffValue("ReplaceEntityID", result:GetReplaceEntityID())
end

_class("BuffViewResetReplaceChain", BuffViewBase)
BuffViewResetReplaceChain = BuffViewResetReplaceChain

function BuffViewResetReplaceChain:PlayView(TT)
  local bvcmpt = self._entity:BuffView()
  bvcmpt:SetBuffValue("ReplaceEntityID", nil)
end

_class("BuffViewSetExtraChain", BuffViewBase)
BuffViewSetExtraChain = BuffViewSetExtraChain

function BuffViewSetDoubleChain:IsNotifyMatch(notify)
  return true
end

function BuffViewSetExtraChain:PlayView(TT)
  local entity = self._entity
  local buffView = entity:BuffView()
  buffView:SetBuffValue("ExtraChainFlag", 1)
end

_class("BuffViewResetExtraChain", BuffViewBase)
BuffViewResetExtraChain = BuffViewResetExtraChain

function BuffViewResetExtraChain:IsNotifyMatch(notify)
  return true
end

function BuffViewResetExtraChain:PlayView(TT)
  local entity = self._entity
  local buffView = entity:BuffView()
  buffView:SetBuffValue("ExtraChainFlag", nil)
end

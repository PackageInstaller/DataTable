_class("BuffViewSetDoubleChain", BuffViewBase)
BuffViewSetDoubleChain = BuffViewSetDoubleChain

function BuffViewSetDoubleChain:IsNotifyMatch(notify)
  return true
end

function BuffViewSetDoubleChain:PlayView(TT)
  local buffResult = self:GetBuffResult()
  local chainSkillCount = buffResult:GetChainSkillCount()
  local rate = buffResult:GetRate()
  local entity = self._entity
  local buffView = entity:BuffView()
  buffView:SetBuffValue("ChainSkillCount", chainSkillCount)
  buffView:SetBuffValue("DoubleChainRate", rate)
end

_class("BuffViewResetDoubleChain", BuffViewBase)
BuffViewResetDoubleChain = BuffViewResetDoubleChain

function BuffViewResetDoubleChain:IsNotifyMatch(notify)
  return true
end

function BuffViewResetDoubleChain:PlayView(TT)
  local buffResult = self:GetBuffResult()
  local chainSkillCount = buffResult:GetChainSkillCount()
  local rate = buffResult:GetRate()
  local entity = self._entity
  local buffView = entity:BuffView()
  buffView:SetBuffValue("ChainSkillCount", chainSkillCount)
  buffView:SetBuffValue("DoubleChainRate", rate)
end

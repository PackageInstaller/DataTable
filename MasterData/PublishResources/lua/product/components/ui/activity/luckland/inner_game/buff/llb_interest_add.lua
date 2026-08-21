_class("LLBuffLogicAddInterest", LLBuffLogicBase)
LLBuffLogicAddInterest = LLBuffLogicAddInterest

function LLBuffLogicAddInterest:Constructor(buffObj, logicParam)
  self._perVal = logicParam.perVal
end

function LLBuffLogicAddInterest:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicAddInterest:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    local module = GameGlobal:GetLuckLandModule()
    local interestGold = lmathext.round(module:GetGold() * self._perVal)
    target:AddDirectGold(interestGold)
  elseif target:GetEntityType() == LuckLandEntityType.Monster then
  elseif target:GetEntityType() == LuckLandEntityType.Building then
    local module = GameGlobal:GetLuckLandModule()
    local interestGold = lmathext.round(module:GetGold() * self._perVal)
    target:AddDirectGold(interestGold)
  end
end

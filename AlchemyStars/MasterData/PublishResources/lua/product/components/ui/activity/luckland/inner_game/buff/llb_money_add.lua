_class("LLBuffLogicAddMoney", LLBuffLogicBase)
LLBuffLogicAddMoney = LLBuffLogicAddMoney

function LLBuffLogicAddMoney:Constructor(buffObj, logicParam)
  self._fixVal = logicParam.fixVal
  self._addToTotal = logicParam.addToTotal
end

function LLBuffLogicAddMoney:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicAddMoney:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if self._addToTotal then
      local module = GameGlobal:GetLuckLandModule()
      module:AddGold(self._fixVal)
    else
      target:AddDirectGold(self._fixVal)
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster then
  end
end

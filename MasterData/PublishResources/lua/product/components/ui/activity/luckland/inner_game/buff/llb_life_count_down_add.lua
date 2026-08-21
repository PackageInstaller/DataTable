_class("LLBuffLogicAddLifeCountDown", LLBuffLogicBase)
LLBuffLogicAddLifeCountDown = LLBuffLogicAddLifeCountDown

function LLBuffLogicAddLifeCountDown:Constructor(buffObj, logicParam)
  self._fixVal = logicParam.fixVal
end

function LLBuffLogicAddLifeCountDown:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicAddLifeCountDown:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    target:AddCountDownNum(self._fixVal)
  elseif target:GetEntityType() == LuckLandEntityType.Monster then
    target:AddCountDownNum(self._fixVal)
  end
end

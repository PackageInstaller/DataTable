require("llb_logic_base")
_class("LLBuffLogicIncreaseProduction", LLBuffLogicBase)
LLBuffLogicIncreaseProduction = LLBuffLogicIncreaseProduction

function LLBuffLogicIncreaseProduction:Constructor(buffObj, logicParam)
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProduction:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicIncreaseProduction:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal)
    end
  end
end

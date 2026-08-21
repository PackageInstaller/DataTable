require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionElement", LLBuffLogicBase)
LLBuffLogicIncreaseProductionElement = LLBuffLogicIncreaseProductionElement

function LLBuffLogicIncreaseProductionElement:Constructor(buffObj, logicParam)
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionElement:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local elementCount = 0
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local pets = entityMgr:GetFightPets()
  if pets then
    local elements = {}
    for _, pet in pairs(pets) do
      if not elements[pet:Element()] then
        elements[pet:Element()] = true
        elementCount = elementCount + 1
      end
    end
  end
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target, elementCount)
  end
end

function LLBuffLogicIncreaseProductionElement:DoLogicSingle(target, elementCount)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  if self._incType == LuckLandIncType.Accumulate then
    if self._fixVal then
      target:AddAccFixValue(self._fixVal * elementCount)
    end
    if self._perVal then
      target:AddAccPerValue(self._perVal * elementCount)
    end
  elseif self._incType == LuckLandIncType.Temp then
    if self._fixVal then
      target:AddTempFixValue(self._fixVal * elementCount)
    end
    if self._perVal then
      target:AddTempPerValue(self._perVal * elementCount)
    end
  end
end

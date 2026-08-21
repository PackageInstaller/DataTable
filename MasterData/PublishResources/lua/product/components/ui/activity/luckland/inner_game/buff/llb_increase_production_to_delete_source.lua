require("llb_logic_base")
_class("LLBuffLogicIncreaseProductionToDeleteSource", LLBuffLogicBase)
LLBuffLogicIncreaseProductionToDeleteSource = LLBuffLogicIncreaseProductionToDeleteSource

function LLBuffLogicIncreaseProductionToDeleteSource:Constructor(buffObj, logicParam)
  self._incType = logicParam.incType
  self._fixVal = logicParam.fixVal
  self._perVal = logicParam.perVal
end

function LLBuffLogicIncreaseProductionToDeleteSource:DoLogic(notify)
  local params = notify:GetNotifyParams()
  if not LLNTDeletePet:IsInstanceOfType(notify) or not params then
    return
  end
  local notifyEntity = notify:GetNotifyEntity()
  local deleteEntity = params[1]
  if notifyEntity ~= deleteEntity then
    return
  end
  local deleteSource = params[2]
  if self._incType and deleteSource and LLEntityPet:IsInstanceOfType(deleteSource) and not deleteSource:HasDeleteFlag() then
    if self._incType == LuckLandIncType.Accumulate then
      if self._fixVal then
        deleteSource:AddAccFixValue(self._fixVal)
      end
      if self._perVal then
        deleteSource:AddAccPerValue(self._perVal)
      end
    elseif self._incType == LuckLandIncType.Temp then
      if self._fixVal then
        deleteSource:AddTempFixValue(self._fixVal)
      end
      if self._perVal then
        deleteSource:AddTempPerValue(self._perVal)
      end
    end
  end
end

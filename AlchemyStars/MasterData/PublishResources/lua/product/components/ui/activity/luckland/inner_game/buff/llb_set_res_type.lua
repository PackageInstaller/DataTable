require("llb_logic_base")
_class("LLBuffLogicSetResType", LLBuffLogicBase)
LLBuffLogicSetResType = LLBuffLogicSetResType

function LLBuffLogicSetResType:Constructor(buffObj, logicParam)
  self._resType = logicParam.resType
  self._val = logicParam.value
end

function LLBuffLogicSetResType:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicSetResType:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    if target:HasDeleteFlag() then
      return
    end
  elseif target:GetEntityType() == LuckLandEntityType.Monster and target:IsDead() then
    return
  end
  target:SetResType(self._resType)
  target:AddTempFixValue(self._val)
end

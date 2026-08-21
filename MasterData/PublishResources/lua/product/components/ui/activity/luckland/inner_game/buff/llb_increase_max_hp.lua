require("llb_logic_base")
_class("LLBuffLogicIncreaseMaxHP", LLBuffLogicBase)
LLBuffLogicIncreaseMaxHP = LLBuffLogicIncreaseMaxHP

function LLBuffLogicIncreaseMaxHP:Constructor(buffObj, logicParam)
  self._fixVal = logicParam.fixVal
end

function LLBuffLogicIncreaseMaxHP:DoLogic(notify)
  local notifyEntity = notify:GetNotifyEntity()
  local targets = self._buffObj:GetTargets()
  for _, target in ipairs(targets) do
    self:DoLogicSingle(target)
  end
end

function LLBuffLogicIncreaseMaxHP:DoLogicSingle(target)
  if target:GetEntityType() == LuckLandEntityType.Pet then
    local module = GameGlobal:GetLuckLandModule()
    module:AddMaxHp(self._fixVal)
  elseif target:GetEntityType() == LuckLandEntityType.Monster then
  end
end

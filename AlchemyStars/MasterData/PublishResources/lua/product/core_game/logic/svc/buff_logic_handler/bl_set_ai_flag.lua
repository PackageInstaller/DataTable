require("buff_logic_base")
_class("BuffLogicSetAIFlag", BuffLogicBase)
BuffLogicSetAIFlag = BuffLogicSetAIFlag

function BuffLogicSetAIFlag:Constructor(buffInstance, logicParam)
  self._flag = logicParam.flag
end

function BuffLogicSetAIFlag:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasAI() then
    local aiComponent = e:AI()
    aiComponent:SetRuntimeData(self._flag, true)
  end
end

_class("BuffLogicClearAIFlag", BuffLogicBase)
BuffLogicClearAIFlag = BuffLogicClearAIFlag

function BuffLogicClearAIFlag:Constructor(buffInstance, logicParam)
  self._flag = logicParam.flag
end

function BuffLogicClearAIFlag:DoLogic()
  local e = self._buffInstance:Entity()
  if e:HasAI() then
    local aiComponent = e:AI()
    aiComponent:SetRuntimeData(self._flag, false)
  end
end

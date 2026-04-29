_class("BuffLogicAddTrapExist", BuffLogicBase)
BuffLogicAddTrapExist = BuffLogicAddTrapExist

function BuffLogicAddTrapExist:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue or 0
  self._forceFull = logicParam.forceFull and true or false
  self._ignoreNextEffectUpdate = logicParam.ignoreNextEffectUpdate and true or false
  self._additionalOnZeroCurrentRound = logicParam.additionalOnZeroCurrentRound or false
end

function BuffLogicAddTrapExist:DoLogic(notify)
  local e = self._buffInstance:Entity()
  local trapCmpt = e:Trap()
  local trapDestroyType = trapCmpt:GetTrapDestroyType()
  local trapDestroyParam = trapCmpt:GetTrapDestroyParam()
  if not trapDestroyParam then
    return
  end
  local addValue = self._addValue
  local totalRound = e:Attributes():GetAttribute("TotalRound")
  local currentRound = e:Attributes():GetAttribute("CurrentRound")
  if self._additionalOnZeroCurrentRound and currentRound == 0 and self._addValue < 0 then
    addValue = addValue - 1
  end
  if currentRound - addValue < 0 then
    addValue = currentRound
  end
  local changeValue = currentRound - addValue
  e:Attributes():Modify("CurrentRound", changeValue)
  trapDestroyParam:AddNum(addValue)
  local isDestroy = false
  if totalRound < e:Attributes():GetAttribute("CurrentRound") then
    e:Attributes():Modify("HP", 0)
    local trapServiceLogic = self._world:GetService("TrapLogic")
    trapServiceLogic:AddTrapDeadMark(e)
    isDestroy = true
  end
  local result = BuffResultAddTrapExist:New(changeValue, self._forceFull, self._ignoreNextEffectUpdate, isDestroy)
  local res = DataAttributeResult:New(e:GetID(), "CurrentRound", changeValue)
  self._world:EventDispatcher():Dispatch(GameEventType.DataLogicResult, 0, res)
  return result
end

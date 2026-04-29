_class("LogicResultComponent", Object)

function LogicResultComponent:Constructor()
  self._logicStep = LogicStepType.Init
  self._result = {}
end

function LogicResultComponent:SetLogicResult(logicStep, result)
  if self.logicStep == logicStep then
    Log.fatal("AddLogicResult() error: duplicate logic step result! step=", logicStep)
    return
  end
  self._logicStep = logicStep
  self._result[logicStep] = result
end

function LogicResultComponent:ClearLogicResult()
  self._logicStep = LogicStepType.Init
  self._result = {}
end

function LogicResultComponent:GetLogicStep()
  return self._logicStep
end

function LogicResultComponent:GetLogicResult(logicStep)
  if logicStep ~= self._logicStep then
    Log.info("GetLogicResult() error: logic step not match! selfstep=", self._logicStep, " step=", logicStep)
  end
  return self._result[logicStep]
end

function Entity:LogicResult()
  return self:GetComponent(self.WEComponentsEnum.LogicResult)
end

function Entity:HasLogicResult()
  return self:HasComponent(self.WEComponentsEnum.LogicResult)
end

function Entity:AddLogicResult()
  local index = self.WEComponentsEnum.LogicResult
  local component = LogicResultComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveLogicResult()
  if self:HasLogicResult() then
    self:RemoveComponent(self.WEComponentsEnum.LogicResult)
  end
end

require("lltc_base")
require("luckland_buff_target_type")
_class("LuckLandTargetCalculator", Object)
LuckLandTargetCalculator = LuckLandTargetCalculator

function LuckLandTargetCalculator:Constructor()
  self._calculatorDic = {}
  for k, v in pairs(LuckLandBuffTargetType) do
    local clsName = "LLTC" .. k
    self._calculatorDic[v] = Classes[clsName]
  end
end

function LuckLandTargetCalculator:CalculateBuffTarget(targetType, param, buffOwner)
  local calculatorClass = self._calculatorDic[targetType]
  local calculator = calculatorClass:New(param)
  local targets = calculator:CalculateTarget(buffOwner)
  return targets
end

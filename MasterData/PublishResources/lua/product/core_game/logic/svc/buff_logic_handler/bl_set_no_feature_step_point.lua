require("buff_logic_base")
_class("BuffLogicSetNoFeatureStepPoint", BuffLogicBase)
BuffLogicSetNoFeatureStepPoint = BuffLogicSetNoFeatureStepPoint

function BuffLogicSetNoFeatureStepPoint:Constructor(buffinstance, logicParam)
  self._maxStep = logicParam.MaxStep
end

function BuffLogicSetNoFeatureStepPoint:DoLogic(notify)
  self._buffComponent:SetBuffValue("NoFeatureStepPoint", self._maxStep)
end

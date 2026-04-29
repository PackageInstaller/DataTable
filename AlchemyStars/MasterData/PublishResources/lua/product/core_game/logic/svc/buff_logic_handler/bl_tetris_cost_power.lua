require("buff_logic_base")
_class("BuffLogicTetrisChangeCostPower", BuffLogicBase)
BuffLogicTetrisChangeCostPower = BuffLogicTetrisChangeCostPower

function BuffLogicTetrisChangeCostPower:Constructor(buffInstance, logicParam)
  self._costPower = logicParam.costPower
end

function BuffLogicTetrisChangeCostPower:DoLogic(notify)
  local featureSvcL = self._world:GetService("FeatureLogic")
  local curCostPower = featureSvcL:GetTetrisPower()
  local newCostPower = self._costPower + curCostPower
  if newCostPower < 0 then
    newCostPower = 0
  end
  Log.fatal("BuffLogicTetrisChangeCostPower curCostPower:", curCostPower, "ChangePower:", self._costPower, "newCostPower:", newCostPower)
  featureSvcL:SetTetrisCostPower(newCostPower)
end

_class("BuffLogicTetrisSetCostPower", BuffLogicBase)
BuffLogicTetrisSetCostPower = BuffLogicTetrisSetCostPower

function BuffLogicTetrisSetCostPower:Constructor(buffInstance, logicParam)
  self._costPower = logicParam.costPower
end

function BuffLogicTetrisSetCostPower:DoLogic(notify)
  local featureSvcL = self._world:GetService("FeatureLogic")
  featureSvcL:SetTetrisCostPower(self._costPower)
  Log.fatal("BuffLogicTetrisSetCostPower SetCostPower:", self._costPower)
end

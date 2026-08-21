require("buff_logic_base")
_class("BuffLogicTetrisChangePower", BuffLogicBase)
BuffLogicTetrisChangePower = BuffLogicTetrisChangePower

function BuffLogicTetrisChangePower:Constructor(buffInstance, logicParam)
  self._power = logicParam.power
end

function BuffLogicTetrisChangePower:DoLogic(notify)
  local featureSvcL = self._world:GetService("FeatureLogic")
  local curPower = featureSvcL:GetTetrisPower()
  local newPower = self._power + curPower
  if newPower < 0 then
    newPower = 0
  end
  newPower = featureSvcL:SetTetrisPower(newPower)
  local newPos
  if notify:GetNotifyType() == NotifyType.EntityMoveEnd or notify:GetNotifyType() == NotifyType.PlayerEachMoveEnd then
    newPos = notify:GetPosNew()
  end
  local result = BuffResultTetrisChangePower:New(newPower, newPos)
  return result
end

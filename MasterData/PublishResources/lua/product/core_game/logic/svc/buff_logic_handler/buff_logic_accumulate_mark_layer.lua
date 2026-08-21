require("buff_logic_base")
_class("BuffLogicAccumulateMarkLayer", BuffLogicBase)
BuffLogicAccumulateMarkLayer = BuffLogicAccumulateMarkLayer

function BuffLogicAccumulateMarkLayer:Constructor(buffInstance, logicParam)
end

function BuffLogicAccumulateMarkLayer:DoLogic(notify)
  local curMarkLayer = self._buffInstance:AddLayerCount(1)
  self:PrintBuffLogicLog("BuffLogicAccumulateMarkLayer entity=", self._entity:GetID(), " layer=", curMarkLayer)
  local buffResult = BuffResultAccumulateMarkLayer:New(notify:GetAttackerEntity():GetID(), notify:GetDefenderEntity():GetID(), notify:GetAttackPos(), curMarkLayer)
  return buffResult
end

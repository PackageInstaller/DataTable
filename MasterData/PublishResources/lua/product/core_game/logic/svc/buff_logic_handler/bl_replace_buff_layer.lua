require("buff_logic_base")
_class("BuffLogicReplaceBuffLayer", BuffLogicBase)
BuffLogicReplaceBuffLayer = BuffLogicReplaceBuffLayer

function BuffLogicReplaceBuffLayer:Constructor(_, logicParam)
  self._buffEffectTypeList = logicParam.BuffEffectTypeList
  self._maxLayerCount = logicParam.MaxLayerCount
end

function BuffLogicReplaceBuffLayer:DoLogic(_)
  local e = self:GetEntity()
  local buffCmpt = e:BuffComponent()
  buffCmpt:SetBuffValue("ReplaceMaxLayer_BuffEffectTypeList", self._buffEffectTypeList)
  buffCmpt:SetBuffValue("ReplaceMaxLayer_MaxLayer", self._maxLayerCount)
end

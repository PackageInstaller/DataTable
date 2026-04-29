_class("BuffLogicPSPSetExtraProbValue", BuffLogicBase)
BuffLogicPSPSetExtraProbValue = BuffLogicPSPSetExtraProbValue

function BuffLogicPSPSetExtraProbValue:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue
  self._modifyType = logicParam.modifyType
  self._buffID = logicParam.buffID
end

function BuffLogicPSPSetExtraProbValue:DoLogic()
  local popSarProSvc = self._world:GetService("PopStarProLogic")
  local count = popSarProSvc:GetCountByModifyType(self._modifyType)
  local addValue = self._mulValue * count
  local buffComponent = self._entity:BuffComponent()
  if not buffComponent then
    return
  end
  local key = "ExtraProb" .. tostring(self._buffID)
  buffComponent:SetBuffValue(key, addValue)
end

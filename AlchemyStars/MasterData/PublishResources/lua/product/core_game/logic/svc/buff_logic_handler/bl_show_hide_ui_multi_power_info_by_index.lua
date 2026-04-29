_class("BuffLogicShowHideUiMultiPowerInfoByIndex", BuffLogicBase)
BuffLogicShowHideUiMultiPowerInfoByIndex = BuffLogicShowHideUiMultiPowerInfoByIndex

function BuffLogicShowHideUiMultiPowerInfoByIndex:Constructor(buffInstance, logicParam)
  self._uiIndex = logicParam.uiIndex or 2
  self._showHide = logicParam.showHide or 1
end

function BuffLogicShowHideUiMultiPowerInfoByIndex:DoLogic(notify)
  if self._entity:PetPstID() then
    local pstId = self._entity:PetPstID():GetPstID()
    local bShow = self._showHide == 1
    local buffResult = BuffResultShowHideUiMultiPowerInfoByIndex:New(pstId, self._uiIndex, bShow)
    return buffResult
  end
end

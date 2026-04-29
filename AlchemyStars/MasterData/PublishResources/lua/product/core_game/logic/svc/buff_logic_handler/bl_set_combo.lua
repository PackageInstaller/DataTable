_class("BuffLogicSetCombo", BuffLogicBase)
BuffLogicSetCombo = BuffLogicSetCombo

function BuffLogicSetCombo:Constructor(buffInstance, logicParam)
  self._value = logicParam.value or 0
end

function BuffLogicSetCombo:DoLogic(notify)
  local battleSvc = self._world:GetService("Battle")
  local curComboNum = battleSvc:GetLogicComboNum()
  curComboNum = curComboNum + self._value
  battleSvc:SetLogicComboNum(curComboNum)
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    local buffResult = BuffResultAddCombo:New(self._value, notify:GetPos())
    return buffResult
  end
end

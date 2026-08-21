require("buff_logic_base")
_class("BuffLogicModifyPopStarTrapRefreshID", BuffLogicBase)
BuffLogicModifyPopStarTrapRefreshID = BuffLogicModifyPopStarTrapRefreshID

function BuffLogicModifyPopStarTrapRefreshID:Constructor(buffInstance, logicParam)
  self._refreshID = logicParam.refreshID
end

function BuffLogicModifyPopStarTrapRefreshID:DoLogic(notify)
  if not self._refreshID then
    return true
  end
  local popStarSvc = self._world:GetService("PopStarLogic")
  popStarSvc:DoParseTrapRefreshData(self._refreshID)
  return true
end

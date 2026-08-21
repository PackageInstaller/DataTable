require("base_state_node")
_class("Cartridge_CheatGetCartridgeItem", Common_AsyncBase)
Cartridge_CheatGetCartridgeItem = Cartridge_CheatGetCartridgeItem

function Cartridge_CheatGetCartridgeItem:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  local strcmd = string.format("add_asset %s %s %s", LocalDB.GetString("OpenIdTest"), runData:GetCartridgeID(), 1)
  status:SetMessage(strcmd)
  local addResResult = gmproxy:SendCmdTask(TT, strcmd)
  if addResResult.m_call_err ~= CallResultType.Normal then
    Log.exception(self._className, "GM command failed: ", strcmd)
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end

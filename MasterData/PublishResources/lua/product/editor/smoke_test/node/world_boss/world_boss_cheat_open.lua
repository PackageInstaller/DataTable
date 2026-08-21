require("common_async_base")
_class("WorldBoss_CheatOpen", Common_AsyncBase)
WorldBoss_CheatOpen = WorldBoss_CheatOpen

function WorldBoss_CheatOpen:TaskFunc(TT, status)
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  local strcmd = string.format("open_auto_test %s", LocalDB.GetString("OpenIdTest"))
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

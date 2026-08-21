require("common_async_base")
_class("WorldBoss_Init", Common_AsyncBase)
WorldBoss_Init = WorldBoss_Init

function WorldBoss_Init:TaskFunc(TT, status)
  local worldBossModule = GameGlobal.GetModule(WorldBossModule)
  local result = worldBossModule:ReqWorldBossData(TT)
  if result.m_call_err ~= CallResultType.Normal then
    Log.exception(self._className, "ReqWorldBossData failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end

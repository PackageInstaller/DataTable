require("common_async_base")
_class("DifficultyMission_Init", Common_AsyncBase)
DifficultyMission_Init = DifficultyMission_Init

function DifficultyMission_Init:TaskFunc(TT, status)
  local worldBossModule = GameGlobal.GetModule(DifficultyMissionModule)
  local result = worldBossModule:HandleGetDifficultyMissionData(TT)
  if result.m_call_err ~= CallResultType.Normal then
    Log.exception(self._className, "HandleGetDifficultyMissionData failed. ")
    status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
    status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
    return
  end
  local uiModule = GameGlobal.GetUIModule(DifficultyMissionModule)
  uiModule:Init()
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
end

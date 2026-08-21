require("common_async_base")
_class("SailingMission_GetData", Common_AsyncBase)
SailingMission_GetData = SailingMission_GetData

function SailingMission_GetData:TaskFunc(TT, status)
  local sailingModule = GameGlobal.GetModule(SailingMissionModule)
  for i = 1, 3 do
    local asyncRes = sailingModule:HandleGetSailingMissionData(TT)
    local replyResult = asyncRes:GetResult()
    if replyResult == SailingMissionErrorType.E_SAILINGMISSION_ERROR_TYPE_SUCCESS then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("获取大航海基础信息失败")
end

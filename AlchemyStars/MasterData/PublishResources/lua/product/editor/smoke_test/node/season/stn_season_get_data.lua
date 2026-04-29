require("common_async_base")
_class("Season_GetData", Common_AsyncBase)
Season_GetData = Season_GetData

function Season_GetData:TaskFunc(TT, status)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local runData = self.m_pManager:GetMissionRunData()
  local componentID = runData:GetComponentID()
  self._manager:AsyncGM_OpenAllCampaign(TT, status, componentID)
  local resLoadInfoList = AsyncRequestRes:New()
  campaignModule:CampaignLoadInfoList(TT, resLoadInfoList)
  local resProtoLoadInfo = AsyncRequestRes:New()
  campaignModule:CampaignComProtoLoadInfo(TT, resProtoLoadInfo, componentID)
  campaignModule:LoadCampaignInfoListTask(TT)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  for i = 1, 3 do
    local resSeason = seasonModule:ForceRequestCurSeasonData(TT)
    if resSeason:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("获取赛季基础信息失败")
end

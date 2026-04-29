require("base_state_node")
_class("GoldbergEventTest_HandleSelectAffix", Common_AsyncBase)
GoldbergEventTest_HandleSelectAffix = GoldbergEventTest_HandleSelectAffix

function GoldbergEventTest_HandleSelectAffix:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  if not runData:HaseAffix() then
    return
  end
  local campaignID = runData:GetCampaignID()
  local componentsID = runData:GetComponentID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local res = AsyncRequestRes:New()
  local request = SummerIISelectAffixReq:New()
  local response = SummerIISelectAffixRep:New()
  request.nCampaignMissionId = runData:GetMissionID()
  request.SelectAffixIdArray = runData:GetAffixList()
  request.nHardId = runData:GetHardID()
  campaignModule:CampaignComProtoRequest(TT, res, campaignID, componentsID, request, response)
  if CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_SUCCESS ~= res.m_result then
    Log.fatal("1111111")
  end
  self.m_nNodeState = 1
end

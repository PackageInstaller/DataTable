require("base_state_node")
_class("CCAffix_HandleSelectAffix", Common_AsyncBase)
CCAffix_HandleSelectAffix = CCAffix_HandleSelectAffix

function CCAffix_HandleSelectAffix:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  if not runData:GetAffixList() then
    return
  end
  local missionId = runData:GetMissionID()
  local res1 = AsyncRequestRes:New()
  res1:SetSucc(true)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res1, ECampaignType.CAMPAIGN_TYPE_INLAND_N4_CHALLENGE, ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  self._localProcess = self._campaign:GetLocalProcess()
  local component = self._localProcess:GetComponent(ECCampaignInlandN4ChallengeComponentID.CHALLENGE)
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  res = component:HandleSelectAffix(TT, res, missionId, runData:GetAffixList())
  if res:GetSucc() then
  else
  end
  self.m_nNodeState = 1
end

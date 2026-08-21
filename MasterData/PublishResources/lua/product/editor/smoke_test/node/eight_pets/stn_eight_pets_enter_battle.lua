require("common_async_base")
_class("EightPets_EnterBattle", Common_AsyncBase)
EightPets_EnterBattle = EightPets_EnterBattle

function EightPets_EnterBattle:TaskFunc(TT, status)
  local runData = self.m_pManager:GetMissionRunData()
  local missionID = runData:GetMissionID()
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  local localProcess = campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_INLAND_EIGHT_PETS_MISSION)
  local eightComponent = localProcess:GetComponent(ECampaignEightPetsMissionComponentID.ECAMPAIGN_Eight_Pets_MISSION)
  local componentID = eightComponent:GetCampaignMissionComponentId()
  local paramKeyMap = eightComponent:GetCampaignMissionParamKeyMap()
  local game = GameGlobal.GetModule(GameMatchModule)
  local createInfo = game:GetMatchCreateInfo(MatchType.MT_EightPets, {
    missionID,
    componentID,
    paramKeyMap
  })
  for i = 1, 3 do
    local res = game:StartMatchTask(TT, MatchType.MT_EightPets, TestConst.MissionTeamIndex, createInfo)
    if res:GetSucc() then
      status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
      status:SetResult(ST_ASYNC_OPERATION_RESULT.SUCCESS)
      return
    end
  end
  status:SetStatus(ST_ASYNC_OPERATION_STATUS.FINISHED)
  status:SetResult(ST_ASYNC_OPERATION_RESULT.ERROR)
  self._manager:Exception_DeclareExceptionThrew("对局创建失败")
end

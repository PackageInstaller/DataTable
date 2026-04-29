require("common_async_base")
_class("GM_SetCampaignTalentList", Common_AsyncBase)
GM_SetCampaignTalentList = GM_SetCampaignTalentList

function GM_SetCampaignTalentList:Constructor(_manager)
end

function GM_SetCampaignTalentList:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  local missionID = runData:GetMissionID()
  local talentList = {
    100006,
    101001,
    102002,
    103002,
    200006,
    201001,
    202002,
    203002,
    300006,
    301001,
    302002,
    303002,
    400006,
    401001,
    402002,
    403002,
    500006,
    501001,
    502002,
    503002
  }
  self._manager:AsyncGM_SetCampaignTalentList(TT, status, talentList)
end

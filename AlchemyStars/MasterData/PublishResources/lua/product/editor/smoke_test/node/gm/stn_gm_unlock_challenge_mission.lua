require("common_async_base")
_class("GM_UnlockChallengeMission", Common_AsyncBase)
GM_UnlockChallengeMission = GM_UnlockChallengeMission

function GM_UnlockChallengeMission:Constructor(_manager)
end

function GM_UnlockChallengeMission:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  local missionID = runData:GetMissionID()
  self._manager:AsyncGM_UnlockChallengeMission(TT, status, componentID, missionID)
  self._manager:AsyncGM_PassMultiLineCampMission(TT, status, componentID, missionID)
end

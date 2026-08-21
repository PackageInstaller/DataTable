require("common_async_base")
_class("GM_UnlockChallengeMissionCCAffix", Common_AsyncBase)
GM_UnlockChallengeMissionCCAffix = GM_UnlockChallengeMissionCCAffix

function GM_UnlockChallengeMissionCCAffix:Constructor(_manager)
end

function GM_UnlockChallengeMissionCCAffix:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  self._manager:AsyncGM_UnlockChallengeMission(TT, status, componentID)
end

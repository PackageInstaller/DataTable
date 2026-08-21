require("common_async_base")
_class("GM_SeasonMazeReset", Common_AsyncBase)
GM_SeasonMazeReset = GM_SeasonMazeReset

function GM_SeasonMazeReset:Constructor(_manager)
end

function GM_SeasonMazeReset:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  local activityID = 9001
  self._manager:AsyncGM_ResetCampDat(TT, status, activityID)
end

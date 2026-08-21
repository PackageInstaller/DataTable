require("common_async_base")
_class("GM_SeasonMazeLevelDifficulty", Common_AsyncBase)
GM_SeasonMazeLevelDifficulty = GM_SeasonMazeLevelDifficulty

function GM_SeasonMazeLevelDifficulty:Constructor(_manager, level)
  self._level = level
end

function GM_SeasonMazeLevelDifficulty:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  self._manager:AsyncGM_SeasonMazeLevelDifficulty(TT, status, componentID, self._level)
end

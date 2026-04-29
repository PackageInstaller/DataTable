require("common_async_base")
_class("DifficultyMissionActivity_GM_PassAll", Common_AsyncBase)
DifficultyMissionActivity_GM_PassAll = DifficultyMissionActivity_GM_PassAll

function DifficultyMissionActivity_GM_PassAll:TaskFunc(TT, status)
  self._manager:AsyncGM_PassAllActivityDifficultyMission(TT, status)
end

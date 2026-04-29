require("common_async_base")
_class("DifficultyMission_GM_PassAll", Common_AsyncBase)
DifficultyMission_GM_PassAll = DifficultyMission_GM_PassAll

function DifficultyMission_GM_PassAll:TaskFunc(TT, status)
  self._manager:AsyncGM_PassAllDifficultyMission(TT, status)
end
